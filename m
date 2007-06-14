Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95406DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 13:35:35 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5E3ZTw6005220
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 20:35:30 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5E3ZSUl012107
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 22:35:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 11:37:20 +0800
Message-ID: <989B956029373F45A0B8AF0297081890D2AD35@zch01exm26.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: <joakim.tjernlund@transmode.se>,
	"linuxppc-dev Development" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Li Yang-r58472
> Sent: Thursday, June 14, 2007 11:15 AM
> To: 'joakim.tjernlund@transmode.se'; 'linuxppc-dev Development'
> Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
>=20
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > Sent: Wednesday, June 13, 2007 10:22 PM
> > To: 'linuxppc-dev Development'; Li Yang-r58472
> > Subject: ucc_geth DPRAM alloc error, 2.6.22-rc3
> >
> > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > a Freescale 832x CPU gives me this:
> >  ifconfig eth2 up
> >  ucc_geth_startup: Can not allocate DPRAM memory for
p_thread_data_tx.
> >  eth2: Cannot configure net device, aborting.
> >  SIOCSIFFLAGS: Cannot allocate memory
> >
> > This worked in 2.6.20
> Hi Joakim,
>=20
> Thanks for the bug report.  The cause of this problem is that ucc_geth
is set to work in 1000Mbps mode.  However, 8323 only supports
> 100Mbps.  1000Mbps mode consumes much more MURAM for virtual FIFO.


You can try adding the following property in your ucc node.
	phy-connection-type =3D "mii"

- Leo
