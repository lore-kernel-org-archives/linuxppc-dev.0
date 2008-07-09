Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CD3DDDDF2A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 18:31:13 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 09 Jul 2008 10:31:11 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5h1w2vc9js.wl%tiwai@suse.de>
Message-ID: <20080709083111.44860@gmx.net>
MIME-Version: 1.0
References: <s5h1w2vc9js.wl%tiwai@suse.de>
Subject: Re: [PATCH 0/3] ALSA fixes for non-coherent ppc32
To: Takashi Iwai <tiwai@suse.de>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

-------- Original-Nachricht --------
> Datum: Wed, 18 Jun 2008 12:38:31 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: benh@kernel.crashing.org
> CC: linuxppc-dev@ozlabs.org, cjg@cruxppc.org
> Betreff: [PATCH 0/3] ALSA fixes for non-coherent ppc32

> Hi,
> 
> I've tried to renew the fixes of ALSA issues about non-coherent DMA
> memories.  The last patch worked for SG-buffers somehow but would
> result in a problem if many pages are allocated because of
> dma_alloc_coherent() handling.  Now, I chose a more simpler
> workaround: the SG-buffers are handled as simple continuous buffers.
> 
> This time I split the patches to several parts.  The first patch
> contains a very lazy dma_mmap_coherent() implementation for ppc32.
> The next patch adds the call of dma_mmap_coherent() for the default
> mmap of ALSA PCM.  And the last one is to add the conversion of
> SG-buffer handling as above.
> 
> The patches are created against the latest ALSA tree, and the last
> patch won't be applicable fully to 2.6.26-rc6.  But, it's only for
> snd-hda-intel and there is no PPC32 hardware supporting this, AFAIK.
> So just ignore the reject.
> 
> The patches are found also on my git tree, dma-fix branch of
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> Any comments and test reports are appreciated, especially about
> dma_mmap_coherent() addition.
I know this answer comes a little bit late, but my PPC machine was not
working for two weeks due to a hardware failure. I tested the patch on
2.6.26-rc9 and it seems to work fine so far with my emu10k soundcard.
I just had to add "#include <linux/dma-mapping.h>" to pcm_native.c.
Otherwise it wouldn't compile.

Thanks!

regards,

Gerhard

-- 
Psssst! Schon das coole Video vom GMX MultiMessenger gesehen?
Der Eine für Alle: http://www.gmx.net/de/go/messenger03
