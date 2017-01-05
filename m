Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvQ0D1DLXzDqN7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 22:08:27 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v05B5M5u043771
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 06:08:25 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27skwvu7ku-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 06:08:24 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Jan 2017 21:08:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C57C42CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 22:08:19 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v05B8KC054853740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 22:08:20 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v05B8JgE007202
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 22:08:19 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: Cleanup to use is_kernel_addr macro
Date: Thu,  5 Jan 2017 16:38:15 +0530
Message-Id: <1483614495-6189-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9c0e17cf6886..a44b049b9cf6 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1403,7 +1403,7 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 	struct pt_regs regs;
 
 	while (max_to_print--) {
-		if (sp < PAGE_OFFSET) {
+		if (!is_kernel_addr(sp)) {
 			if (sp != 0)
 				printf("SP (%lx) is in userspace\n", sp);
 			break;
@@ -1431,12 +1431,12 @@ static void xmon_show_stack(unsigned long sp, unsigned long lr,
 				mread(newsp + LRSAVE_OFFSET, &nextip,
 				      sizeof(unsigned long));
 			if (lr == ip) {
-				if (lr < PAGE_OFFSET
+				if (!is_kernel_addr(lr)
 				    || (fnstart <= lr && lr < fnend))
 					printip = 0;
 			} else if (lr == nextip) {
 				printip = 0;
-			} else if (lr >= PAGE_OFFSET
+			} else if (is_kernel_addr(lr)
 				   && !(fnstart <= lr && lr < fnend)) {
 				printf("[link register   ] ");
 				xmon_print_symbol(lr, " ", "\n");
@@ -1496,7 +1496,7 @@ static void print_bug_trap(struct pt_regs *regs)
 	if (regs->msr & MSR_PR)
 		return;		/* not in kernel */
 	addr = regs->nip;	/* address of trap instruction */
-	if (addr < PAGE_OFFSET)
+	if (!is_kernel_addr(addr))
 		return;
 	bug = find_bug(regs->nip);
 	if (bug == NULL)
-- 
2.7.4
