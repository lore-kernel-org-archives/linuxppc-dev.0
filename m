Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9CDA067B6A
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:20:01 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8RDJxpT005339
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 06:19:59 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8RDJveN005221
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 08:19:58 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 27 Sep 2006 21:20:35 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
In-Reply-To: <20060927165556.04c8d5d7@vitb.ru.mvista.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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
> Sent: Wednesday, September 27, 2006 8:56 PM
> To: Li Yang-r58472
> Cc: Paul Mackerras; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
>=20
> On Wed, 27 Sep 2006 20:02:56 +0800
> "Li Yang-r58472" <LeoLi@freescale.com> wrote:
>=20
> > > -----Original Message-----
> > > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > > Sent: Wednesday, September 27, 2006 7:56 PM
> > > To: Paul Mackerras
> > > Cc: Li Yang-r58472; linuxppc-dev@ozlabs.org
> > > Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
> > >
> > > On Wed, 27 Sep 2006 16:39:11 +1000
> > > Paul Mackerras <paulus@samba.org> wrote:
> > >
> > > > Li Yang writes:
> > > >
> > > > > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > > > > +#define BCSR_SIZE		((uint)(32 * 1024))
> > > >
> > > > This sort of thing should really be in the device tree.
> > > >
> > > Just a suggestion, but for the similar aim in pq2 I have those
stuff
> > in memory node :
> > >
> > > +memory {
> > > +               device_type =3D "memory";
> > > +               linux,phandle =3D <300>;
> > > +               reg =3D <00000000 4000000 f4500000 00000020>;
> > > +       };
> > > the second pair is about bcsr and its size.
> > >
> > > Just in case this may help (and wondering if I'm not violating
> > something :) )
> >
> > Well, this can make it work.  But I would prefer to use a new node
> > because the BCSR is by no means a memory type of device.  I have
made my
> > change to use node like this:
> >
> >         bcsr@f8000000 {
> >                 device_type =3D "board-control";
> >                 reg =3D <f8000000 8000>;
> >         };
> >
>=20
> I though about that approach, but saw somewhere a reference that we
should not summon
> new node types without utter necessity, and utilized memory because
bcsr is
> memory-mapped stuff. I can hardly imagine bcsr as a device (which
would require
> respective spec inclusion btw).

Well I didn't see such a guideline.  However BCSR is truly a device like
any other peripherals on board.  Usually it is an FPGA on local bus to
control the board.
>=20
> hence let's open a discussion what others think about that. The
problem seems common
> (and for some boards
> is called somewhat else apparently), but at this point we should come
to some
> conclusion, document it, and use it.

Agreed.  As we are adding more devices to the device tree, we should
also have a guideline clearly stated for adding new nodes. =20

I'm adding MURAM as a new node under QE bus.  Please comment.
                muram@10000 {
                        device_type =3D "memory";
                        ranges =3D <0 00010000 0000c000>;

                        data-only@0{
                                reg =3D <0 c000>;
                        };
                };

- Leo
