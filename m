Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qR8v24yVtzDqGd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 13:54:06 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 18 Mar 2016 12:54:05 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 71E1A3578066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 13:53:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2I2rPEF32047240
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 13:53:33 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2I2qlUb021291
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 13:52:47 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: kvm-ppc@vger.kernel.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH kernel] KVM: PPC: Create a virtual-mode only TCE table handlers
Date: Fri, 18 Mar 2016 13:50:42 +1100
Message-Id: <1458269442-24292-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Upcoming in-kernel VFIO acceleration needs different handling in real
and virtual modes which makes it hard to support both modes in
the same handler.

This creates a copy of kvmppc_rm_h_stuff_tce and kvmppc_rm_h_put_tce
in addition to the existing kvmppc_rm_h_put_tce_indirect.

This also fixes linker breakage when only PR KVM was selected (leaving
HV KVM off): the kvmppc_h_put_tce/kvmppc_h_stuff_tce functions
would not compile at all and the linked would fail.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c        | 52 +++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_64_vio_hv.c     |  8 ++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 +--
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 2c2d103..75469f6 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -209,6 +209,32 @@ fail:
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
@@ -264,3 +290,29 @@ unlock_exit:
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
index 44be73e..18f0227 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -180,8 +180,8 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
 EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
-		      unsigned long ioba, unsigned long tce)
+long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		unsigned long ioba, unsigned long tce)
 {
 	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
 	long ret;
@@ -204,7 +204,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
 
 static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
 		unsigned long ua, unsigned long *phpa)
@@ -296,7 +295,7 @@ unlock_exit:
 	return ret;
 }
 
-long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
+long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 		unsigned long liobn, unsigned long ioba,
 		unsigned long tce_value, unsigned long npages)
 {
@@ -320,7 +319,6 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 
 	return H_SUCCESS;
 }
-EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
 
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 85b32f1..81b0b51 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1942,7 +1942,7 @@ hcall_real_table:
 	.long	DOTSYM(kvmppc_h_clear_ref) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_protect) - hcall_real_table
 	.long	DOTSYM(kvmppc_h_get_tce) - hcall_real_table
-	.long	DOTSYM(kvmppc_h_put_tce) - hcall_real_table
+	.long	DOTSYM(kvmppc_rm_h_put_tce) - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	DOTSYM(kvmppc_h_set_dabr) - hcall_real_table
 	.long	0		/* 0x2c */
@@ -2020,7 +2020,7 @@ hcall_real_table:
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
