Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2201A0206
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 10:45:48 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0104.outbound.protection.outlook.com [157.56.110.104])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5339A1400F1
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 10:45:46 +1100 (AEDT)
Message-ID: <1416872736.15957.158.camel@freescale.com>
Subject: Re: [PATCH v2 3/4] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support
 to device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Mon, 24 Nov 2014 17:45:36 -0600
In-Reply-To: <1416827243-16396-4-git-send-email-Emilian.Medve@Freescale.com>
References: <1416827243-16396-1-git-send-email-Emilian.Medve@Freescale.com>
 <1416827243-16396-4-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Poonam Aggrwal <poonam.aggrwal@Freescale.com>,
 Geoff Thorpe <Geoff.Thorpe@Freescale.com>, linuxppc-dev@ozlabs.org,
 Chunhe Lan <Chunhe.Lan@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-24 at 05:07 -0600, Emil Medve wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> [Emil Medve: Sync with the upstream binding]
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>  arch/powerpc/boot/dts/b4qds.dtsi            |  20 ++-
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  60 ++++++-
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  84 ++++++++-
>  arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  30 +++-
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |   6 +-
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |   6 +-
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |   6 +-
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |   6 +-
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |   6 +-
>  arch/powerpc/boot/dts/fsl/t1040si-post.dtsi |  60 ++++++-
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 100 ++++++++++-
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 260 +++++++++++++++++++++++++++-
>  arch/powerpc/boot/dts/kmcoge4.dts           |  18 ++
>  arch/powerpc/boot/dts/oca4080.dts           |  18 ++
>  arch/powerpc/boot/dts/p1023rdb.dts          |  21 ++-
>  arch/powerpc/boot/dts/p2041rdb.dts          |  20 ++-
>  arch/powerpc/boot/dts/p3041ds.dts           |  20 ++-
>  arch/powerpc/boot/dts/p4080ds.dts           |  20 ++-
>  arch/powerpc/boot/dts/p5020ds.dts           |  20 ++-
>  arch/powerpc/boot/dts/p5040ds.dts           |  20 ++-
>  arch/powerpc/boot/dts/t104xqds.dtsi         |  20 ++-
>  arch/powerpc/boot/dts/t104xrdb.dtsi         |  18 ++
>  arch/powerpc/boot/dts/t208xqds.dtsi         |  20 ++-
>  arch/powerpc/boot/dts/t208xrdb.dtsi         |  18 ++
>  arch/powerpc/boot/dts/t4240qds.dts          |  20 ++-
>  arch/powerpc/boot/dts/t4240rdb.dts          |  18 ++
>  26 files changed, 893 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
> index 6188583..3a73103 100644
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
> @@ -104,10 +104,28 @@
>  		device_type = "memory";
>  	};
>  
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
> +		};

Again, I don't think this should have no-map.  It's not required by the
hardware, it doesn't perform as advertised on PPC and would be
burdensome to support on e500, we don't currently create a separate
coherence domain for it, and you haven't indicated that there's been any
benchmarks to show that using a separate coherence domain is beneficial.

Is there a reason why these reserved-memory nodes need to be repeated in
each board dts rather than being in a dtsi?

-Scott
