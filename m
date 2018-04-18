Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Qx2k0kFtzF1sZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 19:02:21 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3I90x7E060793
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 05:02:19 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2he2g4sw3f-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 05:02:17 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 18 Apr 2018 10:02:15 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc64s: Print exception vector name alongside the trap
 number
Date: Wed, 18 Apr 2018 14:32:05 +0530
Message-Id: <20180418090205.30844-1-naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Print a small help text indicating the exception vector alongside the
trap number to make it easier while analyzing back traces. As an
example:

    Unable to handle kernel paging request for data at address 0x00000000
    Faulting instruction address: 0xc0000000006e3728
    Oops: Kernel access of bad area, sig: 11 [#1]
    LE SMP NR_CPUS=2048 NUMA PowerNV
    Modules linked in:
    CPU: 0 PID: 1 Comm: bash Not tainted 4.16.0-nnr #226
    NIP:  c0000000006e3728 LR: c0000000006e4774 CTR: c0000000006e3700
    REGS: c0000000f0aa3980 TRAP: 0300 (DSI)  Not tainted  (4.16.0-nnr)
    MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 28222222  XER: 20000000
    CFAR: c0000000006e4770 DAR: 0000000000000000 DSISR: 42000000 SOFTE: 0

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
I find this useful to have in backtraces, instead of having to look it 
up. Some of the names could probably be tweaked a bit to be more 
sensible.

- Naveen

 arch/powerpc/kernel/process.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1237f13fed51..71bfe29af456 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1414,6 +1414,42 @@ static void print_msr_bits(unsigned long val)
 #define LAST_VOLATILE	12
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S_64
+static char *print_trap(unsigned long trapno)
+{
+	trapno &= 0xff0;
+	switch (trapno) {
+		case 0x100:	return "SRESET";
+		case 0x200:	return "MCE";
+		case 0x300:	return "DSI";
+		case 0x380:	return "DSISLB";
+		case 0x400:	return "ISI";
+		case 0x480:	return "ISISLB";
+		case 0x500:	return "EXT";
+		case 0x600:	return "ALIGN";
+		case 0x700:	return "PCHECK";
+		case 0x800:	return "FP";
+		case 0x900:	return "DEC";
+		case 0x980:	return "HDEC";
+		case 0xa00:	return "DBELL";
+		case 0xc00:	return "SC";
+		case 0xd00:	return "SSTEP";
+		case 0xe00:	return "HDSI";
+		case 0xe20:	return "HISI";
+		case 0xe40:	return "HEMUL";
+		case 0xe60:	return "HMI";
+		case 0xe80:	return "HDBELL";
+		case 0xea0:	return "HVIRT";
+		case 0xf00:	return "PMI";
+		case 0xf20:	return "ALTIVEC";
+		case 0xf40:	return "VSX";
+		case 0xf60:	return "UNAVAIL";
+		case 0xf80:	return "HUNAVAIL";
+	}
+	return "UNKNOWN";
+}
+#endif
+
 void show_regs(struct pt_regs * regs)
 {
 	int i, trap;
@@ -1422,8 +1458,14 @@ void show_regs(struct pt_regs * regs)
 
 	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
+#ifdef CONFIG_PPC_BOOK3S_64
+	printk("REGS: %px TRAP: %04lx (%s)  %s  (%s)\n",
+	       regs, regs->trap, print_trap(regs->trap), print_tainted(),
+	       init_utsname()->release);
+#else
 	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
+#endif
 	printk("MSR:  "REG" ", regs->msr);
 	print_msr_bits(regs->msr);
 	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
-- 
2.17.0
