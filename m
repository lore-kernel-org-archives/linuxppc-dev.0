Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84DBE1A09F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 16:34:26 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Jul 2015 00:34:24 -0600
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B1A626E803C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2015 02:26:08 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t616YLwI52560076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2015 06:34:21 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t616YL9P010041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jul 2015 02:34:21 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mahesh@linux.vnet.ibm.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix race in updating core_idle_state
Date: Wed,  1 Jul 2015 12:04:10 +0530
Message-Id: <1435732450-7258-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
This patch fixes the above race by looping on the lock bit even while
entering the idle states.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_power7.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index ccde8f0..48c7d4f 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -144,12 +144,26 @@ power7_enter_nap_mode:
 	bge	cr3,2f
 	IDLE_STATE_ENTER_SEQ(PPC_NAP)
 	/* No return */
+
+core_idle_lock_held_entry:
+       HMT_LOW
+core_idle_lock_loop_entry:
+       lwz     r15,0(r14)
+       andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+       bne     core_idle_lock_loop_entry
+       HMT_MEDIUM
+       b       lwarx_loop1
+
 2:
 	/* Sleep or winkle */
 	lbz	r7,PACA_THREAD_MASK(r13)
 	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
 lwarx_loop1:
 	lwarx	r15,0,r14
+
+	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bne     core_idle_lock_held_entry
+
 	andc	r15,r15,r7			/* Clear thread bit */
 
 	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
-- 
1.9.3
