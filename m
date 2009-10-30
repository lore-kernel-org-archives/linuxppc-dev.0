Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C0D6FB7C34
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:34 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 09/27] Add interrupt handling code
Date: Fri, 30 Oct 2009 16:47:09 +0100
Message-Id: <1256917647-6200-10-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Getting from host state to the guest is only half the story. We also need
to return to our host context and handle whatever happened to get us out of
the guest.

On PowerPC every guest exit is an interrupt. So all we need to do is trap
the host's interrupt handlers and get into our #VMEXIT code to handle it.

PowerPCs also have a register that can add an offset to the interrupt handlers'
adresses which is what the booke KVM code uses. Unfortunately that is a
hypervisor ressource and we also want to be able to run KVM when we're running
in an LPAR. So we have to hook into the Linux interrupt handlers.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v3 -> v4:

  - header rename fix
---
 arch/powerpc/kvm/book3s_64_rmhandlers.S |  131 +++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_64_rmhandlers.S

diff --git a/arch/powerpc/kvm/book3s_64_rmhandlers.S b/arch/powerpc/kvm/book3s_64_rmhandlers.S
new file mode 100644
index 0000000..fb7dd2e
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_64_rmhandlers.S
@@ -0,0 +1,131 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright SUSE Linux Products GmbH 2009
+ *
+ * Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/kvm_asm.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+#include <asm/exception-64s.h>
+
+/*****************************************************************************
+ *                                                                           *
+ *        Real Mode handlers that need to be in low physical memory          *
+ *                                                                           *
+ ****************************************************************************/
+
+
+.macro INTERRUPT_TRAMPOLINE intno
+
+.global kvmppc_trampoline_\intno
+kvmppc_trampoline_\intno:
+
+	mtspr	SPRN_SPRG_SCRATCH0, r13		/* Save r13 */
+
+	/*
+	 * First thing to do is to find out if we're coming
+	 * from a KVM guest or a Linux process.
+	 *
+	 * To distinguish, we check a magic byte in the PACA
+	 */
+	mfspr	r13, SPRN_SPRG_PACA		/* r13 = PACA */
+	std	r12, (PACA_EXMC + EX_R12)(r13)
+	mfcr	r12
+	stw	r12, (PACA_EXMC + EX_CCR)(r13)
+	lbz	r12, PACA_KVM_IN_GUEST(r13)
+	cmpwi	r12, 0
+	bne	..kvmppc_handler_hasmagic_\intno
+	/* No KVM guest? Then jump back to the Linux handler! */
+	lwz	r12, (PACA_EXMC + EX_CCR)(r13)
+	mtcr	r12
+	ld	r12, (PACA_EXMC + EX_R12)(r13)
+	mfspr	r13, SPRN_SPRG_SCRATCH0		/* r13 = original r13 */
+	b	kvmppc_resume_\intno		/* Get back original handler */
+
+	/* Now we know we're handling a KVM guest */
+..kvmppc_handler_hasmagic_\intno:
+	/* Unset guest state */
+	li	r12, 0
+	stb	r12, PACA_KVM_IN_GUEST(r13)
+
+	std	r1, (PACA_EXMC+EX_R9)(r13)
+	std	r10, (PACA_EXMC+EX_R10)(r13)
+	std	r11, (PACA_EXMC+EX_R11)(r13)
+	std	r2, (PACA_EXMC+EX_R13)(r13)
+
+	mfsrr0	r10
+	mfsrr1	r11
+
+	/* Restore R1/R2 so we can handle faults */
+	ld	r1, PACAR1(r13)
+	ld	r2, (PACA_EXMC+EX_SRR0)(r13)
+
+	/* Let's store which interrupt we're handling */
+	li	r12, \intno
+
+	/* Jump into the SLB exit code that goes to the highmem handler */
+	b	kvmppc_handler_trampoline_exit
+
+.endm
+
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_SYSTEM_RESET
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_MACHINE_CHECK
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DATA_STORAGE
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DATA_SEGMENT
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_INST_STORAGE
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_INST_SEGMENT
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_EXTERNAL
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALIGNMENT
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_PROGRAM
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_FP_UNAVAIL
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_DECREMENTER
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_SYSCALL
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_TRACE
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_PERFMON
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_ALTIVEC
+INTERRUPT_TRAMPOLINE	BOOK3S_INTERRUPT_VSX
+
+/*
+ * This trampoline brings us back to a real mode handler
+ *
+ * Input Registers:
+ *
+ * R6 = SRR0
+ * R7 = SRR1
+ * LR = real-mode IP
+ *
+ */
+.global kvmppc_handler_lowmem_trampoline
+kvmppc_handler_lowmem_trampoline:
+
+	mtsrr0	r6
+	mtsrr1	r7
+	blr
+kvmppc_handler_lowmem_trampoline_end:
+
+.global kvmppc_trampoline_lowmem
+kvmppc_trampoline_lowmem:
+	.long kvmppc_handler_lowmem_trampoline - _stext
+
+.global kvmppc_trampoline_enter
+kvmppc_trampoline_enter:
+	.long kvmppc_handler_trampoline_enter - _stext
+
+#include "book3s_64_slb.S"
+
-- 
1.6.0.2
