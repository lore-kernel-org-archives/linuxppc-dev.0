Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1FFFE140089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Apr 2014 08:42:47 +1100 (EST)
Message-ID: <1396388556.32034.17.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/3] powerpc/fsl-booke: Add support for T2080/T2081 SoC
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Date: Tue, 1 Apr 2014 16:42:36 -0500
In-Reply-To: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
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

On Mon, 2014-03-03 at 17:50 +0800, Shengzhou Liu wrote:
> +	corenet-cf@18000 {
> +		compatible = "fsl,corenet-cf";
> +		reg = <0x18000 0x1000>;
> +		interrupts = <16 2 1 31>;
> +		fsl,ccf-num-csdids = <32>;
> +		fsl,ccf-num-snoopids = <32>;
> +	};

This is not compatible with "fsl,corenet-cf".

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0";
> +		reg = <0xe1000 0x1000>;
> +	};

See Documentation/devicetree/bindings/clock/corenet-clock.txt

> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/*
> +		 * Temporarily add next-level-cache info in each cpu node so
> +		 * that uboot can do L2 cache fixup. This can be removed once
> +		 * u-boot can create cpu node with cache info.
> +		 */

Is there a reason why this is temporary?  What do we gain from U-Boot
doing the fixup?  Is U-Boot doing the rest of the fixup (adding ePAPR
properties to the L2 cache nodes)?

-Scott
