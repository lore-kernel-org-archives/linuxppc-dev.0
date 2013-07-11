Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DD272C0350
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 06:34:34 +1000 (EST)
Date: Thu, 11 Jul 2013 15:34:18 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2 V4] powerpc/85xx: add the P1020RDB-PD DTS support
To: Haijun Zhang <Haijun.Zhang@freescale.com>
In-Reply-To: <1373423097-27866-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Tue Jul  9 21:24:57 2013)
Message-ID: <1373574858.8183.267@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, AFLEMING@freescale.com,
 Haijun Zhang <Haijun.Zhang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 09:24:57 PM, Haijun Zhang wrote:
> +		nand@1,0 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,p1020-fcm-nand",
> +				     "fsl,elbc-fcm-nand";
> +			reg =3D <0x1 0x0 0x40000>;
> +
> +			partition@0 {
> +				/* This location must not be altered  */
> +				/* 1MB for u-boot Bootloader Image */
> +				reg =3D <0x0 0x00100000>;
> +				label =3D "NAND U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition@100000 {
> +				/* 1MB for DTB Image */
> +				reg =3D <0x00100000 0x00100000>;
> +				label =3D "NAND DTB Image";
> +			};
> +
> +			partition@200000 {
> +				/* 4MB for Linux Kernel Image */
> +				reg =3D <0x00200000 0x00400000>;
> +				label =3D "NAND Linux Kernel Image";
> +			};
> +
> +			partition@600000 {
> +				/* 96MB for File System Image */
> +				reg =3D <0x00600000 0x06000000>;
> +				label =3D "NAND FILE System Image";
> +			};

This accounts for 102 MiB of the flash.  The rest is just unused?  Why =20
not increase the filesystem partition?

Also, why capitalize "FILE"?

> +		spi@7000 {
> +			flash@0 {
> +				#address-cells =3D <1>;
> +				#size-cells =3D <1>;
> +				compatible =3D "spansion,s25sl12801";
> +				reg =3D <0>;
> +				/* input clock */
> +				spi-max-frequency =3D <40000000>;
> +
> +				partition@0 {
> +					/* 512KB for u-boot Bootloader =20
> Image */
> +					reg =3D <0x0 0x00080000>;
> +					label =3D "SPI U-Boot Image";
> +					read-only;
> +				};
> +
> +				partition@80000 {
> +					/* 512KB for DTB Image*/
> +					reg =3D <0x00080000 0x00080000>;
> +					label =3D "SPI DTB Image";
> +				};
> +
> +				partition@100000 {
> +					/* 4MB for Linux Kernel Image */
> +					reg =3D <0x00100000 0x00400000>;
> +					label =3D "SPI Linux Kernel =20
> Image";
> +				};
> +
> +				partition@500000 {
> +					/* 7MB for FS System Image */
> +					reg =3D <0x00500000 0x00700000>;
> +					label =3D "SPI File System Image";
> +				};
> +			};

Likewise.

-Scott=
