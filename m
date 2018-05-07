Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYX65YXzF151
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:48 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id x9so2873566pfm.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:48 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 04/10] KVM: PPC: add KVMPPC_VSX_COPY_WORD_LOAD_DUMP type
 support for mmio emulation
Date: Mon,  7 May 2018 14:20:10 +0800
Message-Id: <1525674016-6703-5-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
References: <1525674016-6703-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Some VSX instruction like lxvwsx will splat word into VSR. This patch
adds VSX copy type KVMPPC_VSX_COPY_WORD_LOAD_DUMP to support this.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kvm/powerpc.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d87768..3fb5e8d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -454,6 +454,7 @@ struct mmio_hpte_cache {
 #define KVMPPC_VSX_COPY_WORD		1
 #define KVMPPC_VSX_COPY_DWORD		2
 #define KVMPPC_VSX_COPY_DWORD_LOAD_DUMP	3
+#define KVMPPC_VSX_COPY_WORD_LOAD_DUMP	4
 
 struct openpic;
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index bef27b1..45daf3b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -907,6 +907,26 @@ static inline void kvmppc_set_vsr_dword_dump(struct kvm_vcpu *vcpu,
 	}
 }
 
+static inline void kvmppc_set_vsr_word_dump(struct kvm_vcpu *vcpu,
+	u32 gpr)
+{
+	union kvmppc_one_reg val;
+	int index = vcpu->arch.io_gpr & KVM_MMIO_REG_MASK;
+
+	if (vcpu->arch.mmio_vsx_tx_sx_enabled) {
+		val.vsx32val[0] = gpr;
+		val.vsx32val[1] = gpr;
+		val.vsx32val[2] = gpr;
+		val.vsx32val[3] = gpr;
+		VCPU_VSX_VR(vcpu, index) = val.vval;
+	} else {
+		val.vsx32val[0] = gpr;
+		val.vsx32val[1] = gpr;
+		VCPU_VSX_FPR(vcpu, index, 0) = val.vsxval[0];
+		VCPU_VSX_FPR(vcpu, index, 1) = val.vsxval[0];
+	}
+}
+
 static inline void kvmppc_set_vsr_word(struct kvm_vcpu *vcpu,
 	u32 gpr32)
 {
@@ -1061,6 +1081,9 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		else if (vcpu->arch.mmio_vsx_copy_type ==
 				KVMPPC_VSX_COPY_DWORD_LOAD_DUMP)
 			kvmppc_set_vsr_dword_dump(vcpu, gpr);
+		else if (vcpu->arch.mmio_vsx_copy_type ==
+				KVMPPC_VSX_COPY_WORD_LOAD_DUMP)
+			kvmppc_set_vsr_word_dump(vcpu, gpr);
 		break;
 #endif
 #ifdef CONFIG_ALTIVEC
-- 
1.8.3.1
