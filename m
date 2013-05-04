Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FAE12C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 17:11:24 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
Date: Sat, 4 May 2013 07:11:13 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3E9F9B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Saturday, May 04, 2013 2:45 AM
> To: Alexander Graf
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Wood Scott-B07421; Caraman Mihai Claudiu-B02008
> Subject: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
> the guest
>=20
> kvmppc_lazy_ee_enable() was causing interrupts to be soft-enabled
> (albeit hard-disabled) in kvmppc_restart_interrupt().  This led to
> warnings, and possibly breakage if the interrupt state was later saved
> and then restored (leading to interrupts being hard-and-soft enabled
> when they should be at least soft-disabled).
>=20
> Simply removing kvmppc_lazy_ee_enable() leaves interrupts only
> soft-disabled when we enter the guest, but they will be hard-disabled
> when we exit the guest -- without PACA_IRQ_HARD_DIS ever being set, so
> the local_irq_enable() fails to hard-enable.

Just to mention one special case. may_hard_irq_enable() called from do_IRQ(=
)
and timer_interrupt() clears PACA_IRQ_HARD_DIS but it either hard-enable or=
=20
let PACA_IRQ_EE set which is enough for local_irq_enable() to hard-enable.

>=20
> While we could just set PACA_IRQ_HARD_DIS after an exit to compensate,
> instead hard-disable interrupts before entering the guest.  This way,
> we won't have to worry about interactions if we take an interrupt
> during the guest entry code.  While I don't see any obvious
> interactions, it could change in the future (e.g. it would be bad if
> the non-hv code were used on 64-bit or if 32-bit guest lazy interrupt
> disabling, since the non-hv code changes IVPR among other things).
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Mihai Caraman <mihai.caraman@freescale.com>

Please add my signed-off, it builds on the same principle of interrupts
soft-disabled to fix warnings and irq_happened flags to force interrupts
hard-enabled ... and parts of the code ;)

-Mike
