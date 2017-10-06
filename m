Return-Path: <shriyak@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7h4c3WLGzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 18:25:36 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v967NxmY079910
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 03:25:34 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2de3tfmtj2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Oct 2017 03:25:33 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shriyak@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 17:25:31 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v967OFTY49348732
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:24:15 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v967O7C4032588
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Oct 2017 18:24:08 +1100
From: Shriya <shriyak@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au, paulus@samba.org
Cc: mikey@neuling.org, aneesh.kumar@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 Shriya <shriyak@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Return the actual CPU frequency in
 /proc/cpuinfo
Date: Fri,  6 Oct 2017 12:54:08 +0530
Message-Id: <1507274648-14221-1-git-send-email-shriyak@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make /proc/cpuinfo read the frequency of the CPU it is running at
instead of reading the cached value of the last requested frequency.
In conditions like WOF/throttle CPU can be running at a different
frequency than the requested frequency.

Signed-off-by: Shriya <shriyak@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 897aa14..55ea4bf 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -311,7 +311,7 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
 {
 	unsigned long ret_freq;
 
-	ret_freq = cpufreq_quick_get(cpu) * 1000ul;
+	ret_freq = cpufreq_get(cpu) * 1000ul;
 
 	/*
 	 * If the backend cpufreq driver does not exist,
-- 
1.9.1
