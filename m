Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 54AF72C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:31:50 +1000 (EST)
Date: Fri, 3 May 2013 18:30:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3E9D81@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B02008@freescale.com on Fri May  3 17:59:32 2013)
Message-ID: <1367623846.19391.15@snotra>
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

On 05/03/2013 05:59:32 PM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Saturday, May 04, 2013 1:07 AM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: Wood Scott-B07421; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and =20
> hangs
> >
> > I replaced the two calls to kvmppc_lazy_ee_enable() with calls to
> > hard_irq_disable(), and it seems to be working fine.
>=20
> Please take a look on 'KVM: PPC64: booke: Hard disable interrupts when
> entering guest' RFC thread and see if your solution addresses Ben's
> comments.

My original one didn't (there was a race if an interrupt comes in =20
between soft-disabling and hard-disabling, it wouldn't be received =20
until the guest exits for some other reason).

Instead, I turned the local_irq_disable() into hard_irq_disable() plus =20
trace_hardirqs_off().  This worked without warnings.

-Scott=
