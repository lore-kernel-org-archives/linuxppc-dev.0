Return-Path: <SHorton@kodiaknetworks.com>
Received: from planomail.kodiaknetworks.com (planomail.kodiaknetworks.com
	[76.203.108.6]) by ozlabs.org (Postfix) with ESMTP id 30022474C3
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 08:06:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Marvell mv64462 + mpc744x PCI Interrupt Cause Error Handling
Date: Wed, 3 Dec 2008 15:06:23 -0600
Message-ID: <295C5089A56CE143B316E5F67CA99CB001F4398C@cowboy.inovate.inovate.com>
In-Reply-To: <4935E65B.30305@windriver.com>
References: <295C5089A56CE143B316E5F67CA99CB001F4389F@cowboy.inovate.inovate.com>
	<4935E65B.30305@windriver.com>
From: "Stephen Horton" <SHorton@kodiaknetworks.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tiejun,
Thanks. That is very helpful; I had not thought to look inside the
drivers directory.
Regards,
stephen

-----Original Message-----
From: tiejun.chen [mailto:tiejun.chen@windriver.com]=20
Sent: Tuesday, December 02, 2008 7:52 PM
To: Stephen Horton
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Marvell mv64462 + mpc744x PCI Interrupt Cause Error
Handling

Stephen Horton wrote:
> Hi folks,
>=20
> =20
>=20
> I'm really hoping Mark Greer or Dale Farnsworth sees this email. In my
> current project, we are in the process of updating a board that has a
> Marvell mv64462 system controller and a Freescale mpc7447A processor
on
> it. The board was originally developed with Gentoo Linux 2.6.9, but we
> have ported Linux 2.6.24 kernel onto it. The new kernel is working
well
> thanks to help from people on this list. However, in examining the
> differences between the 2 kernels, I can see that the 2.6.24 kernel
> registers no interrupt error handling routines (see PCI Error Report
> Register Map in the Marvell documentation). The error handlers for
cpu,
> sram, and specifically for the PCI bus that were previously in:
>=20
>             /arch/ppc/syslib/mv64460_pic.c
>=20
> are absent from:
>=20
>             /arch/powerpc/sysdev/mv64x60_pic.c
>=20
> =20
>=20
> Can someone who is familiar with the history of the ppc->powerpc
> migration for this architecture help me figure out why the error
> handling wasn't ported over? Is there some reason for this, such as it
> didn't work properly or had some disadvantages? Is this error handling
> done in 2.6.24 in some more generic manner that I have not yet found?
Is
> this an exercise left for me to implement?
>=20
> =20

Untill v2.6.27 you can find corresponding dts content such as cpu-error,
sram-ctrl, pci-error and mem-ctrl, in file, prpmc2800.dts. All events
are
handled on EDAC, error detection and reporting, as an unified mode. So
you can
track the directory drivers/edac/ for more information. I think these
are not
upgraded completely for v2.6.24.

Best Regards
Tiejun

>=20
> Thanks,
>=20
> Stephen
>=20
>=20
>=20
>=20
>
------------------------------------------------------------------------
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
