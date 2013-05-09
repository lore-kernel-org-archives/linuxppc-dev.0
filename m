Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB1862C00D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 08:13:12 +1000 (EST)
Date: Thu, 9 May 2013 17:13:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][KVM][PATCH 1/1] kvm:ppc:booke-64: soft-disable interrupts
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1368134856.654.11@snotra> <1368137220.3715.14.camel@pasglop>
In-Reply-To: <1368137220.3715.14.camel@pasglop> (from
 benh@kernel.crashing.org on Thu May  9 17:07:00 2013)
Message-ID: <1368137583.654.15@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 05/09/2013 05:07:00 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2013-05-09 at 16:27 -0500, Scott Wood wrote:
> > On 05/09/2013 07:37:42 AM, Benjamin Herrenschmidt wrote:
> > > On Thu, 2013-05-09 at 17:44 +0800, tiejun.chen wrote:
> > > >
> > > > Actually in the case GS=3D1 even if EE=3D0, EXT/DEC/DBELL still =20
> occur
> > > as I
> > > > recall.
> > >
> > > Only if directed to the hypervisor.
> >
> > This is always the case with KVM, right?  At least on booke...
>=20
> Hrm, on A2 we could choose iirc. Well not DEC but EXT at least, I =20
> don't
> remember about DBELL.

As for as the hardware goes we can choose on e500mc as well -- we just =20
don't support it in KVM, because we can't distinguish between guest and =20
host interrupts without routing the latter to critical, which is way =20
too much of a pain for Linux (we did it in our standalone hypervisor, =20
though).

-Scott=
