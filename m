Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C7DDEB7D83
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:49:59 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o4HInvUP017575
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 11:49:57 -0700 (MST)
Subject: Re: [PATCH 2/3] powerpc/fsl: 85xx: p2020rdb: add cache sram node
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1260257477-21942-2-git-send-email-vivek.mahajan@freescale.com>
Date: Mon, 17 May 2010 13:49:56 -0500
Message-Id: <9EBDE8E8-110D-4ECD-AD15-0217A6E4C5B7@freescale.com>
References: <1260257477-21942-1-git-send-email-vivek.mahajan@freescale.com>
	<1260257477-21942-2-git-send-email-vivek.mahajan@freescale.com>
To: Gupta Maneesh-B18878 <B18878@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Dec 8, 2009, at 1:31 AM, Vivek Mahajan wrote:

> Signed-off-by: Vivek Mahajan <vivek.mahajan@freescale.com>
> ---
> arch/powerpc/boot/dts/p2020rdb.dts |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p2020rdb.dts =
b/arch/powerpc/boot/dts/p2020rdb.dts
> index da4cb0d..8a26050 100644
> --- a/arch/powerpc/boot/dts/p2020rdb.dts
> +++ b/arch/powerpc/boot/dts/p2020rdb.dts
> @@ -583,4 +583,10 @@
> 				  0x0 0x100000>;
> 		};
> 	};
> +
> +	cache-sram@fff00000 {
> +		fsl,cache-sram-ctlr-handle =3D <&L2>;
> +		reg =3D <0 0xfff00000 0 0x10000>;
> +		compatible =3D "fsl,p2020-cache-sram";
> +	};
> };
> --=20
> 1.5.6.5

Sorry, we've let this sit too long:

This should be created by u-boot instead of static in the .dts.  The =
assumption should be the cache/SRAM is already setup this way via u-boot =
and its just conveying the HW config to the kernel.

In the future we should have the kernel dynamically allocate a physical =
address region for the SRAM (if its not already setup by u-boot).

- k=
