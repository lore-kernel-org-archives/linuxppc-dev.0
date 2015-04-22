Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E50C1A0317
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:40:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/3] powerpc/vdso: Disable building the 32-bit VDSO on little
 endian
Date: Wed, 22 Apr 2015 15:40:36 +1000
Message-Id: <1429681236-11644-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
References: <1429681236-11644-1-git-send-email-mpe@ellerman.id.au>
Cc: scottwood@freescale.com, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only little endian configuration we support is ppc64le. As such if
we're building little endian we don't need a 32-bit VDSO, because there
is no 32-bit userspace.

This patch is a fairly ugly mess of #ifdefs, but is the minimal logic
required to disable the 32-bit VDSO. We can hopefully clean up the
result in future with some further refactoring.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/vdso.h        |  1 +
 arch/powerpc/kernel/Makefile           |  3 ++-
 arch/powerpc/kernel/vdso.c             | 40 ++++++++++++++++++++++++++++++----
 arch/powerpc/platforms/Kconfig.cputype | 10 +++++++++
 4 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index c53f5f6d1761..f455adb471e7 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -19,6 +19,7 @@
 
 /* Offsets relative to thread->vdso_base */
 extern unsigned long vdso64_rt_sigtramp;
+
 extern unsigned long vdso32_sigtramp;
 extern unsigned long vdso32_rt_sigtramp;
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c1ebbdaac28f..87c7d1473488 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -33,11 +33,12 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o dma.o \
-				   misc_$(CONFIG_WORD_SIZE).o vdso32/ \
+				   misc_$(CONFIG_WORD_SIZE).o \
 				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
+obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 8331d0bef0fb..c2bd45187315 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -49,12 +49,15 @@
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
 
-extern char vdso32_start, vdso32_end;
-static void *vdso32_kbase = &vdso32_start;
 static unsigned int vdso32_pages;
+static void *vdso32_kbase;
 static struct page **vdso32_pagelist;
-unsigned long vdso32_sigtramp;
-unsigned long vdso32_rt_sigtramp;
+unsigned long vdso32_sigtramp = 0;
+unsigned long vdso32_rt_sigtramp = 0;
+
+#ifdef CONFIG_VDSO32
+extern char vdso32_start, vdso32_end;
+#endif
 
 #ifdef CONFIG_PPC64
 extern char vdso64_start, vdso64_end;
@@ -248,6 +251,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 
 
 
+#ifdef CONFIG_VDSO32
 static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
 				  unsigned long *size)
 {
@@ -335,6 +339,20 @@ static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
 
 	return 0;
 }
+#else /* !CONFIG_VDSO32 */
+static unsigned long __init find_function32(struct lib32_elfinfo *lib,
+					    const char *symname)
+{
+	return 0;
+}
+
+static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
+				       struct lib64_elfinfo *v64,
+				       const char *orig, const char *fix)
+{
+	return 0;
+}
+#endif /* CONFIG_VDSO32 */
 
 
 #ifdef CONFIG_PPC64
@@ -445,6 +463,7 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 	 * Locate symbol tables & text section
 	 */
 
+#ifdef CONFIG_VDSO32
 	v32->dynsym = find_section32(v32->hdr, ".dynsym", &v32->dynsymsize);
 	v32->dynstr = find_section32(v32->hdr, ".dynstr", NULL);
 	if (v32->dynsym == NULL || v32->dynstr == NULL) {
@@ -457,6 +476,7 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 		return -1;
 	}
 	v32->text = sect - vdso32_kbase;
+#endif
 
 #ifdef CONFIG_PPC64
 	v64->dynsym = find_section64(v64->hdr, ".dynsym", &v64->dynsymsize);
@@ -493,7 +513,9 @@ static __init void vdso_setup_trampolines(struct lib32_elfinfo *v32,
 static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 				       struct lib64_elfinfo *v64)
 {
+#ifdef CONFIG_VDSO32
 	Elf32_Sym *sym32;
+#endif
 #ifdef CONFIG_PPC64
 	Elf64_Sym *sym64;
 
@@ -508,6 +530,7 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 		(sym64->st_value - VDSO64_LBASE);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_VDSO32
 	sym32 = find_symbol32(v32, "__kernel_datapage_offset");
 	if (sym32 == NULL) {
 		printk(KERN_ERR "vDSO32: Can't find symbol "
@@ -517,6 +540,7 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 	*((int *)(vdso32_kbase + (sym32->st_value - VDSO32_LBASE))) =
 		(vdso32_pages << PAGE_SHIFT) -
 		(sym32->st_value - VDSO32_LBASE);
+#endif
 
 	return 0;
 }
@@ -550,6 +574,7 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				 start, start + size);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_VDSO32
 	start = find_section32(v32->hdr, "__ftr_fixup", &size);
 	if (start)
 		do_feature_fixups(cur_cpu_spec->cpu_features,
@@ -571,6 +596,7 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 	if (start)
 		do_lwsync_fixups(cur_cpu_spec->cpu_features,
 				 start, start + size);
+#endif
 
 	return 0;
 }
@@ -732,11 +758,15 @@ static int __init vdso_init(void)
 #endif /* CONFIG_PPC64 */
 
 
+#ifdef CONFIG_VDSO32
+	vdso32_kbase = &vdso32_start;
+
 	/*
 	 * Calculate the size of the 32 bits vDSO
 	 */
 	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
 	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
+#endif
 
 
 	/*
@@ -757,6 +787,7 @@ static int __init vdso_init(void)
 		return 0;
 	}
 
+#ifdef CONFIG_VDSO32
 	/* Make sure pages are in the correct state */
 	vdso32_pagelist = kzalloc(sizeof(struct page *) * (vdso32_pages + 2),
 				  GFP_KERNEL);
@@ -769,6 +800,7 @@ static int __init vdso_init(void)
 	}
 	vdso32_pagelist[i++] = virt_to_page(vdso_data);
 	vdso32_pagelist[i] = NULL;
+#endif
 
 #ifdef CONFIG_PPC64
 	vdso64_pagelist = kzalloc(sizeof(struct page *) * (vdso64_pages + 2),
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c8ae35f564fd..c140e94c7c72 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -405,6 +405,16 @@ config PPC_DOORBELL
 
 endmenu
 
+config VDSO32
+	def_bool y
+	depends on PPC32 || CPU_BIG_ENDIAN
+	help
+	  This symbol controls whether we build the 32-bit VDSO. We obviously
+	  want to do that if we're building a 32-bit kernel. If we're building
+	  a 64-bit kernel then we only want a 32-bit VDSO if we're building for
+	  big endian. That is because the only little endian configuration we
+	  support is ppc64le which is 64-bit only.
+
 choice
 	prompt "Endianness selection"
 	default CPU_BIG_ENDIAN
-- 
2.1.0
