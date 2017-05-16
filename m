Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRrkB36hRzDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:50:10 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G8mlOw055338
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:05 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2aft10tu0a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:05 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 16 May 2017 02:50:04 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/6] powernv:idle: Correctly initialize core_idle_state_ptr
Date: Tue, 16 May 2017 14:19:43 +0530
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
Message-Id: <f6c49fcf42b78c0b8bdad17d6e659679c0288cd9.1494585671.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The lower 8 bits of core_idle_state_ptr tracks the number of non-idle
threads in the core. This is supposed to be initialized to bit-map
corresponding to the threads_per_core. However, currently it is
initialized to PNV_CORE_IDLE_THREAD_BITS (0xFF). This is correct for
POWER8 which has 8 threads per core, but not for POWER9 which has 4
threads per core.

As a result, on POWER9, core_idle_state_ptr gets initialized to
0xFF. In case when all the threads of the core are idle, the bits
corresponding tracking the idle-threads are non-zero. As a result, the
idle entry/exit code fails to save/restore per-core hypervisor state
since it assumes that there are threads in the cores which are still
active.

Fix this by correctly initializing the lower bits of the
core_idle_state_ptr on the basis of threads_per_core.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 445f30a..84eb9bc 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -96,15 +96,24 @@ static void pnv_alloc_idle_core_states(void)
 	u32 *core_idle_state;
 
 	/*
-	 * core_idle_state - First 8 bits track the idle state of each thread
-	 * of the core. The 8th bit is the lock bit. Initially all thread bits
-	 * are set. They are cleared when the thread enters deep idle state
-	 * like sleep and winkle. Initially the lock bit is cleared.
-	 * The lock bit has 2 purposes
-	 * a. While the first thread is restoring core state, it prevents
-	 * other threads in the core from switching to process context.
-	 * b. While the last thread in the core is saving the core state, it
-	 * prevents a different thread from waking up.
+	 * core_idle_state - The lower 8 bits track the idle state of
+	 * each thread of the core.
+	 *
+	 * The most significant bit is the lock bit.
+	 *
+	 * Initially all the bits corresponding to threads_per_core
+	 * are set. They are cleared when the thread enters deep idle
+	 * state like sleep and winkle/stop.
+	 *
+	 * Initially the lock bit is cleared.  The lock bit has 2
+	 * purposes:
+	 * 	a. While the first thread in the core waking up from
+	 * 	   idle is restoring core state, it prevents other
+	 * 	   threads in the core from switching to process
+	 * 	   context.
+	 * 	b. While the last thread in the core is saving the
+	 *	   core state, it prevents a different thread from
+	 *	   waking up.
 	 */
 	for (i = 0; i < nr_cores; i++) {
 		int first_cpu = i * threads_per_core;
@@ -112,7 +121,7 @@ static void pnv_alloc_idle_core_states(void)
 		size_t paca_ptr_array_size;
 
 		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
-		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
+		*core_idle_state = (1 << threads_per_core) - 1;
 		paca_ptr_array_size = (threads_per_core *
 				       sizeof(struct paca_struct *));
 
-- 
1.8.3.1
