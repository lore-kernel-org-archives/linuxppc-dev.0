Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6070B1A045B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 23:36:53 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <kvm-ppc@vger.kernel.org>
Subject: [PATCH v4 6/6] KVM: PPC: Booke: Add ONE_REG support for IVPR and IVORs
Date: Wed, 20 Aug 2014 16:36:27 +0300
Message-ID: <1408541787-24625-7-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
References: <1408541787-24625-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add ONE_REG support for IVPR and IVORs registers. Implement IVPR, IVORs 0-15
and 35 in booke common layer.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
v4:
 - add ONE_REG IVPR
 - use IVPR, IVOR2 and IVOR8 setters
 - add api documentation for ONE_REG IVPR and IVORs

v3:
 - new patch

 Documentation/virtual/kvm/api.txt   |   7 ++
 arch/powerpc/include/uapi/asm/kvm.h |  25 +++++++
 arch/powerpc/kvm/booke.c            | 145 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/kvm/e500.c             |  42 ++++++++++-
 arch/powerpc/kvm/e500mc.c           |  16 ++++
 5 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index beae3fd..cd7b171 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1917,6 +1917,13 @@ registers, find a list below:
   PPC   | KVM_REG_PPC_TM_VSCR           | 32
   PPC   | KVM_REG_PPC_TM_DSCR           | 64
   PPC   | KVM_REG_PPC_TM_TAR            | 64
+  PPC   | KVM_REG_PPC_IVPR              | 64
+  PPC   | KVM_REG_PPC_IVOR0             | 32
+          ...
+  PPC   | KVM_REG_PPC_IVOR15            | 32
+  PPC   | KVM_REG_PPC_IVOR32            | 32
+          ...
+  PPC   | KVM_REG_PPC_IVOR37            | 32
         |                               |
   MIPS  | KVM_REG_MIPS_R0               | 64
           ...
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ab4d473..c97f119 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -564,6 +564,31 @@ struct kvm_get_htab_header {
 #define KVM_REG_PPC_SPRG9	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xba)
 #define KVM_REG_PPC_DBSR	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbb)
 
+/* Booke IVPR & IVOR registers */
+#define KVM_REG_PPC_IVPR	(KVM_REG_PPC | KVM_REG_SIZE_U64 | 0xbc)
+#define KVM_REG_PPC_IVOR0	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbd)
+#define KVM_REG_PPC_IVOR1	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbe)
+#define KVM_REG_PPC_IVOR2	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xbf)
+#define KVM_REG_PPC_IVOR3	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc0)
+#define KVM_REG_PPC_IVOR4	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc1)
+#define KVM_REG_PPC_IVOR5	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc2)
+#define KVM_REG_PPC_IVOR6	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc3)
+#define KVM_REG_PPC_IVOR7	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc4)
+#define KVM_REG_PPC_IVOR8	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc5)
+#define KVM_REG_PPC_IVOR9	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc6)
+#define KVM_REG_PPC_IVOR10	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc7)
+#define KVM_REG_PPC_IVOR11	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc8)
+#define KVM_REG_PPC_IVOR12	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xc9)
+#define KVM_REG_PPC_IVOR13	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xca)
+#define KVM_REG_PPC_IVOR14	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xcb)
+#define KVM_REG_PPC_IVOR15	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xcc)
+#define KVM_REG_PPC_IVOR32	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xcd)
+#define KVM_REG_PPC_IVOR33	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xce)
+#define KVM_REG_PPC_IVOR34	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xcf)
+#define KVM_REG_PPC_IVOR35	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xd0)
+#define KVM_REG_PPC_IVOR36	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xd1)
+#define KVM_REG_PPC_IVOR37	(KVM_REG_PPC | KVM_REG_SIZE_U32 | 0xd2)
+
 /* Transactional Memory checkpointed state:
  * This is all GPRs, all VSX regs and a subset of SPRs
  */
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d4df648..1cb2a2a 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1570,6 +1570,75 @@ int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
 	int r = 0;
 
 	switch (id) {
+	case KVM_REG_PPC_IVPR:
+		*val = get_reg_val(id, vcpu->arch.ivpr);
+		break;
+	case KVM_REG_PPC_IVOR0:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_CRITICAL]);
+		break;
+	case KVM_REG_PPC_IVOR1:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_MACHINE_CHECK]);
+		break;
+	case KVM_REG_PPC_IVOR2:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_DATA_STORAGE]);
+		break;
+	case KVM_REG_PPC_IVOR3:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_INST_STORAGE]);
+		break;
+	case KVM_REG_PPC_IVOR4:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_EXTERNAL]);
+		break;
+	case KVM_REG_PPC_IVOR5:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_ALIGNMENT]);
+		break;
+	case KVM_REG_PPC_IVOR6:
+		*val = get_reg_val(id, vcpu->arch.ivor[BOOKE_IRQPRIO_PROGRAM]);
+		break;
+	case KVM_REG_PPC_IVOR7:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_FP_UNAVAIL]);
+		break;
+	case KVM_REG_PPC_IVOR8:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_CRITICAL]);
+		break;
+	case KVM_REG_PPC_IVOR9:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_AP_UNAVAIL]);
+		break;
+	case KVM_REG_PPC_IVOR10:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_DECREMENTER]);
+		break;
+	case KVM_REG_PPC_IVOR11:
+		*val = get_reg_val(id, vcpu->arch.ivor[BOOKE_IRQPRIO_FIT]);
+		break;
+	case KVM_REG_PPC_IVOR12:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_WATCHDOG]);
+		break;
+	case KVM_REG_PPC_IVOR13:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_DTLB_MISS]);
+		break;
+	case KVM_REG_PPC_IVOR14:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_ITLB_MISS]);
+		break;
+	case KVM_REG_PPC_IVOR15:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_DEBUG]);
+		break;
+	case KVM_REG_PPC_IVOR35:
+		*val = get_reg_val(id,
+			vcpu->arch.ivor[BOOKE_IRQPRIO_PERFORMANCE_MONITOR]);
+		break;
 	case KVM_REG_PPC_IAC1:
 		*val = get_reg_val(id, vcpu->arch.dbg_reg.iac1);
 		break;
@@ -1626,6 +1695,82 @@ int kvmppc_set_one_reg(struct kvm_vcpu *vcpu, u64 id,
 	int r = 0;
 
 	switch (id) {
+	case KVM_REG_PPC_IVPR: {
+		ulong new_ivpr = set_reg_val(id, *val);
+
+		kvmppc_set_ivpr(vcpu, new_ivpr);
+		break;
+	}
+	case KVM_REG_PPC_IVOR0:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_CRITICAL] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR1:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_MACHINE_CHECK] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR2: {
+		u32 new_ivor = set_reg_val(id, *val);
+
+		kvmppc_set_ivor2(vcpu, new_ivor);
+		break;
+	}
+	case KVM_REG_PPC_IVOR3:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_INST_STORAGE] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR4:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_EXTERNAL] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR5:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_ALIGNMENT] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR6:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_PROGRAM] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR7:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_FP_UNAVAIL] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR8: {
+		u32 new_ivor = set_reg_val(id, *val);
+
+		kvmppc_set_ivor8(vcpu, new_ivor);
+		break;
+	}
+	case KVM_REG_PPC_IVOR9:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_AP_UNAVAIL] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR10:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_DECREMENTER] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR11:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_FIT] = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR12:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_WATCHDOG] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR13:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_DTLB_MISS] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR14:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_ITLB_MISS] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR15:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_DEBUG] = set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR35:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_PERFORMANCE_MONITOR] =
+			set_reg_val(id, *val);
+		break;
 	case KVM_REG_PPC_IAC1:
 		vcpu->arch.dbg_reg.iac1 = set_reg_val(id, *val);
 		break;
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 2e02ed8..08f61bf 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -433,14 +433,52 @@ static int kvmppc_core_set_sregs_e500(struct kvm_vcpu *vcpu,
 static int kvmppc_get_one_reg_e500(struct kvm_vcpu *vcpu, u64 id,
 				   union kvmppc_one_reg *val)
 {
-	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	int r = 0;
+
+	switch (id) {
+	case KVM_REG_PPC_IVOR32:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL]);
+		break;
+	case KVM_REG_PPC_IVOR33:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA]);
+		break;
+	case KVM_REG_PPC_IVOR34:
+		*val = get_reg_val(id,
+				vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND]);
+		break;
+	default:
+		r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+		break;
+	}
+
 	return r;
 }
 
 static int kvmppc_set_one_reg_e500(struct kvm_vcpu *vcpu, u64 id,
 				   union kvmppc_one_reg *val)
 {
-	int r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+	int r = 0;
+
+	switch (id) {
+	case KVM_REG_PPC_IVOR32:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR33:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_DATA] =
+			set_reg_val(id, *val);
+		break;
+	case KVM_REG_PPC_IVOR34:
+		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_FP_ROUND] =
+			set_reg_val(id, *val);
+		break;
+	default:
+		r = kvmppc_get_one_reg_e500_tlb(vcpu, id, val);
+		break;
+	}
+
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index 4549349..0668bc7 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -268,6 +268,22 @@ static int kvmppc_get_one_reg_e500mc(struct kvm_vcpu *vcpu, u64 id,
 	int r = 0;
 
 	switch (id) {
+	case KVM_REG_PPC_IVOR32:
+		*val = get_reg_val(id,
+			vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_UNAVAIL]);
+		break;
+	case KVM_REG_PPC_IVOR33:
+		*val = get_reg_val(id,
+			vcpu->arch.ivor[BOOKE_IRQPRIO_ALTIVEC_ASSIST]);
+		break;
+	case KVM_REG_PPC_IVOR36:
+		*val = get_reg_val(id,
+			vcpu->arch.ivor[BOOKE_IRQPRIO_DBELL]);
+		break;
+	case KVM_REG_PPC_IVOR37:
+		*val = get_reg_val(id,
+			vcpu->arch.ivor[BOOKE_IRQPRIO_DBELL_CRIT]);
+		break;
 	case KVM_REG_PPC_SPRG9:
 		*val = get_reg_val(id, vcpu->arch.sprg9);
 		break;
-- 
1.7.11.7
