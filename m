Return-Path: <npiggin@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7MhJ2mhHzDqmF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 23:06:24 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id h41so3501784ioi.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 06:06:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 7/9] powerpc/64s: idle do not hold reservation longer than
 required
Date: Wed, 19 Apr 2017 23:05:49 +1000
Message-Id: <20170419130551.32378-8-npiggin@gmail.com>
In-Reply-To: <20170419130551.32378-1-npiggin@gmail.com>
References: <20170419130551.32378-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When taking the core idle state lock, grab it immediately like a regular
lock, rather than adding more tests in there. Holding the lock keeps it
stable, so there is no need to do it whole holding the reservation.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 13b7044c1541..db60e051fb1c 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -569,12 +569,12 @@ BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 
-	lbz	r7,PACA_THREAD_MASK(r13)
 	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
-lwarx_loop2:
-	lwarx	r15,0,r14
-	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	lbz	r7,PACA_THREAD_MASK(r13)
+
 	/*
+	 * Take the core lock to synchronize against other threads.
+	 *
 	 * Lock bit is set in one of the 2 cases-
 	 * a. In the sleep/winkle enter path, the last thread is executing
 	 * fastsleep workaround code.
@@ -582,7 +582,14 @@ lwarx_loop2:
 	 * workaround undo code or resyncing timebase or restoring context
 	 * In either case loop until the lock bit is cleared.
 	 */
+1:
+	lwarx	r15,0,r14
+	andis.	r9,r15,PNV_CORE_IDLE_LOCK_BIT@h
 	bnel-	core_idle_lock_held
+	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
+	stwcx.	r15,0,r14
+	bne-	1b
+	isync
 
 	andi.	r9,r15,PNV_CORE_IDLE_THREAD_BITS
 	cmpwi	cr2,r9,0
@@ -594,11 +601,6 @@ lwarx_loop2:
 	 * cr4 - gt or eq if waking up from complete hypervisor state loss.
 	 */
 
-	oris	r15,r15,PNV_CORE_IDLE_LOCK_BIT@h
-	stwcx.	r15,0,r14
-	bne-	lwarx_loop2
-	isync
-
 BEGIN_FTR_SECTION
 	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
 	and	r4,r4,r15
-- 
2.11.0
