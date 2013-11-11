Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C7D202C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:08:25 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Nov 2013 00:08:25 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A20AA2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:08:22 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rABDokfQ9896002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 00:50:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rABE8M9x002145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 01:08:22 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: book3s: PR: Enable Little Endian PR guest
Date: Mon, 11 Nov 2013 19:38:18 +0530
Message-Id: <1384178898-24673-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch make sure we inherit the LE bit correctly in different case
so that we can run Little Endian distro in PR mode

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

This patch depends on the below two changes
1)  [PATCH v5 0/6] KVM: PPC: Book3S: MMIO support for Little Endian guests (kvm-ppc)
        http://mid.gmane.org/1383672128-26795-1-git-send-email-clg@fr.ibm.com
2) [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
       http://mid.gmane.org/1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

 arch/powerpc/kvm/book3s_64_mmu.c | 2 +-
 arch/powerpc/kvm/book3s_pr.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 83da1f8..d339096 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -38,7 +38,7 @@
 
 static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
 {
-	kvmppc_set_msr(vcpu, MSR_SF);
+	kvmppc_set_msr(vcpu, MSR_SF | (vcpu->arch.shared->msr & MSR_LE));
 }
 
 static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index a7fe87a..cf9362c 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -226,7 +226,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	ulong smsr = vcpu->arch.shared->msr;
 
 	/* Guest MSR values */
-	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE;
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
 	/* Process MSR values */
 	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
 	/* External providers the guest reserved */
-- 
1.8.3.2
