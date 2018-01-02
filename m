Return-Path: <caleb@crome.org>
Received: from mail-pg0-x22a.google.com (mail-pg0-x22a.google.com
 [IPv6:2607:f8b0:400e:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zB9H75mnZzDqvT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 10:28:34 +1100 (AEDT)
Received: by mail-pg0-x22a.google.com with SMTP id f18so2703pga.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jan 2018 15:28:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
From: Caleb Crome <caleb@crome.org>
Date: Tue, 2 Jan 2018 15:28:11 -0800
Message-ID: <CAG5mAdxBOvrE3U-PAZVKepZfTZc91kKOLrC_UoMnBsoZvJ9hyA@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] ASoC: fsl_ssi: Clean up - program flow level
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 mail@maciej.szmigiero.name,
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

On Tue, Dec 19, 2017 at 9:00 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
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
> Example of uncovered tests: TDM, AC97, PowerPC and FIQ.
>
> Nicolin Chen (15):
>   ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
>   ASoC: fsl_ssi: Maintain a mask of active streams
>   ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
>   ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
>   ASoC: fsl_ssi: Clean up helper functions of trigger()
>   ASoC: fsl_ssi: Add DAIFMT define for AC97
>   ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
>   ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
>   ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
>   ASoC: fsl_ssi: Move one-time configurations to dai_probe()
>   ASoC: fsl_ssi: Setup AC97 in dai_probe()
>   ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
>   ASoC: fsl_ssi: Remove cpu_dai_drv from fsl_ssi structure
>   ASoC: fsl_ssi: Move DT related code to a separate probe()
>   ASoC: fsl_ssi: Use ssi->streams instead of reading register
>
>  sound/soc/fsl/fsl_ssi.c | 710 ++++++++++++++++++++++++------------------------
>  1 file changed, 348 insertions(+), 362 deletions(-)
>
> --
> 2.7.4
>

tested this patch set on MX6 SSI against broonie for-next (4.15-rc5),
no problems.
Do I send a separate Tested-by for each patch, or just the 00/15 one?



Tested-by: Caleb Crome <caleb@crome.org>
