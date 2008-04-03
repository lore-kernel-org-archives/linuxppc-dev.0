Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 4F17DDDE04
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 15:16:29 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC][V3] Xilinx: of_serial support for Xilinx
	uart 16550.
Date: Thu, 3 Apr 2008 06:16:08 +0200
References: <20080402232213.5D87515B8067@mail37-sin.bigfish.com>
	<200804030134.11437.arnd@arndb.de>
	<fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
In-Reply-To: <fa686aa40804021943m208c2ff0va6c6b629a747439f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804030616.09825.arnd@arndb.de>
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 03 April 2008, Grant Likely wrote:
> >
> > =A0Since it is not really compatible with ns16550, shouldn't you at lea=
st specify
> > =A0a different "compatible" property? That way, the driver won't do inc=
orrect
> > =A0accesses when you try to use an old driver with a device tree that s=
pecifies
> > =A0one of these.
>=20
> Heh; we've gone back and forth on this issue. =A0The problem is that we
> have a common case of ns16550 like devices that require a little bit
> of register address tweaking that spans a whole range of vendors (so
> adding a compatible match with each of those vendor's prefixes is
> probably non-scalable). =A0So, if "ns16550" is not a good idea, then
> what should be used? =A0"sparse16550" has been suggested more than once.

After another IRC discussion between Grant, Segher and myself, we concluded
that we don't need to invent a new "compatible" value, as only new device
trees with old kernels will have a problem with this, and they don't work
in the first place.

The devices will still have their specific "compatible" value, e.g.
"xlnx,plb-uart16550-1.00.c", followed by "ns16550", and possibly
"ns16450" and "i8250", although the last two do not have an effect
on Linux.

Josh, can you please forward all three patches in their latest version?

Acked-by: Arnd Bergmann <arnd@arndb.de>
