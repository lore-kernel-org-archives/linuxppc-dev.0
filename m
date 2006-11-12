Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6620067BCD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 07:38:25 +1100 (EST)
Date: Sun, 12 Nov 2006 21:38:26 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 31/32] powerpc: Merge 32 and 64 bits asm-powerpc/io.h
In-Reply-To: <20061111062552.2648A68527@ozlabs.org>
Message-ID: <Pine.LNX.4.60.0611122055580.3778@poirot.grange>
References: <20061111062552.2648A68527@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 11 Nov 2006, Benjamin Herrenschmidt wrote:

> +/* 32 bits uses slightly different variables for the various IO
> + * bases. Most of this file only uses _IO_BASE though which we
> + * define properly based on the platform
> + */
> +#ifdef CONFIG_PCI
> +#define _IO_BASE	0
> +#define _ISA_MEM_BASE	0
> +#define PCI_DRAM_OFFSET 0
> +#elif defined(CONFIG_PPC32)
> +#define _IO_BASE	isa_io_base
> +#define _ISA_MEM_BASE	isa_mem_base
> +#define PCI_DRAM_OFFSET	pci_dram_offset
> +#else
> +#define _IO_BASE	pci_io_base
> +#define _ISA_MEM_BASE	0
> +#define PCI_DRAM_OFFSET	0
> +#endif

As narrowed down by me during a git-bisect session, debugging non-working 
IDE on kuroboxHG with your patches applied, actually found by a modest IRC 
hero, wiching to remain incognito, and verified by me, that is a typo, it 
should have been

> +#ifndef CONFIG_PCI

Thanks
Guennadi
---
Guennadi Liakhovetski
