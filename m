Return-Path: <lars@metafoo.de>
Received: from smtp-out-134.synserver.de (smtp-out-134.synserver.de
 [212.40.185.134])
 by lists.ozlabs.org (Postfix) with ESMTP id A14C11A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 18:36:40 +1000 (EST)
Message-ID: <53F30C91.7080700@metafoo.de>
Date: Tue, 19 Aug 2014 10:36:33 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shengjiu Wang <shengjiu.wang@freescale.com>
Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
 of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
 <53F22F5E.2090601@metafoo.de> <20140819074103.GA5806@audiosh1>
In-Reply-To: <20140819074103.GA5806@audiosh1>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: fabio.estevam@freescale.com, sfr@canb.auug.org.au,
 alsa-devel@alsa-project.org, timur@tabi.org, arnd@arndb.de, shc_work@mail.ru,
 tiwai@suse.de, Li.Xiubo@freescale.com, lgirdwood@gmail.com, perex@perex.cz,
 nicoleotsuka@gmail.com, broonie@kernel.org, xobs@kosagi.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2014 09:41 AM, Shengjiu Wang wrote:
> On Mon, Aug 18, 2014 at 06:52:46PM +0200, Lars-Peter Clausen wrote:
>> On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
>>> Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the following
>>> error:
>>>
>>>     sound/built-in.o: In function `fsl_sai_probe':
>>>>> fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
>>>     sound/built-in.o: In function `fsl_esai_probe':
>>>>> fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
>>>
>>> Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
>>> defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it depends
>>> on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
>>> selected.
>>> So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
>>>
>>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
>>
>> Those if conditions where just added[1] by Arnd to avoid other build
>> failures. So just removing them again makes little sense.
>>
>> As far as I can see imx_pcm_dma_init() should be stubbed out when
>> SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?
>>
>> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40260f79dc0436604452bccd449bffd25ebafb
>>
> Lars-Peter Clausen & Arnd
>
> The purpose of Arnd's patch is same with me, which is to resolve the build
> error when SND_SOC_IMX_PCM_DMA=m & SND_SOC_FSL_SSI/SAI/ESAI/SPDIF=y, the
> error is "undefined reference to `imx_pcm_dma_init'".
> But Arnd's patch didn't involve this situation that SND_IMX_SOC=n &
> SND_SOC_IMX_PCM_DMA=m.

Having SND_SOC_IMX_PCM_DMA selected if SND_IMX_SOC is not selected makes no 
sense. I think the proper fix is to find out why it is selected and make 
sure that it is not selected when SND_IMX_SOC is not selected.

>
> Currently I think out a solution for this issue is to change
>
> select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
>
> to
>
> depends on SND_SOC_IMX_PCM_DMA != m
>
> How do you think about this?

No, that has the dependencies in reverse.
