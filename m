Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9BY30D71zDvWl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 17:20:54 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA46ItoI010235
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 02:20:52 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26gff7wfhe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Nov 2016 02:20:51 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 4 Nov 2016 16:20:49 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BC8FA3578057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 17:20:46 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA46Kk2R4653396
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 17:20:46 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA46KksL026099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Nov 2016 17:20:46 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/oops: fix pr_cont() issues in instruction dump
Date: Fri,  4 Nov 2016 17:20:40 +1100
Message-Id: <20161104062040.25903-1-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the KERN_CONT changes, the current code in show_instructions() prints
out a whole bunch of unnecessary newlines. Change occurrences of
printk("\n") to pr_cont("\n"). While we're here, change all the other
cases of printk(KERN_CONT ...) to pr_cont() as well.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Based off mpe's earlier pr_cont() fixes series
---
 arch/powerpc/kernel/process.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ea6fe2e..749fb41 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1215,7 +1215,7 @@ static void show_instructions(struct pt_regs *regs)
 		int instr;
 
 		if (!(i % 8))
-			printk("\n");
+			pr_cont("\n");
 
 #if !defined(CONFIG_BOOKE)
 		/* If executing with the IMMU off, adjust pc rather
@@ -1227,18 +1227,18 @@ static void show_instructions(struct pt_regs *regs)
 
 		if (!__kernel_text_address(pc) ||
 		     probe_kernel_address((unsigned int __user *)pc, instr)) {
-			printk(KERN_CONT "XXXXXXXX ");
+			pr_cont("XXXXXXXX ");
 		} else {
 			if (regs->nip == pc)
-				printk(KERN_CONT "<%08x> ", instr);
+				pr_cont("<%08x> ", instr);
 			else
-				printk(KERN_CONT "%08x ", instr);
+				pr_cont("%08x ", instr);
 		}
 
 		pc += sizeof(int);
 	}
 
-	printk("\n");
+	pr_cont("\n");
 }
 
 struct regbit {
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
