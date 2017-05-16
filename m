Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRrkF0MFVzDqZJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:50:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G8mm7o100654
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:06 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afwsj18s8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:05 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 16 May 2017 02:50:05 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/6] powernv:idle: Decouple Timebase restore & Per-core SPRs
 restore
Date: Tue, 16 May 2017 14:19:44 +0530
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
Message-Id: <d83df78bd8693f9a9814eb7b1d95537f663e47ea.1494585671.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

On POWER8, in case of
   -  nap: both timebase and hypervisor state is retained.
   -  fast-sleep: timebase is lost. But the hypervisor state is retained.
   -  winkle: timebase and hypervisor state is lost.

Hence, the current code for handling exit from a idle state assumes
that if the timebase value is retained, then so is the hypervisor
state. Thus, the current code doesn't restore per-core hypervisor
state in such cases.

But that is no longer the case on POWER9 where we do have stop states
in which timebase value is retained, but the hypervisor state is
lost. So we have to ensure that the per-core hypervisor state gets
restored in such cases.

Fix this by ensuring that even in the case when timebase is retained,
we explicitly check if we are waking up from a deep stop that loses
per-core hypervisor state (indicated by cr4 being eq or gt), and if
this is the case, we restore the per-core hypervisor state.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 4898d67..afd029f 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -731,13 +731,14 @@ timebase_resync:
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
1.8.3.1
