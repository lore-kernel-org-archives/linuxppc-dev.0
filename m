Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTWvB0f5wzDrns
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 15:17:57 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u875HuFW082466
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Sep 2016 01:17:56 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25a57uxenp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Sep 2016 01:17:55 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 7 Sep 2016 01:17:52 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Subject: [PATCH] powernv: Restore SPRs correctly upon wake up from hypervisor
 state loss
Date: Wed,  7 Sep 2016 10:46:30 +0530
Message-Id: <1473225390-4281-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

pnv_wakeup_tb_loss function currently expects the cr4 to be "eq" if
the CPU is waking up from a complete hypervisor state loss. Hence, it
currently restores the SPR contents only if cr4 is "eq".

However, after the commit bcef83a00dc4 ("powerpc/powernv: Add platform
support for stop instruction"), on ISA_V300 CPUs, the function
pnv_restore_hyp_resource sets cr4 to contain the result of the
comparison between state the CPU has woken up and the first deepest
stop state before calling pnv_wakeup_tb_loss.

Thus if the CPU woke up from a state that is deeper than the first
deepest stop state, cr4 have "gt" set and hence, pnv_wakeup_tb_loss
will fail to restore the SPRs on waking up from such a state.

Fix the code in pnv_wakeup_tb_loss to restore the SPR states when cr4 is
"eq" or "gt".

Fixes: Commit bcef83a00dc4 ("powerpc/powernv: Add platform support for
stop instruction")

Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shreyas B. Prabhu <shreyasbp@gmail.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 2265c63..bd739fe 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -411,7 +411,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
  *
  * r13 - PACA
  * cr3 - gt if waking up with partial/complete hypervisor state loss
- * cr4 - eq if waking up from complete hypervisor state loss.
+ * cr4 - gt or eq if waking up from complete hypervisor state loss.
  */
 _GLOBAL(pnv_wakeup_tb_loss)
 	ld	r1,PACAR1(r13)
@@ -453,7 +453,7 @@ lwarx_loop2:
 	 * At this stage
 	 * cr2 - eq if first thread to wakeup in core
 	 * cr3-  gt if waking up with partial/complete hypervisor state loss
-	 * cr4 - eq if waking up from complete hypervisor state loss.
+	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
 	 */
 
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
@@ -481,7 +481,7 @@ first_thread_in_subcore:
 	 * If waking up from sleep, subcore state is not lost. Hence
 	 * skip subcore state restore
 	 */
-	bne	cr4,subcore_state_restored
+	blt	cr4,subcore_state_restored
 
 	/* Restore per-subcore state */
 	ld      r4,_SDR1(r1)
@@ -526,7 +526,7 @@ timebase_resync:
 	 * If waking up from sleep, per core state is not lost, skip to
 	 * clear_lock.
 	 */
-	bne	cr4,clear_lock
+	blt	cr4,clear_lock
 
 	/*
 	 * First thread in the core to wake up and its waking up with
@@ -557,7 +557,7 @@ common_exit:
 	 * If waking up from sleep, hypervisor state is not lost. Hence
 	 * skip hypervisor state restore.
 	 */
-	bne	cr4,hypervisor_state_restored
+	blt	cr4,hypervisor_state_restored
 
 	/* Waking up from winkle */
 
-- 
1.9.4
