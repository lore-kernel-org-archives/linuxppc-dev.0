Return-Path: <glikely@secretlab.ca>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E369B71F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 00:26:32 +1000 (EST)
Received: by mail-ww0-f45.google.com with SMTP id 40so3795536wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Jul 2011 07:26:32 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sat, 30 Jul 2011 22:08:19 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 2/4] powerpc, mpc52xx: add a4m072 board support
Message-ID: <20110731040819.GM24334@ponder.secretlab.ca>
References: <1308729311-15375-3-git-send-email-hs@denx.de>
	<1308739150-31527-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308739150-31527-1-git-send-email-hs@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 12:39:10PM +0200, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: devicetree-discuss@ozlabs.org
> cc: Wolfgang Denk <wd@denx.de>
> cc: Wolfram Sang <w.sang@pengutronix.de>
> ---
> For this patchseries following patch is needed:
> 
> http://patchwork.ozlabs.org/patch/91919/
> 
> Grant? Do you have some comments on that patch?
> 
> changes for v2:
>   add comment from Wolfram Sang:
>   use mpc5200.dtsi
> 
>  arch/powerpc/boot/dts/a4m072.dts             |  172 ++++++++++++++++++++++++++
>  arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
>  2 files changed, 173 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/a4m072.dts
> 
> diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
> new file mode 100644
> index 0000000..adb6746
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/a4m072.dts
> @@ -0,0 +1,172 @@
> +/*
> + * a4m072 board Device Tree Source
> + *
> + * Copyright (C) 2011 DENX Software Engineering GmbH
> + * Heiko Schocher <hs@denx.de>
> + *
> + * Copyright (C) 2007 Semihalf
> + * Marian Balakowicz <m8@semihalf.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +/include/ "mpc5200b.dtsi"

Ah, I missed this follow up patch.  Yes, this is better.

> +
> +/ {
> +	model = "anonymous,a4m072";
> +	compatible = "anonymous,a4m072";
> +
> +	soc5200@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc5200b-immr";
> +		ranges = <0 0xf0000000 0x0000c000>;
> +		reg = <0xf0000000 0x00000100>;
> +		bus-frequency = <0>; /* From boot loader */
> +		system-frequency = <0>; /* From boot loader */
> +
> +		cdm@200 {
> +			fsl,ext_48mhz_en = <0x0>;
> +			fsl,fd_enable = <0x01>;
> +			fsl,fd_counters = <0xbbbb>;

Are these new properties documented?  They need to be.  Also,
convention is to use '-' instead of '_' in property names.

> +		};
> +
> +		timer@600 {
> +			compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
> +			reg = <0x600 0x80>;
> +			interrupts = <1 9 0>;
> +			fsl,has-wdt;
> +		};

Isn't this node already in the mpc5200b.dtsi file?

Otherwise, this patch looks pretty good.

g.
