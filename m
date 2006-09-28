Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4664667B56
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 16:37:29 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8S6bRL3025318
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:37:27 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8S6bPgW015663
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 01:37:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 10/11] Add MPC8360EMDS board support 
Date: Thu, 28 Sep 2006 14:38:02 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D91A@zch01exm20.fsl.freescale.net>
In-Reply-To: <E1GSaAn-000340-DD@jdl.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Jon Loeliger" <jdl@jdl.com>
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
> From: Jon Loeliger [mailto:jdl@jdl.com]
> Sent: Wednesday, September 27, 2006 10:14 PM
> To: Li Yang-r58472
> Cc: Vitaly Bordug; linuxppc-dev@ozlabs.org; Paul Mackerras
> Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
>=20
> So, like, the other day "Li Yang-r58472" mumbled:
>=20
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
> >
> > - Leo
>=20
> So, does it make sense for this node to participate in the early scan
> of memory available during the early_init_dt_scan_memory() pass?
>=20

Are all "memory" type nodes regarded as system memory during the early
scan?  If so, it needs to use a new device_type "muram" I think.

> Out of curiosity, is "data-only" a standard thing, or did you make
> that up too?  What's it mean?

Well, it is from kernel code of cpm/cpm2 era.  It defines the MURAM area
which can be freely allocated.  The base and size of such area vary
between chips and revisions, even boards.

- Leo
