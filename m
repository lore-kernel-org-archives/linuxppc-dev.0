Return-Path: <lars@metafoo.de>
Received: from smtp-out-047.synserver.de (smtp-out-050.synserver.de
 [212.40.185.50])
 by lists.ozlabs.org (Postfix) with ESMTP id F3EF21A003A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 03:04:30 +1000 (EST)
Message-ID: <53F22F5E.2090601@metafoo.de>
Date: Mon, 18 Aug 2014 18:52:46 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shengjiu Wang <shengjiu.wang@freescale.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.de,
 nicoleotsuka@gmail.com, Li.Xiubo@freescale.com, shc_work@mail.ru,
 fabio.estevam@freescale.com, xobs@kosagi.com, arnd@arndb.de,
 sfr@canb.auug.org.au, timur@tabi.org
Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
 of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
In-Reply-To: <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
> Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the following
> error:
>
>     sound/built-in.o: In function `fsl_sai_probe':
>>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
>     sound/built-in.o: In function `fsl_esai_probe':
>>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
>
> Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
> defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it depends
> on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
> selected.
> So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Those if conditions where just added[1] by Arnd to avoid other build 
failures. So just removing them again makes little sense.

As far as I can see imx_pcm_dma_init() should be stubbed out when 
SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?

[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40260f79dc0436604452bccd449bffd25ebafb
