Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10296DE0A3
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 06:19:47 +1000 (EST)
Message-ID: <468EA3DA.8070903@freescale.com>
Date: Fri, 06 Jul 2007 15:19:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PowerPC equivalent to dma_mmap_writecombine()?
References: <468D1F23.6000803@freescale.com> <200707051813.53762.arnd@arndb.de>
In-Reply-To: <200707051813.53762.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> Not sure exactly what arm does here, but it sounds like you want
> to call remap_pfn_range with the _PAGE_NO_CACHE bit set in the
> protection flags, and _PAGE_GUARDED not set.

I always have a hard time with these mapping functions.  Is this right?

vma->vm_page_prot = __pgprot((pgprot_val(vma->vm_page_prot) | _PAGE_NO_CACHE) & 
~_PAGE_GUARDED));

ret = remap_pfn_range(vma, vma->vm_start, runtime->dma_addr, runtime->dma_bytes, 
vma->vm_page_prot);

Alternatively, could I use function snd_pcm_lib_mmap_iomem() (sound/core/pcm_native.c)? 
It looks like it does the right thing, although it doesn't unset the guarded bit.  If 
that's wrong, I can submit a patch to unset that bit on PowerPC, but like I said, I can 
never quite get my head around this mapping stuff.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
