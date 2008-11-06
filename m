Return-Path: <dgibson@ozlabs.org>
Date: Thu, 6 Nov 2008 11:16:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] powerpc/boot: allocate more memory for dtb
Message-ID: <20081106001646.GD28465@yookeroo.seuss>
References: <20080923203857.GB10935@www.tglx.de>
	<200809240146.m8O1kIpZ077447@sullivan.realtime.net>
	<20080925214357.GA2929@www.tglx.de>
	<1223611088.8157.144.camel@pasglop>
	<20081013091526.GA9925@www.tglx.de>
	<20081014015753.GD20620@yookeroo.seuss>
	<20081014020004.GE20620@yookeroo.seuss>
	<20081101200056.GA23385@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081101200056.GA23385@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 01, 2008 at 09:00:56PM +0100, Sebastian Andrzej Siewior wrote:
> * David Gibson | 2008-10-14 13:00:04 [+1100]:
> 
> >Oh, one other thing.  Since we are now unconditionally copying the dtb
> >into a malloc()ed buffer, possibly it would be sensible to add a
> >little padding to the buffer at that point, so that further device
> >tree manipulations won't need to reallocate it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Looks fine.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Haven't notice earlier that the other patch went mainline.
> EXPAND_GRANULARITY is 1KiB and it is used in expand_buf() if the buffer
> has to be increased. I hope that is okay.
> 
> All other platforms except prpmc2800 are passing the dtb to fdt_init().
> prpmc2800 is reallocating the dtb to a malloced area. I thing I can
> remove that part since fdt_init() is doing this anyway.
> 
>  arch/powerpc/boot/libfdt-wrapper.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/boot/libfdt-wrapper.c b/arch/powerpc/boot/libfdt-wrapper.c
> index 1daa73f..0085930 100644
> --- a/arch/powerpc/boot/libfdt-wrapper.c
> +++ b/arch/powerpc/boot/libfdt-wrapper.c
> @@ -179,7 +179,7 @@ void fdt_init(void *blob)
>  
>  	/* Make sure the dt blob is the right version and so forth */
>  	fdt = blob;
> -	bufsize = fdt_totalsize(fdt) + 4;
> +	bufsize = fdt_totalsize(fdt) + EXPAND_GRANULARITY;
>  	buf = malloc(bufsize);
>  	if(!buf)
>  		fatal("malloc failed. can't relocate the device tree\n\r");

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
