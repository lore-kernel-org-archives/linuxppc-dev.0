Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6F2851A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 01:29:16 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Oct 2014 19:59:14 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DD41F1258043
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:58:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9KETeLm59506852
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:41 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9KET9xH031727
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Oct 2014 19:59:10 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/3] KVM: PPC: BOOK3S: HV: Rename variable for better
 readability
Date: Mon, 20 Oct 2014 19:59:00 +0530
Message-Id: <1413815340-22426-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1413815340-22426-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Minor cleanup

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 78e689b066f1..2922f8d127ff 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -523,7 +523,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 	unsigned long *args = &vcpu->arch.gpr[4];
 	__be64 *hp, *hptes[4];
 	unsigned long tlbrb[4];
-	long int i, j, k, n, found, indexes[4];
+	long int i, j, k, collected_hpte, found, indexes[4];
 	unsigned long flags, req, pte_index, rcbits;
 	int global;
 	long int ret = H_SUCCESS;
@@ -532,7 +532,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 
 	global = global_invalidates(kvm, 0);
 	for (i = 0; i < 4 && ret == H_SUCCESS; ) {
-		n = 0;
+		collected_hpte = 0;
 		for (; i < 4; ++i) {
 			j = i * 2;
 			pte_index = args[j];
@@ -554,7 +554,7 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 			hp = (__be64 *) (kvm->arch.hpt_virt + (pte_index << 4));
 			/* to avoid deadlock, don't spin except for first */
 			if (!try_lock_hpte(hp, HPTE_V_HVLOCK)) {
-				if (n)
+				if (collected_hpte)
 					break;
 				while (!try_lock_hpte(hp, HPTE_V_HVLOCK))
 					cpu_relax();
@@ -596,22 +596,23 @@ long kvmppc_h_bulk_remove(struct kvm_vcpu *vcpu)
 
 			/* leave it locked */
 			hp[0] &= ~cpu_to_be64(HPTE_V_VALID);
-			tlbrb[n] = compute_tlbie_rb(be64_to_cpu(hp[0]),
-				be64_to_cpu(hp[1]), pte_index);
-			indexes[n] = j;
-			hptes[n] = hp;
-			revs[n] = rev;
-			++n;
+			tlbrb[collected_hpte] = compute_tlbie_rb(be64_to_cpu(hp[0]),
+								 be64_to_cpu(hp[1]),
+								 pte_index);
+			indexes[collected_hpte] = j;
+			hptes[collected_hpte] = hp;
+			revs[collected_hpte] = rev;
+			++collected_hpte;
 		}
 
-		if (!n)
+		if (!collected_hpte)
 			break;
 
 		/* Now that we've collected a batch, do the tlbies */
-		do_tlbies(kvm, tlbrb, n, global, true);
+		do_tlbies(kvm, tlbrb, collected_hpte, global, true);
 
 		/* Read PTE low words after tlbie to get final R/C values */
-		for (k = 0; k < n; ++k) {
+		for (k = 0; k < collected_hpte; ++k) {
 			j = indexes[k];
 			pte_index = args[j] & ((1ul << 56) - 1);
 			hp = hptes[k];
-- 
1.9.1
