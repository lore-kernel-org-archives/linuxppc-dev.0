Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40q7RZ3XNwzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 16:00:25 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id c11-v6so8153493plr.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 May 2018 23:00:25 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v3 6/7] KVM: PPC: expand mmio_vsx_copy_type to mmio_copy_type
 to cover VMX load/store elem types
Date: Mon, 21 May 2018 13:24:25 +0800
Message-Id: <1526880266-11291-7-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
References: <1526880266-11291-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

VSX MMIO emulation uses mmio_vsx_copy_type to represent VSX emulated
element size/type, such as KVMPPC_VSX_COPY_DWORD_LOAD, etc. This
patch expands mmio_vsx_copy_type to cover VMX copy type, such as
KVMPPC_VMX_COPY_BYTE(stvebx/lvebx), etc. As a result,
mmio_vsx_copy_type is also renamed to mmio_copy_type.

It is a preparation for reimplement VMX MMIO emulation.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h  |  9 +++++++--
 arch/powerpc/kvm/emulate_loadstore.c | 14 +++++++-------
 arch/powerpc/kvm/powerpc.c           | 10 +++++-----
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 4bade29..fe506c8 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -455,6 +455,11 @@ struct mmio_hpte_cache {
 #define KVMPPC_VSX_COPY_DWORD_LOAD_DUMP	3
 #define KVMPPC_VSX_COPY_WORD_LOAD_DUMP	4
 
+#define KVMPPC_VMX_COPY_BYTE		8
+#define KVMPPC_VMX_COPY_HWORD		9
+#define KVMPPC_VMX_COPY_WORD		10
+#define KVMPPC_VMX_COPY_DWORD		11
+
 struct openpic;
 
 /* W0 and W1 of a XIVE thread management context */
@@ -677,16 +682,16 @@ struct kvm_vcpu_arch {
 	 * Number of simulations for vsx.
 	 * If we use 2*8bytes to simulate 1*16bytes,
 	 * then the number should be 2 and
-	 * mmio_vsx_copy_type=KVMPPC_VSX_COPY_DWORD.
+	 * mmio_copy_type=KVMPPC_VSX_COPY_DWORD.
 	 * If we use 4*4bytes to simulate 1*16bytes,
 	 * the number should be 4 and
 	 * mmio_vsx_copy_type=KVMPPC_VSX_COPY_WORD.
 	 */
 	u8 mmio_vsx_copy_nums;
 	u8 mmio_vsx_offset;
-	u8 mmio_vsx_copy_type;
 	u8 mmio_vsx_tx_sx_enabled;
 	u8 mmio_vmx_copy_nums;
+	u8 mmio_copy_type;
 	u8 osi_needed;
 	u8 osi_enabled;
 	u8 papr_enabled;
diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index ed73497..fa4de6b 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -109,7 +109,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_vsx_tx_sx_enabled = get_tx_or_sx(inst);
 	vcpu->arch.mmio_vsx_copy_nums = 0;
 	vcpu->arch.mmio_vsx_offset = 0;
-	vcpu->arch.mmio_vsx_copy_type = KVMPPC_VSX_COPY_NONE;
+	vcpu->arch.mmio_copy_type = KVMPPC_VSX_COPY_NONE;
 	vcpu->arch.mmio_sp64_extend = 0;
 	vcpu->arch.mmio_sign_extend = 0;
 	vcpu->arch.mmio_vmx_copy_nums = 0;
@@ -175,17 +175,17 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 
 			if (op.element_size == 8)  {
 				if (op.vsx_flags & VSX_SPLAT)
-					vcpu->arch.mmio_vsx_copy_type =
+					vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_DWORD_LOAD_DUMP;
 				else
-					vcpu->arch.mmio_vsx_copy_type =
+					vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_DWORD;
 			} else if (op.element_size == 4) {
 				if (op.vsx_flags & VSX_SPLAT)
-					vcpu->arch.mmio_vsx_copy_type =
+					vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_WORD_LOAD_DUMP;
 				else
-					vcpu->arch.mmio_vsx_copy_type =
+					vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_WORD;
 			} else
 				break;
@@ -261,10 +261,10 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 				vcpu->arch.mmio_sp64_extend = 1;
 
 			if (op.element_size == 8)
-				vcpu->arch.mmio_vsx_copy_type =
+				vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_DWORD;
 			else if (op.element_size == 4)
-				vcpu->arch.mmio_vsx_copy_type =
+				vcpu->arch.mmio_copy_type =
 						KVMPPC_VSX_COPY_WORD;
 			else
 				break;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 8ce9e7b..1580bd2 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1080,14 +1080,14 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		if (vcpu->kvm->arch.kvm_ops->giveup_ext)
 			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VSX);
 
-		if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_DWORD)
+		if (vcpu->arch.mmio_copy_type == KVMPPC_VSX_COPY_DWORD)
 			kvmppc_set_vsr_dword(vcpu, gpr);
-		else if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_WORD)
+		else if (vcpu->arch.mmio_copy_type == KVMPPC_VSX_COPY_WORD)
 			kvmppc_set_vsr_word(vcpu, gpr);
-		else if (vcpu->arch.mmio_vsx_copy_type ==
+		else if (vcpu->arch.mmio_copy_type ==
 				KVMPPC_VSX_COPY_DWORD_LOAD_DUMP)
 			kvmppc_set_vsr_dword_dump(vcpu, gpr);
-		else if (vcpu->arch.mmio_vsx_copy_type ==
+		else if (vcpu->arch.mmio_copy_type ==
 				KVMPPC_VSX_COPY_WORD_LOAD_DUMP)
 			kvmppc_set_vsr_word_dump(vcpu, gpr);
 		break;
@@ -1260,7 +1260,7 @@ static inline int kvmppc_get_vsr_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
 	u32 dword_offset, word_offset;
 	union kvmppc_one_reg reg;
 	int vsx_offset = 0;
-	int copy_type = vcpu->arch.mmio_vsx_copy_type;
+	int copy_type = vcpu->arch.mmio_copy_type;
 	int result = 0;
 
 	switch (copy_type) {
-- 
1.8.3.1
