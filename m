Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 248A967B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 16:11:57 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8S6Bub7020741
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:11:56 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8S6BrPa009078
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 01:11:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 10/11] Add MPC8360EMDS board support
Date: Thu, 28 Sep 2006 14:12:30 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D90F@zch01exm20.fsl.freescale.net>
In-Reply-To: <C62AC4D8-39E5-44D0-88A3-E8D8042FC828@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
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
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Wednesday, September 27, 2006 9:34 PM
> To: Li Yang-r58472
> Cc: Vitaly Bordug; linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
>=20
> >>>> +memory {
> >>>> +               device_type =3D "memory";
> >>>> +               linux,phandle =3D <300>;
> >>>> +               reg =3D <00000000 4000000 f4500000 00000020>;
> >>>> +       };
> >>>> the second pair is about bcsr and its size.
> >>>>
> >>>> Just in case this may help (and wondering if I'm not violating
> >>> something :) )
> >>>
> >>> Well, this can make it work.  But I would prefer to use a new node
> >>> because the BCSR is by no means a memory type of device.  I have
> > made my
> >>> change to use node like this:
> >>>
> >>>         bcsr@f8000000 {
> >>>                 device_type =3D "board-control";
> >>>                 reg =3D <f8000000 8000>;
> >>>         };
> >>>
> >>
> >> I though about that approach, but saw somewhere a reference that we
> > should not summon
> >> new node types without utter necessity, and utilized memory because
> > bcsr is
> >> memory-mapped stuff. I can hardly imagine bcsr as a device (which
> > would require
> >> respective spec inclusion btw).
> >
> > Well I didn't see such a guideline.  However BCSR is truly a device
> > like
> > any other peripherals on board.  Usually it is an FPGA on local bus
to
> > control the board.
>=20
> Agree that a new node is better, calling it memory isn't right.
> However, I'm not sure this really needs a node in the device tree.
> The BCSR isn't really the same from board to board last time I
> checked.  I'd be interested in Paul's thinking about why it should be
> in the tree.
>=20
> >> hence let's open a discussion what others think about that. The
> > problem seems common
> >> (and for some boards
> >> is called somewhat else apparently), but at this point we should
come
> > to some
> >> conclusion, document it, and use it.
> >
> > Agreed.  As we are adding more devices to the device tree, we should
> > also have a guideline clearly stated for adding new nodes.
> >
> > I'm adding MURAM as a new node under QE bus.  Please comment.
> >                 muram@10000 {
> >                         device_type =3D "memory";
> >                         ranges =3D <0 00010000 0000c000>;
> >
> >                         data-only@0{
> >                                 reg =3D <0 c000>;
> >                         };
> >                 };
>=20
> What was the need for this?


Data-only defines MURAM area which can be allocated for data and
parameter ram.  Some MURAM space can be occupied by microcode or
microcode patch, and should be excluded from allocation.

- Leo
