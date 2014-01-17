Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8BCE82C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 09:27:36 +1100 (EST)
Message-ID: <1389997642.24905.284.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/4 v2]powerpc/fsl-booke: Add support for T2080/T2081 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 17 Jan 2014 16:27:22 -0600
In-Reply-To: <1389866562-6235-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1389866562-6235-1-git-send-email-Shengzhou.Liu@freescale.com>
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

On Thu, 2014-01-16 at 18:02 +0800, Shengzhou Liu wrote:
> +	cpc: l3-cache-controller@10000 {
> +		compatible = "cache";
> +		reg = <0x10000 0x1000
> +		       0x11000 0x1000
> +		       0x12000 0x1000>;
> +		interrupts = <16 2 1 27
> +			      16 2 1 26
> +			      16 2 1 25>;
> +	};

Where's the specific compatible for this node?

> +       corenet-cf@18000 {
> +               compatible = "fsl,corenet2-cf";
> +               reg = <0x18000 0x1000>;
> +               interrupts = <16 2 1 31>;
> +               fsl,ccf-num-csdids = <32>;
> +               fsl,ccf-num-snoopids = <32>;
> +       };

"fsl,corenet2-cf" doesn't appear in any other device tree nor in any
binding.

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,qoriq-clockgen-2.0", "fixed-clock";
> +		reg = <0xe1000 0x1000>;
> +		clock-output-names = "sysclk";
> +		#clock-cells = <0>;

Please update this according to v9 of the clock binding:
In particular, sysclk goes in its own node, and compatible strings have
changed.

> +	rcpm: global-utilities@e2000 {
> +		compatible = "fsl,qoriq-rcpm-2.0";
> +		reg = <0xe2000 0x1000>;
> +	};

compatible = "fsl,t2080-rcpm-2.0", "fsl,qoriq-rcpm-2.0";

-Scott
