Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D1F81A06CA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 May 2014 07:17:23 +1000 (EST)
Message-ID: <1401484629.6603.216.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3 v2] powerpc/fsl-booke: Add support for T2080/T2081 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Fri, 30 May 2014 16:17:09 -0500
In-Reply-To: <1400833623-17547-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1400833623-17547-1-git-send-email-Shengzhou.Liu@freescale.com>
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

On Fri, 2014-05-23 at 16:27 +0800, Shengzhou Liu wrote:
> +	iommu@20000 {
> +		compatible = "fsl,pamu-v1.0", "fsl,pamu";
> +		reg = <0x20000 0x6000>;
> +		interrupts = <
> +			24 2 0 0
> +			16 2 1 30>;
> +	};

Please add fsl,portid-mapping here and on the CPU nodes.

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0",
> +				   "fixed-clock";
> +		reg = <0xe1000 0x1000>;
> +		clock-output-names = "sysclk";
> +		#clock-cells = <0>;

Please update this based on
Documentation/devicetree/bindings/clock/qoriq-clock.txt.

In particular, sysclk needs to go in a subnode rather than in the
global-utilities node.

-Scott
