Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxCMk2tJ2zDqNh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 16:17:22 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8J6CT6O087962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 02:17:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d2nvg3kye-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 02:17:19 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 19 Sep 2017 16:17:16 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8J6HD4J40632368
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 16:17:13 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8J6HC5V020995
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 16:17:13 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, maddy@linux.vnet.ibm.com,
 tglx@linutronix.de, mingo@kernel.org, kan.liang@intel.com,
 linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/sysrq: Fix oops whem ppmu is not registered
Date: Tue, 19 Sep 2017 11:47:06 +0530
Message-Id: <1505801826-12396-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel crashes if power pmu is not registered and user tries to dump
regs with 'echo p > /proc/sysrq-trigger'. Sample log:

  Unable to handle kernel paging request for data at address 0x00000008
  Faulting instruction address: 0xc0000000000d52f0

  NIP [c0000000000d52f0] perf_event_print_debug+0x10/0x230
  LR [c00000000058a938] sysrq_handle_showregs+0x38/0x50
  Call Trace:
   printk+0x38/0x4c (unreliable)
   __handle_sysrq+0xe4/0x270
   write_sysrq_trigger+0x64/0x80
   proc_reg_write+0x80/0xd0
   __vfs_write+0x40/0x200
   vfs_write+0xc8/0x240
   SyS_write+0x60/0x110
   system_call+0x58/0x6c

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> 
---
 arch/powerpc/perf/core-book3s.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2e3eb74..9e3da16 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -793,6 +793,11 @@ void perf_event_print_debug(void)
 	u32 pmcs[MAX_HWEVENTS];
 	int i;
 
+	if (!ppmu) {
+		pr_info("Performance monitor hardware not registered.\n");
+		return;
+	}
+
 	if (!ppmu->n_counter)
 		return;
 
-- 
1.8.3.1
