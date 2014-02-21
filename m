Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B27012C0334
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 02:31:19 +1100 (EST)
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 21 Feb 2014 15:31:15 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id D77881B0805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 15:30:51 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1LFV0BP721252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 15:31:01 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1LFVCrr017479
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 08:31:12 -0700
Subject: [PATCH] PPC: KVM: Introduce hypervisor call H_GET_TCE
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Fri, 21 Feb 2014 16:31:10 +0100
Message-ID: <20140221153110.8190.6271.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fix introduces the H_GET_TCE hypervisor call which is basically the
reverse of H_PUT_TCE, as defined in the Power Architecture Platform
Requirements (PAPR).

The hcall H_GET_TCE is required by the kdump kernel which is calling it to
retrieve the TCE set up by the panicing kernel.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h      |    2 ++
 arch/powerpc/kvm/book3s_64_vio_hv.c     |   28 ++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index fcd53f0..4096f16 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -129,6 +129,8 @@ extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
 				struct kvm_create_spapr_tce *args);
 extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 			     unsigned long ioba, unsigned long tce);
+extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+			     unsigned long ioba);
 extern struct kvm_rma_info *kvm_alloc_rma(void);
 extern void kvm_release_rma(struct kvm_rma_info *ri);
 extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
index 2c25f54..89e96b3 100644
--- a/arch/powerpc/kvm/book3s_64_vio_hv.c
+++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
@@ -75,3 +75,31 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 	return H_TOO_HARD;
 }
 EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
+
+long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
+		      unsigned long ioba)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvmppc_spapr_tce_table *stt;
+
+	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
+		if (stt->liobn == liobn) {
+			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
+			struct page *page;
+			u64 *tbl;
+
+			if (ioba >= stt->window_size)
+				return H_PARAMETER;
+
+			page = stt->pages[idx / TCES_PER_PAGE];
+			tbl = (u64 *)page_address(page);
+
+			vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
+			return H_SUCCESS;
+		}
+	}
+
+	/* Didn't find the liobn, punt it to userspace */
+	return H_TOO_HARD;
+}
+EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e66d4ec..7d4fe2a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1758,7 +1758,7 @@ hcall_real_table:
 	.long	0		/* 0x10 - H_CLEAR_MOD */
 	.long	0		/* 0x14 - H_CLEAR_REF */
 	.long	.kvmppc_h_protect - hcall_real_table
-	.long	0		/* 0x1c - H_GET_TCE */
+	.long	.kvmppc_h_get_tce - hcall_real_table
 	.long	.kvmppc_h_put_tce - hcall_real_table
 	.long	0		/* 0x24 - H_SET_SPRG0 */
 	.long	.kvmppc_h_set_dabr - hcall_real_table
