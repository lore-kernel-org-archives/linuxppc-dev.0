Return-Path: <shriyak@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCw0p3T98zDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 15:36:58 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9D4XktY023241
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 00:36:55 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2djg4qmek9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 00:36:55 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shriyak@linux.vnet.ibm.com>;
 Fri, 13 Oct 2017 05:36:54 +0100
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9D4aoU226476776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 04:36:51 GMT
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9D4anmA009871
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 15:36:49 +1100
From: Shriya <shriyak@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 Shriya <shriyak@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2] cpufreq: powernv: Fix the frequency read by /proc/cpuinfo
Date: Fri, 13 Oct 2017 10:06:41 +0530
Message-Id: <1507869401-4715-1-git-send-email-shriyak@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The call to /proc/cpuinfo in turn calls cpufreq_quick_get() which
returns the last frequency requested by the kernel, but may not
reflect the actual frequency the processor is running at.
This patch makes a call to cpufreq_get() instead which returns the
current frequency reported by the hardware.

Fixes : commit fb5153d05a7d ("powerpc: powernv: Implement
ppc_md.get_proc_freq()")
Cc: stable@vger.kernel.org

Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index cf52d53..58e7ae5 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -312,7 +312,7 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
 {
 	unsigned long ret_freq;
 
-	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
+	ret_freq = cpufreq_get(cpu) * 1000ul;
 
 	/*
 	 * If the backend cpufreq driver does not exist,
-- 
1.9.1
