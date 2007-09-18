Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BE541DDE25
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:04:06 +1000 (EST)
Date: Tue, 18 Sep 2007 16:03:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 16/28] 8xx: Move softemu8xx.c from arch/ppc
Message-ID: <20070918210326.GC19607@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, Soft_emulate_8xx was called with no implementation, resulting in
build failures whenever building 8xx without math emulation.  The
implementation is copied from arch/ppc to resolve this issue.

However, this sort of minimal emulation is not a very good idea other than
for compatibility with existing userspaces, as it's less efficient than
soft-float and can mislead users into believing they have soft-float.  Thus,
it is made a configurable option, off by default.
---
This replaces the old 16/28 "Don't call non-existent Soft_emulate_8xx from
SoftwareEmulation".

 arch/powerpc/Kconfig             |   11 ++
 arch/powerpc/kernel/Makefile     |    2 +
 arch/powerpc/kernel/softemu8xx.c |  202 ++++++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c      |    6 +-
 4 files changed, 220 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/kernel/softemu8xx.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2622f04..0c0329e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -180,6 +180,17 @@ config MATH_EMULATION
 	  unit, which will allow programs that use floating-point
 	  instructions to run.
 
+config 8XX_MINIMAL_FPEMU
+	bool "Minimal math emulation for 8xx"
+	depends on 8xx && !MATH_EMULATION
+	help
+	  Older arch/ppc kernels still emulated a few floating point
+	  instructions such as load and store, even when full math
+	  emulation is disabled.  Say "Y" here if you want to preserve
+	  this behavior.
+
+	  It is recommended that you build a soft-float userspace instead.
+
 config IOMMU_VMERGE
 	bool "Enable IOMMU virtual merging"
 	depends on PPC64
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 967afc5..0d7b68b 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -76,6 +76,8 @@ obj-$(CONFIG_KEXEC)		+= machine_kexec.o crash.o $(kexec-y)
 obj-$(CONFIG_AUDIT)		+= audit.o
 obj64-$(CONFIG_AUDIT)		+= compat_audit.o
 
+obj-$(CONFIG_8XX_MINIMAL_FPEMU) += softemu8xx.o
+
 ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
 obj-y				+= iomap.o
 endif
diff --git a/arch/powerpc/kernel/softemu8xx.c b/arch/powerpc/kernel/softemu8xx.c
new file mode 100644
index 0000000..67d6f68
--- /dev/null
+++ b/arch/powerpc/kernel/softemu8xx.c
@@ -0,0 +1,202 @@
+/*
+ * Software emulation of some PPC instructions for the 8xx core.
+ *
+ * Copyright (C) 1998 Dan Malek (dmalek@jlc.net)
+ *
+ * Software floating emuation for the MPC8xx processor.  I did this mostly
+ * because it was easier than trying to get the libraries compiled for
+ * software floating point.  The goal is still to get the libraries done,
+ * but I lost patience and needed some hacks to at least get init and
+ * shells running.  The first problem is the setjmp/longjmp that save
+ * and restore the floating point registers.
+ *
+ * For this emulation, our working registers are found on the register
+ * save area.
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/interrupt.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+/* Eventually we may need a look-up table, but this works for now.
+*/
+#define LFS	48
+#define LFD	50
+#define LFDU	51
+#define STFD	54
+#define STFDU	55
+#define FMR	63
+
+void print_8xx_pte(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	printk(" pte @ 0x%8lx: ", addr);
+	pgd = pgd_offset(mm, addr & PAGE_MASK);
+	if (pgd) {
+		pmd = pmd_offset(pud_offset(pgd, addr & PAGE_MASK),
+		                 addr & PAGE_MASK);
+		if (pmd && pmd_present(*pmd)) {
+			pte = pte_offset_kernel(pmd, addr & PAGE_MASK);
+			if (pte) {
+				printk(" (0x%08lx)->(0x%08lx)->0x%08lx\n",
+				        (long)pgd, (long)pte, (long)pte_val(*pte));
+#define pp ((long)pte_val(*pte))
+				printk(" RPN: %05lx PP: %lx SPS: %lx SH: %lx "
+				       "CI: %lx v: %lx\n",
+				       pp>>12,    /* rpn */
+				       (pp>>10)&3, /* pp */
+				       (pp>>3)&1, /* small */
+				       (pp>>2)&1, /* shared */
+				       (pp>>1)&1, /* cache inhibit */
+				       pp&1       /* valid */
+				       );
+#undef pp
+			}
+			else {
+				printk("no pte\n");
+			}
+		}
+		else {
+			printk("no pmd\n");
+		}
+	}
+	else {
+		printk("no pgd\n");
+	}
+}
+
+int get_8xx_pte(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	int retval = 0;
+
+	pgd = pgd_offset(mm, addr & PAGE_MASK);
+	if (pgd) {
+		pmd = pmd_offset(pud_offset(pgd, addr & PAGE_MASK),
+		                 addr & PAGE_MASK);
+		if (pmd && pmd_present(*pmd)) {
+			pte = pte_offset_kernel(pmd, addr & PAGE_MASK);
+			if (pte) {
+				retval = (int)pte_val(*pte);
+			}
+		}
+	}
+	return retval;
+}
+
+/*
+ * We return 0 on success, 1 on unimplemented instruction, and EFAULT
+ * if a load/store faulted.
+ */
+int Soft_emulate_8xx(struct pt_regs *regs)
+{
+	u32 inst, instword;
+	u32 flreg, idxreg, disp;
+	int retval;
+	s16 sdisp;
+	u32 *ea, *ip;
+
+	retval = 0;
+
+	instword = *((u32 *)regs->nip);
+	inst = instword >> 26;
+
+	flreg = (instword >> 21) & 0x1f;
+	idxreg = (instword >> 16) & 0x1f;
+	disp = instword & 0xffff;
+
+	ea = (u32 *)(regs->gpr[idxreg] + disp);
+	ip = (u32 *)&current->thread.fpr[flreg];
+
+	switch ( inst )
+	{
+	case LFD:
+		/* this is a 16 bit quantity that is sign extended
+		 * so use a signed short here -- Cort
+		 */
+		sdisp = (instword & 0xffff);
+		ea = (u32 *)(regs->gpr[idxreg] + sdisp);
+		if (copy_from_user(ip, ea, sizeof(double)))
+			retval = -EFAULT;
+		break;
+
+	case LFDU:
+		if (copy_from_user(ip, ea, sizeof(double)))
+			retval = -EFAULT;
+		else
+			regs->gpr[idxreg] = (u32)ea;
+		break;
+	case LFS:
+		sdisp = (instword & 0xffff);
+		ea = (u32 *)(regs->gpr[idxreg] + sdisp);
+		if (copy_from_user(ip, ea, sizeof(float)))
+			retval = -EFAULT;
+		break;
+	case STFD:
+		/* this is a 16 bit quantity that is sign extended
+		 * so use a signed short here -- Cort
+		 */
+		sdisp = (instword & 0xffff);
+		ea = (u32 *)(regs->gpr[idxreg] + sdisp);
+		if (copy_to_user(ea, ip, sizeof(double)))
+			retval = -EFAULT;
+		break;
+
+	case STFDU:
+		if (copy_to_user(ea, ip, sizeof(double)))
+			retval = -EFAULT;
+		else
+			regs->gpr[idxreg] = (u32)ea;
+		break;
+	case FMR:
+		/* assume this is a fp move -- Cort */
+		memcpy(ip, &current->thread.fpr[(instword>>11)&0x1f],
+		       sizeof(double));
+		break;
+	default:
+		retval = 1;
+		printk("Bad emulation %s/%d\n"
+		       " NIP: %08lx instruction: %08x opcode: %x "
+		       "A: %x B: %x C: %x code: %x rc: %x\n",
+		       current->comm,current->pid,
+		       regs->nip,
+		       instword,inst,
+		       (instword>>16)&0x1f,
+		       (instword>>11)&0x1f,
+		       (instword>>6)&0x1f,
+		       (instword>>1)&0x3ff,
+		       instword&1);
+		{
+			int pa;
+			print_8xx_pte(current->mm,regs->nip);
+			pa = get_8xx_pte(current->mm,regs->nip) & PAGE_MASK;
+			pa |= (regs->nip & ~PAGE_MASK);
+			pa = (unsigned long)__va(pa);
+			printk("Kernel VA for NIP %x ", pa);
+			print_8xx_pte(current->mm,pa);
+		}
+	}
+
+	if (retval == 0)
+		regs->nip += 4;
+
+	return retval;
+}
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index ccfc99d..81859ae 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -898,7 +898,9 @@ void SoftwareEmulation(struct pt_regs *regs)
 {
 	extern int do_mathemu(struct pt_regs *);
 	extern int Soft_emulate_8xx(struct pt_regs *);
+#if defined(CONFIG_MATH_EMULATION) || defined(CONFIG_8XX_MINIMAL_FPEMU)
 	int errcode;
+#endif
 
 	CHECK_FULL_REGS(regs);
 
@@ -928,7 +930,7 @@ void SoftwareEmulation(struct pt_regs *regs)
 		return;
 	}
 
-#else
+#elif defined(CONFIG_8XX_MINIMAL_FPEMU)
 	errcode = Soft_emulate_8xx(regs);
 	switch (errcode) {
 	case 0:
@@ -941,6 +943,8 @@ void SoftwareEmulation(struct pt_regs *regs)
 		_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
 		return;
 	}
+#else
+	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 #endif
 }
 #endif /* CONFIG_8xx */
-- 
1.5.3.1
