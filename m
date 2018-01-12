Return-Path: <caleb@crome.org>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zJ8zM54R4zF0V3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jan 2018 04:35:42 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id k19so4887933pfj.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 09:35:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
From: Caleb Crome <caleb@crome.org>
Date: Fri, 12 Jan 2018 09:35:20 -0800
Message-ID: <CAG5mAdzcpHmQbFopgryhFt5j6FpGU1G5_JFQboX4iU7tsMhY_g@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 mail@maciej.szmigiero.name,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 10, 2018 at 10:42 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> ==Change log==
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
> Caleb has tested v1 with TDM lookback tests on i.MX6.
>
> Example of uncovered tests: AC97, PowerPC and FIQ.
>
> Nicolin Chen (16):
>   ASoC: fsl_ssi: Keep ssi->i2s_net updated
>   ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
>   ASoC: fsl_ssi: Maintain a mask of active streams
>   ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
>   ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
>   ASoC: fsl_ssi: Clean up helper functions of trigger()
>   ASoC: fsl_ssi: Add DAIFMT define for AC97
>   ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
>   ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
>   ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
>   ASoC: fsl_ssi: Move one-time configurations to probe()
>   ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
>   ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
>   ASoC: fsl_ssi: Remove cpu_dai_drv from fsl_ssi structure
>   ASoC: fsl_ssi: Move DT related code to a separate probe()
>   ASoC: fsl_ssi: Use ssi->streams instead of reading register
>
>  sound/soc/fsl/fsl_ssi.c | 740 ++++++++++++++++++++++++------------------------
>  1 file changed, 369 insertions(+), 371 deletions(-)
>
> --
> 2.7.4
>
Tested again, just to be sure...  All looks good.


Tested-by: Caleb Crome <caleb@crome.org>
