Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler3.mail.xerox.com (wvmler3.mail.xerox.com [13.8.138.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler3.mail.xerox.com",
	Issuer "wvmler3.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F2582DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Feb 2007 21:04:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: using gdb/kgdb
Date: Mon, 26 Feb 2007 09:51:46 -0000
Message-ID: <35786B99AB3FDC45A8215724617919730105A278@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069AEA@MERCURY.inside.istor.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Charles Krinke" <ckrinke@istor.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Charles

> The kernel is compiled with CONFIG_DEBUG_KERNEL, CONFIG_KGDB,
> CONFIG_KGDB_TTYS1 all defined and I can boot it to the point
> where it is waiting for a gdb connection and it does make a
> connection. I have kernel command line that contains
> "kgdb=3DttyS1,115200,halt kgdbwait" in it and this appears to
> be working fine and the output looks like this.
>=20
> MMU:enterJCSSU'=EB=81init
> MMU:mapin
> MMU:setio
> MMU:exit
> begin start_kernel
> setup_arch: enter
> setup_arch: kgdb breakpoint
>=20
> At this point, from the cross-compiled gdb on a host, if I
> invoke gdb with vmlinux as an argument, the PC is zero.
>=20
> $ ppc-gdb vmlinux
>=20
> (gdb)set remotebaud 115200
>=20
At this point, try setting the architecture as below (you can
show the current architecture first, to check that it is
wrongly set to "e500", which doesn't work properly)

(gdb) show architecture
The target architecture is set automatically (currently powerpc:e500)

(gdb) set architecture powerpc:common
The target architecture is assumed to be powerpc:common

> (gdb)target remote /dev/ttyUSB0
> ...

More explanation can be found here:
http://www.ultsol.com/faq_p311.htm
[I would prefer to reference an explanation on this
mailing list, but I did not find one.]

I hope this solves your problem.

Clive
