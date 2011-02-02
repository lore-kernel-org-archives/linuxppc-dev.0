Return-Path: <aik@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 12CD7B7103
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 17:22:57 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p126Mrk0030740
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 17:22:53 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p126MtQ62449454
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 17:22:56 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p126MtDr014045
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 17:22:55 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p126MtBL014042
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Feb 2011 17:22:55 +1100
Received: from [10.61.2.175] (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9962973440
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Feb 2011 17:22:55 +1100 (EST)
Message-ID: <4D48F843.7060404@au1.ibm.com>
Date: Wed, 02 Feb 2011 17:22:59 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Per process DSCR + somefixes
Content-Type: multipart/mixed; boundary="------------040404070806050701050907"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040404070806050701050907
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This is reworked http://patchwork.ozlabs.org/patch/71489/

Originally there were 4 questions left:

1. /sys/devices/system/cpu/cpu##/dscr
It is left as is.

2. Out of band method of changing the DSCR:
Introduced new /sys/devices/system/cpu/dscr_default and "dscr_inherit" 
flag for a thread's DSCR which is used in copy_thread to decide whether 
to inherit a DSCR value or not.
The "inherit" flag is set when:
- DSCR has been explicitly changed by writing DSCR;
- a parent process has this flag set;
- dscr_default is not 0 at the moment of fork().
In all other cases DSCR remains zero.

3. improve context switch speed.
Done :-)

4. About disabling the feature when there is "no stinking DSCR".
The calls likes:
cpu_has_feature(CPU_FTR_DSCR)
and
BEGIN_FTR_SECTION
END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
ensure that DSCR is not accessed on systems which do not support it.

Tested on power5, power6, power7.


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail/sametime: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM



--------------040404070806050701050907
Content-Type: text/x-patch;
 name="dscr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dscr.patch"

diff --git a/arch/powerpc/include/asm/emulated_ops.h b/arch/powerpc/include/asm/emulated_ops.h
index f0fb4fc..4592167 100644
--- a/arch/powerpc/include/asm/emulated_ops.h
+++ b/arch/powerpc/include/asm/emulated_ops.h
@@ -52,6 +52,10 @@ extern struct ppc_emulated {
 #ifdef CONFIG_VSX
 	struct ppc_emulated_entry vsx;
 #endif
+#ifdef CONFIG_PPC64
+	struct ppc_emulated_entry mfdscr;
+	struct ppc_emulated_entry mtdscr;
+#endif
 } ppc_emulated;
 
 extern u32 ppc_warn_emulated;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 43adc8b..4141be8 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -39,6 +39,10 @@
 #define PPC_INST_RFCI			0x4c000066
 #define PPC_INST_RFDI			0x4c00004e
 #define PPC_INST_RFMCI			0x4c00004c
+#define PPC_INST_MFSPR_DSCR		0x7c1102a6
+#define PPC_INST_MFSPR_DSCR_MASK	0xfc1fffff
+#define PPC_INST_MTSPR_DSCR		0x7c1103a6
+#define PPC_INST_MTSPR_DSCR_MASK	0xfc1fffff
 
 #define PPC_INST_STRING			0x7c00042a
 #define PPC_INST_STRING_MASK		0xfc0007fe
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 4c14187..b60a5c5 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -240,6 +240,10 @@ struct thread_struct {
 #ifdef CONFIG_KVM_BOOK3S_32_HANDLER
 	void*		kvm_shadow_vcpu; /* KVM internal data */
 #endif /* CONFIG_KVM_BOOK3S_32_HANDLER */
+#ifdef CONFIG_PPC64
+	unsigned long	dscr;
+	int		dscr_inherit;
+#endif
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index bd0df2e..f2236ff 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -74,6 +74,7 @@ int main(void)
 	DEFINE(AUDITCONTEXT, offsetof(struct task_struct, audit_context));
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
+	DEFINE(THREAD_DSCR, offsetof(struct thread_struct, dscr));
 #else
 	DEFINE(THREAD_INFO, offsetof(struct task_struct, stack));
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d82878c..e4d3b3f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -421,6 +421,12 @@ BEGIN_FTR_SECTION
 	std	r24,THREAD_VRSAVE(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	mfspr	r25,SPRN_DSCR
+	std	r25,THREAD_DSCR(r3)
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
@@ -522,6 +528,15 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
+#ifdef CONFIG_PPC64
+BEGIN_FTR_SECTION
+	ld	r0,THREAD_DSCR(r4)
+	cmpd	r0,r25
+	beq	1f
+	mtspr	SPRN_DSCR,r0
+1:	
+END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
+#endif
 
 	/* r3-r13 are destroyed -- Cort */
 	REST_8GPRS(14, r1)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 84906d3..79940b0 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -700,6 +700,8 @@ void prepare_to_copy(struct task_struct *tsk)
 /*
  * Copy a thread..
  */
+extern volatile unsigned long dscr_default; /* defined in arch/powerpc/kernel/sysfs.c */
+
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long unused, struct task_struct *p,
 		struct pt_regs *regs)
@@ -768,6 +770,21 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 	}
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
+#ifdef CONFIG_PPC64 
+	if (cpu_has_feature(CPU_FTR_DSCR)) {
+		if (current->thread.dscr_inherit) {
+			p->thread.dscr_inherit = 1;
+			p->thread.dscr = current->thread.dscr;
+		} else if (0 != dscr_default) {
+			p->thread.dscr_inherit = 1;
+			p->thread.dscr = dscr_default;
+		} else {
+			p->thread.dscr_inherit = 0;
+			p->thread.dscr = 0;
+		}
+	}
+#endif
+
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
 	 * pointers.  The function (ret_from_except) is actually a pointer
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index c0d8c20..1e0ef79 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -182,6 +182,37 @@ static SYSDEV_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
 static SYSDEV_ATTR(spurr, 0600, show_spurr, NULL);
 static SYSDEV_ATTR(dscr, 0600, show_dscr, store_dscr);
 static SYSDEV_ATTR(purr, 0600, show_purr, store_purr);
+
+unsigned long dscr_default = 0;
+EXPORT_SYMBOL(dscr_default);
+
+static ssize_t show_dscr_default(struct sys_device *class,
+		struct sysdev_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%lx\n", dscr_default);
+}
+
+static ssize_t __used store_dscr_default(struct sys_device *class,
+		struct sysdev_attribute *attr, const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret = sscanf(buf, "%lx", &val);
+	if (ret != 1)
+		return -EINVAL;
+	dscr_default = val;
+	return count;
+}
+
+static SYSDEV_ATTR(dscr_default, 0600, show_dscr_default, store_dscr_default);
+
+static void sysfs_create_dscr_default(void)
+{
+	int err = 0;
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		err = sysfs_create_file(&cpu_sysdev_class.kset.kobj,
+			&attr_dscr_default.attr);
+}
+
 #endif /* CONFIG_PPC64 */
 
 #ifdef HAS_PPC_PMC_PA6T
@@ -618,6 +649,10 @@ static int __init topology_init(void)
 			register_cpu_online(cpu);
 	}
 
+#ifdef CONFIG_PPC64
+	sysfs_create_dscr_default();
+#endif /* CONFIG_PPC64 */
+
 	return 0;
 }
 subsys_initcall(topology_init);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1b2cdc8..443e9ac 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -919,6 +919,27 @@ static int emulate_instruction(struct pt_regs *regs)
 		return emulate_isel(regs, instword);
 	}
 
+#ifdef CONFIG_PPC64
+	/* Emulate the mfspr rD, DSCR. */
+	if (((instword & PPC_INST_MFSPR_DSCR_MASK) == PPC_INST_MFSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mfdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_DSCR);
+		return 0;
+	}
+
+	/* Emulate the mtspr DSCR, rD. */
+	if (((instword & PPC_INST_MTSPR_DSCR_MASK) == PPC_INST_MTSPR_DSCR) &&
+			cpu_has_feature(CPU_FTR_DSCR)) {
+		PPC_WARN_EMULATED(mtdscr, regs);
+		rd = (instword >> 21) & 0x1f;
+		mtspr(SPRN_DSCR, regs->gpr[rd]);
+		current->thread.dscr_inherit = 1;
+		return 0;
+	}
+#endif
+
 	return -EINVAL;
 }
 

--------------040404070806050701050907--
