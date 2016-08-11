Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNh3YbFzDr7v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:08 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSa9N081060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:06 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24rqx1x78b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:05 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DDD072BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNT01Q25755786
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNT0JP003453
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:00 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 03/20] powerpc: Add check_if_tm_restore_required() to
 giveup_all()
Date: Fri, 12 Aug 2016 09:28:02 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-4-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

giveup_all() causes FPU/VMX/VSX facilitities to be disabled in a
threads MSR. If this thread was transactional this should be recorded
as reclaiming/recheckpointing code will need to know.

Fixes: c208505 ("powerpc: create giveup_all()")
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a5cdef9..79f0615 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -439,6 +439,7 @@ void giveup_all(struct task_struct *tsk)
 		return;
 
 	msr_check_and_set(msr_all_available);
+	check_if_tm_restore_required(tsk);
 
 #ifdef CONFIG_PPC_FPU
 	if (usermsr & MSR_FP)
-- 
2.9.2
