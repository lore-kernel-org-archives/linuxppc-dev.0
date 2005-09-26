Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc64-dev@ozlabs.org
Date: Mon, 26 Sep 2005 11:57:36 +1000
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<20050924104827.114939ca.sfr@canb.auug.org.au>
	<BCC97EBE-6171-4FF9-A696-B98B11046391@freescale.com>
In-Reply-To: <BCC97EBE-6171-4FF9-A696-B98B11046391@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200509261157.37514.michael@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 25 Sep 2005 01:35, Kumar Gala wrote:
> On Sep 23, 2005, at 7:48 PM, Stephen Rothwell wrote:
> > On Sat, 24 Sep 2005 10:04:12 +1000 Paul Mackerras
> >
> > <paulus@samba.org> wrote:
> >> Kumar Gala writes:
> >>> +#ifdef __powerpc64__
> >>> +extern struct cpu_spec        *cur_cpu_spec;
> >>> +#else /* __powerpc64__ */
> >>> +extern struct cpu_spec        *cur_cpu_spec[];
> >>> +#endif /* __powerpc64__ */
> >>
> >> I would like to see this unified - it makes no sense for them to be
> >> different.  We are unlikely to support asymmetric multiprocessing any
> >> time soon, so let's go with the single cur_cpu_spec pointer (a la
> >> ppc64).
> >
> > Michael Ellerman also has a patch that makes this a struct (i.e. not a
> > pointer) which allows us to mark the array of cpuspec's that we test
> > against at boot time as __init.  Maybe he could do the ppc32 single
> > cpu_spec as part of that.
>
> I'm all for unifying this as well.  If Michael can post his patch
> I'll look at fixing up this issue. Let's merge the current patch and
> follow it up with an update that includes this fix and Michael's work.

Here's a version of my patch updated to apply on top of the merge tree.
It'll be a lot cleaner when ppc32 has a single cur_cpu_spec, as we'll
be able to remove a lot of the #ifdefs.

cheers

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---

 arch/powerpc/oprofile/common.c          |    8 +++----
 arch/powerpc/oprofile/op_model_power4.c |    6 ++---
 arch/ppc64/kernel/asm-offsets.c         |    4 ---
 arch/ppc64/kernel/cputable.c            |   33 ++++++++++++++++++++++++++------
 arch/ppc64/kernel/head.S                |   11 ----------
 arch/ppc64/kernel/idle_power4.S         |    5 +---
 arch/ppc64/kernel/misc.S                |   32 -------------------------------
 arch/ppc64/kernel/prom.c                |   12 +++++------
 arch/ppc64/kernel/setup.c               |    8 +++----
 arch/ppc64/kernel/sysfs.c               |   32 +++++++++++++++----------------
 include/asm-powerpc/cputable.h          |   24 +++++++++++++++++------
 include/asm-powerpc/elf.h               |    2 -

Index: kexec/include/asm-powerpc/cputable.h
===================================================================
--- kexec.orig/include/asm-powerpc/cputable.h
+++ kexec/include/asm-powerpc/cputable.h
@@ -26,7 +26,7 @@ struct cpu_spec;
 struct op_powerpc_model;
 
 #ifdef __powerpc64__
-typedef	void (*cpu_setup_t)(unsigned long offset, struct cpu_spec* spec);
+typedef	void (*cpu_setup_t)(struct cpu_spec* spec);
 #else /* __powerpc64__ */
 typedef	void (*cpu_setup_t)(unsigned long offset, int cpu_nr, struct cpu_spec* spec);
 #endif /* __powerpc64__ */
@@ -61,10 +61,10 @@ struct cpu_spec {
 #endif /* __powerpc64__ */
 };
 
-extern struct cpu_spec		cpu_specs[];
+extern void identify_cpu(void);
 
 #ifdef __powerpc64__
-extern struct cpu_spec		*cur_cpu_spec;
+extern struct cpu_spec		cur_cpu_spec;
 #else /* __powerpc64__ */
 extern struct cpu_spec		*cur_cpu_spec[];
 #endif /* __powerpc64__ */
@@ -398,14 +398,26 @@ static inline int cpu_has_feature(unsign
 {
 	return (CPU_FTRS_ALWAYS & feature) ||
 	       (CPU_FTRS_POSSIBLE
-#ifndef __powerpc64__
-		& cur_cpu_spec[0]->cpu_features
+#ifdef __powerpc64__
+		& cur_cpu_spec.cpu_features
 #else
-		& cur_cpu_spec->cpu_features
+		& cur_cpu_spec[0].cpu_features
 #endif
 		& feature);
 }
 
+#ifdef __powerpc64__
+static inline void cpu_set_feature(unsigned long feature)
+{
+	cur_cpu_spec.cpu_features |= feature;
+}
+
+static inline void cpu_unset_feature(unsigned long feature)
+{
+	cur_cpu_spec.cpu_features &= ~feature;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
Index: kexec/arch/ppc64/kernel/cputable.c
===================================================================
--- kexec.orig/arch/ppc64/kernel/cputable.c
+++ kexec/arch/ppc64/kernel/cputable.c
@@ -22,7 +22,7 @@
 #include <asm/oprofile_impl.h>
 #include <asm/cputable.h>
 
-struct cpu_spec* cur_cpu_spec = NULL;
+struct cpu_spec cur_cpu_spec;
 EXPORT_SYMBOL(cur_cpu_spec);
 
 /* NOTE:
@@ -32,12 +32,12 @@ EXPORT_SYMBOL(cur_cpu_spec);
  * part of the cputable though. That has to be fixed for both ppc32
  * and ppc64
  */
-extern void __setup_cpu_power3(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_power4(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
-extern void __setup_cpu_be(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_power3(struct cpu_spec* spec);
+extern void __setup_cpu_power4(struct cpu_spec* spec);
+extern void __setup_cpu_ppc970(struct cpu_spec* spec);
+extern void __setup_cpu_be(struct cpu_spec* spec);
 
-struct cpu_spec	cpu_specs[] = {
+static __initdata struct cpu_spec cpu_specs[] = {
 	{	/* Power3 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00400000,
@@ -258,3 +258,24 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power4,
 	}
 };
+
+void __init identify_cpu(void)
+{
+	unsigned int pvr, mask, value;
+	int i;
+
+	pvr = mfspr(SPRN_PVR);
+
+	/* We rely on the default match at the end of the cpu_spec array */
+	for (i = 0; ; i++) {
+		mask  = cpu_specs[i].pvr_mask;
+		value = cpu_specs[i].pvr_value;
+
+		if ((pvr & mask) == value)
+			break;
+	}
+
+	cur_cpu_spec = cpu_specs[i];
+
+	cur_cpu_spec.cpu_setup(&cur_cpu_spec);
+}
Index: kexec/arch/ppc64/kernel/asm-offsets.c
===================================================================
--- kexec.orig/arch/ppc64/kernel/asm-offsets.c
+++ kexec/arch/ppc64/kernel/asm-offsets.c
@@ -165,11 +165,7 @@ int main(void)
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 
 	/* About the CPU features table */
-	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
-	DEFINE(CPU_SPEC_PVR_MASK, offsetof(struct cpu_spec, pvr_mask));
-	DEFINE(CPU_SPEC_PVR_VALUE, offsetof(struct cpu_spec, pvr_value));
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
-	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
 	/* systemcfg offsets for use by vdso */
 	DEFINE(CFG_TB_ORIG_STAMP, offsetof(struct systemcfg, tb_orig_stamp));
Index: kexec/arch/ppc64/kernel/head.S
===================================================================
--- kexec.orig/arch/ppc64/kernel/head.S
+++ kexec/arch/ppc64/kernel/head.S
@@ -1354,15 +1354,11 @@ _STATIC(__start_initialization_iSeries)
 	li	r0,0
 	stdu	r0,-STACK_FRAME_OVERHEAD(r1)
 
-	LOADADDR(r3,cpu_specs)
-	LOADADDR(r4,cur_cpu_spec)
-	li	r5,0
-	bl	.identify_cpu
-
 	LOADADDR(r2,__toc_start)
 	addi	r2,r2,0x4000
 	addi	r2,r2,0x4000
 
+	bl	.identify_cpu
 	bl	.iSeries_early_setup
 
 	/* relocation is on at this point */
@@ -1771,11 +1767,6 @@ _STATIC(start_here_multiplatform)
 	addi	r2,r2,0x4000
 	sub	r2,r2,r26
 
-	LOADADDR(r3,cpu_specs)
-	sub	r3,r3,r26
-	LOADADDR(r4,cur_cpu_spec)
-	sub	r4,r4,r26
-	mr	r5,r26
 	bl	.identify_cpu
 
 	/* Save some low level config HIDs of CPU0 to be copied to
Index: kexec/arch/ppc64/kernel/misc.S
===================================================================
--- kexec.orig/arch/ppc64/kernel/misc.S
+++ kexec/arch/ppc64/kernel/misc.S
@@ -508,35 +508,6 @@ _GLOBAL(cvt_df)
 	blr
 
 /*
- * identify_cpu and calls setup_cpu
- * In:	r3 = base of the cpu_specs array
- *	r4 = address of cur_cpu_spec
- *	r5 = relocation offset
- */
-_GLOBAL(identify_cpu)
-	mfpvr	r7
-1:
-	lwz	r8,CPU_SPEC_PVR_MASK(r3)
-	and	r8,r8,r7
-	lwz	r9,CPU_SPEC_PVR_VALUE(r3)
-	cmplw	0,r9,r8
-	beq	1f
-	addi	r3,r3,CPU_SPEC_ENTRY_SIZE
-	b	1b
-1:
-	add	r0,r3,r5
-	std	r0,0(r4)
-	ld	r4,CPU_SPEC_SETUP(r3)
-	sub	r4,r4,r5
-	ld	r4,0(r4)
-	sub	r4,r4,r5
-	mtctr	r4
-	/* Calling convention for cpu setup is r3=offset, r4=cur_cpu_spec */
-	mr	r4,r3
-	mr	r3,r5
-	bctr
-
-/*
  * do_cpu_ftr_fixups - goes through the list of CPU feature fixups
  * and writes nop's over sections of code that don't apply for this cpu.
  * r3 = data offset (not changed)
@@ -545,9 +516,8 @@ _GLOBAL(do_cpu_ftr_fixups)
 	/* Get CPU 0 features */
 	LOADADDR(r6,cur_cpu_spec)
 	sub	r6,r6,r3
-	ld	r4,0(r6)
+	ld	r4,CPU_SPEC_FEATURES(r6)
 	sub	r4,r4,r3
-	ld	r4,CPU_SPEC_FEATURES(r4)
 	/* Get the fixup table */
 	LOADADDR(r6,__start___ftr_fixup)
 	sub	r6,r6,r3
Index: kexec/arch/ppc64/kernel/idle_power4.S
===================================================================
--- kexec.orig/arch/ppc64/kernel/idle_power4.S
+++ kexec/arch/ppc64/kernel/idle_power4.S
@@ -38,9 +38,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	/* We must dynamically check for the NAP feature as it
 	 * can be cleared by CPU init after the fixups are done
 	 */
-	LOADBASE(r3,cur_cpu_spec)
-	ld	r4,cur_cpu_spec@l(r3)
-	ld	r4,CPU_SPEC_FEATURES(r4)
+	LOADADDR(r3,cur_cpu_spec)
+	ld	r4,CPU_SPEC_FEATURES(r3)
 	andi.	r0,r4,CPU_FTR_CAN_NAP
 	beqlr
 	/* Now check if user or arch enabled NAP mode */
Index: kexec/arch/ppc64/kernel/prom.c
===================================================================
--- kexec.orig/arch/ppc64/kernel/prom.c
+++ kexec/arch/ppc64/kernel/prom.c
@@ -1032,15 +1032,15 @@ static int __init early_init_dt_scan_cpu
 	/* Check if we have a VMX and eventually update CPU features */
 	prop = (u32 *)get_flat_dt_prop(node, "ibm,vmx", NULL);
 	if (prop && (*prop) > 0) {
-		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
-		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+		cpu_set_feature(CPU_FTR_ALTIVEC);
+		cpu_set_feature(PPC_FEATURE_HAS_ALTIVEC);
 	}
 
 	/* Same goes for Apple's "altivec" property */
 	prop = (u32 *)get_flat_dt_prop(node, "altivec", NULL);
 	if (prop) {
-		cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
-		cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+		cpu_set_feature(CPU_FTR_ALTIVEC);
+		cpu_set_feature(PPC_FEATURE_HAS_ALTIVEC);
 	}
 #endif /* CONFIG_ALTIVEC */
 
@@ -1051,9 +1051,9 @@ static int __init early_init_dt_scan_cpu
 	 */
 	prop = (u32 *)get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s",
 				       &size);
-	cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
+	cpu_unset_feature(CPU_FTR_SMT);
 	if (prop && ((size / sizeof(u32)) > 1))
-		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+		cpu_set_feature(CPU_FTR_SMT);
 
 	return 0;
 }
Index: kexec/arch/ppc64/kernel/setup.c
===================================================================
--- kexec.orig/arch/ppc64/kernel/setup.c
+++ kexec/arch/ppc64/kernel/setup.c
@@ -448,7 +448,7 @@ static void __init initialize_cache_info
 			}
 
 			size = 0;
-			lsize = cur_cpu_spec->dcache_bsize;
+			lsize = cur_cpu_spec.dcache_bsize;
 			sizep = (u32 *)get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
@@ -466,7 +466,7 @@ static void __init initialize_cache_info
 			ppc64_caches.dlines_per_page = PAGE_SIZE / lsize;
 
 			size = 0;
-			lsize = cur_cpu_spec->icache_bsize;
+			lsize = cur_cpu_spec.icache_bsize;
 			sizep = (u32 *)get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
@@ -736,8 +736,8 @@ static int show_cpuinfo(struct seq_file 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "cpu\t\t: ");
 
-	if (cur_cpu_spec->pvr_mask)
-		seq_printf(m, "%s", cur_cpu_spec->cpu_name);
+	if (cur_cpu_spec.pvr_mask)
+		seq_printf(m, "%s", cur_cpu_spec.cpu_name);
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
 
Index: kexec/arch/ppc64/kernel/sysfs.c
===================================================================
--- kexec.orig/arch/ppc64/kernel/sysfs.c
+++ kexec/arch/ppc64/kernel/sysfs.c
@@ -215,21 +215,21 @@ static void register_cpu_online(unsigned
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_create_file(s, &attr_mmcra);
 
-	if (cur_cpu_spec->num_pmcs >= 1)
+	if (cur_cpu_spec.num_pmcs >= 1)
 		sysdev_create_file(s, &attr_pmc1);
-	if (cur_cpu_spec->num_pmcs >= 2)
+	if (cur_cpu_spec.num_pmcs >= 2)
 		sysdev_create_file(s, &attr_pmc2);
-	if (cur_cpu_spec->num_pmcs >= 3)
+	if (cur_cpu_spec.num_pmcs >= 3)
 		sysdev_create_file(s, &attr_pmc3);
-	if (cur_cpu_spec->num_pmcs >= 4)
+	if (cur_cpu_spec.num_pmcs >= 4)
 		sysdev_create_file(s, &attr_pmc4);
-	if (cur_cpu_spec->num_pmcs >= 5)
+	if (cur_cpu_spec.num_pmcs >= 5)
 		sysdev_create_file(s, &attr_pmc5);
-	if (cur_cpu_spec->num_pmcs >= 6)
+	if (cur_cpu_spec.num_pmcs >= 6)
 		sysdev_create_file(s, &attr_pmc6);
-	if (cur_cpu_spec->num_pmcs >= 7)
+	if (cur_cpu_spec.num_pmcs >= 7)
 		sysdev_create_file(s, &attr_pmc7);
-	if (cur_cpu_spec->num_pmcs >= 8)
+	if (cur_cpu_spec.num_pmcs >= 8)
 		sysdev_create_file(s, &attr_pmc8);
   
 	if (cpu_has_feature(CPU_FTR_SMT))
@@ -257,21 +257,21 @@ static void unregister_cpu_online(unsign
 	if (cpu_has_feature(CPU_FTR_MMCRA))
 		sysdev_remove_file(s, &attr_mmcra);
 
-	if (cur_cpu_spec->num_pmcs >= 1)
+	if (cur_cpu_spec.num_pmcs >= 1)
 		sysdev_remove_file(s, &attr_pmc1);
-	if (cur_cpu_spec->num_pmcs >= 2)
+	if (cur_cpu_spec.num_pmcs >= 2)
 		sysdev_remove_file(s, &attr_pmc2);
-	if (cur_cpu_spec->num_pmcs >= 3)
+	if (cur_cpu_spec.num_pmcs >= 3)
 		sysdev_remove_file(s, &attr_pmc3);
-	if (cur_cpu_spec->num_pmcs >= 4)
+	if (cur_cpu_spec.num_pmcs >= 4)
 		sysdev_remove_file(s, &attr_pmc4);
-	if (cur_cpu_spec->num_pmcs >= 5)
+	if (cur_cpu_spec.num_pmcs >= 5)
 		sysdev_remove_file(s, &attr_pmc5);
-	if (cur_cpu_spec->num_pmcs >= 6)
+	if (cur_cpu_spec.num_pmcs >= 6)
 		sysdev_remove_file(s, &attr_pmc6);
-	if (cur_cpu_spec->num_pmcs >= 7)
+	if (cur_cpu_spec.num_pmcs >= 7)
 		sysdev_remove_file(s, &attr_pmc7);
-	if (cur_cpu_spec->num_pmcs >= 8)
+	if (cur_cpu_spec.num_pmcs >= 8)
 		sysdev_remove_file(s, &attr_pmc8);
 
 	if (cpu_has_feature(CPU_FTR_SMT))
Index: kexec/arch/powerpc/oprofile/common.c
===================================================================
--- kexec.orig/arch/powerpc/oprofile/common.c
+++ kexec/arch/powerpc/oprofile/common.c
@@ -173,12 +173,12 @@ int __init oprofile_arch_init(struct opr
 
 	ops->cpu_type = cpu_type;
 #else /* __powerpc64__ */
-	if (!cur_cpu_spec->oprofile_model || !cur_cpu_spec->oprofile_cpu_type)
+	if (!cur_cpu_spec.oprofile_model || !cur_cpu_spec.oprofile_cpu_type)
 		return -ENODEV;
-	model = cur_cpu_spec->oprofile_model;
-	model->num_counters = cur_cpu_spec->num_pmcs;
+	model = cur_cpu_spec.oprofile_model;
+	model->num_counters = cur_cpu_spec.num_pmcs;
 
-	ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
+	ops->cpu_type = cur_cpu_spec.oprofile_cpu_type;
 #endif /* __powerpc64__ */
 	ops->create_files = op_powerpc_create_files;
 	ops->setup = op_powerpc_setup;
Index: kexec/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- kexec.orig/arch/powerpc/oprofile/op_model_power4.c
+++ kexec/arch/powerpc/oprofile/op_model_power4.c
@@ -64,7 +64,7 @@ static void power4_reg_setup(struct op_c
 
 	backtrace_spinlocks = sys->backtrace_spinlocks;
 
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i)
+	for (i = 0; i < cur_cpu_spec.num_pmcs; ++i)
 		reset_value[i] = 0x80000000UL - ctr[i].count;
 
 	/* setup user and kernel profiling */
@@ -117,7 +117,7 @@ static void power4_start(struct op_count
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
 
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
+	for (i = 0; i < cur_cpu_spec.num_pmcs; ++i) {
 		if (ctr[i].enabled) {
 			ctr_write(i, reset_value[i]);
 		} else {
@@ -268,7 +268,7 @@ static void power4_handle_interrupt(stru
 	/* set the PMM bit (see comment below) */
 	mtmsrd(mfmsr() | MSR_PMM);
 
-	for (i = 0; i < cur_cpu_spec->num_pmcs; ++i) {
+	for (i = 0; i < cur_cpu_spec.num_pmcs; ++i) {
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
Index: kexec/include/asm-powerpc/elf.h
===================================================================
--- kexec.orig/include/asm-powerpc/elf.h
+++ kexec/include/asm-powerpc/elf.h
@@ -213,7 +213,7 @@ extern int dump_task_fpu(struct task_str
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
 #ifdef __powerpc64__
-# define ELF_HWCAP	(cur_cpu_spec->cpu_user_features)
+# define ELF_HWCAP	(cur_cpu_spec.cpu_user_features)
 # define ELF_PLAT_INIT(_r, load_addr)	do { \
 	memset(_r->gpr, 0, sizeof(_r->gpr)); \
 	_r->ctr = _r->link = _r->xer = _r->ccr = 0; \
