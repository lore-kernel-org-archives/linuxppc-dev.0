Return-Path: <harninder.rai@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DD011400A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:59:36 +1000 (EST)
From: Harninder Rai <harninder.rai@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: powerpc/mpc85xx: Add BSC9132 QDS Support
Date: Fri, 9 May 2014 07:44:48 +0000
Message-ID: <b054b6eafb074ed28673628a127c6cf0@BL2PR03MB177.namprd03.prod.outlook.com>
References: <1395128102-12983-1-git-send-email-harninder.rai@freescale.com>
 <20140503002309.GA20757@home.buserror.net>
In-Reply-To: <20140503002309.GA20757@home.buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Ruchika
 Gupta <ruchika.gupta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > +	};
> > +
> > +	nand@1,0 {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		compatible =3D "fsl,ifc-nand";
> > +		reg =3D <0x1 0x0 0x4000>;
> > +
> > +		partition@0 {
> > +			/* This location must not be altered  */
> > +			/* 3MB for u-boot Bootloader Image */
> > +			reg =3D <0x0 0x00300000>;
> > +			label =3D "NAND U-Boot Image";
> > +			read-only;
> > +		};
> > +
> > +		partition@300000 {
> > +			/* 1MB for DTB Image */
> > +			reg =3D <0x00300000 0x00100000>;
> > +			label =3D "NAND DTB Image";
> > +		};
> > +
> > +		partition@400000 {
> > +			/* 8MB for Linux Kernel Image */
> > +			reg =3D <0x00400000 0x00800000>;
> > +			label =3D "NAND Linux Kernel Image";
> > +		};
> > +
> > +		partition@c00000 {
> > +			/* Rest space for Root file System Image */
> > +			reg =3D <0x00c00000 0x07400000>;
> > +			label =3D "NAND RFS Image";
> > +		};
> > +	};
> > +};
>=20
> Please keep partition definitions out of the dts file, as has been recent=
ly
> requested of other boards.  You can use U-Boot to create the partition no=
des
> based on the mtdparts variable, or you can use the Linux mtdparts command=
 line
> option.
Ok. Will remove these in V2 of patch
>=20
> -Scott
