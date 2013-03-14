Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 830972C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 22:04:40 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Michael Ellerman
 <michael@ellerman.id.au>
Subject: RE: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
 errata
Date: Thu, 14 Mar 2013 11:04:26 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01C18D6F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <20130313050403.GB9317@concordia> (from michael@ellerman.id.au
 on Wed Mar 13 00:04:03 2013) <1363206260.8945.13@snotra>
In-Reply-To: <1363206260.8945.13@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
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
> Sent: Thursday, March 14, 2013 4:24 AM
> To: Michael Ellerman
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org;
> galak@kernel.crashing.org; Wood Scott-B07421
> Subject: Re: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
> errata
>=20
> On 03/13/2013 12:04:03 AM, Michael Ellerman wrote:
> > On Tue, Mar 12, 2013 at 03:48:02PM +0800, Jia Hongtao wrote:
> > > The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of
> > mpc8544),
> > > It causes that neither MSI nor MSI-X can work fine. This is a
> > workaround
> > > to allow MSI-X to function properly.
> >
> > You say "neither MSI nor MSI-X can work fine", which I take to mean
> > "both MSI and MSI-X do not work".
> >
> > But then you say this is a workaround to allow MSI-X to work.
> >
> > So what I think you mean is, the erratum prevents both MSI and MSI-X
> > from working. This is a workaround that allows MSI-X to work, and in
> > addition the patch prevents MSI from being used on chips with the
> > erratum - because there is no workaround for MSI.
>=20
> There actually is a workaround for MSI, but it's more complicated and not
> implemented by this patch.
>=20
> We could also possibly get away with allowing exactly one MSI
> (byteswapping doesn't matter if the value is zero) -- not sure how hard
> that would be.

For now we have no plan to support MSI workaround. Also MSI workaround
deserve a new patch :)

I will sent V2 of this patch soon.

-Hongtao.

>=20
> > > +		list_for_each_entry(msi, &msi_head, list)
> > > +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
> > > +				return -EINVAL;
> >
> > I take it you're happy preventing MSI for all devices even if only a
> > single chip in the machine has the erratum? In practice you probably
> > have all or none with the erratum right?
>=20
> Yes, it's all integrated onto one chip (the SoC itself).  In fact there
> should only be one MSI block on these chips.
>=20
> -Scott
