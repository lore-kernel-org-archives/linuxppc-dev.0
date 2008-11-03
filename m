Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BEE5BDDEDE
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:02:26 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id mA3K2Hdq010944
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 15:02:17 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mA3K11Ji043698
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 15:01:01 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mA3K0oiI027297
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Nov 2008 15:00:51 -0500
Date: Mon, 3 Nov 2008 15:00:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 1/2] powerpc: add 16K/64K pages support for the 44x
	PPC32 architectures.
Message-ID: <20081103150055.70bd7360@zod.rchland.ibm.com>
In-Reply-To: <1225742121.24019.9.camel@localhost.localdomain>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<1224123753-20907-2-git-send-email-yanok@emcraft.com>
	<48FF3889.2030304@linux.vnet.ibm.com>
	<fb412d760810311623i2b0f93a3r5aa0eb297e154b4a@mail.gmail.com>
	<20081101113018.GA13646@zod.rchland.ibm.com>
	<1225576502.8004.222.camel@pasglop>
	<20081102134153.GA1029@zod.rchland.ibm.com>
	<1225661596.8004.226.camel@pasglop>
	<20081102193307.32d17e62@zod.rchland.ibm.com>
	<1225673034.8004.239.camel@pasglop>
	<1225742121.24019.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>,
	linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 03 Nov 2008 13:55:21 -0600
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> On Mon, 2008-11-03 at 11:43 +1100, Benjamin Herrenschmidt wrote:
> > > Cropping the size of the memory node.  That was simplest to do from the
> > > cuboot wrapper at the time.  If marking it reserved via a reserve map
> > > is more elegant and correct, we could do that.
> > > 
> > > But I will still like to know what about the other way is hairy please.
> > 
> > I don't like it :-) Bad feeling ... don't like having a memory
> > node entry that isn't aligned to some large power of two typically.
> 
> More specifically, mm/bootmem.c seems to be making the implicit
> assumption that memory size is an even multiple of PAGE_SIZE. With 4K
> pages, 0xffff000 bytes of RAM fits; with 64K pages it does not.

Hmm..  I dunno what to think about that.  Again, how does mem= play
into this?  (I will look myself in a bit, but if someone knows offhand
that would be nice..)

> Using the device tree reserve map stuff does indeed seem to solve the
> problem. However, I really don't understand the layering in
> arch/powerpc/boot at all, so I'll just put this patch out here and
> people can play with wrappers and prototypes all they want:

This actually looks pretty nice.  I'll wait for David to Ack the fdt
parts.

josh

> powerpc/4xx: work around CHIP11 errata in a more PAGE_SIZE-friendly way
> 
> The current CHIP11 errata truncates the device tree memory node, and assumes a
> 4K page size. This breaks kernels with non-4K PAGE_SIZE.
> 
> Instead, use a device tree memory reservation to reserve only the 256 bytes
> actually affected by the errata, leaving the total memory size unaltered.
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
> 
> diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
> --- a/arch/powerpc/boot/4xx.c
> +++ b/arch/powerpc/boot/4xx.c
> @@ -21,7 +21,7 @@
>  #include "reg.h"
>  #include "dcr.h"
> 
> -static unsigned long chip_11_errata(unsigned long memsize)
> +static void chip_11_errata(unsigned long memsize)
>  {
>  	unsigned long pvr;
> 
> @@ -31,13 +31,11 @@ static unsigned long chip_11_errata(unsi
>  		case 0x40000850:
>  		case 0x400008d0:
>  		case 0x200008d0:
> -			memsize -= 4096;
> +			fdt_reserve_mem(memsize - 256, 256);
>  			break;
>  		default:
>  			break;
>  	}
> -
> -	return memsize;
>  }
> 
>  /* Read the 4xx SDRAM controller to get size of system memory. */
> @@ -53,7 +51,7 @@ void ibm4xx_sdram_fixup_memsize(void)
>  			memsize += SDRAM_CONFIG_BANK_SIZE(bank_config);
>  	}
> 
> -	memsize = chip_11_errata(memsize);
> +	chip_11_errata(memsize);
>  	dt_fixup_memory(0, memsize);
>  }
> 
> @@ -219,7 +217,7 @@ void ibm4xx_denali_fixup_memsize(void)
>  		bank = 4; /* 4 banks */
> 
>  	memsize = cs * (1 << (col+row)) * bank * dpath;
> -	memsize = chip_11_errata(memsize);
> +	chip_11_errata(memsize);
>  	dt_fixup_memory(0, memsize);
>  }
> 
> diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
> --- a/arch/powerpc/boot/libfdt-wrapper.c
> +++ b/arch/powerpc/boot/libfdt-wrapper.c
> @@ -167,6 +167,11 @@ static unsigned long fdt_wrapper_finaliz
>  	return (unsigned long)fdt;
>  }
> 
> +int fdt_reserve_mem(unsigned long addr, unsigned long bytes)
> +{
> +	return fdt_add_mem_rsv(fdt, addr, bytes);
> +}
> +
>  void fdt_init(void *blob)
>  {
>  	int err;
> diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
> --- a/arch/powerpc/boot/ops.h
> +++ b/arch/powerpc/boot/ops.h
> @@ -83,6 +83,7 @@ extern struct loader_info loader_info;
> 
>  void start(void);
>  void fdt_init(void *blob);
> +int fdt_reserve_mem(unsigned long addr, unsigned long bytes);
>  int serial_console_init(void);
>  int ns16550_console_init(void *devp, struct serial_console_data *scdp);
>  int mpsc_console_init(void *devp, struct serial_console_data *scdp);
> 
> 
