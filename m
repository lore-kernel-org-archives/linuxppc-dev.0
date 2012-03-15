Return-Path: <r66093@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DF840B6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 13:30:37 +1100 (EST)
Received: from mail35-am1 (localhost [127.0.0.1])	by mail35-am1-R.bigfish.com
 (Postfix) with ESMTP id 191FF460842	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 15 Mar 2012 02:30:32 +0000 (UTC)
Received: from AM1EHSMHS012.bigfish.com (unknown [10.3.201.227])	by
 mail35-am1.bigfish.com (Postfix) with ESMTP id 148303A01B2	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 02:30:31 +0000 (UTC)
From: Huang Changming-R66093 <r66093@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 4/4] powerpc/85xx: add the P1020UTM-PC DTS support
Date: Thu, 15 Mar 2012 02:30:27 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C04CBF1@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-4-git-send-email-Chang-Ming.Huang@freescale.com>
 <4F60E86C.7000603@freescale.com>
In-Reply-To: <4F60E86C.7000603@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Thanks
Jerry Huang


> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Thursday, March 15, 2012 2:50 AM
> To: Huang Changming-R66093
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 4/4] powerpc/85xx: add the P1020UTM-PC DTS support
>=20
> On 03/14/2012 04:08 AM, Chang-Ming.Huang@freescale.com wrote:
> > +&lbc {
> > +	nor@0,0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "cfi-flash";
> > +		reg =3D <0x0 0x0 0x2000000>;
> > +		bank-width =3D <2>;
> > +		device-width =3D <1>;
> > +
> > +		partition@0 {
> > +			/* 256KB for DTB Image */
> > +			reg =3D <0x0 0x00040000>;
> > +			label =3D "NOR (RO) DTB Image";
> > +			read-only;
> > +		};
> > +
> > +		partition@40000 {
> > +			/* 3.75 MB for Linux Kernel Image */
> > +			reg =3D <0x00040000 0x003c0000>;
> > +			label =3D "NOR (RO) Linux Kernel Image";
> > +			read-only;
> > +		};
> > +
> > +		partition@400000 {
> > +			/* 27MB for Root file System */
> > +			reg =3D <0x00400000 0x01b00000>;
> > +			label =3D "NOR (RW) Root File System";
> > +		};
> > +
> > +		partition@1f00000 {
> > +			/* This location must not be altered  */
> > +			/* 512KB for u-boot Bootloader Image */
> > +			/* 512KB for u-boot Environment Variables */
> > +			reg =3D <0x01f00000 0x00100000>;
> > +			label =3D "NOR (RO) U-Boot Image";
> > +			read-only;
> > +		};
>=20
> Don't put (RW) or (RO) in the label; that information is already there in
> the read-only property.
But for the user, after booting the kernel, he don't know these partition a=
re read-only or can be wrote.=20
If add (RW) or (RO), user can know which partition can be wrote or can't di=
rectly.

> The DTB and kernel image should not be read-only.
