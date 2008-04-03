Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 60AC4DDF22
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 09:36:28 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for
	Xilinxuart 16550.
Date: Thu, 3 Apr 2008 15:36:20 -0700
In-Reply-To: <200804030616.09825.arnd@arndb.de>
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com><200804030134.11437.arnd@arndb.de><fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
	<200804030616.09825.arnd@arndb.de>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080403223622.66C28F4007D@mail128-dub.bigfish.com>
Cc: John Linn <linnj@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The device tree generator now reflects this.

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of =
Arnd Bergmann
> Sent: Wednesday, April 02, 2008 9:16 PM
> To: linuxppc-dev@ozlabs.org
> Cc: John Linn
> Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for =
Xilinxuart 16550.
>=20
> On Thursday 03 April 2008, Grant Likely wrote:
> > >
> > > =A0Since it is not really compatible with ns16550, shouldn't you =
at least specify
> > > =A0a different "compatible" property? That way, the driver won't =
do incorrect
> > > =A0accesses when you try to use an old driver with a device tree =
that specifies
> > > =A0one of these.
> >
> > Heh; we've gone back and forth on this issue. =A0The problem is that =
we
> > have a common case of ns16550 like devices that require a little bit
> > of register address tweaking that spans a whole range of vendors (so
> > adding a compatible match with each of those vendor's prefixes is
> > probably non-scalable). =A0So, if "ns16550" is not a good idea, then
> > what should be used? =A0"sparse16550" has been suggested more than =
once.
>=20
> After another IRC discussion between Grant, Segher and myself, we =
concluded
> that we don't need to invent a new "compatible" value, as only new =
device
> trees with old kernels will have a problem with this, and they don't =
work
> in the first place.
>=20
> The devices will still have their specific "compatible" value, e.g.
> "xlnx,plb-uart16550-1.00.c", followed by "ns16550", and possibly
> "ns16450" and "i8250", although the last two do not have an effect
> on Linux.
>=20
> Josh, can you please forward all three patches in their latest =
version?
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
