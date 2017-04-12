Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w32Fs1lSszDqFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 21:46:56 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CBdB5n136532
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29s05fabrr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 07:46:46 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 05:46:45 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powernv:idle: Decouple TB restore & Per-core SPRs restore
Date: Wed, 12 Apr 2017 17:16:21 +0530
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1491996797.git.ego@linux.vnet.ibm.com>
References: <cover.1491996797.git.ego@linux.vnet.ibm.com>
Message-Id: <27511c1235ee58c66eabdea65b39f5dd35d91426.1491996797.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The idle-exit code assumes that if Timebase is not lost, then neither
are the per-core hypervisor resources lost. This was true on POWER8
where fast-sleep lost only TB but not per-core resources, and winkle
lost both.

This assumption is not true for POWER9 however, since there can be
states which do not lose timebase but can lose per-core SPRs.

Hence check if we need to restore the per-core hypervisor state even
if timebase is not lost.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 9b747e9..6a9bd28 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -723,13 +723,14 @@ timebase_resync:
 	 * Use cr3 which indicates that we are waking up with atleast partial
 	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
 	 */
-	ble	cr3,clear_lock
+	ble	cr3,.Ltb_resynced
 	/* Time base re-sync */
 	bl	opal_resync_timebase;
 	/*
-	 * If waking up from sleep, per core state is not lost, skip to
-	 * clear_lock.
+	 * If waking up from sleep (POWER8), per core state
+	 * is not lost, skip to clear_lock.
 	 */
+.Ltb_resynced:
 	blt	cr4,clear_lock
 
 	/*
-- 
1.9.4
