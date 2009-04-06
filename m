Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAFE7DDED1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 07:07:08 +1000 (EST)
Message-ID: <49DA6ECE.4010900@freescale.com>
Date: Mon, 06 Apr 2009 16:06:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] ASoC: fsl_dma: Pass the proper device for dma mapping
	routines
References: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
In-Reply-To: <20090404183319.GA22203@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> The driver should pass a device that specifies internal DMA ops, but
> substream->pcm is just a logical device, and thus doesn't have arch-
> specific dma callbacks, therefore following bug appears:
> 
>   Freescale Synchronous Serial Interface (SSI) ASoC Driver
>   ------------[ cut here ]------------
>   kernel BUG at arch/powerpc/include/asm/dma-mapping.h:237!
>   Oops: Exception in kernel mode, sig: 5 [#1]
>   ...
>   NIP [c02259c4] snd_malloc_dev_pages+0x58/0xac
>   LR [c0225c74] snd_dma_alloc_pages+0xf8/0x108
>   Call Trace:
>   [df02bde0] [df02be2c] 0xdf02be2c (unreliable)
>   [df02bdf0] [c0225c74] snd_dma_alloc_pages+0xf8/0x108
>   [df02be10] [c023a100] fsl_dma_new+0x68/0x124
>   [df02be20] [c02342ac] soc_new_pcm+0x1bc/0x234
>   [df02bea0] [c02343dc] snd_soc_new_pcms+0xb8/0x148
>   [df02bed0] [c023824c] cs4270_probe+0x34/0x124
>   [df02bef0] [c0232fe8] snd_soc_instantiate_card+0x1a4/0x2f4
>   [df02bf20] [c0233164] snd_soc_instantiate_cards+0x2c/0x68
>   [df02bf30] [c0234704] snd_soc_register_platform+0x60/0x80
>   [df02bf50] [c03d5664] fsl_soc_platform_init+0x18/0x28
>   ...
> 
> This patch fixes the issue by using card's device instead.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

Mark and Takashi: this patch is a must-fix for 2.6.30

-- 
Timur Tabi
Linux kernel developer at Freescale
