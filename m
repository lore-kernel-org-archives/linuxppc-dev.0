Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DA601A010A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 14:27:32 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E17E1140B0D
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 14:27:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <cyrilbur@gmail.com>;
 Thu, 1 Oct 2015 14:27:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BCA212CE805A
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 14:27:29 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t914RH9j38338638
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Oct 2015 14:27:25 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t914QuC1027983
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Oct 2015 14:26:57 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix checkstop in native_hpte_clear() with lockdep
Date: Thu,  1 Oct 2015 14:25:57 +1000
Message-Id: <1443673557-7226-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

native_hpte_clear() is called in real mode from two places:
- Early in boot during htab initialisation if firmware assisted dump is
  active.
- Late in the kexec path.

In both contexts there is no need to disable interrupts are they are
already disabled. Furthermore, locking around the tlbie() is only required
for pre POWER5 hardware.

On POWER5 or newer hardware concurrent tlbie()s work as expected and on pre
POWER5 hardware concurrent tlbie()s could result in deadlock. This code
would only be executed during a crashdump during which all bets are off,
concurrent tlbie()s are unlikely and taking locks is unsafe therefore the
best course of action is to simply do nothing. Concurrent tlbie()s are not
possible in the first case as secondary CPUs have not come up yet.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/mm/hash_native_64.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 13befa35..c8822af 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -582,13 +582,21 @@ static void hpte_decode(struct hash_pte *hpte, unsigned long slot,
  * be when they isi), and we are the only one left.  We rely on our kernel
  * mapping being 0xC0's and the hardware ignoring those two real bits.
  *
+ * This must be called with interrupts disabled.
+ *
+ * Taking the native_tlbie_lock is unsafe here due to the possibility of
+ * lockdep being on. On pre POWER5 hardware, not taking the lock could
+ * cause deadlock. POWER5 and newer not taking the lock is fine. This only
+ * gets called during boot before secondary CPUs have come up and during
+ * crashdump and all bets are off anyway.
+ *
  * TODO: add batching support when enabled.  remember, no dynamic memory here,
  * athough there is the control page available...
  */
 static void native_hpte_clear(void)
 {
 	unsigned long vpn = 0;
-	unsigned long slot, slots, flags;
+	unsigned long slot, slots;
 	struct hash_pte *hptep = htab_address;
 	unsigned long hpte_v;
 	unsigned long pteg_count;
@@ -596,13 +604,6 @@ static void native_hpte_clear(void)
 
 	pteg_count = htab_hash_mask + 1;
 
-	local_irq_save(flags);
-
-	/* we take the tlbie lock and hold it.  Some hardware will
-	 * deadlock if we try to tlbie from two processors at once.
-	 */
-	raw_spin_lock(&native_tlbie_lock);
-
 	slots = pteg_count * HPTES_PER_GROUP;
 
 	for (slot = 0; slot < slots; slot++, hptep++) {
@@ -614,8 +615,8 @@ static void native_hpte_clear(void)
 		hpte_v = be64_to_cpu(hptep->v);
 
 		/*
-		 * Call __tlbie() here rather than tlbie() since we
-		 * already hold the native_tlbie_lock.
+		 * Call __tlbie() here rather than tlbie() since we can't take the
+		 * native_tlbie_lock.
 		 */
 		if (hpte_v & HPTE_V_VALID) {
 			hpte_decode(hptep, slot, &psize, &apsize, &ssize, &vpn);
@@ -625,8 +626,6 @@ static void native_hpte_clear(void)
 	}
 
 	asm volatile("eieio; tlbsync; ptesync":::"memory");
-	raw_spin_unlock(&native_tlbie_lock);
-	local_irq_restore(flags);
 }
 
 /*
-- 
2.6.0
