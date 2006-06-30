Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id A2C3667B5E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Jul 2006 04:21:46 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 30 Jun 2006 20:21:44 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hwtaz9fdr.wl%tiwai@suse.de>
Message-ID: <20060630182144.27980@gmx.net>
MIME-Version: 1.0
References: <20060628202753.198630@gmx.net>	<s5hfyhopb0s.wl%tiwai@suse.de>
	<20060629211513.64980@gmx.net> <s5hwtaz9fdr.wl%tiwai@suse.de>
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
Datum: Fri, 30 Jun 2006 11:12:00 +0200
Von: Takashi Iwai <tiwai@suse.de>
An: Gerhard Pircher <gerhard_pircher@gmx.net>
Betreff: Re: [Alsa-devel] RFC: dma_mmap_coherent() for powerpc/ppc architecture and ALSA?
> 
> What is the type of buffer are you using?  If it's a buffer
> pre-allocated via snd_pcm_lib_preallocate*() with SNDRV_DMA_TYPE_DEV,
> there should be no snd_pcm_mmap_data_nopage call.  For other types,
> there can be.  For example, the patch still doesn't solve the problems
> with drivers using sg-buffer.
> 
I added a debug output and it shows a buffer of SNDRV_DMA_TYPE_DEV_SG type. Well, then I'll hack the kernel to use the normal DMA allocation functions for ALSA instead of the non cache coherent ones and will wait until the ALSA core has been adapted for dma_mmap_coherent().

Or what would have to be done to get it working for SG buffers?

Thanks!

Gerhard

-- 


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
Ideal für Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
