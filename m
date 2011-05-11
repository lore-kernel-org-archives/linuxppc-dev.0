Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:42:00 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 06/13] kvm/powerpc: Deliver program interrupts right away
	instead of queueing them
Message-ID: <20110511104200.GG2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Doing so means that we don't have to save the flags anywhere and gets
rid of the last reference to to_book3s(vcpu) in arch/powerpc/kvm/book3s.c.

Doing so is OK because a program interrupt won't be generated at the
same time as any other synchronous interrupt.  If a program interrupt
and an asynchronous interrupt (external or decrementer) are generated
at the same time, the program interrupt will be delivered, which is
correct because it has a higher priority, and then the asynchronous
interrupt will be masked.

We don't ever generate system reset or machine check interrupts to the
guest, but if we did, then we would need to make sure they got delivered
rather than the program interrupt.  The current code would be wrong in
this situation anyway since it would deliver the program interrupt as
well as the reset/machine check interrupt.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 224e6a8..729f799 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -128,8 +128,8 @@ void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec)
 
 void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
 {
-	to_book3s(vcpu)->prog_flags = flags;
-	kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_PROGRAM);
+	/* might as well deliver this straight away */
+	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_PROGRAM, flags);
 }
 
 void kvmppc_core_queue_dec(struct kvm_vcpu *vcpu)
@@ -169,7 +169,6 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 {
 	int deliver = 1;
 	int vec = 0;
-	ulong flags = 0ULL;
 	bool crit = kvmppc_critical_section(vcpu);
 
 	switch (priority) {
@@ -205,7 +204,6 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 		break;
 	case BOOK3S_IRQPRIO_PROGRAM:
 		vec = BOOK3S_INTERRUPT_PROGRAM;
-		flags = to_book3s(vcpu)->prog_flags;
 		break;
 	case BOOK3S_IRQPRIO_VSX:
 		vec = BOOK3S_INTERRUPT_VSX;
@@ -236,7 +234,7 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
 #endif
 
 	if (deliver)
-		kvmppc_inject_interrupt(vcpu, vec, flags);
+		kvmppc_inject_interrupt(vcpu, vec, 0);
 
 	return deliver;
 }
-- 
1.7.4.4
