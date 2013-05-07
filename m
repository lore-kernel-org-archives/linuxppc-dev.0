Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 08F0F2C0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 13:53:28 +1000 (EST)
Message-ID: <1367898790.5769.4.camel@pasglop>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 07 May 2013 13:53:10 +1000
In-Reply-To: <1367895926.3398.14@snotra>
References: <1367895926.3398.14@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Mihai Caraman <mihai.caraman@freescale.com>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 22:05 -0500, Scott Wood wrote:
> On 05/06/2013 07:03:14 PM, Benjamin Herrenschmidt wrote:
> > On Mon, 2013-05-06 at 18:53 -0500, Scott Wood wrote:
> > >
> > > > Ie. The last stage of entry will hard enable, so they should be
> > > > soft-enabled too... if not, latency trackers will consider the  
> > whole
> > > > guest periods as "interrupt disabled"...
> > >
> > > OK... I guess we already have that problem on 32-bit as well?
> > 
> > 32-bit doesn't do lazy disable, so the situation is a lot easier  
> > there.
> 
> Right, but it still currently enters the guest with interrupts marked  
> as disabled, so we'd have the same latency tracker issue.
> 
> > Another problem is that hard_irq_disable() doesn't call
> > trace_hardirqs_off()... We might want to fix that:
> > 
> > static inline void hard_irq_disable(void)
> > {
> > 	__hard_irq_disable();
> > 	if (get_paca()->soft_enabled)
> > 		trace_hardirqs_off();
> > 	get_paca()->soft_enabled = 0;
> > 	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
> > }
> 
> Is it possible there are places that assume the current behavior?

There aren't many callers, I think this should be safe. Most
callers call it with interrupts already soft disabled, so that
should be a nop in these cases (idle for example).

But I can give it a quick spin today on a machine or two.

> > > We also don't want PACA_IRQ_HARD_DIS to be cleared the way
> > > prep_irq_for_idle() does, because that's what lets the
> > > local_irq_enable() do the hard-enabling after we exit the guest.
> > 
> > Then set it again. Don't leave the kernel in a state where  
> > soft_enabled
> > is 1 and irq_happened is non-zero. It might work in the specific KVM
> > case we are looking at now because we know we are coming back via KVM
> > exit and putting things right again but it's fragile, somebody will  
> > come
> > back and break it, etc...
> 
> KVM is a pretty special case -- at least on booke, it's required that  
> all exits from guest state go through the KVM exception code.  I think  
> it's less likely that that changes, than something breaks in the code  
> to fix up lazy ee state (especially since we've already seen the latter  
> happen).
> 
> I'll give it a shot, though.
> 
> > If necessary, create (or improve existing) helpers that do the right
> > state adjustement. The cost of a couple of byte stores is negligible,
> > I'd rather you make sure everything remains in sync at all times.
> 
> My concern was mainly about complexity -- it seemed simpler to just say  
> that the during guest execution, CPU is in a special state that is not  
> visible to anything that cares about lazy EE.  The fact that EE can  
> actually be *off* and we still take the interrupt supports its  
> specialness. :-)

Yeah ... sort of :-)

Cheers,
Ben.
