Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5AA22C0113
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 09:53:47 +1000 (EST)
Date: Mon, 6 May 2013 18:53:38 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1367787788.11982.58.camel@pasglop> (from
 benh@kernel.crashing.org on Sun May  5 16:03:08 2013)
Message-ID: <1367884418.3398.10@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 05/05/2013 04:03:08 PM, Benjamin Herrenschmidt wrote:
> On Fri, 2013-05-03 at 18:45 -0500, Scott Wood wrote:
> > kvmppc_lazy_ee_enable() was causing interrupts to be soft-enabled
> > (albeit hard-disabled) in kvmppc_restart_interrupt().  This led to
> > warnings, and possibly breakage if the interrupt state was later =20
> saved
> > and then restored (leading to interrupts being hard-and-soft enabled
> > when they should be at least soft-disabled).
> >
> > Simply removing kvmppc_lazy_ee_enable() leaves interrupts only
> > soft-disabled when we enter the guest, but they will be =20
> hard-disabled
> > when we exit the guest -- without PACA_IRQ_HARD_DIS ever being set, =20
> so
> > the local_irq_enable() fails to hard-enable.
> >
> > While we could just set PACA_IRQ_HARD_DIS after an exit to =20
> compensate,
> > instead hard-disable interrupts before entering the guest.  This =20
> way,
> > we won't have to worry about interactions if we take an interrupt
> > during the guest entry code.  While I don't see any obvious
> > interactions, it could change in the future (e.g. it would be bad if
> > the non-hv code were used on 64-bit or if 32-bit guest lazy =20
> interrupt
> > disabling, since the non-hv code changes IVPR among other things).
>=20
> Shouldn't the interrupts be marked soft-enabled (even if hard =20
> disabled)
> when entering the guest ?
>=20
> Ie. The last stage of entry will hard enable, so they should be
> soft-enabled too... if not, latency trackers will consider the whole
> guest periods as "interrupt disabled"...

OK... I guess we already have that problem on 32-bit as well?

> Now, kvmppc_lazy_ee_enable() seems to be clearly bogus to me. It will
> unconditionally set soft_enabled and clear irq_happened from a
> soft-disabled state, thus potentially losing a pending event.
>=20
> Book3S "HV" seems to be keeping interrupts fully enabled all the way
> until the asm hard disables, which would be fine except that I'm =20
> worried
> we are racy vs. need_resched & signals.
>=20
> One thing you may be able to do is call prep_irq_for_idle(). This will
> tell you if something happened, giving you a chance to abort/re-enable
> before you go the guest.

As long as we go straight from IRQs fully enabled to hard-disabled, =20
before we check for signals and such, I don't think we need that (and =20
using it would raise the question of what to do on 32-bit).

What if we just take this patch, and add trace_hardirqs_on() just =20
before entering the guest?  This would be similar to what the 32-bit =20
non-KVM exception return code does (except it would be in C code).  =20
Perhaps we could set soft_enabled as well, but then we'd have to clear =20
it again before calling kvmppc_restart_interrupt() -- since the KVM =20
exception handlers don't actually care about soft_enabled (it would =20
just be for consistency), I'd rather just leave soft_enabled off.

We also don't want PACA_IRQ_HARD_DIS to be cleared the way =20
prep_irq_for_idle() does, because that's what lets the =20
local_irq_enable() do the hard-enabling after we exit the guest.

-Scott=
