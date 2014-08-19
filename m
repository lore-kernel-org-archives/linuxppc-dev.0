Return-Path: <shengjiu.wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0144.outbound.protection.outlook.com [207.46.163.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 298B41A00C7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 18:21:22 +1000 (EST)
Date: Tue, 19 Aug 2014 16:21:09 +0800
From: Shengjiu Wang <shengjiu.wang@freescale.com>
To: Xiubo Li-B47053 <Li.Xiubo@freescale.com>
Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove
 dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
Message-ID: <20140819082108.GB5806@audiosh1>
References: <cover.1408350626.git.shengjiu.wang@freescale.com>
 <f30ba4e2c4eb6702fa40bd255036e6e9ad6eb47d.1408350626.git.shengjiu.wang@freescale.com>
 <53F22F5E.2090601@metafoo.de> <20140819074103.GA5806@audiosh1>
 <d7b06608abcc4f098789f63cb9f36eef@BN1PR0301MB0609.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <d7b06608abcc4f098789f63cb9f36eef@BN1PR0301MB0609.namprd03.prod.outlook.com>
Cc: Estevam Fabio-R49496 <Fabio.Estevam@freescale.com>,
 "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Lars-Peter Clausen <lars@metafoo.de>, "timur@tabi.org" <timur@tabi.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "shc_work@mail.ru" <shc_work@mail.ru>,
 "tiwai@suse.de" <tiwai@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, "xobs@kosagi.com" <xobs@kosagi.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 04:13:15PM +0800, Xiubo Li-B47053 wrote:
> > Subject: Re: [alsa-devel] [PATCH V1 1/3] ASoC: fsl: Kconfig: remove dependence
> > of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA
> > 
> > On Mon, Aug 18, 2014 at 06:52:46PM +0200, Lars-Peter Clausen wrote:
> > > On 08/18/2014 10:38 AM, Shengjiu Wang wrote:
> > > >Build kernel with SND_SOC_IMC_PCM_DMA=m && SND_IMX_SOC=n leads the
> > following
> > > >error:
> > > >
> > > >    sound/built-in.o: In function `fsl_sai_probe':
> > > >>>fsl_sai.c:(.text+0x5f662): undefined reference to `imx_pcm_dma_init'
> > > >    sound/built-in.o: In function `fsl_esai_probe':
> > > >>>fsl_esai.c:(.text+0x6044b): undefined reference to `imx_pcm_dma_init'
> > > >
> > > >Most cpu driver in soc/fsl has use the function 'imx_pcm_dma_init' which is
> > > >defined in imx-pcm-dma.c, so need to select SND_SOC_IMX_PCM_DMA, but it
> > depends
> > > >on SND_IMX_SOC, if SND_IMX_SOC=n, then SND_SOC_IMX_PCM_DMA will not be
> > > >selected.
> > > >So remove the dependence of SND_IMX_SOC for SND_SOC_IMX_PCM_DMA.
> > > >
> > > >Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > > >Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
> > >
> > > Those if conditions where just added[1] by Arnd to avoid other build
> > > failures. So just removing them again makes little sense.
> > >
> > > As far as I can see imx_pcm_dma_init() should be stubbed out when
> > > SND_SOC_IMX_PCM_DMA is not selected. So what's going on here?
> > >
> > > [1]
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=ff40
> > 260f79dc0436604452bccd449bffd25ebafb
> > >
> > Lars-Peter Clausen & Arnd
> > 
> > The purpose of Arnd's patch is same with me, which is to resolve the build
> > error when SND_SOC_IMX_PCM_DMA=m & SND_SOC_FSL_SSI/SAI/ESAI/SPDIF=y, the
> > error is "undefined reference to `imx_pcm_dma_init'".
> > But Arnd's patch didn't involve this situation that SND_IMX_SOC=n &
> > SND_SOC_IMX_PCM_DMA=m.
> > 
> > Currently I think out a solution for this issue is to change
> > 
> > select SND_SOC_IMX_PCM_DMA if SND_IMX_SOC != n
> > 
> > to
> > 
> > depends on SND_SOC_IMX_PCM_DMA != m
> > 
> > How do you think about this?
> > 
> 
> What will happen if to build both SAI/ESAI and IMX_PCM_DMA as modules at the same
> time ?
> 
> Thanks,
> 
> BRs
> Xiubo

I didn't find error/warning when SAI/ESAI and IMX_PCM_DMA are as modules. The 
build is successful.

> 
> 
> > best regards
> > Wang shengjiu
