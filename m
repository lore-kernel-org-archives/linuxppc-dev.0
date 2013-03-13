Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29D4E2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 07:24:32 +1100 (EST)
Date: Wed, 13 Mar 2013 15:24:20 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: workaround for chips with MSI hardware
 errata
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <20130313050403.GB9317@concordia> (from michael@ellerman.id.au
 on Wed Mar 13 00:04:03 2013)
Message-ID: <1363206260.8945.13@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/13/2013 12:04:03 AM, Michael Ellerman wrote:
> On Tue, Mar 12, 2013 at 03:48:02PM +0800, Jia Hongtao wrote:
> > The MPIC chip with version 2.0 has a MSI errata (errata PIC1 of =20
> mpc8544),
> > It causes that neither MSI nor MSI-X can work fine. This is a =20
> workaround
> > to allow MSI-X to function properly.
>=20
> You say "neither MSI nor MSI-X can work fine", which I take to mean
> "both MSI and MSI-X do not work".
>=20
> But then you say this is a workaround to allow MSI-X to work.
>=20
> So what I think you mean is, the erratum prevents both MSI and MSI-X
> from working. This is a workaround that allows MSI-X to work, and in =20
> addition
> the patch prevents MSI from being used on chips with the erratum -
> because there is no workaround for MSI.

There actually is a workaround for MSI, but it's more complicated and =20
not implemented by this patch.

We could also possibly get away with allowing exactly one MSI =20
(byteswapping doesn't matter if the value is zero) -- not sure how hard =20
that would be.

> > +		list_for_each_entry(msi, &msi_head, list)
> > +			if (msi->feature & MSI_HW_ERRATA_ENDIAN)
> > +				return -EINVAL;
>=20
> I take it you're happy preventing MSI for all devices even if only a
> single chip in the machine has the erratum? In practice you probably
> have all or none with the erratum right?

Yes, it's all integrated onto one chip (the SoC itself).  In fact there =20
should only be one MSI block on these chips.

-Scott=
