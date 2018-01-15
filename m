Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zL5ky5XV4zF0Zb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jan 2018 08:16:40 +1100 (AEDT)
Subject: Re: [PATCH v3 14/17] ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: timur@tabi.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, fabio.estevam@nxp.com, caleb@crome.org,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
References: <1515990087-11598-1-git-send-email-nicoleotsuka@gmail.com>
 <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <88551d87-1b76-9a30-6781-1d0b6479b317@maciej.szmigiero.name>
Date: Mon, 15 Jan 2018 22:16:28 +0100
MIME-Version: 1.0
In-Reply-To: <1515990087-11598-15-git-send-email-nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 15.01.2018 05:21, Nicolin Chen wrote:
> The _fsl_ssi_set_dai_fmt() is a helper function being called from
> fsl_ssi_set_dai_fmt() as an ASoC operation and fsl_ssi_hw_init()
> mainly for AC97 format initialization.
> 
> This patch cleans the _fsl_ssi_set_dai_fmt() in following ways:
> * Removing *dev pointer in the parameters as it's included in the
>   *ssi pointer of struct fsl_ssi.
> * Using regmap_update_bits() instead of regmap_read() with masking
>   the value manually.
> * Removing TXBIT0 configurations since this bit is set to 1 as its
>   reset value and there is no use case so far to unset it. And it
>   is safe to remove since regmap_update_bits() won't touch it.

I didn't get any response to a comment I've written about the point
above during the previous patch iteration:> The old code set this bit in any mode other than AC'97 (where the
> hardware always treats this bit as set regardless of the actual value).
> I would play safe here and not rely on this bit being set by a SSI
> reset on all SSI models.

Maciej

> * Moving baudclk check to the switch-case routine to skip the I2S
>   master check. And moving SxCCR.DC settings after baudclk check.
> * Adding format settings for SND_SOC_DAIFMT_AC97 like others.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> Tested-by: Caleb Crome <caleb@crome.org>
> ---
> Changelog
> v3
>  * Put CBM_CFS behind the baudclk check to keep the same program
>    flow as before
> 
>  sound/soc/fsl/fsl_ssi.c | 73 ++++++++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 40 deletions(-)
> 
