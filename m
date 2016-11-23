Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNn5B2NShzDvtr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 13:55:26 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so37148pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 18:55:26 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/boot: fix the early OPAL console wrappers
Date: Wed, 23 Nov 2016 13:55:13 +1100
Message-Id: <1479869713-30059-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When configured with CONFIG_PPC_EARLY_DEBUG_OPAL=y the kernel expects
the OPAL entry and base addresses to be passed in r8 and r9
respectively. Currently the wrapper does not attempt to restore these
values before entering the decompressed kernel which causes the kernel
to branch into whatever happens to be in r9 when doing a write to the
OPAL console in early boot.

This patch adds a platform_ops hook that can be used to branch into the
new kernel. The OPAL console driver patches this at runtime so that if
the console is used it will be restored just prior to entering the
kernel.

Fixes: 656ad58ef19e
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/boot/main.c       |  8 ++++++--
 arch/powerpc/boot/opal-calls.S | 13 +++++++++++++
 arch/powerpc/boot/opal.c       | 11 +++++++++++
 arch/powerpc/boot/ops.h        |  1 +
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
index d80161b633f4..60522d22a428 100644
--- a/arch/powerpc/boot/main.c
+++ b/arch/powerpc/boot/main.c
@@ -217,8 +217,12 @@ void start(void)
 		console_ops.close();
 
 	kentry = (kernel_entry_t) vmlinux.addr;
-	if (ft_addr)
-		kentry(ft_addr, 0, NULL);
+	if (ft_addr) {
+		if(platform_ops.kentry)
+			platform_ops.kentry(ft_addr, vmlinux.addr);
+		else
+			kentry(ft_addr, 0, NULL);
+	}
 	else
 		kentry((unsigned long)initrd.addr, initrd.size,
 		       loader_info.promptr);
diff --git a/arch/powerpc/boot/opal-calls.S b/arch/powerpc/boot/opal-calls.S
index ff2f1b97bc53..2a99fc9a3ccf 100644
--- a/arch/powerpc/boot/opal-calls.S
+++ b/arch/powerpc/boot/opal-calls.S
@@ -12,6 +12,19 @@
 
 	.text
 
+	.globl opal_kentry
+opal_kentry:
+	/* r3 is the fdt ptr */
+	mtctr r4
+	li	r4, 0
+	li	r5, 0
+	li	r6, 0
+	li	r7, 0
+	ld	r11,opal@got(r2)
+	ld	r8,0(r11)
+	ld	r9,8(r11)
+	bctr
+
 #define OPAL_CALL(name, token)				\
 	.globl name;					\
 name:							\
diff --git a/arch/powerpc/boot/opal.c b/arch/powerpc/boot/opal.c
index 1f37e1c1d6d8..d7b4fd47eb44 100644
--- a/arch/powerpc/boot/opal.c
+++ b/arch/powerpc/boot/opal.c
@@ -23,14 +23,25 @@ struct opal {
 
 static u32 opal_con_id;
 
+/* see opal-wrappers.S */
 int64_t opal_console_write(int64_t term_number, u64 *length, const u8 *buffer);
 int64_t opal_console_read(int64_t term_number, uint64_t *length, u8 *buffer);
 int64_t opal_console_write_buffer_space(uint64_t term_number, uint64_t *length);
 int64_t opal_console_flush(uint64_t term_number);
 int64_t opal_poll_events(uint64_t *outstanding_event_mask);
 
+void opal_kentry(unsigned long fdt_addr, void *vmlinux_addr);
+
 static int opal_con_open(void)
 {
+	/*
+	 * When OPAL loads the boot kernel it stashes the OPAL base and entry
+	 * address in r8 and r9 so the kernel can use the OPAL console
+	 * before unflattening the devicetree. While executing the wrapper will
+	 * probably trash r8 and r9 so this kentry hook restores them before
+	 * entering the decompressed kernel.
+	 */
+	platform_ops.kentry = opal_kentry;
 	return 0;
 }
 
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index e19b64ef977a..deeae6f6ba9c 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -30,6 +30,7 @@ struct platform_ops {
 	void *	(*realloc)(void *ptr, unsigned long size);
 	void	(*exit)(void);
 	void *	(*vmlinux_alloc)(unsigned long size);
+	void  	(*kentry)(unsigned long fdt_addr, void *vmlinux_addr);
 };
 extern struct platform_ops platform_ops;
 
-- 
2.5.5
