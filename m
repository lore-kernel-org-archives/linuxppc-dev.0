Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411qBB6pM3zF34F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 01:25:50 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w57FONRD121211
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 11:25:47 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jf5pewb7r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:25:47 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Thu, 7 Jun 2018 11:25:46 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w57FPiT715532528
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 15:25:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AFE2AC040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:27:08 -0400 (EDT)
Received: from pedro.localdomain (unknown [9.18.235.95])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id 6F94BAC03A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 11:27:08 -0400 (EDT)
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/5] powerpc: Fix inverted active predicate for setting
 the EBB regset
Date: Thu,  7 Jun 2018 12:25:30 -0300
In-Reply-To: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
References: <20180607152534.29427-1-pedromfc@linux.vnet.ibm.com>
Message-Id: <20180607152534.29427-2-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the ebb_set function for writing to the EBB regset returns
ENODATA when ebb is active in the thread, and copies in the data when
it is inactive. This patch inverts the condition so that it matches
ebb_get and ebb_active.
---
 arch/powerpc/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d23cf632edf0..6618570c6d56 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1701,7 +1701,7 @@ static int ebb_set(struct task_struct *target,
 	if (!cpu_has_feature(CPU_FTR_ARCH_207S))
 		return -ENODEV;
 
-	if (target->thread.used_ebb)
+	if (!target->thread.used_ebb)
 		return -ENODATA;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-- 
2.13.6
