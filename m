Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B04022C035E
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Mar 2013 04:48:43 +1100 (EST)
Date: Thu, 7 Mar 2013 11:47:50 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/8] powerpc/fsl-booke: Add initial silicon device tree for
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <FFA4082B-0C61-43F6-BB84-2C5A25476814@kernel.crashing.org>
 (from galak@kernel.crashing.org on Thu Mar  7 11:09:50 2013)
Message-ID: <1362678470.23227.5@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/07/2013 11:09:50 AM, Kumar Gala wrote:
>=20
> On Mar 5, 2013, at 6:15 PM, Scott Wood wrote:
>=20
> > On 03/05/2013 05:15:57 PM, Kumar Gala wrote:
> >> Enable a baseline T4240 SoC to boot.  There are several things =20
> missing
> >> from the device trees for T4240:
> >> * Thread support on e6500
> >
> > Why did threads get removed from the device tree?  It's supposed to =20
> describe hardware, not what Linux currently supports.
>=20
> will fix, was concerned if we'd be able to boot if they exited

I don't think it'd be a problem (and if it is, then fix Linux).

> >> +	device_type =3D "pci";
> >> +	#size-cells =3D <2>;
> >> +	#address-cells =3D <3>;
> >> +	bus-range =3D <0x0 0xff>;
> >> +	clock-frequency =3D <33333333>;
> >
> > This clock-frequency is not correct (I doubt it's needed at all).
>=20
> I can zero the field, but its spec'd by pci binding

If we aren't going to put a correct value in, is zero better than =20
omitting it entirely?

There are other properties in the PCI binding that we don't have, such =20
as slot-names.  I don't see any language in the PCI binding that says =20
one is required but the other isn't.

And shouldn't we be using the PCI express binding (device_type =3D =20
"pciex", or just get rid of it since this isn't real OF)?

-Scott=
