Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4326D2C00CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 06:15:49 +1000 (EST)
Date: Fri, 3 May 2013 15:15:01 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
References: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
 <1367604287.19391.2@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3E984C@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3E984C@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B02008@freescale.com on Fri May  3 15:01:26 2013)
Message-ID: <1367612101.19391.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

On 05/03/2013 03:01:26 PM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, May 03, 2013 9:05 PM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> > Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and =20
> hangs
> >
> > > The unresponsiveness has to do with the fact that
> > > arch_local_irq_restore()
> > > does not guarantees to hard enable interrupts.
> >
> > Could you elaborate?  If the saved IRQ state was "enabled", why
> > wouldn't arch_local_irq_restore() hard-enable IRQs?  The last thing =20
> it
> > does is __hard_irq_enable().
>=20
> 	if (!irq_happened)
> 		return;

OK, so the problem is that we're not setting PACA_IRQ_HARD_DIS when we =20
hard-disable interrupts?

> > Where is the arch_local_irq_restore() instance you're talking about?
>=20
> ./arch/power/kernel/irq.c

I meant the caller. :-P

-Scott=
