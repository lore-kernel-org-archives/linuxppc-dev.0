Return-Path: <John.Linn@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id DCB94DDF69
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:29:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
Date: Thu, 3 Apr 2008 07:29:48 -0600
In-Reply-To: <200804030616.09825.arnd@arndb.de>
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
	<200804030134.11437.arnd@arndb.de>
	<fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
	<200804030616.09825.arnd@arndb.de>
From: "John Linn" <John.Linn@xilinx.com>
To: "Arnd Bergmann" <arnd@arndb.de>,
	<linuxppc-dev@ozlabs.org>
Message-Id: <20080403132951.01E841B3005C@mail13-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Arnd, I apologize for not keeping you in the loop on this.

I'm still learning the process and appreciate your help and patience.

Thanks to all for the work to get consensus on this,
John

-----Original Message-----
From: Arnd Bergmann [mailto:arnd@arndb.de]=20
Sent: Wednesday, April 02, 2008 10:16 PM
To: linuxppc-dev@ozlabs.org
Cc: Grant Likely; John Linn; Segher Boessenkool; Josh Boyer
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for =
Xilinx uart 16550.

On Thursday 03 April 2008, Grant Likely wrote:
> >
> > =A0Since it is not really compatible with ns16550, shouldn't you at =
least specify
> > =A0a different "compatible" property? That way, the driver won't do =
incorrect
> > =A0accesses when you try to use an old driver with a device tree =
that specifies
> > =A0one of these.
>=20
> Heh; we've gone back and forth on this issue. =A0The problem is that =
we
> have a common case of ns16550 like devices that require a little bit
> of register address tweaking that spans a whole range of vendors (so
> adding a compatible match with each of those vendor's prefixes is
> probably non-scalable). =A0So, if "ns16550" is not a good idea, then
> what should be used? =A0"sparse16550" has been suggested more than =
once.

After another IRC discussion between Grant, Segher and myself, we =
concluded
that we don't need to invent a new "compatible" value, as only new =
device
trees with old kernels will have a problem with this, and they don't =
work
in the first place.

The devices will still have their specific "compatible" value, e.g.
"xlnx,plb-uart16550-1.00.c", followed by "ns16550", and possibly
"ns16450" and "i8250", although the last two do not have an effect
on Linux.

Josh, can you please forward all three patches in their latest version?

Acked-by: Arnd Bergmann <arnd@arndb.de>
