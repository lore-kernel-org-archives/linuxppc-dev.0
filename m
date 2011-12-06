Return-Path: <paulus@ozlabs.org>
Date: Tue, 6 Dec 2011 16:47:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH] powerpc: Provide a way for KVM to indicate that NV GPR
 values are lost
Message-ID: <20111206054726.GB12389@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a problem where a CPU thread coming out of nap mode can
think it has valid values in the nonvolatile GPRs (r14 - r31) as saved
away in power7_idle, but in fact the values have been trashed because
the thread was used for KVM in the mean time.  The result is that the
thread crashes because code that called power7_idle (e.g.,
pnv_smp_cpu_kill_self()) goes to use values in registers that have
been trashed.

The bit field in SRR1 that tells whether state was lost only reflects
the most recent nap, which may not have been the nap instruction in
power7_idle.  So we need an extra PACA field to indicate that state
has been lost even if SRR1 indicates that the most recent nap didn't
lose state.  We clear this field when saving the state in power7_idle,
we set it to a non-zero value when we use the thread for KVM, and we
test it in power7_wakeup_noloss.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
I assume this should go via Ben's tree, since it touches more powerpc
code than PPC KVM code.

 arch/powerpc/include/asm/paca.h         |    1 +
 arch/powerpc/kernel/asm-offsets.c       |    1 +
 arch/powerpc/kernel/idle_power7.S       |    4 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |    3 +++
 4 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 17722c7..269c05a 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -135,6 +135,7 @@ struct paca_struct {
 	u8 hard_enabled;		/* set if irqs are enabled in MSR */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
+	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 
 #ifdef CONFIG_PPC_POWERNV
 	/* Pointer to OPAL machine check event structure set by the
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ec24b36..8e0db0b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -208,6 +208,7 @@ int main(void)
 	DEFINE(PACA_USER_TIME, offsetof(struct paca_struct, user_time));
 	DEFINE(PACA_SYSTEM_TIME, offsetof(struct paca_struct, system_time));
 	DEFINE(PACA_TRAP_SAVE, offsetof(struct paca_struct, trap_save));
+	DEFINE(PACA_NAPSTATELOST, offsetof(struct paca_struct, nap_state_lost));
 #endif /* CONFIG_PPC64 */
 
 	/* RTAS */
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 3a70845..fcdff19 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -54,6 +54,7 @@ _GLOBAL(power7_idle)
 	li	r0,0
 	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
 	stb	r0,PACAHARDIRQEN(r13)
+	stb	r0,PACA_NAPSTATELOST(r13)
 
 	/* Continue saving state */
 	SAVE_GPR(2, r1)
@@ -86,6 +87,9 @@ _GLOBAL(power7_wakeup_loss)
 	rfid
 
 _GLOBAL(power7_wakeup_noloss)
+	lbz	r0,PACA_NAPSTATELOST(r13)
+	cmpwi	r0,0
+	bne	.power7_wakeup_loss
 	ld	r1,PACAR1(r13)
 	ld	r4,_MSR(r1)
 	ld	r5,_NIP(r1)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 7b8dbf6..b70bf22 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -112,6 +112,9 @@ kvm_start_guest:
 	stbcix	r0, r5, r6		/* clear it */
 	stwcix	r8, r5, r7		/* EOI it */
 
+	/* NV GPR values from power7_idle() will no longer be valid */
+	stb	r0, PACA_NAPSTATELOST(r13)
+
 .global kvmppc_hv_entry
 kvmppc_hv_entry:
 
