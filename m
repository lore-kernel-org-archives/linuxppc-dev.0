Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40fXYQ38CFzF157
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 May 2018 16:20:42 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id n9-v6so19495547pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 May 2018 23:20:42 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v2 03/10] KVM: PPC: Fix a mmio_host_swabbed uninitialized
 usage issue when VMX store
Date: Mon,  7 May 2018 14:20:09 +0800
Message-Id: <1525674016-6703-4-git-send-email-wei.guo.simon@gmail.com>
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

When KVM emulates VMX store, it will invoke kvmppc_get_vmx_data() to
retrieve VMX reg val. kvmppc_get_vmx_data() will check mmio_host_swabbed
to decide which double word of vr[] to be used. But the
mmio_host_swabbed can be uninitiazed during VMX store procedure:

kvmppc_emulate_loadstore
	\- kvmppc_handle_store128_by2x64
		\- kvmppc_get_vmx_data

So vcpu->arch.mmio_host_swabbed is not meant to be used at all for
emulation of store instructions, and this patch makes that true for
VMX stores. This patch also initializes mmio_host_swabbed to avoid
invisble trouble.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kvm/emulate_loadstore.c | 1 +
 arch/powerpc/kvm/powerpc.c           | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/emulate_loadstore.c b/arch/powerpc/kvm/emulate_loadstore.c
index a382e15..b8a3aef 100644
--- a/arch/powerpc/kvm/emulate_loadstore.c
+++ b/arch/powerpc/kvm/emulate_loadstore.c
@@ -111,6 +111,7 @@ int kvmppc_emulate_loadstore(struct kvm_vcpu *vcpu)
 	vcpu->arch.mmio_sp64_extend = 0;
 	vcpu->arch.mmio_sign_extend = 0;
 	vcpu->arch.mmio_vmx_copy_nums = 0;
+	vcpu->arch.mmio_host_swabbed = 0;
 
 	switch (get_op(inst)) {
 	case 31:
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 4e38764..bef27b1 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1374,7 +1374,7 @@ static inline int kvmppc_get_vmx_data(struct kvm_vcpu *vcpu, int rs, u64 *val)
 	if (di > 1)
 		return -1;
 
-	if (vcpu->arch.mmio_host_swabbed)
+	if (kvmppc_need_byteswap(vcpu))
 		di = 1 - di;
 
 	w0 = vrs.u[di * 2];
-- 
1.8.3.1
