Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 059FE1A104C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 06:09:55 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 14:09:53 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7176C3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 14:09:38 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t66K9c0N44237028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 13:09:38 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t66K9a4n017045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Jul 2015 14:09:37 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, mpe@ellerman.id.au
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/powernv: Fix race in updating core_idle_state
Date: Tue,  7 Jul 2015 01:39:23 +0530
Message-Id: <1436213363-18419-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

core_idle_state is maintained for each core. It uses 0-7 bits to track
whether a thread in the core has entered fastsleep or winkle. 8th bit is
used as a lock bit.
The lock bit is set in these 2 scenarios-
 - The thread is first in subcore to wakeup from sleep/winkle.
 - If its the last thread in the core about to enter sleep/winkle

While the lock bit is set, if any other thread in the core wakes up, it
loops until the lock bit is cleared before proceeding in the wakeup
path. This helps prevent race conditions w.r.t fastsleep workaround and
prevents threads from switching to process context before core/subcore
resources are restored.

But, in the path to sleep/winkle entry, we currently don't check for
lock-bit. This exposes us to following race when running with subcore
on-

First thread in the subcorea		Another thread in the same
waking up		   		core entering sleep/winkle

lwarx   r15,0,r14
ori     r15,r15,PNV_CORE_IDLE_LOCK_BIT
stwcx.  r15,0,r14
[Code to restore subcore state]

						lwarx   r15,0,r14
						[clear thread bit]
						stwcx.  r15,0,r14

andi.   r15,r15,PNV_CORE_IDLE_THREAD_BITS
stw     r15,0(r14)

Here, after the thread entering sleep clears its thread bit in
core_idle_state, the value is overwritten by the thread waking up.
In such cases when the core enters fastsleep, code mistakes an idle
thread as running. Because of this, the first thread waking up from
fastsleep which is supposed to resync timebase skips it. So we can
end up having a core with stale timebase value.

This patch fixes the above race by looping on the lock bit even while
entering the idle states.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Fixes: 7b54e9f213f76 'powernv/powerpc: Add winkle support for offline
cpus'

---
This needs to go into stable 3.19+

Changes in v2:
-------------
- Based on suggestion from Micheal, core_idle_lock_held changed to a
function call so that the same block can be called in entry and exit path.

- More detail on how this bug manifests added to commit message.

 arch/powerpc/kernel/idle_power7.S | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index ccde8f0..4d04315 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -52,6 +52,22 @@
 	.text
 
 /*
+ * Used by threads when the lock bit of core_idle_state is set.
+ * Threads will spin in HMT_LOW until the lock bit is cleared.
+ * r14 - pointer to core_idle_state
+ * r15 - used to load contents of core_idle_state
+ */
+
+core_idle_lock_held:
+	HMT_LOW
+3:	lwz	r15,0(r14)
+	andi.   r15,r15,PNV_CORE_IDLE_LOCK_BIT
+	bne	3b
+	HMT_MEDIUM
+	lwarx	r15,0,r14
+	blr
+
+/*
  * Pass requested state in r3:
  *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE
  *
@@ -150,6 +166,10 @@ power7_enter_nap_mode:
 	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
 lwarx_loop1:
 	lwarx	r15,0,r14
+
+	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bnel	core_idle_lock_held
+
 	andc	r15,r15,r7			/* Clear thread bit */
 
 	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
@@ -294,7 +314,7 @@ lwarx_loop2:
 	 * workaround undo code or resyncing timebase or restoring context
 	 * In either case loop until the lock bit is cleared.
 	 */
-	bne	core_idle_lock_held
+	bnel	core_idle_lock_held
 
 	cmpwi	cr2,r15,0
 	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
@@ -319,15 +339,6 @@ lwarx_loop2:
 	isync
 	b	common_exit
 
-core_idle_lock_held:
-	HMT_LOW
-core_idle_lock_loop:
-	lwz	r15,0(14)
-	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
-	bne	core_idle_lock_loop
-	HMT_MEDIUM
-	b	lwarx_loop2
-
 first_thread_in_subcore:
 	/* First thread in subcore to wakeup */
 	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
-- 
1.9.3
