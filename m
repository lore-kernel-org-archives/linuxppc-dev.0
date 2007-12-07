Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 35BADDDE39
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:58:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 balbir@linux.vnet.ibm.com
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
Date: Fri, 7 Dec 2007 22:58:17 +0100
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<4759BCBA.7060800@linux.vnet.ibm.com>
	<4759BE88.3020702@linux.vnet.ibm.com>
In-Reply-To: <4759BE88.3020702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712072258.19331.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 07 December 2007, Balbir Singh wrote:
> Balbir Singh wrote:
> > Geert Uytterhoeven wrote:
> >> On Sat, 8 Dec 2007, Balbir Singh wrote:
> >>> +=A0=A0=A0if (strstr(p, "fake=3D"))
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0cmdline =3D p + 5;=A0=A0=A0=A0=A0=
=A0=A0=A0/* 5 is faster than strlen("fake=3D") */
> >> Really? My gcc is smart enough to replace the `strlen("fake=3D")' by 5=
, even
> >> without -O.
> >>
> >=20
> > Thanks for pointing that out, but I am surprised that a compiler would
> > interpret library routines like strlen.
> >=20
>=20
> I just tested it and it turns out that you are right. I'll go hunt to
> see where gcc gets its magic powers from.
>=20

Even if it wasn't: Why the heck would you want to optimize this? The functi=
on
is run _once_ at boot time and the object code gets thrown away afterwards!

	Arnd <><
