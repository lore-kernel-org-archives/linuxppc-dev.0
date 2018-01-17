Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMHTK5cN5zF0gs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 06:38:59 +1100 (AEDT)
Subject: Re: [PATCH v5 00/17] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <a6621849-2621-79ee-c8a4-09e23beea2c5@maciej.szmigiero.name>
Date: Wed, 17 Jan 2018 20:38:48 +0100
MIME-Version: 1.0
In-Reply-To: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17.01.2018 07:51, Nicolin Chen wrote:
> [ Maciej, could you please send your Tested-by/Reviewed-by for AC97
>   once you confirm this series?
>   
>   And Caleb, this version does not need a test for non-AC97 cases.
> 
>   Thanks both! ]
> 
> ==Change log==
> v5
>  * Reworked the series by taking suggestions from Maciej for AC97
>   + Fixed SSI lockup issue by changing cleanup sequence in PATCH-13
>   + Moved fsl_ssi_hw_clean() after unregistering the CODEC device
>     in PATCH-13
>   + Set NULL as the parent of CODEC platform device to fix a NULL
>     pointer dereference bug in PATCH-16
>  * Updated comments of three variables/pointers in struct fsl_ssi
>    to describe them more accurately in PATCH-16
> v4
>  * Reworked the series by taking suggestions from Maciej
>   + Added TXBIT0 bit back to play safe in PATCH-14
>   + Made bool synchronous exclusive with AC97 mode in PATCH-16
> v3
>  * Reworked the series by taking suggestions from Maciej
>   + Added PATCH-01 to make RX and TX more clearly defined
>   + Replaced "bool dir" with "int dir" in PATCH-04
>   + Replaced "!dir" with "int adir" in PATCH-05
>   + Put CBM_CFS behind the baudclk check to keep the same
>     program flow in PATCH-14
>   + Removed all cpu_dai_drv changes in PATCH-15
> v2
>  * Reworked the series by taking suggestions from Maciej
>   + Added PATCH-01 to keep all ssi->i2s_net updated
>   + Replaced bool tx with bool dir in PATCH-03 and PATCH-06
>   + Moved all initial register configurations from dai probe() to
>     platform probe() so as to let AC97 CODEC successfully probe.
>  * Added Tested-by from Caleb for TDM test cases.
> 
> ==Background==
> The fsl_ssi driver was designed for PPC originally and then it has
> been updated to support different modes for i.MX Series, including
> SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
> contributors for different use cases in different coding styles.
> 
> Additionally, in order to fix/work-around hardware bugs and design
> flaws, the driver made a lot of compromise so now its program flow
> looks very complicated and it's getting hard to maintain or update.
> 
> So I am going to clean up the driver on both coding style level and
> program flow level.
> 
> ==Introduction==
> This series of patches is the second set to clean up fsl_ssi driver
> in the program flow level. Any patch here may impact a fundamental
> test case like playback or record.
> 
> ==Verification==
> This series of patches require fully tested. I have done such tests
> on i.MX6SoloX with WM8962 using imx_v6_v7_defconfig as:
>  - Playback via I2S Master and Slave mode
>  - Record via I2S Master and Slave mode
>  - Simultaneous playback and record via I2S Master and Slave mode
>  - Background playback with foreground record (starting at different
>    time) via I2S Master and Slave mode
>  - Background record with foreground playback (starting at different
>    time) via I2S Master and Slave mode
>  * All tests above by hacking offline_config to true in imx51.
> 
> Caleb has tested v1-v4 with TDM lookback tests on i.MX6.
> 
> Example of uncovered tests: AC97, PowerPC and FIQ.

For the whole series:
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

However, I have a small nitpick regarding a comment newly added in
this version of patch 16:
+		/*
+		 * Do not set SSI dev as the parent of AC97 CODEC device since
+		 * it does not have a DT node. Otherwise ASoC core will assume
+		 * CODEC has the same DT node as the SSI, so it may return a
+		 * NULL pointer of CODEC when asked for SSI via the DT node

The second part of the last sentence isn't really true, the ASoC core
will return a (valid, non-NULL) CODEC object pointer when asked for
the SSI one if we set the SSI as the parent device of a AC'97 CODEC
platform device.

The NULL pointer dereference when starting a playback that I wrote
about in my previous message happens because in this situation the SSI
DAI probe callback won't ever get called and so won't setup DMA data
pointers (they will remain NULL).
And this in turn will cause the ASoC DMA code to dereference these
NULL pointers when starting a playback (the same will probably happen
also when starting a capture).

Sorry if I wasn't 100% clear about these details in my previous
message describing this issue.

Maciej
