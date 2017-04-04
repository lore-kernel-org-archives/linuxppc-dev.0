Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy4N32tSgzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 20:05:07 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Paul Mackerras <paulus@samba.org>,
	kvm-ppc@vger.kernel.org
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2] KVM: PPC: Book3S PR: Do not fail emulation with
 mtspr/mfspr for unknown SPRs
Date: Tue,  4 Apr 2017 12:05:03 +0200
Message-Id: <1491300303-16153-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

According to the PowerISA 2.07, mtspr and mfspr should not always
generate an illegal instruction exception when being used with an
undefined SPR, but rather treat the instruction as a NOP or inject a
privilege exception in some cases, too - depending on the SPR number.
Also turn the printk here into a ratelimited print statement, so that
the guest can not flood the dmesg log of the host by issueing lots of
illegal mtspr/mfspr instruction here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Inject illegal instruction program interrupt instead of emulation
   assist interrupt (according to the last programming note in section
   6.5.9 of Book III of the PowerISA v2.07)

 arch/powerpc/kvm/book3s_emulate.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 8359752..bf4181e 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -503,10 +503,14 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
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
+				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+		}
 		break;
 	}
 
@@ -648,10 +652,16 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
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
+				kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
+		}
+
 		break;
 	}
 
-- 
1.8.3.1
