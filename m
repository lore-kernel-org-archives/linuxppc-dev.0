Return-Path: <paulus@ozlabs.org>
Date: Wed, 3 Aug 2011 13:31:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] KVM: PPC: Implement H_CEDE hcall for book3s_hv in
	real-mode code
Message-ID: <20110803033133.GB17893@drongo>
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
	<20110723074246.GC17927@bloggs.ozlabs.ibm.com>
	<4E380DEC.8030803@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E380DEC.8030803@suse.de>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2011 at 04:47:08PM +0200, Alexander Graf wrote:

> >  int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
> >  {
> >-	if (irq->irq == KVM_INTERRUPT_UNSET)
> >+	if (irq->irq == KVM_INTERRUPT_UNSET) {
> >  		kvmppc_core_dequeue_external(vcpu, irq);
> >-	else
> >-		kvmppc_core_queue_external(vcpu, irq);
> >+		return 0;
> >+	}
> 
> Not sure I understand this part. Mind to explain?

It's a micro-optimization - we don't really need to wake up or
interrupt the vcpu thread when we're clearing the interrupt.
Unless of course I'm missing something... :)

> 
> Alex
> 
> >+
> >+	kvmppc_core_queue_external(vcpu, irq);
> >
> >-	if (waitqueue_active(&vcpu->wq)) {
> >-		wake_up_interruptible(&vcpu->wq);
> >+	if (waitqueue_active(vcpu->arch.wqp)) {
> >+		wake_up_interruptible(vcpu->arch.wqp);
> >  		vcpu->stat.halt_wakeup++;
> >  	} else if (vcpu->cpu != -1) {
> >  		smp_send_reschedule(vcpu->cpu);

Paul.
