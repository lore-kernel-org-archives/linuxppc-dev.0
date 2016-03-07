Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AF6B1A0B70
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:46 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 7 Mar 2016 13:42:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 838E82CE805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:42:39 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u273gVMP55967944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:39 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u273g7GS028563
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 14:42:07 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel 7/9] KVM: PPC: Create a virtual-mode only TCE table
 handlers
Date: Mon,  7 Mar 2016 14:41:15 +1100
Message-Id: <1457322077-26640-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In-kernel VFIO acceleration needs different handling in real and virtual
modes which makes it hard to support both modes in the same handler.

This creates a copy of kvmppc_rm_h_stuff_tce and kvmppc_rm_h_put_tce
in addition to the existing kvmppc_rm_h_put_tce_indirect.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c        | 52 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c     |  8 ++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 +--
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 846d16d..7965fc7 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -317,6 +317,32 @@ fail:
 	return ret;
 }
 
+long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		      unsigned long ioba, unsigned long tce)
+{
+	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	long ret;
+
+	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
+	/* 	    liobn, ioba, tce); */
+
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, 1);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	ret = kvmppc_tce_validate(stt, tce);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	kvmppc_tce_put(stt, ioba >> stt->page_shift, tce);
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
+
 long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 		unsigned long liobn, unsigned long ioba,
 		unsigned long tce_list, unsigned long npages)
@@ -372,3 +398,29 @@ unlock_exit:
 	return ret;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
+
+long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+		unsigned long liobn, unsigned long ioba,
+		unsigned long tce_value, unsigned long npages)
+{
+	struct kvmppc_spapr_tce_table *stt;
+	long i, ret;
+
+	stt = kvmppc_find_table(vcpu, liobn);
+	if (!stt)
+		return H_TOO_HARD;
+
+	ret = kvmppc_ioba_validate(stt, ioba, npages);
+	if (ret != H_SUCCESS)
+		return ret;
+
+	/* Check permission bits only to allow userspace poison TCE for debug */
+	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
+		return H_PARAMETER;
+
+	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
+		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
+
+	return H_SUCCESS;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index af155f6..11163ae 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -212,8 +212,8 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
 	return mm_iommu_lookup_rm(mm, ua, size);
 }
 
-long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-		      unsigned long ioba, unsigned long tce)
+long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
 	long ret;
@@ -236,7 +236,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
 static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 		unsigned long ua, unsigned long *phpa)
@@ -350,7 +349,7 @@ unlock_exit:
 	return ret;
 }
 
-long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 		unsigned long liobn, unsigned long ioba,
 		unsigned long tce_value, unsigned long npages)
 {
@@ -374,7 +373,6 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index ed16182..d6dad2c 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1928,7 +1928,7 @@ hcall_real_table:
 	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
-	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
 	.long	0		/* 0x2c */
@@ -2006,7 +2006,7 @@ hcall_real_table:
 	.long	0		/* 0x12c */
 	.long	0		/* 0x130 */
 	.long	DOTSYM(kvmppc_h_set_xdabr) - hcall_real_table
-	.long	DOTSYM(kvmppc_h_stuff_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_stuff_tce) - hcall_real_table
 	.long	DOTSYM(kvmppc_rm_h_put_tce_indirect) - hcall_real_table
 	.long	0		/* 0x140 */
 	.long	0		/* 0x144 */
-- 
2.5.0.rc3
