Return-Path: <caleb@crome.org>
Received: from mail-pg0-x22f.google.com (mail-pg0-x22f.google.com
 [IPv6:2607:f8b0:400e:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM9jx4GcFzF0VR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 02:19:32 +1100 (AEDT)
Received: by mail-pg0-x22f.google.com with SMTP id 136so10868248pgd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 07:19:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
References: <1516171902-32669-1-git-send-email-nicoleotsuka@gmail.com>
From: Caleb Crome <caleb@crome.org>
Date: Wed, 17 Jan 2018 07:19:09 -0800
Message-ID: <CAG5mAdxS1NBf8zqRWZgjHvs5L63Ze3Tgeehx+v5YRoYxZevr3Q@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] ASoC: fsl_ssi: Clean up - program flow level
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

On Tue, Jan 16, 2018 at 10:51 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
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
>
> Nicolin Chen (17):
>   ASoC: fsl_ssi: Redefine RX and TX macros
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
>   ASoC: fsl_ssi: Add bool synchronous to mark synchronous mode
>   ASoC: fsl_ssi: Move DT related code to a separate probe()
>   ASoC: fsl_ssi: Use ssi->streams instead of reading register
>
>  sound/soc/fsl/fsl_ssi.c | 756 +++++++++++++++++++++++++-----------------------
>  sound/soc/fsl/fsl_ssi.h |   3 -
>  2 files changed, 395 insertions(+), 364 deletions(-)
>
> --
> 2.7.4
>
tested v5.

No problems,
 -Caleb
