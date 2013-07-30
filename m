Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92A712C00BD
 for <linuxppc-dev@ozlabs.org>; Wed, 31 Jul 2013 04:29:30 +1000 (EST)
Date: Tue, 30 Jul 2013 13:29:22 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: Add C293PCIE board support
To: Po Liu <Po.Liu@freescale.com>
References: <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-1-git-send-email-Po.Liu@freescale.com>
 <1375174163-19246-3-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1375174163-19246-3-git-send-email-Po.Liu@freescale.com> (from
 Po.Liu@freescale.com on Tue Jul 30 03:49:23 2013)
Message-ID: <1375208962.30721.75@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/30/2013 03:49:23 AM, Po Liu wrote:
> +	nand@1,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,ifc-nand";
> +		reg =3D <0x1 0x0 0x10000>;
> +
> +		partition@0 {
> +			/* This location must not be altered  */
> +			/* 1MB for u-boot Bootloader Image */
> +			reg =3D <0x0 0x00100000>;
> +			label =3D "NAND U-Boot Image";
> +			read-only;
> +		};
> +
> +		partition@100000 {
> +			/* 1MB for DTB Image */
> +			reg =3D <0x00100000 0x00100000>;
> +			label =3D "NAND DTB Image";
> +		};
> +
> +		partition@200000 {
> +			/* 4MB for Linux Kernel Image */
> +			reg =3D <0x00200000 0x00400000>;
> +			label =3D "NAND Linux Kernel Image";
> +		};
> +
> +		partition@600000 {
> +			/* 4090MB for Root file System Image */
> +			reg =3D <0x00600000 0xffa00000>;
> +			label =3D "NAND RFS Image";
> +		};
> +	};

Might want to leave a bit more room for the kernel image, given the =20
size of NAND.

-Scott=
