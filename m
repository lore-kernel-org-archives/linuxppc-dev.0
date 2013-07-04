Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D2602C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 17:06:29 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <tiejun.chen@windriver.com>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <mikey@neuling.org>,
 <scottwood@freescale.com>, <sfr@canb.auug.org.au>
Subject: [PATCH 2/4 v6] KVM: PPC: exit to user space on "ehpriv 1" instruction
Date: Thu, 4 Jul 2013 12:27:45 +0530
Message-ID: <1372921067-19678-3-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1372921067-19678-1-git-send-email-Bharat.Bhushan@freescale.com>
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

"ehpriv 1" instruction is used for setting software breakpoints
by user space. This patch adds support to exit to user space
with "run->debug" have relevant information.

As this is the first point we are using run->debug, also defined
the run->debug structure.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v5->v6
 - using "ehpriv 1" instread of "ehpriv" for software breakpoint

 arch/powerpc/include/asm/disassemble.h |    4 ++++
 arch/powerpc/include/asm/kvm_booke.h   |    7 ++++++-
 arch/powerpc/include/uapi/asm/kvm.h    |   21 +++++++++++++++++----
 arch/powerpc/kvm/booke.c               |    2 +-
 arch/powerpc/kvm/e500_emulate.c        |   26 ++++++++++++++++++++++++++
 5 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/disassemble.h b/arch/powerpc/include/asm/disassemble.h
index 9b198d1..856f8de 100644
--- a/arch/powerpc/include/asm/disassemble.h
+++ b/arch/powerpc/include/asm/disassemble.h
@@ -77,4 +77,8 @@ static inline unsigned int get_d(u32 inst)
 	return inst & 0xffff;
 }
 
+static inline unsigned int get_oc(u32 inst)
+{
+	return (inst >> 11) & 0x7fff;
+}
 #endif /* __ASM_PPC_DISASSEMBLE_H__ */
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index d3c1eb3..dd8f615 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -26,7 +26,12 @@
 /* LPIDs we support with this build -- runtime limit may be lower */
 #define KVMPPC_NR_LPIDS                        64
 
-#define KVMPPC_INST_EHPRIV	0x7c00021c
+#define KVMPPC_INST_EHPRIV		0x7c00021c
+#define EHPRIV_OC_SHIFT			11
+/* "ehpriv 1" : ehpriv with OC = 1 is used for debug emulation */
+#define EHPRIV_OC_DEBUG			1
+#define KVMPPC_INST_EHPRIV_DEBUG	(KVMPPC_INST_EHPRIV | \
+					 (EHPRIV_OC_DEBUG << EHPRIV_OC_SHIFT))
 
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index 0fb1a6e..ded0607 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -269,7 +269,24 @@ struct kvm_fpu {
 	__u64 fpr[32];
 };
 
+/*
+ * Defines for h/w breakpoint, watchpoint (read, write or both) and
+ * software breakpoint.
+ * These are used as "type" in KVM_SET_GUEST_DEBUG ioctl and "status"
+ * for KVM_DEBUG_EXIT.
+ */
+#define KVMPPC_DEBUG_NONE		0x0
+#define KVMPPC_DEBUG_BREAKPOINT		(1UL << 1)
+#define KVMPPC_DEBUG_WATCH_WRITE	(1UL << 2)
+#define KVMPPC_DEBUG_WATCH_READ		(1UL << 3)
 struct kvm_debug_exit_arch {
+	__u64 address;
+	/*
+	 * exiting to userspace because of h/w breakpoint, watchpoint
+	 * (read, write or both) and software breakpoint.
+	 */
+	__u32 status;
+	__u32 reserved;
 };
 
 /* for KVM_SET_GUEST_DEBUG */
@@ -281,10 +298,6 @@ struct kvm_guest_debug_arch {
 		 * Type denotes h/w breakpoint, read watchpoint, write
 		 * watchpoint or watchpoint (both read and write).
 		 */
-#define KVMPPC_DEBUG_NONE		0x0
-#define KVMPPC_DEBUG_BREAKPOINT		(1UL << 1)
-#define KVMPPC_DEBUG_WATCH_WRITE	(1UL << 2)
-#define KVMPPC_DEBUG_WATCH_READ		(1UL << 3)
 		__u32 type;
 		__u32 reserved;
 	} bp[16];
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 62d4ece..4c9f6ad 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1460,7 +1460,7 @@ int kvm_vcpu_ioctl_get_one_reg(struct kvm_vcpu *vcpu, struct kvm_one_reg *reg)
 		val = get_reg_val(reg->id, vcpu->arch.tsr);
 		break;
 	case KVM_REG_PPC_DEBUG_INST:
-		val = get_reg_val(reg->id, KVMPPC_INST_EHPRIV);
+		val = get_reg_val(reg->id, KVMPPC_INST_EHPRIV_DEBUG);
 		break;
 	default:
 		r = kvmppc_get_one_reg(vcpu, reg->id, &val);
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index b10a012..6163a03 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -26,6 +26,7 @@
 #define XOP_TLBRE   946
 #define XOP_TLBWE   978
 #define XOP_TLBILX  18
+#define XOP_EHPRIV  270
 
 #ifdef CONFIG_KVM_E500MC
 static int dbell2prio(ulong param)
@@ -82,6 +83,26 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
 }
 #endif
 
+static int kvmppc_e500_emul_ehpriv(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				   unsigned int inst, int *advance)
+{
+	int emulated = EMULATE_DONE;
+
+	switch (get_oc(inst)) {
+	case EHPRIV_OC_DEBUG:
+		run->exit_reason = KVM_EXIT_DEBUG;
+		run->debug.arch.address = vcpu->arch.pc;
+		run->debug.arch.status = 0;
+		kvmppc_account_exit(vcpu, DEBUG_EXITS);
+		emulated = EMULATE_EXIT_USER;
+		*advance = 0;
+		break;
+	default:
+		emulated = EMULATE_FAIL;
+	}
+	return emulated;
+}
+
 int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                            unsigned int inst, int *advance)
 {
@@ -130,6 +151,11 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			emulated = kvmppc_e500_emul_tlbivax(vcpu, ea);
 			break;
 
+		case XOP_EHPRIV:
+			emulated = kvmppc_e500_emul_ehpriv(run, vcpu, inst,
+							   advance);
+			break;
+
 		default:
 			emulated = EMULATE_FAIL;
 		}
-- 
1.7.0.4
