Return-Path: <R65777@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79C062C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:34:50 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <scottwood@freescale.com>, <tiejun.chen@windriver.com>,
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <mikey@neuling.org>
Subject: [PATCH 5/6 v5] KVM: PPC: Using "struct debug_reg"
Date: Wed, 26 Jun 2013 11:12:25 +0530
Message-ID: <1372225346-5029-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372225346-5029-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For KVM also use the "struct debug_reg" defined in asm/processor.h

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/include/asm/kvm_host.h |   13 +------------
 arch/powerpc/kvm/booke.c            |   34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index af326cd..838a577 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -381,17 +381,6 @@ struct kvmppc_slb {
 #define KVMPPC_EPR_USER		1 /* exit to userspace to fill EPR */
 #define KVMPPC_EPR_KERNEL	2 /* in-kernel irqchip */
 
-struct kvmppc_booke_debug_reg {
-	u32 dbcr0;
-	u32 dbcr1;
-	u32 dbcr2;
-#ifdef CONFIG_KVM_E500MC
-	u32 dbcr4;
-#endif
-	u64 iac[KVMPPC_BOOKE_MAX_IAC];
-	u64 dac[KVMPPC_BOOKE_MAX_DAC];
-};
-
 #define KVMPPC_IRQ_DEFAULT	0
 #define KVMPPC_IRQ_MPIC		1
 #define KVMPPC_IRQ_XICS		2
@@ -535,7 +524,7 @@ struct kvm_vcpu_arch {
 	u32 eptcfg;
 	u32 epr;
 	u32 crit_save;
-	struct kvmppc_booke_debug_reg dbg_reg;
+	struct debug_reg dbg_reg;
 #endif
 	gpa_t paddr_accessed;
 	gva_t vaddr_accessed;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 62d4ece..3e9fc1d 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1424,7 +1424,6 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	int r = 0;
 	union kvmppc_one_reg val;
 	int size;
-	long int i;
 
 	size = one_reg_size(reg->id);
 	if (size > sizeof(val))
@@ -1432,16 +1431,24 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 
 	switch (reg->id) {
 	case KVM_REG_PPC_IAC1:
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac1);
+		break;
 	case KVM_REG_PPC_IAC2:
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac2);
+		break;
+#if CONFIG_PPC_ADV_DEBUG_IACS > 2
 	case KVM_REG_PPC_IAC3:
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac3);
+		break;
 	case KVM_REG_PPC_IAC4:
-		i = reg->id - KVM_REG_PPC_IAC1;
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac[i]);
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.iac4);
 		break;
+#endif
 	case KVM_REG_PPC_DAC1:
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac1);
+		break;
 	case KVM_REG_PPC_DAC2:
-		i = reg->id - KVM_REG_PPC_DAC1;
-		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac[i]);
+		val = get_reg_val(reg->id, vcpu->arch.dbg_reg.dac2);
 		break;
 	case KVM_REG_PPC_EPR: {
 		u32 epr = get_guest_epr(vcpu);
@@ -1481,7 +1488,6 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 	int r = 0;
 	union kvmppc_one_reg val;
 	int size;
-	long int i;
 
 	size = one_reg_size(reg->id);
 	if (size > sizeof(val))
@@ -1492,16 +1498,24 @@ int kvm_vcpu_ioctl_set_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 
 	switch (reg->id) {
 	case KVM_REG_PPC_IAC1:
+		vcpu->arch.dbg_reg.iac1 = set_reg_val(reg->id, val);
+		break;
 	case KVM_REG_PPC_IAC2:
+		vcpu->arch.dbg_reg.iac2 = set_reg_val(reg->id, val);
+		break;
+#if CONFIG_PPC_ADV_DEBUG_IACS > 2
 	case KVM_REG_PPC_IAC3:
+		vcpu->arch.dbg_reg.iac3 = set_reg_val(reg->id, val);
+		break;
 	case KVM_REG_PPC_IAC4:
-		i = reg->id - KVM_REG_PPC_IAC1;
-		vcpu->arch.dbg_reg.iac[i] = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.iac4 = set_reg_val(reg->id, val);
 		break;
+#endif
 	case KVM_REG_PPC_DAC1:
+		vcpu->arch.dbg_reg.dac1 = set_reg_val(reg->id, val);
+		break;
 	case KVM_REG_PPC_DAC2:
-		i = reg->id - KVM_REG_PPC_DAC1;
-		vcpu->arch.dbg_reg.dac[i] = set_reg_val(reg->id, val);
+		vcpu->arch.dbg_reg.dac2 = set_reg_val(reg->id, val);
 		break;
 	case KVM_REG_PPC_EPR: {
 		u32 new_epr = set_reg_val(reg->id, val);
-- 
1.7.0.4
