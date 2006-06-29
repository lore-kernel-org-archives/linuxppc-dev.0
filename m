Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id E01B067B17
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 07:15:17 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 29 Jun 2006 23:15:13 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hfyhopb0s.wl%tiwai@suse.de>
Message-ID: <20060629211513.64980@gmx.net>
MIME-Version: 1.0
References: <20060628202753.198630@gmx.net> <s5hfyhopb0s.wl%tiwai@suse.de>
Subject: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture
	and ALSA?
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, rlrevell@joe-job.com,
	alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
Datum: Thu, 29 Jun 2006 11:27:15 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?

> At Wed, 28 Jun 2006 22:27:53 +0200,
> Gerhard Pircher wrote:
> > 
> > Hi,
> > 
> > It took a little bit longer to integrate the patch, as I didn't figure
> out  first how to implement the __dma_mmap_coherent() function for PPC
> systems with CONFIG_NOT_COHERENT_CACHE defined. :)
> > 
> > Unfortunately my system still crashes within snd_pcm_mmap_data_nopage() 
> > (sound/core/pcm_native.c), as you can see below. I guess it tries to
> remap 
> > a DMA buffer allocated by the not cache coherent DMA memory allocation 
> > function in arch/ppc/kernel/dma-mapping.c.
> 
> Strange, nopage will be never called if you apply my patch and modify
> to use dma_mmap_coherent().
> 
> 
> Takashi
> 
That's indeed strange! I'm sure that the new code is called by the sound drivers. Should snd_pcm_mmap_data_nopage() not be used at all anymore, or are there any cases that could still trigger a call of snd_pcm_mmap_data_nopage()?

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
