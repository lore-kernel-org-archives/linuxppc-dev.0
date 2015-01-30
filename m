Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448211A0D01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 12:24:59 +1100 (AEDT)
Date: Thu, 29 Jan 2015 19:24:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [1/4] powerpc/fsl-booke: Add device tree support for T1024/T1023
 SoC
Message-ID: <20150130012444.GB19864@home.buserror.net>
References: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1422517947-28722-1-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 29, 2015 at 03:52:24PM +0800, Shengzhou Liu wrote:
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"

t1023 has only three i2c controllers -- where do you disable the fourth? 

> +/include/ "t1023si-post.dtsi"
> +
> +/ {
> +	aliases {
> +		vga = &display;
> +		display = &display;
> +	};
> +};
> +
> +&soc {
> +	display:display@180000 {
> +		compatible = "fsl,t1024-diu", "fsl,diu";
> +		reg = <0x180000 1000>;
> +		interrupts = <74 2 0 0>;
> +	};
> +};

There are other differences between t1023 an t1024.  Where do you
describe t1024's QE?  Where do you describe the DDR and IFC differences? 
Ccan they be detected at runtime?  t1024 supports deep sleep, but t1023
doesn't -- yet you label both chips as having t1024 rcpm.

-Scott
