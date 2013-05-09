Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B41162C010A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 08:07:10 +1000 (EST)
Message-ID: <1368137220.3715.14.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 10 May 2013 08:07:00 +1000
In-Reply-To: <1368134856.654.11@snotra>
References: <1368134856.654.11@snotra>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 16:27 -0500, Scott Wood wrote:
> On 05/09/2013 07:37:42 AM, Benjamin Herrenschmidt wrote:
> > On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> > >
> > > Actually in the case GS=1 even if EE=0, EXT/DEC/DBELL still occur  
> > as I
> > > recall.
> > 
> > Only if directed to the hypervisor.
> 
> This is always the case with KVM, right?  At least on booke...

Hrm, on A2 we could choose iirc. Well not DEC but EXT at least, I don't
remember about DBELL.

> > > > Case 1)
> > > >   -> Local_irq_disable()  will set soft_enabled = 0
> > > >   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in
> > > irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard
> > > disabled. No more other interrupt gated by MSR.EE can happen. Looks
> > > like the idea here is to not let a device keep on inserting  
> > interrupt
> > > till the interrupt condition on device is cleared, right?
> > 
> > The external interrupt line is level sensitive normally, so we have to
> > mask MSR:EE in that case or the interrupt would keep re-occurring  
> > (note
> > that FSL has this concept of auto-acked interrupts via the on die MPIC
> > for which you can potentially use PACA_IRQ_EE_EDGE instead and avoid
> > having to mask MSR:EE).
> 
> Note that if we do this, we can no longer leave the interrupt vector in  
> EPR, and would have to track (potentially multiple different) pending  
> external interrupts in software.

Right, you can have a little queue in the PACA and leave EE disabled if
it's full. You can probably get away with a queue of 1 though :-)

Cheers,
Ben.
