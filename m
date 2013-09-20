Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [173.228.107.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 560172C016E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 04:42:24 +1000 (EST)
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: make kernel module helper endian-safe.
Date: Fri, 20 Sep 2013 11:42:20 -0700
Message-Id: <1379702541-28372-1-git-send-email-ebs@ebshome.net>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Eugene Surovegin <surovegin@google.com>
---
 arch/powerpc/kernel/module_64.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 6ee59a0..a102f44 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -62,6 +62,16 @@ struct ppc64_stub_entry
    r2) into the stub. */
 static struct ppc64_stub_entry ppc64_stub =
 { .jump = {
+#ifdef __LITTLE_ENDIAN__
+	0x00, 0x00, 0x82, 0x3d, /* addis   r12,r2, <high> */
+	0x00, 0x00, 0x8c, 0x39, /* addi    r12,r12, <low> */
+	/* Save current r2 value in magic place on the stack. */
+	0x28, 0x00, 0x41, 0xf8, /* std     r2,40(r1) */
+	0x20, 0x00, 0x6c, 0xe9, /* ld      r11,32(r12) */
+	0x28, 0x00, 0x4c, 0xe8, /* ld      r2,40(r12) */
+	0xa6, 0x03, 0x69, 0x7d, /* mtctr   r11 */
+	0x20, 0x04, 0x80, 0x4e  /* bctr */
+#else
 	0x3d, 0x82, 0x00, 0x00, /* addis   r12,r2, <high> */
 	0x39, 0x8c, 0x00, 0x00, /* addi    r12,r12, <low> */
 	/* Save current r2 value in magic place on the stack. */
@@ -70,6 +80,7 @@ static struct ppc64_stub_entry ppc64_stub =
 	0xe8, 0x4c, 0x00, 0x28, /* ld      r2,40(r12) */
 	0x7d, 0x69, 0x03, 0xa6, /* mtctr   r11 */
 	0x4e, 0x80, 0x04, 0x20  /* bctr */
+#endif
 } };
 
 /* Count how many different 24-bit relocations (different symbol,
@@ -269,8 +280,13 @@ static inline int create_stub(Elf64_Shdr *sechdrs,
 
 	*entry = ppc64_stub;
 
+#ifdef __LITTLE_ENDIAN__
+	loc1 = (Elf64_Half *)&entry->jump[0];
+	loc2 = (Elf64_Half *)&entry->jump[4];
+#else
 	loc1 = (Elf64_Half *)&entry->jump[2];
 	loc2 = (Elf64_Half *)&entry->jump[6];
+#endif
 
 	/* Stub uses address relative to r2. */
 	reladdr = (unsigned long)entry - my_r2(sechdrs, me);
-- 
1.8.1.5
