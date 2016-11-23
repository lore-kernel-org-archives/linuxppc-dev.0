Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvy0MWFzDw1r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 09/11] KVM: PPC: Book3S HV: Enable hypervisor
 virtualization interrupts while in guest
Date: Wed, 23 Nov 2016 11:32:03 +1100
Message-Id: <1479861125-21394-10-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new XIVE interrupt controller on POWER9 can direct external
interrupts to the hypervisor or the guest.  The interrupts directed to
the hypervisor are controlled by an LPCR bit called LPCR_HVICE, and
come in as a "hypervisor virtualization interrupt".  This sets the
LPCR bit so that hypervisor virtualization interrupts can occur while
we are in the guest.  We then also need to cope with exiting the guest
because of a hypervisor virtualization interrupt.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/kvm_asm.h |  1 +
 arch/powerpc/kvm/book3s_hv.c       | 11 +++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 05cabed..09a802b 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -99,6 +99,7 @@
 #define BOOK3S_INTERRUPT_H_EMUL_ASSIST	0xe40
 #define BOOK3S_INTERRUPT_HMI		0xe60
 #define BOOK3S_INTERRUPT_H_DOORBELL	0xe80
+#define BOOK3S_INTERRUPT_H_VIRT		0xea0
 #define BOOK3S_INTERRUPT_PERFMON	0xf00
 #define BOOK3S_INTERRUPT_ALTIVEC	0xf20
 #define BOOK3S_INTERRUPT_VSX		0xf40
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index aca9fbf..b6bc867 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -962,6 +962,7 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	case BOOK3S_INTERRUPT_EXTERNAL:
 	case BOOK3S_INTERRUPT_H_DOORBELL:
+	case BOOK3S_INTERRUPT_H_VIRT:
 		vcpu->stat.ext_intr_exits++;
 		r = RESUME_GUEST;
 		break;
@@ -3305,9 +3306,15 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
 	/* On POWER8 turn on online bit to enable PURR/SPURR */
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		lpcr |= LPCR_ONL;
-	/* On POWER9, VPM0 bit is reserved (VPM0=1 behaviour is assumed) */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	/*
+	 * On POWER9, VPM0 bit is reserved (VPM0=1 behaviour is assumed)
+	 * Set HVICE bit to enable hypervisor virtualization interrupts.
+	 */
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		lpcr &= ~LPCR_VPM0;
+		lpcr |= LPCR_HVICE;
+	}
+
 	kvm->arch.lpcr = lpcr;
 
 	/*
-- 
2.7.4
