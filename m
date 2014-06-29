Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 842DD1A0039
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:06 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 29 Jun 2014 21:18:05 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2D9B32BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:02 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5TAtdoM10944988
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 20:55:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5TBI1Ck004746
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Jun 2014 21:18:01 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH 3/6] KVM: PPC: BOOK3S: HV: Remove dead code
Date: Sun, 29 Jun 2014 16:47:32 +0530
Message-Id: <1404040655-12076-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Since we do don't support virtual page class key protection mechanism in
the guest, we should not find a keyfault that needs to be forwarded to
the guest. So remove the dead code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 9 ---------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 1c137f45dd55..590e07b1a43f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -499,15 +499,6 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
 	gpte->may_write = hpte_write_permission(pp, key);
 	gpte->may_execute = gpte->may_read && !(gr & (HPTE_R_N | HPTE_R_G));
 
-	/* Storage key permission check for POWER7 */
-	if (data && virtmode && cpu_has_feature(CPU_FTR_ARCH_206)) {
-		int amrfield = hpte_get_skey_perm(gr, vcpu->arch.amr);
-		if (amrfield & 1)
-			gpte->may_read = 0;
-		if (amrfield & 2)
-			gpte->may_write = 0;
-	}
-
 	/* Get the guest physical address */
 	gpte->raddr = kvmppc_mmu_get_real_addr(v, gr, eaddr);
 	return 0;
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index f908845f7379..1884bff3122c 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -925,15 +925,6 @@ long kvmppc_hpte_hv_fault(struct kvm_vcpu *vcpu, unsigned long addr,
 			return status | DSISR_PROTFAULT;
 	}
 
-	/* Check storage key, if applicable */
-	if (data && (vcpu->arch.shregs.msr & MSR_DR)) {
-		unsigned int perm = hpte_get_skey_perm(gr, vcpu->arch.amr);
-		if (status & DSISR_ISSTORE)
-			perm >>= 1;
-		if (perm & 1)
-			return status | DSISR_KEYFAULT;
-	}
-
 	/* Save HPTE info for virtual-mode handler */
 	vcpu->arch.pgfault_addr = addr;
 	vcpu->arch.pgfault_index = index;
-- 
1.9.1
