Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 179171A0010
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:00 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:17:58 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 64DE63578052
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:17:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TB1Tvs48169198
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:01:30 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBHuBC004669
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:17:56 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 1/6] KVM: PPC: BOOK3S: HV: Clear hash pte bits from do_h_enter
 callers
Date: Sun, 29 Jun 2014 16:47:29 +0530
Message-Id: <1404040655-12076-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We will use this to set HPTE_V_VRMA bit in the later patch. This also
make sure we clear the hpte bits only when called via hcall.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 15 +++++++++++++--
 arch/powerpc/kvm/book3s_hv_rm_mmu.c |  8 ++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 09a47aeb5b63..1c137f45dd55 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -371,8 +371,6 @@ long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 	if (!psize)
 		return H_PARAMETER;
 
-	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
-
 	/* Find the memslot (if any) for this address */
 	gpa = (ptel & HPTE_R_RPN) & ~(psize - 1);
 	gfn = gpa >> PAGE_SHIFT;
@@ -408,6 +406,12 @@ long kvmppc_virtmode_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 			     long pte_index, unsigned long pteh,
 			     unsigned long ptel)
 {
+	/*
+	 * Clear few bits, when called via hcall
+	 */
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+	ptel &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
+
 	return kvmppc_virtmode_do_h_enter(vcpu->kvm, flags, pte_index,
 					  pteh, ptel, &vcpu->arch.gpr[4]);
 }
@@ -1560,6 +1564,13 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
 				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
 			err = -EIO;
+			/*
+			 * Clear few bits we got via read_htab which we
+			 * don't need to carry forward.
+			 */
+			v &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+			r &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
+
 			ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, i, v, r,
 							 tmp);
 			if (ret != H_SUCCESS) {
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 084ad54c73cd..157a5f35edfa 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -182,8 +182,6 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 	if (!psize)
 		return H_PARAMETER;
 	writing = hpte_is_writable(ptel);
-	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
-	ptel &= ~HPTE_GR_RESERVED;
 	g_ptel = ptel;
 
 	/* used later to detect if we might have been invalidated */
@@ -367,6 +365,12 @@ EXPORT_SYMBOL_GPL(kvmppc_do_h_enter);
 long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 		    long pte_index, unsigned long pteh, unsigned long ptel)
 {
+	/*
+	 * Clear few bits. when called via hcall.
+	 */
+	pteh &= ~(HPTE_V_HVLOCK | HPTE_V_ABSENT | HPTE_V_VALID);
+	ptel &= ~(HPTE_R_KEY_HI | HPTE_R_KEY_LO | HPTE_GR_RESERVED);
+
 	return kvmppc_do_h_enter(vcpu->kvm, flags, pte_index, pteh, ptel,
 				 vcpu->arch.pgdir, true, &vcpu->arch.gpr[4]);
 }
-- 
1.9.1
