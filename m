Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD0EF2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 22:37:54 +1000 (EST)
Message-ID: <1368103062.25488.193.camel@pasglop>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Date: Thu, 09 May 2013 22:37:42 +1000
In-Reply-To: <518B7014.1090508@windriver.com>
References: <51885F49.6060605@windriver.com>
 (from tiejun.chen@windriver.com on Mon May 6 20:56:25 2013)
 <1367892390.3398.12@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3F00D0@039-SN2MPN1-013.039d.mgd.msft.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0700E64A@039-SN2MPN1-011.039d.mgd.msft.net>
 <518B7014.1090508@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
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

On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> 
> Actually in the case GS=1 even if EE=0, EXT/DEC/DBELL still occur as I
> recall.

Only if directed to the hypervisor.

> > Case 1)
> >   -> Local_irq_disable()  will set soft_enabled = 0
> >   -> Now Externel interrupt happens, there we set PACA_IRQ_EE in
> irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard
> disabled. No more other interrupt gated by MSR.EE can happen. Looks
> like the idea here is to not let a device keep on inserting interrupt
> till the interrupt condition on device is cleared, right?

The external interrupt line is level sensitive normally, so we have to
mask MSR:EE in that case or the interrupt would keep re-occurring (note
that FSL has this concept of auto-acked interrupts via the on die MPIC
for which you can potentially use PACA_IRQ_EE_EDGE instead and avoid
having to mask MSR:EE).

> I don't understand "the interrupt condition on device is cleared"
> here.

Well, the external interrupt line will remain asserted until the device
(via the PIC) stops interrupting the processor :-) Either because we
mask at the PIC level (or raise the priority) or because the condition
goes away.
 
> I think regardless if you clear the device interrupt status, the
> system still  receive a pending interrupt once EE or GS = 1.

Why ? Depends on your PIC actually but if it's a sane one, it won't
"remember" a level interrupt that is gone. An edge interrupt is a
different matter and is latched.

Some MPIC implementations tend to generate a spurrious IRQ in the case
of level IRQs going away. IE. they still remember an event occurred and
interrupt the processor, but on IACK return the spurious vector. However
that isn't guaranteed to be the case and it is perfectly ok (and a good
idea) for the PIC to just stop asserting the external interrupt line if
the original device interrupt goes away (and it's configured as level
sensitive).
 
You might notice that we try to re-hard-enable (while still soft
disabled) as soon as we have gone get_irq in do_IRQ. This is because
fetching the interrupt normally also masks it (either by masking at the
source or by raisin the processor interrupt priority depending on the
specific PIC) so we know we can re-hard enable. 

> >   -> local_irq_enable() - This checks that irq_happened is set, and
> replays
> 
> ret_from_except also check to replay.

ret_from_except checks because it essentially can act as an implicit
local_irq_enable.

> > Now the case 2)
> > Case 2)
> > -> Local_irq_disable()  will set soft_enabled = 0
> >   -> Now DEC interrupt happens. We set PACA_IRQ_DEC in irq_happened,
> But do not clear EE in SRR1 and rfi. So interrupts are not hard
> disabled.

Right. We move the decrementer to its maximum value however since on
most implementations, it will continue interrupting the processor while
it's top bit is set (and effectively act as a level sensitive
interrupt).

Again, the goal here is to run as much as possible with interrupts hard
enabled which allow better perf sampling.

> >   -> Now say EE interrupt happens, there we set PACA_IRQ_EE in
> irq_happened, Also clears EE in SRR1 and rfi. So interrupts are hard
> disabled.
> >   -> local_irq_enable() - This checks that irq_happened is set.
> > IIUC, it replays only one interrupt? is not it?

It replays one interrupt, but interrupt are still disabled during the
replay. Upon return from the replayed interrupt, the ret_from_except
will see the other one and replay it too.

> After anyone is replayed in arch_local_irq_restore(), we will set
> soft/hard 
> interrupt there:
> 
> set_soft_enabled(1);
> __hard_irq_enable();
> 
> Then any pending interrupt can be executed now.
> 
> Additionally, ret_from_except probably check to replay all.
> 
> Tiejun
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
