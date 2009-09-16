Return-Path: <Poonam.Aggrwal@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C266CB7B85
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 23:46:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8GDk0DD001638
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 06:46:01 -0700 (MST)
Received: from zin33exm24.fsl.freescale.net (zin33exm24.ap.freescale.net
	[10.232.192.24])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8GDlqIe016951
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Sep 2009 08:47:53 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH][v1] powerpc/85xx: Create dts for each core in
	CAMPmodeforP2020RDB
Date: Wed, 16 Sep 2009 19:15:54 +0530
Message-ID: <1BD5CFC378ED0946B688E0C9BA2EF095259E26@zin33exm24.fsl.freescale.net>
In-Reply-To: <3F599858-2550-4234-86F3-A3352576AC34@kernel.crashing.org>
References: <1252573031-4157-1-git-send-email-poonam.aggrwal@freescale.com><20090910093307.GA17117@iram.es><1BD5CFC378ED0946B688E0C9BA2EF0951FD268@zin33exm24.fsl.freescale.net><20090910160233.GA24085@iram.es><1BD5CFC378ED0946B688E0C9BA2EF0951FD33A@zin33exm24.fsl.freescale.net>
	<3F599858-2550-4234-86F3-A3352576AC34@kernel.crashing.org>
From: "Aggrwal Poonam-B10812" <Poonam.Aggrwal@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs
> .org=20
> [mailto:linuxppc-dev-bounces+poonam.aggrwal=3Dfreescale.com@list
> s.ozlabs.org] On Behalf Of Kumar Gala
> Sent: Wednesday, September 16, 2009 7:10 PM
> To: Aggrwal Poonam-B10812
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH][v1] powerpc/85xx: Create dts for each=20
> core in CAMPmodeforP2020RDB
>=20
>=20
> On Sep 11, 2009, at 6:47 AM, Aggrwal Poonam-B10812 wrote:
>=20
> >>
> >> Ok, I wrongly understood protected interrupts as reserved for one=20
> >> core. However, I still dislike two devices having the same name.
> >>
> >> Otherwise it may work if every interrupt is delivered to=20
> both cores=20
> >> although statistically only one core will actually have=20
> some work to=20
> >> do. Doesn't the kernel complain about unhandled irqs however?
> >>
> > We don't see any such messages of unhandled interrupts, although I=20
> > checked the corresponding files for mpc8572ds, they do not have the=20
> > interrupts property for the serial ports at all, in both=20
> the core0 and
> > core1 dts.
> > Don't know the reason.
>=20
> the p2020 versions shouldn't have an interrupt property in=20
> the serial node.  The reason we removed it in the 8572 CAMP=20
> dts is to make sure we get polling mode.  As Gabriel points=20
> out sharing the IRQ between the two OSes is not safe.  While=20
> it might seem to work it will have issues at some point.
>=20
Thanks for the explanation. Probably we are not seeing an issue, because
we are protecting the int 42 in both the dts files.
So probably mpic is not forwarding the interrupt to any of the cores.

Anyways I will rework the patch and resend.

Kind Regards
Poonam
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
