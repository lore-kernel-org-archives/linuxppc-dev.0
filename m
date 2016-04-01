Return-Path: <lblulb@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbt3n65rSzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 18:16:53 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lblulb@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 03:16:50 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 3F86B6E803C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 03:03:38 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u317GmbU36503746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 07:16:48 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u317Gl8Q028345
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 03:16:48 -0400
From: Bin Lu <lblulb@linux.vnet.ibm.com>
To: agraf@suse.com, gleb@kernel.org, pbonzini@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: yongji_xie@cn.ibm.com, zhongli@cn.ibm.com,
 Bin Lu <lblulb@linux.vnet.ibm.com>
Subject: [PATCH] KVM: PPC:enable mmio_sign_extend in kvmppc_handle_load()
Date: Fri,  1 Apr 2016 07:16:09 +0000
Message-Id: <1459494969-23501-1-git-send-email-lblulb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The logic of 'kvmppc_handle_loads' is same as 'kvmppc_handle_load',
but with sign extension.  It sets mmio_sign_extend to 1, then calls
'kvmppc_handle_load', but in 'kvmppc_handle_load', the
mmio_sign_extend flag is reset to 0, so the data does not actually get
sign-extended.

This patch fixes the bug by removing the 'kvmppc_handle_loads'
function, adding a new parameter 'mmio_sign_extend' to
'kvmppc_handle_load'.  Calls to kvmppc_handle_loads() are replaced by
calls to kvmppc_handle_load() with 1 for the sign-extend parameter,
and existing calls to kvmppc_handle_load() have 0 added for the
sign-extend parameter.

Signed-off-by: Bin Lu <lblulb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kvm_ppc.h       |  5 +----
 arch/powerpc/kvm/book3s_paired_singles.c |  6 +++---
 arch/powerpc/kvm/emulate_loadstore.c     | 34 ++++++++++++++++----------------
 arch/powerpc/kvm/powerpc.c               | 17 ++--------------
 4 files changed, 23 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index af353f6..76829fa 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -74,10 +74,7 @@ extern void kvmppc_handler_highmem(void);
 extern void kvmppc_dump_vcpu(struct kvm_vcpu *vcpu);
 extern int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
                               unsigned int rt, unsigned int bytes,
-			      int is_default_endian);
-extern int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
-                               unsigned int rt, unsigned int bytes,
-			       int is_default_endian);
+			      int is_default_endian, u8 is_sign_extend);
 extern int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			       u64 val, unsigned int bytes,
 			       int is_default_endian);
diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index a759d9a..c9e3008 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -200,7 +200,7 @@ static int kvmppc_emulate_fpr_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto done_load;
 	} else if (r == EMULATE_DO_MMIO) {
 		emulated = kvmppc_handle_load(run, vcpu, KVM_MMIO_REG_FPR | rs,
-					      len, 1);
+					      len, 1, 0);
 		goto done_load;
 	}
 
@@ -291,12 +291,12 @@ static int kvmppc_emulate_psq_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		goto done_load;
 	} else if ((r == EMULATE_DO_MMIO) && w) {
 		emulated = kvmppc_handle_load(run, vcpu, KVM_MMIO_REG_FPR | rs,
-					      4, 1);
+					      4, 1, 0);
 		vcpu->arch.qpr[rs] = tmp[1];
 		goto done_load;
 	} else if (r == EMULATE_DO_MMIO) {
 		emulated = kvmppc_handle_load(run, vcpu, KVM_MMIO_REG_FQPR | rs,
-					      8, 1);
+					      8, 1, 0);
 		goto done_load;
 	}
 
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index 6d3c0ee..38b3b6b 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -70,15 +70,15 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	case 31:
 		switch (get_xop(inst)) {
 		case OP_31_XOP_LWZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1, 0);
 			break;
 
 		case OP_31_XOP_LBZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1, 0);
 			break;
 
 		case OP_31_XOP_LBZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1, 0);
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
@@ -102,15 +102,15 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			break;
 
 		case OP_31_XOP_LHAX:
-			emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 1);
 			break;
 
 		case OP_31_XOP_LHZX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 0);
 			break;
 
 		case OP_31_XOP_LHZUX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 0);
 			kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 			break;
 
@@ -138,7 +138,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			break;
 
 		case OP_31_XOP_LWBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 0);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 4, 0, 0);
 			break;
 
 		case OP_31_XOP_STWBRX:
@@ -148,7 +148,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 			break;
 
 		case OP_31_XOP_LHBRX:
-			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 0);
+			emulated = kvmppc_handle_load(run, vcpu, rt, 2, 0, 0);
 			break;
 
 		case OP_31_XOP_STHBRX:
@@ -164,26 +164,26 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		break;
 
 	case OP_LWZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1, 0);
 		break;
 
 	/* TBD: Add support for other 64 bit load variants like ldu, ldux, ldx etc. */
 	case OP_LD:
 		rt = get_rt(inst);
-		emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 8, 1, 0);
 		break;
 
 	case OP_LWZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 4, 1, 0);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
 	case OP_LBZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1, 0);
 		break;
 
 	case OP_LBZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 1, 1, 0);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
@@ -222,20 +222,20 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 		break;
 
 	case OP_LHZ:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 0);
 		break;
 
 	case OP_LHZU:
-		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 0);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
 	case OP_LHA:
-		emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 1);
 		break;
 
 	case OP_LHAU:
-		emulated = kvmppc_handle_loads(run, vcpu, rt, 2, 1);
+		emulated = kvmppc_handle_load(run, vcpu, rt, 2, 1, 1);
 		kvmppc_set_gpr(vcpu, ra, vcpu->arch.vaddr_accessed);
 		break;
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 99dc554..63f68e6 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -800,7 +800,7 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 
 int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		       unsigned int rt, unsigned int bytes,
-		       int is_default_endian)
+		       int is_default_endian, u8 is_sign_extend)
 {
 	int idx, ret;
 	bool host_swabbed;
@@ -825,7 +825,7 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	vcpu->arch.mmio_host_swabbed = host_swabbed;
 	vcpu->mmio_needed = 1;
 	vcpu->mmio_is_write = 0;
-	vcpu->arch.mmio_sign_extend = 0;
+	vcpu->arch.mmio_sign_extend = is_sign_extend;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 
@@ -844,19 +844,6 @@ int kvmppc_handle_load(struct kvm_run *run, struct kvm_vcpu *vcpu,
 }
 EXPORT_SYMBOL_GPL(kvmppc_handle_load);
 
-/* Same as above, but sign extends */
-int kvmppc_handle_loads(struct kvm_run *run, struct kvm_vcpu *vcpu,
-			unsigned int rt, unsigned int bytes,
-			int is_default_endian)
-{
-	int r;
-
-	vcpu->arch.mmio_sign_extend = 1;
-	r = kvmppc_handle_load(run, vcpu, rt, bytes, is_default_endian);
-
-	return r;
-}
-
 int kvmppc_handle_store(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			u64 val, unsigned int bytes, int is_default_endian)
 {
-- 
2.4.0
