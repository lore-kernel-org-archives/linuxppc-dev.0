Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ZpL25kvWzDrHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 05:28:10 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6OJNc2l013191
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:08 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ke9knhkv4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 15:28:08 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Tue, 24 Jul 2018 15:28:06 -0400
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "Alastair D'Silva" <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/7] powerpc/reg: Add REG_FMT definition
Date: Tue, 24 Jul 2018 16:27:16 -0300
In-Reply-To: <20180724192720.32417-1-muriloo@linux.ibm.com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20180724192720.32417-4-muriloo@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make REG definition, in arch/powerpc/kernel/process.c, generic enough by
renaming it to REG_FMT and placing it in arch/powerpc/include/asm/reg.h to be
used elsewhere.

Replace occurrences of REG by REG_FMT in arch/powerpc/kernel/process.c.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/include/asm/reg.h |  6 ++++++
 arch/powerpc/kernel/process.c  | 22 ++++++++++------------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 858aa7984ab0..d6c5c77383de 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1319,6 +1319,12 @@
 #define PVR_ARCH_207	0x0f000004
 #define PVR_ARCH_300	0x0f000005
 
+#ifdef CONFIG_PPC64
+#define REG_FMT		"%016lx"
+#else
+#define REG_FMT		"%08lx"
+#endif /* CONFIG_PPC64 */
+
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLY__
 #define mfmsr()		({unsigned long rval; \
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 27f0caee55ea..b1af3390249c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1381,11 +1381,9 @@ static void print_msr_bits(unsigned long val)
 }
 
 #ifdef CONFIG_PPC64
-#define REG		"%016lx"
 #define REGS_PER_LINE	4
 #define LAST_VOLATILE	13
 #else
-#define REG		"%08lx"
 #define REGS_PER_LINE	8
 #define LAST_VOLATILE	12
 #endif
@@ -1396,21 +1394,21 @@ void show_regs(struct pt_regs * regs)
 
 	show_regs_print_info(KERN_DEFAULT);
 
-	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
+	printk("NIP:  "REG_FMT" LR: "REG_FMT" CTR: "REG_FMT"\n",
 	       regs->nip, regs->link, regs->ctr);
 	printk("REGS: %px TRAP: %04lx   %s  (%s)\n",
 	       regs, regs->trap, print_tainted(), init_utsname()->release);
-	printk("MSR:  "REG" ", regs->msr);
+	printk("MSR:  "REG_FMT" ", regs->msr);
 	print_msr_bits(regs->msr);
-	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
+	pr_cont("  CR: "REG_FMT"  XER: "REG_FMT"\n", regs->ccr, regs->xer);
 	trap = TRAP(regs);
 	if ((TRAP(regs) != 0xc00) && cpu_has_feature(CPU_FTR_CFAR))
-		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
+		pr_cont("CFAR: "REG_FMT" ", regs->orig_gpr3);
 	if (trap == 0x200 || trap == 0x300 || trap == 0x600)
 #if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
-		pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+		pr_cont("DEAR: "REG_FMT" ESR: "REG_FMT" ", regs->dar, regs->dsisr);
 #else
-		pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
+		pr_cont("DAR: "REG_FMT" DSISR: "REG_FMT" ", regs->dar, regs->dsisr);
 #endif
 #ifdef CONFIG_PPC64
 	pr_cont("IRQMASK: %lx ", regs->softe);
@@ -1423,7 +1421,7 @@ void show_regs(struct pt_regs * regs)
 	for (i = 0;  i < 32;  i++) {
 		if ((i % REGS_PER_LINE) == 0)
 			pr_cont("\nGPR%02d: ", i);
-		pr_cont(REG " ", regs->gpr[i]);
+		pr_cont(REG_FMT " ", regs->gpr[i]);
 		if (i == LAST_VOLATILE && !FULL_REGS(regs))
 			break;
 	}
@@ -1433,8 +1431,8 @@ void show_regs(struct pt_regs * regs)
 	 * Lookup NIP late so we have the best change of getting the
 	 * above info out without failing
 	 */
-	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
-	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
+	printk("NIP ["REG_FMT"] %pS\n", regs->nip, (void *)regs->nip);
+	printk("LR ["REG_FMT"] %pS\n", regs->link, (void *)regs->link);
 #endif
 	show_stack(current, (unsigned long *) regs->gpr[1]);
 	if (!user_mode(regs))
@@ -2038,7 +2036,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
+			printk("["REG_FMT"] ["REG_FMT"] %pS", sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			if ((ip == rth) && curr_frame >= 0) {
 				pr_cont(" (%pS)",
-- 
2.17.1
