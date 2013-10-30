Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 18CE62C041C
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:24 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 31 Oct 2013 00:35:23 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A72D42CE804A
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:21 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UEZ9fm3735810
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:09 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UEZL8P011583
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 01:35:21 +1100
Subject: [RFC PATCH v5 07/12] powerpc/book3s: Flush SLB/TLBs if we get SLB/TLB
 machine check errors on power7.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2013 20:05:11 +0530
Message-ID: <20131030143510.26643.43743.stgit@mars>
In-Reply-To: <20131030143219.26643.24782.stgit@mars>
References: <20131030143219.26643.24782.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

If we get a machine check exception due to SLB or TLB errors, then flush
SLBs/TLBs and reload SLBs to recover. We do this in real mode before turning
on MMU. Otherwise we would run into nested machine checks.

If we get a machine check when we are in guest, then just flush the
SLBs and continue. This patch handles errors for power7. The next
patch will handle errors for power8

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/bitops.h |    5 +
 arch/powerpc/include/asm/mce.h    |   67 +++++++++++++++++
 arch/powerpc/kernel/Makefile      |    1 
 arch/powerpc/kernel/cputable.c    |    4 +
 arch/powerpc/kernel/mce_power.c   |  150 +++++++++++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+)
 create mode 100644 arch/powerpc/include/asm/mce.h
 create mode 100644 arch/powerpc/kernel/mce_power.c

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 910194e..a5e9a7d 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -46,6 +46,11 @@
 #include <asm/asm-compat.h>
 #include <asm/synch.h>
 
+/* PPC bit number conversion */
+#define PPC_BITLSHIFT(be)	(BITS_PER_LONG - 1 - (be))
+#define PPC_BIT(bit)		(1UL << PPC_BITLSHIFT(bit))
+#define PPC_BITMASK(bs, be)	((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(bs))
+
 /*
  * clear_bit doesn't imply a memory barrier
  */
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
new file mode 100644
index 0000000..8157d4e
--- /dev/null
+++ b/arch/powerpc/include/asm/mce.h
@@ -0,0 +1,67 @@
+/*
+ * Machine check exception header file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright 2013 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#ifndef __ASM_PPC64_MCE_H__
+#define __ASM_PPC64_MCE_H__
+
+#include <linux/bitops.h>
+
+/*
+ * Machine Check bits on power7 and power8
+ */
+#define P7_SRR1_MC_LOADSTORE(srr1)	((srr1) & PPC_BIT(42)) /* P8 too */
+
+/* SRR1 bits for machine check (On Power7 and Power8) */
+#define P7_SRR1_MC_IFETCH(srr1)	((srr1) & PPC_BITMASK(43, 45)) /* P8 too */
+
+#define P7_SRR1_MC_IFETCH_UE		(0x1 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_PARITY	(0x2 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_MULTIHIT	(0x3 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_SLB_BOTH	(0x4 << PPC_BITLSHIFT(45))
+#define P7_SRR1_MC_IFETCH_TLB_MULTIHIT	(0x5 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_UE_TLB_RELOAD	(0x6 << PPC_BITLSHIFT(45)) /* P8 too */
+#define P7_SRR1_MC_IFETCH_UE_IFU_INTERNAL	(0x7 << PPC_BITLSHIFT(45))
+
+/* SRR1 bits for machine check (On Power8) */
+#define P8_SRR1_MC_IFETCH_ERAT_MULTIHIT	(0x4 << PPC_BITLSHIFT(45))
+
+/* DSISR bits for machine check (On Power7 and Power8) */
+#define P7_DSISR_MC_UE			(PPC_BIT(48))	/* P8 too */
+#define P7_DSISR_MC_UE_TABLEWALK	(PPC_BIT(49))	/* P8 too */
+#define P7_DSISR_MC_ERAT_MULTIHIT	(PPC_BIT(52))	/* P8 too */
+#define P7_DSISR_MC_TLB_MULTIHIT_MFTLB	(PPC_BIT(53))	/* P8 too */
+#define P7_DSISR_MC_SLB_PARITY_MFSLB	(PPC_BIT(55))	/* P8 too */
+#define P7_DSISR_MC_SLB_MULTIHIT	(PPC_BIT(56))	/* P8 too */
+#define P7_DSISR_MC_SLB_MULTIHIT_PARITY	(PPC_BIT(57))	/* P8 too */
+
+/*
+ * DSISR bits for machine check (Power8) in addition to above.
+ * Secondary DERAT Multihit
+ */
+#define P8_DSISR_MC_ERAT_MULTIHIT_SEC	(PPC_BIT(54))
+
+/* SLB error bits */
+#define P7_DSISR_MC_SLB_ERRORS		(P7_DSISR_MC_ERAT_MULTIHIT | \
+					 P7_DSISR_MC_SLB_PARITY_MFSLB | \
+					 P7_DSISR_MC_SLB_MULTIHIT | \
+					 P7_DSISR_MC_SLB_MULTIHIT_PARITY)
+
+#endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 445cb6e..07c63d0 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= mce_power.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC_A2)		+= cpu_setup_a2.o
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 55d0f9c..c54188b 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -73,6 +73,7 @@ extern void __restore_cpu_power8(void);
 extern void __restore_cpu_a2(void);
 extern void __flush_tlb_power7(unsigned long inval_selector);
 extern void __flush_tlb_power8(unsigned long inval_selector);
+extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
 #if defined(CONFIG_E500)
 extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
@@ -443,6 +444,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
 		.flush_tlb		= __flush_tlb_power7,
+		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
 	{	/* 2.07-compliant processor, i.e. Power8 "architected" mode */
@@ -479,6 +481,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
 		.flush_tlb		= __flush_tlb_power7,
+		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7",
 	},
 	{	/* Power7+ */
@@ -498,6 +501,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_power7,
 		.cpu_restore		= __restore_cpu_power7,
 		.flush_tlb		= __flush_tlb_power7,
+		.machine_check_early	= __machine_check_early_realmode_p7,
 		.platform		= "power7+",
 	},
 	{	/* Power8E */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
new file mode 100644
index 0000000..6905473
--- /dev/null
+++ b/arch/powerpc/kernel/mce_power.c
@@ -0,0 +1,150 @@
+/*
+ * Machine check exception handling CPU-side for power7 and power8
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright 2013 IBM Corporation
+ * Author: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
+ */
+
+#undef DEBUG
+#define pr_fmt(fmt) "mce_power: " fmt
+
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <asm/mmu.h>
+#include <asm/mce.h>
+
+/* flush SLBs and reload */
+static void flush_and_reload_slb(void)
+{
+	struct slb_shadow *slb;
+	unsigned long i, n;
+
+	/* Invalidate all SLBs */
+	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
+
+#ifdef CONFIG_KVM_BOOK3S_HANDLER
+	/*
+	 * If machine check is hit when in guest or in transition, we will
+	 * only flush the SLBs and continue.
+	 */
+	if (get_paca()->kvm_hstate.in_guest)
+		return;
+#endif
+
+	/* For host kernel, reload the SLBs from shadow SLB buffer. */
+	slb = get_slb_shadow();
+	if (!slb)
+		return;
+
+	n = min_t(u32, slb->persistent, SLB_MIN_SIZE);
+
+	/* Load up the SLB entries from shadow SLB */
+	for (i = 0; i < n; i++) {
+		unsigned long rb = slb->save_area[i].esid;
+		unsigned long rs = slb->save_area[i].vsid;
+
+		rb = (rb & ~0xFFFul) | i;
+		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
+	}
+}
+
+static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
+{
+	long handled = 1;
+
+	/*
+	 * flush and reload SLBs for SLB errors and flush TLBs for TLB errors.
+	 * reset the error bits whenever we handle them so that at the end
+	 * we can check whether we handled all of them or not.
+	 * */
+	if (dsisr & slb_error_bits) {
+		flush_and_reload_slb();
+		/* reset error bits */
+		dsisr &= ~(slb_error_bits);
+	}
+	if (dsisr & P7_DSISR_MC_TLB_MULTIHIT_MFTLB) {
+		if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
+			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+		/* reset error bits */
+		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
+	}
+	/* Any other errors we don't understand? */
+	if (dsisr & 0xffffffffUL)
+		handled = 0;
+
+	return handled;
+}
+
+static long mce_handle_derror_p7(uint64_t dsisr)
+{
+	return mce_handle_derror(dsisr, P7_DSISR_MC_SLB_ERRORS);
+}
+
+static long mce_handle_common_ierror(uint64_t srr1)
+{
+	long handled = 0;
+
+	switch (P7_SRR1_MC_IFETCH(srr1)) {
+	case 0:
+		break;
+	case P7_SRR1_MC_IFETCH_SLB_PARITY:
+	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
+		/* flush and reload SLBs for SLB errors. */
+		flush_and_reload_slb();
+		handled = 1;
+		break;
+	case P7_SRR1_MC_IFETCH_TLB_MULTIHIT:
+		if (cur_cpu_spec && cur_cpu_spec->flush_tlb) {
+			cur_cpu_spec->flush_tlb(TLBIEL_INVAL_PAGE);
+			handled = 1;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return handled;
+}
+
+static long mce_handle_ierror_p7(uint64_t srr1)
+{
+	long handled = 0;
+
+	handled = mce_handle_common_ierror(srr1);
+
+	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
+		flush_and_reload_slb();
+		handled = 1;
+	}
+	return handled;
+}
+
+long __machine_check_early_realmode_p7(struct pt_regs *regs)
+{
+	uint64_t srr1;
+	long handled = 1;
+
+	srr1 = regs->msr;
+
+	if (P7_SRR1_MC_LOADSTORE(srr1))
+		handled = mce_handle_derror_p7(regs->dsisr);
+	else
+		handled = mce_handle_ierror_p7(srr1);
+
+	/* TODO: Decode machine check reason. */
+	return handled;
+}
