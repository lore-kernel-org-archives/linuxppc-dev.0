Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXKl55yjXzDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:51:45 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7G6mhos102992
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 02:51:43 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ccefkpddb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 02:51:43 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 16 Aug 2017 16:51:40 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7G6pb8f25624802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:51:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7G6pSLJ014010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:51:28 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.192.253.14])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 v7G6pSGk014007
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:51:28 +1000
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 38E5FA0198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:51:37 +1000 (AEST)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use reg.h values for program check reason codes
Date: Wed, 16 Aug 2017 16:50:24 +1000
Message-Id: <20170816065024.24459-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Small amount of #define duplication, makes sense for these to be in
reg.h.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/kernel/traps.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a3b6575c7842..c22b1ae5ad03 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -675,6 +675,7 @@
 					  * may not be recoverable */
 #define	  SRR1_WS_DEEPER	0x00020000 /* Some resources not maintained */
 #define	  SRR1_WS_DEEP		0x00010000 /* All resources maintained */
+#define   SRR1_PROGTMBAD	0x00200000 /* TM Bad Thing */
 #define   SRR1_PROGFPE		0x00100000 /* Floating Point Enabled */
 #define   SRR1_PROGILL		0x00080000 /* Illegal instruction */
 #define   SRR1_PROGPRIV		0x00040000 /* Privileged instruction */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1f7ec178db05..0a5ddaea8bf1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -416,11 +416,11 @@ static inline int check_io_access(struct pt_regs *regs)
    exception is in the MSR. */
 #define get_reason(regs)	((regs)->msr)
 #define get_mc_reason(regs)	((regs)->msr)
-#define REASON_TM		0x200000
-#define REASON_FP		0x100000
-#define REASON_ILLEGAL		0x80000
-#define REASON_PRIVILEGED	0x40000
-#define REASON_TRAP		0x20000
+#define REASON_TM		SRR1_PROGTMBAD
+#define REASON_FP		SRR1_PROGFPE
+#define REASON_ILLEGAL		SRR1_PROGILL
+#define REASON_PRIVILEGED	SRR1_PROGPRIV
+#define REASON_TRAP		SRR1_PROGTRAP
 
 #define single_stepping(regs)	((regs)->msr & MSR_SE)
 #define clear_single_step(regs)	((regs)->msr &= ~MSR_SE)
-- 
2.14.1
