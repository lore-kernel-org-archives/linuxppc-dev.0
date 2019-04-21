Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4395C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:02:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40DA220821
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 16:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40DA220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nDxj1HSvzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 02:02:33 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBk34V69zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:22:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44nBk339h3z9sMQ; Mon, 22 Apr 2019 00:22:19 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBk26GQmz9sML; Mon, 22 Apr 2019 00:22:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH stable v4.4 35/52] powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
Date: Mon, 22 Apr 2019 00:20:20 +1000
Message-Id: <20190421142037.21881-36-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190421142037.21881-1-mpe@ellerman.id.au>
References: <20190421142037.21881-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: diana.craciun@nxp.com, linuxppc-dev@ozlabs.org, msuchanek@suse.de,
 npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

commit 179ab1cbf883575c3a585bcfc0f2160f1d22a149 upstream.

Add a config symbol to encode which platforms support the
barrier_nospec speculation barrier. Currently this is just Book3S 64
but we will add Book3E in a future patch.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig               | 7 ++++++-
 arch/powerpc/include/asm/barrier.h | 6 +++---
 arch/powerpc/include/asm/setup.h   | 2 +-
 arch/powerpc/kernel/Makefile       | 3 ++-
 arch/powerpc/kernel/module.c       | 4 +++-
 arch/powerpc/kernel/vmlinux.lds.S  | 4 +++-
 arch/powerpc/lib/feature-fixups.c  | 6 ++++--
 7 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 58a1fa979655..9d16459632bb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -136,7 +136,7 @@ config PPC
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_TIME_VSYSCALL_OLD
-	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
@@ -162,6 +162,11 @@ config PPC
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select HAVE_ARCH_SECCOMP_FILTER
 
+config PPC_BARRIER_NOSPEC
+    bool
+    default y
+    depends on PPC_BOOK3S_64
+
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
 
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 8e7cbf0ea614..a422e4a69c1a 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -92,7 +92,7 @@ do {									\
 #define smp_mb__after_atomic()      smp_mb()
 #define smp_mb__before_spinlock()   smp_mb()
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
@@ -102,9 +102,9 @@ do {									\
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
+#else /* !CONFIG_PPC_BARRIER_NOSPEC */
 #define barrier_nospec_asm
 #define barrier_nospec()
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 #endif /* _ASM_POWERPC_BARRIER_H */
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index ac4002e5a09e..217a53ceecf3 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -42,7 +42,7 @@ void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 #else
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index e9b0962743b8..22ed3c32fca8 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -40,10 +40,11 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BARRIER_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 340528d79233..ff009be97a42 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -67,13 +67,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+#endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
 	if (sect != NULL)
 		do_barrier_nospec_fixups_range(barrier_nospec_enabled,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
 	if (sect != NULL)
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 977e859b4d4c..4f9e7733e015 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -93,14 +93,16 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+#endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 	. = ALIGN(8);
 	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
 		__start___barrier_nospec_fixup = .;
 		*(__barrier_nospec_fixup)
 		__stop___barrier_nospec_fixup = .;
 	}
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 	EXCEPTION_TABLE(0)
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index e9373f41f0da..64f216af3c1f 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -301,6 +301,9 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -310,8 +313,7 @@ void do_barrier_nospec_fixups(bool enable)
 
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
-- 
2.20.1

