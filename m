Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D4E9E67A2E
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 16:29:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8M6T1fp003171
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 23:29:01 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8M6SxcZ002867
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:29:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 4/11] qe_lib: Add QE I/O ports API
Date: Fri, 22 Sep 2006 14:29:34 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D36C@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060921192137.5c6af005@vitb.ru.mvista.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>,
	"Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Thursday, September 21, 2006 11:22 PM
> To: Joakim Tjernlund
> Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 4/11] qe_lib: Add QE I/O ports API
>=20
> On Thu, 21 Sep 2006 16:52:14 +0200
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
>=20
> > Hi Leo
> >
> > As you know I working with your earlier patches, trying to adopt
them
> > for
> > 8321. Everthing works but ethernet on UCC2 and UCC4, ethernet on
UCC3
> > works though.
> >
> > Anyhow I found some minor changes I had to do to match 8321 that is
> > generic 83xx code.
> > Below is the first:
> > > ---
> > >  arch/powerpc/sysdev/qe_lib/qe_io.c |  272
> > > +#define NUM_OF_PAR_IOS  7
> >
> > NUM_OF_PAR_IOS is 4 on 8321
> >
> > > +static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] =3D {
> > > +	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /*
> > > 24 - 31 */
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0,
> > > 0,0,0,0,0,1,1,0},
> > > +	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
> > > 0,0,1,1,0,0,0,0},
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
> > > 0,0,0,1,1,1,0,0},
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0,
> > > 0,0,1,1,0,0,0,0},
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0,
> > > 1,1,1,1,0,0,0,1},
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0,
> > > 0,0,0,0,0,0,0,0},
> > > +	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,
> > > 0,0,0,0,0,0,0,1}
> > > +};
> >
> > qe_irq_ports is diffrent on 8321 not only the number of rows.
> >
> > These needs to configuruable based on CPU model and/or type of
board.
> >
>=20
> Well, eventually this stuff aims to serve not 83xx/qe, but for
cpm(1,2)-equipped
> stuff
> too. Apparently, we'll have to do something wise to afford that...
>=20
> OTOH, this is good as a starting point I guess.

I agree.  I will remove the I/O port interrupt stuff for now.  Anyway,
it is not used by any code in kernel for now.

- Leo
