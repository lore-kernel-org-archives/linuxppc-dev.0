Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNMBd0xnFzDrgx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 05:28:24 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id hh10so9397867pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 12:28:24 -0700 (PDT)
Date: Mon, 29 Aug 2016 12:28:21 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Xavi Drudis Ferran <xdrudis@tinet.cat>, fabio.estevam@nxp.com
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@freescale.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Setting some clocks back to DUMMY fixes spdif output on imx6q
 wandboard rev B1
Message-ID: <20160829192820.GA14207@Asurada-Nvidia>
References: <20160828160055.GA2122@begut>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160828160055.GA2122@begut>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added Fabio as I can't test S/PDIF on my board.

On Sun, Aug 28, 2016 at 06:00:55PM +0200, Xavi Drudis Ferran wrote:
 
> I was using linux-libre-3.19 (implies no working sdma) with a
> wandboard quad (Freescale imx6q). Spidf output worked fine.
> 
> When I upgraded to linux-libre-4.7 spdif output was supressed without
> any error (precisely, with the same errors about sdma that 3.19 gave).
> 
> I saw someone else reporting the same elsewhere with linux-4.4
> https://forum.digikey.com/thread/34240
> (but I don't have a login there) 
> 
> This patch fixes it for me and sound works again on spdif. 
> 
> But I don't know if it can break (or fix?) something for some other
> boards or kernels or cases... I hardly know what I'm doing.

> The commits that might have caused the problem for me might be 
> 
> commit 833f2cbf7091099baee28136dc68678e974c0ac5
> Author: Shengjiu Wang <shengjiu.wang@freescale.com>
> Date:   Sat Oct 10 18:15:07 2015 +0800
> 
>     ARM: dts: imx6: change the core clock of spdif
>     
>     The correct core clock of spdif is SPDIF_GCLK, which is added to
>     clock tree. So the dts also need to be updated.
>     
>     Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
>     Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> 
> (the commit changed more clocks than SPDIF_GCLK)

Yes, it seems that it also tried to correct the clock sources
as those were not available when adding the S/PDIF support at
the first place.

> The issue is fixed for me with this patch but I'm not sure what's the
> best way to help fix any issue someone else may have or what other
> info or test you might need. Any guidance welcome. 

> --- linux-4.7-no-spdif-out/arch/arm/boot/dts/imx6qdl.dtsi	2016-07-25 00:19:43.000000000 +0200
> +++ linux-4.7/arch/arm/boot/dts/imx6qdl.dtsi	2016-08-28 17:59:14.276774409 +0200
> @@ -240,9 +240,9 @@
>  					       <&sdma 15 18 0>;
>  					dma-names = "rx", "tx";
>  					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
> -						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
> -						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
> -						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
> +						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
> +						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
> +						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
>  						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
>  					clock-names = "core",  "rxtx0",
>  						      "rxtx1", "rxtx2",

This looks like that you merely revert the SPDIF_GCLK. Would you
please do a little debug using "#define DEBUG 1" and check printk
from fsl_spdif_probe_txclk() to see the difference between before
and after Shengjiu's commit?
