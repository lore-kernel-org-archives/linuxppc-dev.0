Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMDY0XVHzDvy9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:23:25 +1100 (AEDT)
Date: Sat, 19 Nov 2016 14:53:43 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/13] KVM: PPC: Book3S HV: Use msgsnd for IPIs to other
 cores on POWER9
Message-ID: <20161119035343.GA29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-11-git-send-email-paulus@ozlabs.org>
 <87vavkn8ua.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vavkn8ua.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2016 at 08:17:25PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > On POWER9, the msgsnd instruction is able to send interrupts to
> > other cores, as well as other threads on the local core.  Since
> > msgsnd is generally simpler and faster than sending an IPI via the
> > XICS, we use msgsnd for all IPIs sent by KVM on POWER9.
> >
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > ---
> >  arch/powerpc/kvm/book3s_hv.c         | 11 ++++++++++-
> >  arch/powerpc/kvm/book3s_hv_builtin.c | 10 ++++++++--
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
[...]
> > diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> > index 0c84d6b..37ed045 100644
> > --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> > +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> > @@ -205,12 +205,18 @@ static inline void rm_writeb(unsigned long paddr, u8 val)
> >  void kvmhv_rm_send_ipi(int cpu)
> >  {
> >  	unsigned long xics_phys;
> > +	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
> >  
> > -	/* On POWER8 for IPIs to threads in the same core, use msgsnd */
> > +	/* On POWER9 we can use msgsnd for any destination cpu. */
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +		msg |= get_hard_smp_processor_id(cpu);
> > +		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
> > +		return;
> 
> Do we need a "sync" there  before msgsnd ?

The comment just above this function says:

/*
 * Send an interrupt or message to another CPU.
 * This can only be called in real mode.
 * The caller needs to include any barrier needed to order writes
 * to memory vs. the IPI/message.
 */

so no.  In fact all of its callers do smp_mb() before calling it.
(And no we don't want to move the smp_mb() into kvmhv_rm_send_ipi();
see kvmhv_interrupt_vcore() for why.)

Paul.
