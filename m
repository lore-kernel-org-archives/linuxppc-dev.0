Return-Path: <B43644@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E4C102C0124
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Jul 2013 12:20:29 +1000 (EST)
From: Liu Po-B43644 <B43644@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 3/3] powerpc/85xx: Add C293PCIE board support
Date: Mon, 29 Jul 2013 02:20:11 +0000
Message-ID: <D473A0D087F4EA47A30C37E4637E25E609DB3735@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
 <1374806479-812-1-git-send-email-Po.Liu@freescale.com>
 <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1374875956.30721.27@snotra>
In-Reply-To: <1374875956.30721.27@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>  -----Original Message-----
>  From: Wood Scott-B07421
>  Sent: Saturday, July 27, 2013 5:59 AM
>  To: Liu Po-B43644
>  Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Fleming Andy-
>  AFLEMING; Hu Mingkai-B21284; Liu Po-B43644
>  Subject: Re: [PATCH v2 3/3] powerpc/85xx: Add C293PCIE board support
> =20
>  On 07/25/2013 09:41:19 PM, Po Liu wrote:
>  > +		partition@1900000 {
>  > +			/* 7MB for User Area */
>  > +			reg =3D <0x01900000 0x00700000>;
>  > +			label =3D "NAND User area";
>  > +		};
>  > +
>  > +		partition@2000000 {
>  > +			/* 96MB for Root File System */
>  > +			reg =3D <0x02000000 0x06000000>;
>  > +			label =3D "NAND Root File System";
>  > +		};
>  > +
>  > +		partition@8000000 {
>  > +			/* 3968MB for Others */
>  > +			reg =3D <0x08000000 0xF8000000>;
>  > +			label =3D "NAND Others";
>  > +		};
> =20
>  Again, what is the difference between "user area" and "others"?  I'm not
>  even sure why it needs to be separate from "root file system", but at
>  least the root filesystem should be larger given the size of the overall
>  flash.
Do you mean just merge up four partition into one "RFS"? Or merge up four p=
artition into "RFS" and "User area" is better?
> =20
>  Also please use lowercase for hex.
> =20
>  > +	};
>  > +
>  > +	cpld@2,0 {
>  > +		#address-cells =3D <1>;
>  > +		#size-cells =3D <1>;
>  > +		compatible =3D "fsl,c293pcie-cpld";
>  > +		reg =3D <0x2 0x0 0x20>;
>  > +	};
> =20
>  Remove #address-cells/#size-cells
> =20
>  > +			partition@580000 {
>  > +				/* 10.5MB for Compressed RFS Image */
>  > +				reg =3D <0x00580000 0x00a80000>;
>  > +				label =3D "SPI Flash Compressed RFSImage";
>  > +			};
> =20
>  Space before "Image".  Why specifiy that it's compressed, versus some
>  other filesystem type?
> =20
Remove all the "compressed" comments when express the RFS partition?
>  -Scott
