Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2DA29B70C9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 07:42:31 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1EDA0DDDF0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 07:42:29 +1000 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 23 Jun 2009 23:42:24 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090623085554.9200@gmx.net>
Message-ID: <20090623214224.104620@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<s5h8wjkoi70.wl%tiwai@suse.de> <20090623085554.9200@gmx.net>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: benh@kernel.crashing.org, tiwai@suse.de
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 23 Jun 2009 10:55:54 +0200
> Von: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> An: Takashi Iwai <tiwai@suse.de>, benh@kernel.crashing.org
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> 
> -------- Original-Nachricht --------
> > Datum: Mon, 22 Jun 2009 09:12:35 +0200
> > Von: Takashi Iwai <tiwai@suse.de>
> > An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> > Betreff: Re: ALSA fixes for non-coherent ppc32 again
> 
> > But, it'd be helpful if someone can test the patches above beforehand,
> > of course :)
> Okay, I checked out your test/dma-fix branch and reformatted your
> dma_mmap_coherent for powerpc patch (
> http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027 ) to
> adapt it for dma_mapping_ops (please take a look at the patch below).
> I also had to change "def_bool n" to "def_bool y" for SND_NONCOHERENT_DMA
> to actually enable it.
> 
> Unfortunately the build process stops with these error messages here
> (but compiles fine, if SND_COHERENT_DMA is not selected):
> 
>   CC [M]  sound/core/memalloc.o
>   CC [M]  sound/core/sgbuf.o
> sound/core/sgbuf.c: In function ‘snd_free_sgbuf_pages’:
> sound/core/sgbuf.c:46: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:47: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:48: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:50: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:51: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:52: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:56: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:57: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c: In function ‘snd_malloc_sgbuf_pages’:
> sound/core/sgbuf.c:78: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:81: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:82: error: implicit declaration of function
> ‘snd_sgbuf_aligned_pages’
> sound/core/sgbuf.c:83: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:84: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:84: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:87: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:88: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:91: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:103: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:107: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:112: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:113: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:115: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:116: error: increment of pointer to unknown structure
> sound/core/sgbuf.c:116: error: arithmetic on pointer to an incomplete type
> sound/core/sgbuf.c:121: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:127: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:128: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:128: error: dereferencing pointer to incomplete type
> sound/core/sgbuf.c:132: error: dereferencing pointer to incomplete type
> 
> I also tried to compile it with the orginal dma_mmap_coherent for
> powerpc patch, but that doesn't make a difference.
> 
> As the next step I applied the reformatted dma_mmap_coherent patch and
> the following patches from your test/dma-fix branch to a 2.6.30-rc8
> branch:
> - ALSA: Remove old DMA-mmap code from arm/devdma.c
> - ALSA: Fix SG-buffer DMA with non-coherent architectures
> - ALSA: Fix mapping of DMA buffers
> 
> This one compiled fine, but ALSA didn't work. No kernel oops, just the
> sound of silence. :)
Okay, that's wrong. I somehow messed up the .config file. It doesn't
compile, too.

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
