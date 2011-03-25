Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 32CCFB6F91
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 20:12:09 +1100 (EST)
Subject: Re: [PATCH] powerpc: Implement dma_mmap_coherent()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5h62r7vd2w.wl%tiwai@suse.de>
References: <1301035806.2402.470.camel@pasglop> <s5h62r7vd2w.wl%tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 25 Mar 2011 20:11:57 +1100
Message-ID: <1301044317.2402.475.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-03-25 at 09:06 +0100, Takashi Iwai wrote:
> > @@ -52,6 +53,7 @@ extern void __dma_sync_page(struct page *page,
> unsigned long offset,
> >  #define __dma_free_coherent(size, addr)              ((void)0)
> >  #define __dma_sync(addr, size, rw)           ((void)0)
> >  #define __dma_sync_page(pg, off, sz, rw)     ((void)0)
> > +#define __dma_get_coherent_pfn(cpu_addr)     (0)
> 
> Just nitpicking: shouldn't we define some real thing like
>         page_to_pfn(virt_to_page(cpu_addr))
> or put something to trigger an error?  Setting a bogus zero can be
> easily overlooked, I'm afraid.

Yes, all those variants are bogus if you noticed :-) The trick is that
they aren't actually called when CONFIG_NOT_COHERENT_CACHE is not set
anyways, with the exception of __dma_sync(), so I want to just remove
them all. But I'll do that in a separate patch.

Cheers,
Ben.
