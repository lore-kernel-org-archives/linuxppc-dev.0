Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxV8z3WlQzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 21:23:31 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] KVM: PPC: Book3S PR: Do not fail emulation with mtspr/mfspr
 for unknown SPRs
Date: Mon,  3 Apr 2017 13:23:15 +0200
Message-Id: <1491218595-10943-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the PowerISA 2.07, mtspr and mfspr should not generate
an illegal instruction exception when being used with an undefined SPR,
but rather treat the instruction as a NOP, inject a privilege exception
or an emulation assistance exception - depending on the SPR number.
Also turn the printk here into a ratelimited print statement, so that
the guest can not flood the dmesg log of the host by issueing lots of
illegal mtspr/mfspr instruction here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/kvm/book3s.c         |  1 +
 arch/powerpc/kvm/book3s_emulate.c | 30 ++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b6b5c18..9b007f9 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -137,6 +137,7 @@ void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags)
 	kvmppc_set_pc(vcpu, kvmppc_interrupt_offset(vcpu) + vec);
 	vcpu->arch.mmu.reset_msr(vcpu);
 }
+EXPORT_SYMBOL_GPL(kvmppc_inject_interrupt);
 
 static int kvmppc_book3s_vec2irqprio(unsigned int vec)
 {
diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 8359752..9c31e23 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -503,10 +503,16 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
 		break;
 unprivileged:
 	default:
-		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
-#ifndef DEBUG_SPR
-		emulated = EMULATE_FAIL;
-#endif
+		pr_info_ratelimited("KVM: invalid SPR write: %d\n", sprn);
+		if (sprn & 0x10) {
+			if (kvmppc_get_msr(vcpu) & MSR_PR)
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+		} else {
+			if ((kvmppc_get_msr(vcpu) & MSR_PR) || sprn == 0)
+				kvmppc_inject_interrupt(vcpu,
+						BOOK3S_INTERRUPT_H_EMUL_ASSIST,
+						0);
+		}
 		break;
 	}
 
@@ -648,10 +654,18 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
 		break;
 	default:
 unprivileged:
-		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
-#ifndef DEBUG_SPR
-		emulated = EMULATE_FAIL;
-#endif
+		pr_info_ratelimited("KVM: invalid SPR read: %d\n", sprn);
+		if (sprn & 0x10) {
+			if (kvmppc_get_msr(vcpu) & MSR_PR)
+				kvmppc_core_queue_program(vcpu, SRR1_PROGPRIV);
+		} else {
+			if ((kvmppc_get_msr(vcpu) & MSR_PR) || sprn == 0 ||
+			    sprn == 4 || sprn == 5 || sprn == 6)
+				kvmppc_inject_interrupt(vcpu,
+						BOOK3S_INTERRUPT_H_EMUL_ASSIST,
+						0);
+		}
+
 		break;
 	}
 
-- 
1.8.3.1
