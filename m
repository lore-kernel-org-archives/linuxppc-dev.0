Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [83.169.36.222])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s464K0RvBzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:41:37 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 13/15] KVM: PPC: Pass kvm* to kvmppc_find_table()
Date: Wed,  3 Aug 2016 18:40:54 +1000
Message-Id: <1470213656-1042-14-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The guest view TCE tables are per KVM anyway (not per VCPU) so pass kvm*
there. This will be used in the following patches where we will be
attaching VFIO containers to LIOBNs via ioctl() to KVM (rather than
to VCPU).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    |  7 ++++---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 13 +++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 2544eda..7f1abe9 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -167,7 +167,7 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
-		struct kvm_vcpu *vcpu, unsigned long liobn);
+		struct kvm *kvm, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages);
 extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c379ff5..15df8ae 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -212,12 +212,13 @@ fail:
 long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba, unsigned long tce)
 {
-	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	struct kvmppc_spapr_tce_table *stt;
 	long ret;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -245,7 +246,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	u64 __user *tces;
 	u64 tce;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -299,7 +300,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index a3be4bd..8a6834e 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -49,10 +49,9 @@
  * WARNING: This will be called in real or virtual mode on HV KVM and virtual
  *          mode on PR KVM
  */
-struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
+struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm *kvm,
 		unsigned long liobn)
 {
-	struct kvm *kvm = vcpu->kvm;
 	struct kvmppc_spapr_tce_table *stt;
 
 	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
@@ -194,12 +193,13 @@ static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
 long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		unsigned long ioba, unsigned long tce)
 {
-	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	struct kvmppc_spapr_tce_table *stt;
 	long ret;
 
 	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
 	/* 	    liobn, ioba, tce); */
 
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -252,7 +252,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	unsigned long tces, entry, ua = 0;
 	unsigned long *rmap = NULL;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -335,7 +335,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -356,12 +356,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 		      unsigned long ioba)
 {
-	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
+	struct kvmppc_spapr_tce_table *stt;
 	long ret;
 	unsigned long idx;
 	struct page *page;
 	u64 *tbl;
 
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
-- 
2.5.0.rc3
