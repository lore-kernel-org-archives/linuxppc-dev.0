Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxVGw3MjbzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 21:28:40 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] KVM: PPC: Book3S PR: Do not always inject facility
 unavailable exceptions
Date: Mon,  3 Apr 2017 13:28:34 +0200
Message-Id: <1491218914-10992-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM should not inject a facility unavailable exception into the guest
when it tries to execute a mtspr/mfspr instruction for an SPR that
is unavailable, and the vCPU is *not* running in PRoblem state.

It's right that we inject an exception when the vCPU is in PR mode, since
chapter "6.2.10 Facility Status and Control Register" of the PowerISA
v2.07 says that "When the FSCR makes a facility unavailable, attempted
usage of the facility in *problem state* is treated as follows: [...]
Access of an SPR using mfspr/mtspr causes a Facility Unavailable
interrupt". But if the guest vCPU is not in PR mode, we should follow
the behavior that is described in chapter "4.4.4 Move To/From System
Register Instructions" instead and treat the instruction as a NOP.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/kvm/book3s_pr.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index d4dfc0c..3e6c0b3 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -27,6 +27,7 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 #include <asm/cacheflush.h>
+#include <asm/disassemble.h>
 #include <asm/tlbflush.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
@@ -830,6 +831,31 @@ static void kvmppc_emulate_fac(struct kvm_vcpu *vcpu, ulong fac)
 	}
 }
 
+static void kvmppc_handle_fac_not_enabled(struct kvm_vcpu *vcpu, ulong fac)
+{
+	enum emulation_result er;
+	u32 inst;
+
+	if (kvmppc_get_msr(vcpu) & MSR_PR) {
+		kvmppc_trigger_fac_interrupt(vcpu, fac);
+		return;
+	}
+
+	er = kvmppc_get_last_inst(vcpu, INST_GENERIC, &inst);
+	if (er != EMULATE_DONE)
+		return;
+
+	if (get_op(inst) == 31 && (get_xop(inst) == OP_31_XOP_MTSPR ||
+				   get_xop(inst) == OP_31_XOP_MFSPR)) {
+		/* mtspr and mfspr are treated as NOP for unsupported SPRs */
+		kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
+		pr_debug_ratelimited("%s: write/read of disabled SPR: %d\n",
+				     __func__, get_sprn(inst));
+	} else {
+		kvmppc_trigger_fac_interrupt(vcpu, fac);
+	}
+}
+
 /* Enable facilities (TAR, EBB, DSCR) for the guest */
 static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac)
 {
@@ -855,7 +881,7 @@ static int kvmppc_handle_fac(struct kvm_vcpu *vcpu, ulong fac)
 
 	if (!guest_fac_enabled) {
 		/* Facility not enabled by the guest */
-		kvmppc_trigger_fac_interrupt(vcpu, fac);
+		kvmppc_handle_fac_not_enabled(vcpu, fac);
 		return RESUME_GUEST;
 	}
 
-- 
1.8.3.1
