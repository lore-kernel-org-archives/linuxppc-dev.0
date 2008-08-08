Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D9F38DDF7D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Aug 2008 19:22:24 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Strange tg3 regression with UMP fw. link reporting
Date: Fri, 8 Aug 2008 11:21:30 +0200
References: <1218180939.24157.332.camel@pasglop>
	<31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
In-Reply-To: <31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808081121.30795.arnd@arndb.de>
Cc: mcarlson@broadcom.com, netdev <netdev@vger.kernel.org>,
	Nathan Lynch <ntl@pobox.com>, Michael Chan <mchan@broadcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 August 2008, Segher Boessenkool wrote:
> > I don't know yet for sure what happens, but a quick look at the commit
> > seems to show that the driver synchronously spin-waits for up to 2.5ms
>=20
> That's what the comment says, but the code says 2.5 _seconds_:
>=20
> + =A0 =A0 =A0 /* Wait for up to 2.5 milliseconds */
> + =A0 =A0 =A0 for (i =3D 0; i < 250000; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(tr32(GRC_RX_CPU_EVENT) & GRC_RX_CPU_D=
RIVER_EVENT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(10);
> + =A0 =A0 =A0 }
>=20
> (not that milliseconds wouldn't be bad already...)

It can potentially be even much longer, because each udelay will wait
for *more* than 10 microseconds, and tr32() is an mmio read that takes
additional time, possibly in the order of microseconds as well.

The correct way to implement a timeout like this would be to use
time_before() in the condition, aside from better not doing a busy-loop
in the first place.

	Arnd <><
