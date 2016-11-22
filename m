Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNKpZ6QPLzDsy6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:26:14 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM9NncG001813
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 04:26:12 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26veh1g2hs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 04:26:12 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 19:26:09 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EA25C357805D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:26:05 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAM9Q5kj19792066
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:26:05 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAM9Q4C9030048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 20:26:05 +1100
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/xmon: Fix data-breakpoint
Date: Tue, 22 Nov 2016 14:55:59 +0530
Message-Id: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xmon data-breakpoint feature is broken.

Whenever there is a watchpoint match occurs, hw_breakpoint_handler will
be called by do_break via notifier chains mechanism. If watchpoint is
registered by xmon, hw_breakpoint_handler won't find any associated
perf_event and returns immediately with NOTIFY_STOP. Similarly, do_break
also returns without notifying to xmon.

Solve this by returning NOTIFY_DONE when hw_breakpoint_handler does not
find any perf_event associated with matched watchpoint.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/hw_breakpoint.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 03d089b..469d86d 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -228,8 +228,10 @@ int hw_breakpoint_handler(struct die_args *args)
 	rcu_read_lock();
 
 	bp = __this_cpu_read(bp_per_reg);
-	if (!bp)
+	if (!bp) {
+		rc = NOTIFY_DONE;
 		goto out;
+	}
 	info = counter_arch_bp(bp);
 
 	/*
-- 
1.8.3.1
