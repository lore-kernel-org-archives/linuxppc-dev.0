Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 32109B722D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 12:22:54 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F169DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 12:22:53 +1000 (EST)
Message-Id: <76C9B3EA-967A-4B4F-BC3A-A24942F31294@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kevin Hao <kexin.hao@windriver.com>
In-Reply-To: <1243389905.13410.6.camel@kevin>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH] powerpc/85xx: add nor flash partitions for mpc8569mds
Date: Wed, 10 Jun 2009 21:20:42 -0500
References: <1243389905.13410.6.camel@kevin>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 26, 2009, at 9:05 PM, Kevin Hao wrote:

> Add 4 partitions in nor flash. Also fix nor flash
> bank width bug.

Can you explain this.. I'm trying to understand why you set the bank- 
width to 1

- k

>
>
> Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
> ---
> arch/powerpc/boot/dts/mpc8569mds.dts |   24 +++++++++++++++++++++++-
> 1 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/mpc8569mds.dts b/arch/powerpc/ 
> boot/dts/mpc8569mds.dts
> index 39c2927..1f98990 100644
> --- a/arch/powerpc/boot/dts/mpc8569mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8569mds.dts
> @@ -70,8 +70,30 @@
> 			#size-cells = <1>;
> 			compatible = "cfi-flash";
> 			reg = <0x0 0x0 0x02000000>;
> -			bank-width = <2>;
> +			bank-width = <1>;
> 			device-width = <1>;
> +			partition@0 {
> +				label = "ramdisk";
> +				reg = <0x00000000 0x01c00000>;
> +			};
> +			partition@1c00000 {
> +				label = "kernel";
> +				reg = <0x01c00000 0x002e0000>;
> +			};
> +			partiton@1ee0000 {
> +				label = "dtb";
> +				reg = <0x01ee0000 0x00020000>;
> +			};
> +			partition@1f00000 {
> +				label = "firmware";
> +				reg = <0x01f00000 0x00080000>;
> +				read-only;
> +			};
> +			partition@1f80000 {
> +				label = "u-boot";
> +				reg = <0x01f80000 0x00080000>;
> +				read-only;
> +			};
> 		};
>
> 		bcsr@1,0 {
> -- 
> 1.6.0.4.771.gef3b3
