Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41cl2z5ywszF09Y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jul 2018 09:06:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org,
	diana.craciun@nxp.com
Cc: oss@buserror.net,
	leoyang.li@nxp.com,
	bharat.bhushan@nxp.com
Subject: [PATCH v5 3/8] powerpc/64: Add CONFIG_PPC_BARRIER_NOSPEC
Date: Sat, 28 Jul 2018 09:06:34 +1000
Message-Id: <20180727230639.25413-4-mpe@ellerman.id.au>
In-Reply-To: <20180727230639.25413-1-mpe@ellerman.id.au>
References: <20180727230639.25413-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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

v5: Rename the config symbol to match the name of the barrier and the name we
use in the code, ie.  BARRIER_NOSPEC.

Don't introduce the freescale code in this patch.

Use BARRIER_NOSPEC in more places.

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5eb4d969afbf..aef1c4e049f1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -165,7 +165,7 @@ config PPC
 	select GENERIC_CLOCKEVENTS_BROADCAST	if SMP
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
-	select GENERIC_CPU_VULNERABILITIES	if PPC_BOOK3S_64
+	select GENERIC_CPU_VULNERABILITIES	if PPC_BARRIER_NOSPEC
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_SMP_IDLE_THREAD
@@ -241,6 +241,11 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 
+config PPC_BARRIER_NOSPEC
+    bool
+    default y
+    depends on PPC_BOOK3S_64
+
 config GENERIC_CSUM
 	def_bool n
 
diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index f67b3f6e36be..ec43375463ba 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -76,7 +76,7 @@ do {									\
 	___p1;								\
 })
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
@@ -86,10 +86,10 @@ do {									\
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
+#else /* !CONFIG_PPC_BARRIER_NOSPEC */
 #define barrier_nospec_asm
 #define barrier_nospec()
-#endif
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8721fd004291..8205f9fdfd67 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -56,7 +56,7 @@ void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 #else
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b255e4..dbe2cf04b406 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,9 +42,10 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_BARRIER_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 1b3c6835e730..77371c9ef3d8 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,13 +72,15 @@ int module_finalize(const Elf_Ehdr *hdr,
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
index 5baac79df97e..07ae018e550e 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,14 +153,16 @@ SECTIONS
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
index 8b69f868298c..0e604b41b5d1 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -304,6 +304,9 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_BARRIER_NOSPEC
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -313,8 +316,7 @@ void do_barrier_nospec_fixups(bool enable)
 
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_BARRIER_NOSPEC */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
-- 
2.14.1
