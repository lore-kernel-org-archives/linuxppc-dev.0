Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C2FB1A0027
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:26:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Oct 2014 19:26:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 776C0357804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:26:46 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9K9ScSJ31981728
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:28:47 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9K9QDFN013329
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 20:26:13 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] KVM: PPC: Book3S HV: Add missing HPTE unlock
Date: Mon, 20 Oct 2014 14:55:35 +0530
Message-Id: <1413797135-17354-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In kvm_test_clear_dirty_npages(), if we find an invalid HPTE we move on to the
next HPTE without unlocking the invalid one.  In fact we should never
find an invalid and unlocked HPTE in the rmap chain, but for robustness
we should unlock it.  This adds the missing unlock.

Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index d40770248b6a..cebb86bc4a37 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1117,9 +1117,11 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		}
 
 		/* Now check and modify the HPTE */
-		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID)))
+		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
+			/* unlock and continue */
+			hptep[0] &= ~cpu_to_be64(HPTE_V_HVLOCK);
 			continue;
-
+		}
 		/* need to make it temporarily absent so C is stable */
 		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
 		kvmppc_invalidate_hpte(kvm, hptep, i);
-- 
1.9.1
