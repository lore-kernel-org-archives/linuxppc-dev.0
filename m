Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpCdn4r75zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 02:04:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2MExEAj100089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:34 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vqaek5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 11:04:34 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 22 Mar 2017 09:04:33 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v3 PATCH 2/4] powernv:smp: Add busy-wait loop as fall back for
 CPU-Hotplug
Date: Wed, 22 Mar 2017 20:34:15 +0530
In-Reply-To: <cover.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1490194710.git.ego@linux.vnet.ibm.com>
References: <cover.1490194710.git.ego@linux.vnet.ibm.com>
Message-Id: <261607d15ec471d88a8d31ee50614c64a4018b90.1490194710.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently, the powernv cpu-offline function assumes that platform idle
states such as stop on POWER9, winkle/sleep/nap on POWER8 are always
available. On POWER8, it picks nap as the default state if other deep
idle states like sleep/winkle are not available and enabled in the
platform.

On POWER9, nap is not available and all idle states are managed by
STOP instruction.  The parameters to the idle state are passed through
processor stop status control register (PSSCR).  Hence as such
executing STOP would take parameters from current PSSCR. We do not
want to make any assumptions in kernel on what STOP states and PSSCR
features are configured by the platform.

Ideally platform will configure a good set of stop states that can be
used in the kernel.  We would like to start with a clean slate, if the
platform choose to not configure any state or there is an error in
platform firmware that lead to no stop states being configured or
allowed to be requested.

This patch adds a fallback method for CPU-Hotplug that is similar to
snooze loop at idle where the threads are left to spin at low priority
and hence reduce the cycles consumed.

This is a safe fallback mechanism in the case when no stop state would
be requested if the platform firmware did not configure them most
likely due to an error condition.

Requesting a stop state when the platform has not configured them or
enabled them would lead to further error conditions which could be
difficult to debug.

[Changelog written with inputs from svaidy@linux.vnet.ibm.com]
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 419edff..f335e0f 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -283,8 +283,16 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		srr1 = power7_sleep();
-	} else {
+	} else if (idle_states & OPAL_PM_NAP_ENABLED) {
 		srr1 = power7_nap(1);
+	} else {
+		/* This is the fallback method. We emulate snooze */
+		while (!generic_check_cpu_restart(cpu)) {
+			HMT_low();
+			HMT_very_low();
+		}
+		srr1 = 0;
+		HMT_medium();
 	}
 
 	return srr1;
-- 
1.9.4
