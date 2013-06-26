Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A3C7A2C029D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 15:34:43 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <kvm-ppc@vger.kernel.org>, <kvm@vger.kernel.org>, <agraf@suse.de>,
 <scottwood@freescale.com>, <tiejun.chen@windriver.com>,
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <mikey@neuling.org>
Subject: [PATCH 4/6 v5] KVM: PPC: exit to user space on "ehpriv" instruction
Date: Wed, 26 Jun 2013 11:12:24 +0530
Message-ID: <1372225346-5029-5-git-send-email-Bharat.Bhushan@freescale.com>
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

"ehpriv" instruction is used for setting software breakpoints
by user space. This patch adds support to exit to user space
with "run->debug" have relevant information.

As this is the first point we are using run->debug, also defined
the run->debug structure.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
 arch/powerpc/include/asm/disassemble.h |    4 ++++
 arch/powerpc/include/uapi/asm/kvm.h    |   21 +++++++++++++++++----
 arch/powerpc/kvm/e500_emulate.c        |   27 +++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

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
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index b10a012..dab9d07 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -26,6 +26,8 @@
 #define XOP_TLBRE   946
 #define XOP_TLBWE   978
 #define XOP_TLBILX  18
+#define XOP_EHPRIV  270
+#define EHPRIV_OC_DEBUG 0
 
 #ifdef CONFIG_KVM_E500MC
 static int dbell2prio(ulong param)
@@ -82,6 +84,26 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
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
@@ -130,6 +152,11 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
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
