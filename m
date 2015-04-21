Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE46C1A0025
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2015 19:42:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc: Disable building the 32-bit VDSO on little endian
Date: Tue, 21 Apr 2015 19:41:52 +1000
Message-Id: <1429609312-32638-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1429609312-32638-1-git-send-email-mpe@ellerman.id.au>
References: <1429609312-32638-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.mj@au1.ibm.com, Anton Blanchard <anton@samba.org>
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
 arch/powerpc/kernel/Makefile           |  3 ++-
 arch/powerpc/kernel/signal_32.c        | 11 ++++++++--
 arch/powerpc/kernel/vdso.c             | 38 +++++++++++++++++++++++++++++++++-
 arch/powerpc/perf/callchain.c          |  5 +++++
 arch/powerpc/platforms/Kconfig.cputype | 10 +++++++++
 5 files changed, 63 insertions(+), 4 deletions(-)

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
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index d3a831ac0f92..561df3c153cc 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1011,10 +1011,14 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	/* Save user registers on the stack */
 	frame = &rt_sf->uc.uc_mcontext;
 	addr = frame;
+
+#ifdef CONFIG_VDSO32
 	if (vdso32_rt_sigtramp && current->mm->context.vdso_base) {
 		sigret = 0;
 		tramp = current->mm->context.vdso_base + vdso32_rt_sigtramp;
-	} else {
+	} else
+#endif
+	{
 		sigret = __NR_rt_sigreturn;
 		tramp = (unsigned long) frame->tramp;
 	}
@@ -1436,10 +1440,13 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs
 	    || __put_user(ksig->sig, &sc->signal))
 		goto badframe;
 
+#ifdef CONFIG_VDSO32
 	if (vdso32_sigtramp && current->mm->context.vdso_base) {
 		sigret = 0;
 		tramp = current->mm->context.vdso_base + vdso32_sigtramp;
-	} else {
+	} else
+#endif
+	{
 		sigret = __NR_sigreturn;
 		tramp = (unsigned long) frame->mctx.tramp;
 	}
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 305eb0d9b768..3cdf4e87917d 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -49,12 +49,14 @@
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
 
+#ifdef CONFIG_VDSO32
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
 static unsigned int vdso32_pages;
 static struct page **vdso32_pagelist;
 unsigned long vdso32_sigtramp;
 unsigned long vdso32_rt_sigtramp;
+#endif
 
 #ifdef CONFIG_PPC64
 extern char vdso64_start, vdso64_end;
@@ -159,6 +161,7 @@ static void dump_vdso_pages(struct vm_area_struct * vma)
 {
 	int i;
 
+#ifdef CONFIG_VDSO32
 	if (!vma || is_32bit_task()) {
 		printk("vDSO32 @ %016lx:\n", (unsigned long)vdso32_kbase);
 		for (i=0; i<vdso32_pages; i++) {
@@ -170,6 +173,8 @@ static void dump_vdso_pages(struct vm_area_struct * vma)
 			dump_one_vdso_page(pg, upg);
 		}
 	}
+#endif
+
 	if (!vma || !is_32bit_task()) {
 		printk("vDSO64 @ %016lx:\n", (unsigned long)vdso64_kbase);
 		for (i=0; i<vdso64_pages; i++) {
@@ -200,11 +205,14 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return 0;
 
 #ifdef CONFIG_PPC64
+#ifdef CONFIG_VDSO32
 	if (is_32bit_task()) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
 		vdso_base = VDSO32_MBASE;
-	} else {
+	} else
+#endif
+	{
 		vdso_pagelist = vdso64_pagelist;
 		vdso_pages = vdso64_pages;
 		/*
@@ -292,6 +300,7 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 
 
 
+#ifdef CONFIG_VDSO32
 static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
 				  unsigned long *size)
 {
@@ -314,7 +323,9 @@ static void * __init find_section32(Elf32_Ehdr *ehdr, const char *secname,
 	*size = 0;
 	return NULL;
 }
+#endif
 
+#ifdef CONFIG_VDSO32
 static Elf32_Sym * __init find_symbol32(struct lib32_elfinfo *lib,
 					const char *symname)
 {
@@ -334,7 +345,9 @@ static Elf32_Sym * __init find_symbol32(struct lib32_elfinfo *lib,
 	}
 	return NULL;
 }
+#endif
 
+#ifdef CONFIG_VDSO32
 /* Note that we assume the section is .text and the symbol is relative to
  * the library base
  */
@@ -379,6 +392,7 @@ static int __init vdso_do_func_patch32(struct lib32_elfinfo *v32,
 
 	return 0;
 }
+#endif
 
 
 #ifdef CONFIG_PPC64
@@ -489,6 +503,7 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 	 * Locate symbol tables & text section
 	 */
 
+#ifdef CONFIG_VDSO32
 	v32->dynsym = find_section32(v32->hdr, ".dynsym", &v32->dynsymsize);
 	v32->dynstr = find_section32(v32->hdr, ".dynstr", NULL);
 	if (v32->dynsym == NULL || v32->dynstr == NULL) {
@@ -501,6 +516,7 @@ static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 		return -1;
 	}
 	v32->text = sect - vdso32_kbase;
+#endif
 
 #ifdef CONFIG_PPC64
 	v64->dynsym = find_section64(v64->hdr, ".dynsym", &v64->dynsymsize);
@@ -530,14 +546,18 @@ static __init void vdso_setup_trampolines(struct lib32_elfinfo *v32,
 #ifdef CONFIG_PPC64
 	vdso64_rt_sigtramp = find_function64(v64, "__kernel_sigtramp_rt64");
 #endif
+#ifdef CONFIG_VDSO32
 	vdso32_sigtramp	   = find_function32(v32, "__kernel_sigtramp32");
 	vdso32_rt_sigtramp = find_function32(v32, "__kernel_sigtramp_rt32");
+#endif
 }
 
 static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 				       struct lib64_elfinfo *v64)
 {
+#ifdef CONFIG_VDSO32
 	Elf32_Sym *sym32;
+#endif
 #ifdef CONFIG_PPC64
 	Elf64_Sym *sym64;
 
@@ -552,6 +572,7 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 		(sym64->st_value - VDSO64_LBASE);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_VDSO32
 	sym32 = find_symbol32(v32, "__kernel_datapage_offset");
 	if (sym32 == NULL) {
 		printk(KERN_ERR "vDSO32: Can't find symbol "
@@ -561,6 +582,7 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 	*((int *)(vdso32_kbase + (sym32->st_value - VDSO32_LBASE))) =
 		(vdso32_pages << PAGE_SHIFT) -
 		(sym32->st_value - VDSO32_LBASE);
+#endif
 
 	return 0;
 }
@@ -569,8 +591,10 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				      struct lib64_elfinfo *v64)
 {
+#ifdef CONFIG_VDSO32
 	void *start32;
 	unsigned long size32;
+#endif
 
 #ifdef CONFIG_PPC64
 	void *start64;
@@ -597,6 +621,7 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				 start64, start64 + size64);
 #endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_VDSO32
 	start32 = find_section32(v32->hdr, "__ftr_fixup", &size32);
 	if (start32)
 		do_feature_fixups(cur_cpu_spec->cpu_features,
@@ -618,6 +643,7 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 	if (start32)
 		do_lwsync_fixups(cur_cpu_spec->cpu_features,
 				 start32, start32 + size32);
+#endif
 
 	return 0;
 }
@@ -643,8 +669,10 @@ static __init int vdso_fixup_alt_funcs(struct lib32_elfinfo *v32,
 		 * It would be easy to do, but doesn't seem to be necessary,
 		 * patching the OPD symbol is enough.
 		 */
+#ifdef CONFIG_VDSO32
 		vdso_do_func_patch32(v32, v64, patch->gen_name,
 				     patch->fix_name);
+#endif
 #ifdef CONFIG_PPC64
 		vdso_do_func_patch64(v32, v64, patch->gen_name,
 				     patch->fix_name);
@@ -660,7 +688,9 @@ static __init int vdso_setup(void)
 	struct lib32_elfinfo	v32;
 	struct lib64_elfinfo	v64;
 
+#ifdef CONFIG_VDSO32
 	v32.hdr = vdso32_kbase;
+#endif
 #ifdef CONFIG_PPC64
 	v64.hdr = vdso64_kbase;
 #endif
@@ -779,11 +809,13 @@ static int __init vdso_init(void)
 #endif /* CONFIG_PPC64 */
 
 
+#ifdef CONFIG_VDSO32
 	/*
 	 * Calculate the size of the 32 bits vDSO
 	 */
 	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
 	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
+#endif
 
 
 	/*
@@ -797,13 +829,16 @@ static int __init vdso_init(void)
 	 */
 	if (vdso_setup()) {
 		printk(KERN_ERR "vDSO setup failure, not enabled !\n");
+#ifdef CONFIG_VDSO32
 		vdso32_pages = 0;
+#endif
 #ifdef CONFIG_PPC64
 		vdso64_pages = 0;
 #endif
 		return 0;
 	}
 
+#ifdef CONFIG_VDSO32
 	/* Make sure pages are in the correct state */
 	vdso32_pagelist = kzalloc(sizeof(struct page *) * (vdso32_pages + 2),
 				  GFP_KERNEL);
@@ -816,6 +851,7 @@ static int __init vdso_init(void)
 	}
 	vdso32_pagelist[i++] = virt_to_page(vdso_data);
 	vdso32_pagelist[i] = NULL;
+#endif
 
 #ifdef CONFIG_PPC64
 	vdso64_pagelist = kzalloc(sizeof(struct page *) * (vdso64_pages + 2),
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index ead55351b254..4ebb6640b23f 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -364,9 +364,11 @@ static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
 {
 	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
 		return 1;
+#ifdef CONFIG_VDSO32
 	if (vdso32_sigtramp && current->mm->context.vdso_base &&
 	    nip == current->mm->context.vdso_base + vdso32_sigtramp)
 		return 1;
+#endif
 	return 0;
 }
 
@@ -375,9 +377,12 @@ static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
 	if (nip == fp + offsetof(struct rt_signal_frame_32,
 				 uc.uc_mcontext.mc_pad))
 		return 1;
+
+#ifdef CONFIG_VDSO32
 	if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
 	    nip == current->mm->context.vdso_base + vdso32_rt_sigtramp)
 		return 1;
+#endif
 	return 0;
 }
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 12fc443b9d54..1324f589f43a 100644
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
