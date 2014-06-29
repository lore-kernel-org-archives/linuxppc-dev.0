Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 650681A014E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:03 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:02 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AE3052BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TB1XRA35848366
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:01:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBHxu7004719
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 2/6] KVM: PPC: BOOK3S: HV: Deny virtual page class key update
 via h_protect
Date: Sun, 29 Jun 2014 16:47:31 +0530
Message-Id: <1404040655-12076-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1404040655-12076-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This makes it consistent with h_enter where we clear the key
bits. We also want to use virtual page class key protection mechanism
for indicating host page fault. For that we will be using key class
index 30 and 31. So prevent the guest from updating key bits until
we add proper support for virtual page class protection mechanism for
the guest. This will not have any impact for PAPR linux guest because
Linux guest currently don't use virtual page class key protection model

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 157a5f35edfa..f908845f7379 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -658,13 +658,17 @@ long kvmppc_h_protect(struct kvm_vcpu *vcpu, unsigned long flags,
 	}
 
 	v = pte;
+	/*
+	 * We ignore key bits here. We use class 31 and 30 for
+	 * hypervisor purpose. We still don't track the page
+	 * class seperately. Until then don't allow h_protect
+	 * to change key bits.
+	 */
 	bits = (flags << 55) & HPTE_R_PP0;
-	bits |= (flags << 48) & HPTE_R_KEY_HI;
-	bits |= flags & (HPTE_R_PP | HPTE_R_N | HPTE_R_KEY_LO);
+	bits |= flags & (HPTE_R_PP | HPTE_R_N);
 
 	/* Update guest view of 2nd HPTE dword */
-	mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N |
-		HPTE_R_KEY_HI | HPTE_R_KEY_LO;
+	mask = HPTE_R_PP0 | HPTE_R_PP | HPTE_R_N;
 	rev = real_vmalloc_addr(&kvm->arch.revmap[pte_index]);
 	if (rev) {
 		r = (rev->guest_rpte & ~mask) | bits;
-- 
1.9.1
