Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywzdP621KzDqRQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 23:28:41 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBCCQnPp112079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 07:28:39 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2etcggfsdk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 07:28:38 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Tue, 12 Dec 2017 12:28:37 -0000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, maddy@linux.vnet.ibm.com,
 tglx@linutronix.de, kamalesh@linux.vnet.ibm.com, kan.liang@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Dereference bhrb entries safely
Date: Tue, 12 Dec 2017 17:59:15 +0530
Message-Id: <20171212122915.20338-1-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It may very well happen that branch instructions recorded by
bhrb entries already get unmapped before they get processed by
the kernel. Hence, trying to dereference such memory location
will endup in a crash. Ex,

    Unable to handle kernel paging request for data at address 0xc008000019c41764
    Faulting instruction address: 0xc000000000084a14
    NIP [c000000000084a14] branch_target+0x4/0x70
    LR [c0000000000eb828] record_and_restart+0x568/0x5c0
    Call Trace:
    [c0000000000eb3b4] record_and_restart+0xf4/0x5c0 (unreliable)
    [c0000000000ec378] perf_event_interrupt+0x298/0x460
    [c000000000027964] performance_monitor_exception+0x54/0x70
    [c000000000009ba4] performance_monitor_common+0x114/0x120

Fix this by deferefencing them safely.

Suggested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 9e3da168d54c..5a68d2effdf9 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -410,8 +410,11 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	int ret;
 	__u64 target;
 
-	if (is_kernel_addr(addr))
-		return branch_target((unsigned int *)addr);
+	if (is_kernel_addr(addr)) {
+		if (probe_kernel_address((void *)addr, instr))
+			return 0;
+		return branch_target(&instr);
+	}
 
 	/* Userspace: need copy instruction here then translate it */
 	pagefault_disable();
-- 
2.13.6
