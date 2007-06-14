Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F91CDDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:35:39 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l5E7ZVwa020968
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 00:35:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l5E7ZTdO009080
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 02:35:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 15:37:22 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
In-Reply-To: <1181805466.30670.352.camel@gentoo-jocke.transmode.se>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>, "Liu Dave-r63238" <DaveLiu@freescale.com>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Try remove the following lines in rheap.c

         /* given alignment larger that default rheap alignment */
         if (alignment > info->alignment)
                 size +=3D alignment - 1;

I don't know if this breaks other things, just have a try.

- Leo

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On Behalf
Of
> Joakim Tjernlund
> Sent: Thursday, June 14, 2007 3:18 PM
> To: Liu Dave-r63238
> Cc: 'linuxppc-dev Development'
> Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
>=20
> On Thu, 2007-06-14 at 09:03 +0200, Joakim Tjernlund wrote:
> > On Thu, 2007-06-14 at 10:31 +0800, Dave Liu wrote:
> > > On Wed, 2007-06-13 at 16:22 +0200, Joakim Tjernlund wrote:
> > > > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > > > a Freescale 832x CPU gives me this:
> > > >  ifconfig eth2 up
> > > >  ucc_geth_startup: Can not allocate DPRAM memory for
p_thread_data_tx.
> > > >  eth2: Cannot configure net device, aborting.
> > > >  SIOCSIFFLAGS: Cannot allocate memory
> > > >
> > > > This worked in 2.6.20
> > >
> > > Could you print the MURAM memory usage for debug?
> > > eg. start address and size.
> > >
> > > -d
> >
> > Like this?
>=20
> redid with all hex, decimal within()
> MURAM alloc, start:1400, size:200(512), align:8(8)
> MURAM alloc, start:1608, size:208(520), align:8(8)
> MURAM alloc, start:1880, size:80(128), align:80(128)
> MURAM alloc, start:1a00, size:1a0(416), align:100(256)
> MURAM alloc, start:1bc0, size:40(64), align:20(32)
> MURAM alloc, start:1d00, size:100(256), align:100(256)
> MURAM alloc, start:1f00, size:a0(160), align:100(256)
> MURAM alloc, start:1fc0, size:c(12), align:40(64)
> MURAM alloc, start:2000, size:30(48), align:8(8)
> MURAM alloc, start:2080, size:80(128), align:80(128)
> MURAM alloc, start:2180, size:80(128), align:80(128)
> MURAM alloc, start:2280, size:80(128), align:80(128)
> MURAM alloc, start:2380, size:80(128), align:80(128)
> MURAM alloc, start:2440, size:40(64), align:40(64)
> MURAM alloc, start:24c0, size:40(64), align:40(64)
> MURAM alloc, start:2540, size:40(64), align:40(64)
> MURAM alloc, start:25c0, size:40(64), align:40(64)
> MURAM alloc, start:262c, size:5d(93), align:4(4)
>=20
> MURAM alloc, start:2630, size:200(512), align:8(8)
> MURAM alloc, start:2838, size:208(520), align:8(8)
> MURAM alloc, start:2a80, size:80(128), align:80(128)
> MURAM alloc, start:2c00, size:1a0(416), align:100(256)
> MURAM alloc, start:2de0, size:40(64), align:20(32)
> MURAM alloc, start:2f00, size:100(256), align:100(256)
> MURAM alloc, start:3100, size:a0(160), align:100(256)
> MURAM alloc, start:3200, size:c(12), align:40(64)
> MURAM alloc, start:3228, size:30(48), align:8(8)
> MURAM alloc, start:3280, size:80(128), align:80(128)
> MURAM alloc, start:3380, size:80(128), align:80(128)
> MURAM alloc, start:3480, size:80(128), align:80(128)
> MURAM alloc, start:3580, size:80(128), align:80(128)
> MURAM alloc, start:3680, size:40(64), align:40(64)
> MURAM alloc, start:3700, size:40(64), align:40(64)
> MURAM alloc, start:3780, size:40(64), align:40(64)
> MURAM alloc, start:3800, size:40(64), align:40(64)
> MURAM alloc, start:3858, size:5d(93), align:4(4)
>=20
> MURAM alloc, start:3858, size:200(512), align:8(8)
> MURAM alloc, start:3a60, size:208(520), align:8(8)
> MURAM alloc, start:3c80, size:80(128), align:80(128)
> MURAM alloc, start:fffffff4, size:1a0(416), align:100(256)
>=20
> some comments:
>=20
> With these aligments, won't you waste alot of MURAM?
>=20
> Looking at the 2 first allocs:
>   MURAM alloc, start:1400, size:200(512), align:8(8)
>   MURAM alloc, start:1608, size:208(520), align:8(8)
> shouldn't the second alloc have 0x1600 as start address?
>=20
>  Jocke
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
