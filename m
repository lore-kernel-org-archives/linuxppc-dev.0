Return-Path: <Jason.Jin@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6C0CDDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 12:32:00 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m4D2VpUF029947
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 19:31:51 -0700 (MST)
Received: from zch01exm27.fsl.freescale.net (zch01exm27.ap.freescale.net
	[10.192.129.223])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m4D2Vn7g024095
	for <linuxppc-dev@ozlabs.org>; Mon, 12 May 2008 21:31:50 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/4 V2] booting-without-of for Freescale MSI
Date: Tue, 13 May 2008 10:31:46 +0800
Message-ID: <CC27DED0F8F39E48A7E75FD768688B7A8C18C5@zch01exm27.fsl.freescale.net>
In-Reply-To: <fa686aa40805090625m1f127898j19e3f2436ef0fbc6@mail.gmail.com>
References: <1210323810-24833-1-git-send-email-Jason.jin@freescale.com>
	<fa686aa40805090625m1f127898j19e3f2436ef0fbc6@mail.gmail.com>
From: "Jin Zhengxiong" <Jason.Jin@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On=20
> Behalf Of Grant Likely
> Sent: Friday, May 09, 2008 9:25 PM
> To: Jin Zhengxiong
> Cc: galak@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/4 V2] booting-without-of for Freescale MSI
>=20
> On Fri, May 9, 2008 at 3:03 AM, Jason Jin=20
> <Jason.jin@freescale.com> wrote:
> > Binding document adding for Freescale MSI support.
> >
> > Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> > ---
> > Updated to V2 version per Segher's suggestion.
> >
> >  Documentation/powerpc/booting-without-of.txt |   40=20
> +++++++++++++++++++++++++-
> >  1 files changed, 39 insertions(+), 1 deletions(-)
> >
> > diff --git a/Documentation/powerpc/booting-without-of.txt=20
> > b/Documentation/powerpc/booting-without-of.txt
> > index 1d2a772..887783c 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -57,7 +57,10 @@ Table of Contents
> >       n) 4xx/Axon EMAC ethernet nodes
> >       o) Xilinx IP cores
> >       p) Freescale Synchronous Serial Interface
> > -         q) USB EHCI controllers
> > +      q) USB EHCI controllers
> > +      r) Freescale Display Interface Unit
> > +      s) Freescale on board FPGA
> > +      t) Freescael MSI interrupt controller
> >
> >   VII - Marvell Discovery mv64[345]6x System Controller chips
> >     1) The /system-controller node
> > @@ -2870,6 +2873,41 @@ platforms are moved over to use the=20
> flattened-device-tree model.
> >                reg =3D <0xe8000000 32>;
> >        };
> >
> > +    t) Freescale MSI interrupt controller
> > +
> > +    Reguired properities:
> > +    - compatible : set as "fsl,86xx-MSI" for 86xx cpu,=20
> "fsl,85xx-MSI" for 85xx
> > +      cpu and "fsl,83xx-MSI" for 83xx cpu.
>=20
> As Segher mentioned; don't use 'generic' compatible values. =20
> Use names of *actual* devices and have newer parts claim=20
> compatibility with older ones.

The *actual* devices that can use this MSI driver, is *all* the=20
boards that use "86xx/85xx/83xx" cpu. This compatible note actually
was used to distinguish different msiir offset for the boards use=20
MPIC and IPIC.=20
If "MPIC-MSI" or "85xx-MSI" is 'generic'. Do we need to describe it=20
as "fsl,mpc8572ds-msi" and make all the boards who use MPIC compatible
to "fsl,mpc8572ds-msi", Or each of the boards have their own compatible
name=20
and each time we add a board to support MSI, add an item to the
of_device_id table?
Please suggest, Thanks=20

Jason
