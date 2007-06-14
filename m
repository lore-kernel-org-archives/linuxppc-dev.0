Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AB6FDDEC7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:24:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5E7OBdA021928
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 00:24:11 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5E7O987006892
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 02:24:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 15:26:02 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2ADA9@zch01exm26.fsl.freescale.net>
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

Looks like you are using virtual FIFO for 100Mbps.

> some comments:
>=20
> With these aligments, won't you waste alot of MURAM?
>=20
> Looking at the 2 first allocs:
>   MURAM alloc, start:1400, size:200(512), align:8(8)
>   MURAM alloc, start:1608, size:208(520), align:8(8)
> shouldn't the second alloc have 0x1600 as start address?

This looks like a bug of rheap.  The main problem is that at system
startup phase, there is an allocation of size 0x400,align 0x1000.
The rheap starts to allocate next buffer from 0x1400, instead of 0x400.

- Leo
