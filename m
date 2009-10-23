Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 93372B7BBC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 19:46:23 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9N8kG80014614 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 01:46:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n9N8kEP8012226
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Oct 2009 03:46:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC5121e DIU driver - kernel crash writing alpha component
Date: Fri, 23 Oct 2009 16:46:13 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED8F6CF3@zch01exm26.fsl.freescale.net>
In-Reply-To: <4AE1585E.60002@tin.it>
References: <4AE1585E.60002@tin.it>
From: "Chen Hongjun-R66092" <hong-jun.chen@freescale.com>
To: "LD" <memorylost@tin.it>,
	"Linux ppc mailing list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,=20

Pls refer to my comment embedded.=20

> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists.ozlabs.
> org=20
> [mailto:linuxppc-dev-bounces+hong-jun.chen=3Dfreescale.com@lists
> .ozlabs.org] On Behalf Of LD
> Sent: Friday, October 23, 2009 3:17 PM
> To: Linux ppc mailing list; Lucio Dona'
> Subject: MPC5121e DIU driver - kernel crash writing alpha component
>=20
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi all,
> I am working on Freescale MPC5121e evaluation board ADS512101=20
> rev. 3 (M34K processor stepping), developing a graphical application.
> Just switched to ADS512101 rev. 4, 0M36P processor stepping.
>=20
> I have problems with the video framebuffer driver, try to explain:
>=20
> - - app is based on microwindows+fltk, framebuffer driver. On=20
> rev3 board working ok.
> - - rev4 board: using the kernel from ltib 2009/06/02, just=20
> adapted fsl-diu-fb.c and .h to support resolution and timings=20
> of my lcd panel.
>=20
> The board is booting ok (NFS), but my user space app keeps=20
> crashing the kernel.
>=20
> I noticed that in 0M36P processor stepping there are many=20
> changes about the video interface (DIU), correcting some bugs=20
> of the previous stepping ; seems that when I write to the ram=20
> area which is mapped to Panel0 of the DIU the system randomly hangs.
>=20
> After some debugging...
> 800x480, 32 bits per pixel, using plane1 (first plane, as=20
> described in the processor's reference manual).
> If, from user space, I write some alpha component !=3D 0 in=20
> this plane then I have a complete system crash.
> The reference pdf says "There is no alpha component defined=20
> for plane1 because there are no planes behind it."
>=20

Sure, panel0 doesn't support alpha function, so you can't operate it.

> I did not yet investigate about writing in other planes ;=20
> time is short...
> For now, patched microwindows driver for writing 0x00 in=20
> alpha components, no more hangs.
> Reported to Freescale FAE, waiting for some answers.
>=20
> Meanwhile: some suggestions about filtering alpha components=20
> in the video driver ?

You can replace panel0 with panel1, which can support alpha function.

> I was thinking about some sort of double buffering : user space app
> (fltk--->microwindows) writes in a buffer, then the driver=20
> clears alpha to 0x00 and memcpy to the real video buffer.
>=20
> Problems:
> - - driver / user space sync. Vertical retrace ? ioctl ?
> - - waste of memory, needs double video buffers
>=20
>=20
> Any suggestions are welcome,
> work in progress.
>=20
> Regards
> Lucio Dona'
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>=20
> iD8DBQFK4VhdvxHCsvXy9okRAtrtAKCaAectSfrHOfzcbTR7KfF9lHCY1QCeOcND
> HC9fMyGUATKeDL9z9IEzAWc=3D
> =3Dofjv
> -----END PGP SIGNATURE-----
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
>=20
