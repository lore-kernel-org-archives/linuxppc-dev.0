Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vdJDZ3sVnzDqYw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 14:00:30 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: [PATCH kernel v7 07/10] KVM: PPC: Pass kvm* to kvmppc_find_table()
Date: Wed,  8 Mar 2017 14:00:08 +1100
Message-Id: <20170308030011.26780-8-aik@ozlabs.ru>
In-Reply-To: <20170308030011.26780-1-aik@ozlabs.ru>
References: <20170308030011.26780-1-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/include/asm/kvm_ppc.h  |  2 +-
 arch/powerpc/kvm/book3s_64_vio.c    |  7 ++++---
 arch/powerpc/kvm/book3s_64_vio_hv.c | 13 +++++++------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index dd11c4c8c56a..eba8988d8443 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -168,7 +168,7 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
 extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce_64 *args);
 extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
-		struct kvm_vcpu *vcpu, unsigned long liobn);
+		struct kvm *kvm, unsigned long liobn);
 extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
 		unsigned long ioba, unsigned long npages);
 extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 3e26cd4979f9..e96a4590464c 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -214,12 +214,13 @@ long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
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
 
@@ -247,7 +248,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	u64 __user *tces;
 	u64 tce;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -301,7 +302,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index e4c4ea973e57..918af76ab2b6 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -48,10 +48,9 @@
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
@@ -182,12 +181,13 @@ EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
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
 
@@ -240,7 +240,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 	unsigned long tces, entry, ua = 0;
 	unsigned long *rmap = NULL;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -301,7 +301,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
 	struct kvmppc_spapr_tce_table *stt;
 	long i, ret;
 
-	stt = kvmppc_find_table(vcpu, liobn);
+	stt = kvmppc_find_table(vcpu->kvm, liobn);
 	if (!stt)
 		return H_TOO_HARD;
 
@@ -322,12 +322,13 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
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
2.11.0
