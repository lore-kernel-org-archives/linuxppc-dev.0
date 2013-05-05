Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35EAF2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 07:03:23 +1000 (EST)
Message-ID: <1367787788.11982.58.camel@pasglop>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Mon, 06 May 2013 07:03:08 +1000
In-Reply-To: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
References: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
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

On Fri, 2013-05-03 at 18:45 -0500, Scott Wood wrote:
> kvmppc_lazy_ee_enable() was causing interrupts to be soft-enabled
> (albeit hard-disabled) in kvmppc_restart_interrupt().  This led to
> warnings, and possibly breakage if the interrupt state was later saved
> and then restored (leading to interrupts being hard-and-soft enabled
> when they should be at least soft-disabled).
> 
> Simply removing kvmppc_lazy_ee_enable() leaves interrupts only
> soft-disabled when we enter the guest, but they will be hard-disabled
> when we exit the guest -- without PACA_IRQ_HARD_DIS ever being set, so
> the local_irq_enable() fails to hard-enable.
> 
> While we could just set PACA_IRQ_HARD_DIS after an exit to compensate,
> instead hard-disable interrupts before entering the guest.  This way,
> we won't have to worry about interactions if we take an interrupt
> during the guest entry code.  While I don't see any obvious
> interactions, it could change in the future (e.g. it would be bad if
> the non-hv code were used on 64-bit or if 32-bit guest lazy interrupt
> disabling, since the non-hv code changes IVPR among other things).

Shouldn't the interrupts be marked soft-enabled (even if hard disabled)
when entering the guest ?

Ie. The last stage of entry will hard enable, so they should be
soft-enabled too... if not, latency trackers will consider the whole
guest periods as "interrupt disabled"...

Now, kvmppc_lazy_ee_enable() seems to be clearly bogus to me. It will
unconditionally set soft_enabled and clear irq_happened from a
soft-disabled state, thus potentially losing a pending event.

Book3S "HV" seems to be keeping interrupts fully enabled all the way
until the asm hard disables, which would be fine except that I'm worried
we are racy vs. need_resched & signals.

One thing you may be able to do is call prep_irq_for_idle(). This will
tell you if something happened, giving you a chance to abort/re-enable
before you go the guest.

Ben.
