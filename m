Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0140.outbound.protection.outlook.com [157.56.110.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 581FD1A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 09:49:23 +1000 (AEST)
Message-ID: <1428450549.22867.487.camel@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Tue, 7 Apr 2015 18:49:09 -0500
In-Reply-To: <1428057350-33553-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1428057350-33553-1-git-send-email-Shengzhou.Liu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-03 at 18:35 +0800, Shengzhou Liu wrote:
> +	rcpm: global-utilities@e2000 {
> +		compatible = "fsl,t1023-rcpm", "fsl,qoriq-rcpm-2.0";
> +		reg = <0xe2000 0x1000>;
> +	};
> +
> +	sfp: sfp@e8000 {
> +		compatible = "fsl,t1023-sfp";
> +		reg	   = <0xe8000 0x1000>;
> +	};
> +
> +	serdes: serdes@ea000 {
> +		compatible = "fsl,t1023-serdes";
> +		reg	   = <0xea000 0x4000>;
> +	};

Consistent whitespace please.  Just one space after "reg".

> +/include/ "qoriq-esdhc-0.dtsi"
> +	sdhc@114000 {
> +		compatible = "fsl,t1023-esdhc", "fsl,esdhc";
> +		fsl,iommu-parent = <&pamu0>;
> +		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
> +		sdhci,auto-cmd12;
> +		no-1-8-v;
> +		sleep = <&rcpm 0x00000080>;

Get rid of "sleep" -- it's undocumented copy-and-paste from something
that was never finished.

-Scott
