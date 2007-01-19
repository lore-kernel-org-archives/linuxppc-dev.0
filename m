Return-Path: <niklaus.giger@member.fsf.org>
Received: from smtp.hispeed.ch (mxout.hispeed.ch [62.2.95.247])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 29CBEDDE23
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 07:47:33 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: "- Reyneke" <reynekejunk@hotmail.com>
Subject: Re: Howto use PPC4xx memory to memory DMA
Date: Fri, 19 Jan 2007 21:47:27 +0100
References: <BAY7-F81C4E9CDFE4D0599271E7BEA90@phx.gbl>
In-Reply-To: <BAY7-F81C4E9CDFE4D0599271E7BEA90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701192147.27340.niklaus.giger@member.fsf.org>
Cc: linuxppc-embedded@ozlabs.org
Reply-To: niklaus.giger@member.fsf.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Freitag, 19. Januar 2007 10:35 schrieb - Reyneke:
> Ooh - and the 3d thing - cache coherence. I.e.:
>
> 	dma_cache_inv((u32)mem, (u32)nBytes);
>
> >>Here are a few things to check:
Thanks a lot for your tips. First I called
a) __get_free_pages(GFP_KERNEL | GFP_DMA, get_order(size));
for the source and destination address.
Then before calling ppc4xx_enable_dma I added
b) ppc4xx_set_src_addr(DMA_NR, virt_to_bus(src));
c) ppc4xx_set_src_addr(DMA_NR, virt_to_bus(dst));
d) flush_dcache_all(); 
With these changes I got at least one byte copied. After fixing the 
ppc4xx_enable_dma everything worked fine. (Patch posted a few minutes ago.)

Did you manage to use DMA on PLB peripheral bus on a memory mapped dev? I 
think there one should also increment the source or destination address. But 
I have no example HW/code at hand to test these two cases too.

Best regards
-- 
Niklaus Giger
