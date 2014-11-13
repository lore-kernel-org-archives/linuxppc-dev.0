Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 040C41A078F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 08:42:17 +1100 (AEDT)
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0131.outbound.protection.outlook.com [65.55.169.131])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D52231400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2014 08:42:14 +1100 (AEDT)
Message-ID: <1415914923.15957.64.camel@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/mpc85xx: Add DPAA Q/BMan support to device
 tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Thu, 13 Nov 2014 15:42:03 -0600
In-Reply-To: <1415870513-10632-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1415870513-10632-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Poonam Aggrwal <poonam.aggrwal@Freescale.com>, Geoff
 Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@ozlabs.org,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-13 at 03:21 -0600, Emil Medve wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760

I suspect these patches are changed quite a bit from Kumar's version...
It's good to note changes after the listed author has stopped being
involved, so they don't get the blame for anything they wouldn't have
put in there.

Why is the devicetree list not CCed?

> ---
> 
> Based on:
> 	http://patchwork.ozlabs.org/patch/407034
> 	http://patchwork.ozlabs.org/patch/407037
> 	http://patchwork.ozlabs.org/patch/407035
> 	http://patchwork.ozlabs.org/patch/407036
> 
>  arch/powerpc/boot/dts/b4qds.dtsi            |  42 +-
>  arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   2 +-
>  arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   2 +-
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 129 ++++++-
>  arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   3 +-
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 180 ++++++++-
>  arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  61 ++-
>  arch/powerpc/boot/dts/fsl/p1023si-pre.dtsi  |   2 +-
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   9 +-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   9 +-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   9 +-
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   9 +-
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   9 +-
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi | 128 ++++++-
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 216 ++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 568 +++++++++++++++++++++++++++-
>  arch/powerpc/boot/dts/kmcoge4.dts           |  40 ++
>  arch/powerpc/boot/dts/oca4080.dts           |  40 ++
>  arch/powerpc/boot/dts/p1023rdb.dts          |  43 ++-
>  arch/powerpc/boot/dts/p2041rdb.dts          |  42 +-
>  arch/powerpc/boot/dts/p3041ds.dts           |  42 +-
>  arch/powerpc/boot/dts/p4080ds.dts           |  42 +-
>  arch/powerpc/boot/dts/p5020ds.dts           |  42 +-
>  arch/powerpc/boot/dts/p5040ds.dts           |  42 +-
>  arch/powerpc/boot/dts/t104xqds.dtsi         |  42 +-
>  arch/powerpc/boot/dts/t104xrdb.dtsi         |  40 ++
>  arch/powerpc/boot/dts/t208xqds.dtsi         |  42 +-
>  arch/powerpc/boot/dts/t208xrdb.dtsi         |  40 ++
>  arch/powerpc/boot/dts/t4240qds.dts          |  42 +-
>  arch/powerpc/boot/dts/t4240rdb.dts          |  40 ++
>  30 files changed, 1930 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
> index 6188583..48c3fb4 100644
> --- a/arch/powerpc/boot/dts/b4qds.dtsi
> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> @@ -1,7 +1,7 @@
>  /*
>   * B4420DS Device Tree Source
>   *
> - * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions are met:
> @@ -38,6 +38,7 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  	interrupt-parent = <&mpic>;
> +	reserved-ranges;

I don't see reserved-ranges documented anywhere, and from the code in
arch/powerpc I don't see how it has any effect when empty.

> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		bman_fbpr: bman-fbpr {
> +			compatible = "fsl,bman-fbpr";
> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
> +			size = <0 0x1000000>;
> +			alignment = <0 0x1000000>;
> +			no-map;
> +			reusable;
> +		};
> +		qman_fqd: qman-fqd {
> +			compatible = "fsl,qman-fqd";
> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
> +			size = <0 0x400000>;
> +			alignment = <0 0x400000>;
> +			no-map;
> +			reusable;
> +		};
> +		qman_pfdr: qman-pfdr {
> +			compatible = "fsl,qman-pfdr";
> +			alloc-ranges = <0 0 0xffff 0xffffffff>;
> +			size = <0 0x2000000>;
> +			alignment = <0 0x2000000>;
> +			no-map;
> +			reusable;
> +		};
> +	};

no-map and reusable don't make sense together.  How can the OS reuse the
memory if it can't map it?

no-map is burdensome (and I believe not yet implemented) on mpc85xx,
where we want to use huge TLB entries to cover all of (low) memory.  Is
it really needed?

What do we gain from specifying reusable here?  How is it actually
supposed to work?

> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> index 86161ae..0f56263 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
> @@ -1,7 +1,7 @@
>  /*
>   * B4420 Silicon/SoC Device Tree Source (post include)
>   *
> - * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions are met:
> diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> index 338af7e..f392949 100644
> --- a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
> @@ -1,7 +1,7 @@
>  /*
>   * B4420 Silicon/SoC Device Tree Source (pre include)
>   *
> - * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2012 - 2014 Freescale Semiconductor, Inc.
>   *
>   * Redistribution and use in source and binary forms, with or without
>   * modification, are permitted provided that the following conditions are met:

Why are you updating the copyright year on files you didn't change?

-Scott
