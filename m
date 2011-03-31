Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 6830FB6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Apr 2011 07:39:29 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Thu, 31 Mar 2011 22:39:21 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20110331203921.56030@gmx.net>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc: Implement dma_mmap_coherent()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org
Cc: tiwai@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-------- Original-Nachricht --------
> Datum: Fri, 25 Mar 2011 17:50:06 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> CC: Takashi Iwai <tiwai@suse.de>
> Betreff: [PATCH] powerpc: Implement dma_mmap_coherent()

> This is used by Alsa to mmap buffers allocated with dma_alloc_coherent()
> into userspace. We need a special variant to handle machines with
> non-coherent DMAs as those buffers have "special" virt addresses and
> require non-cachable mappings
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Dunno if anybody with CONFIG_NOT_COHERENT_CACHE has some audio device
> that uses dma buffers (ie not usb-audio) and wants to try that out...
> should fix a long standing problem.

Compilation fails here with these error messages:

>   CC      arch/powerpc/mm/dma-noncoherent.o
> arch/powerpc/mm/dma-noncoherent.c: In function ‘__dma_get_coherent_pfn’:
> arch/powerpc/mm/dma-noncoherent.c:413: error: invalid operands to binary >> (have ‘void *’ and ‘int’)
> cc1: warnings being treated as errors
> arch/powerpc/mm/dma-noncoherent.c:414: error: passing argument 2 of ‘pud_offset’ makes integer from pointer without a cast
> arch/powerpc/mm/dma-noncoherent.c:415: error: passing argument 2 of ‘pmd_offset’ makes integer from pointer without a cast
> arch/powerpc/mm/dma-noncoherent.c:416: error: invalid operands to binary >> (have ‘void *’ and ‘int’)
> make[1]: *** [arch/powerpc/mm/dma-noncoherent.o] Fehler 1
> make: *** [arch/powerpc/mm] Fehler 2

Anyway, it compiles with explicit type casts and I could test it on my
semi-noncoherent AmigaOne. So far it works just fine with the VIA onboard
sound and a Soundblaster Live PCI card.

Thanks a lot for the fix!

regards,
Gerhard

-- 
NEU: FreePhone - kostenlos mobil telefonieren und surfen!			
Jetzt informieren: http://www.gmx.net/de/go/freephone
