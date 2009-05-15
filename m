Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B23B4DE088
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 16:29:41 +1000 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH] offb: use framebuffer_alloc() to
	allocate fb_info struct
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
In-Reply-To: <20090504190724.c2dfb53c.krzysztof.h1@poczta.fm>
References: <20090504190724.c2dfb53c.krzysztof.h1@poczta.fm>
Content-Type: text/plain
Date: Fri, 15 May 2009 16:28:34 +1000
Message-Id: <1242368914.22331.18.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2009-05-04 at 19:07 +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Use the framebuffer_alloc() function to allocate the fb_info
> structure so the structure is correctly initialized after allocation.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

> ---
> 
> diff -urp linux-orig/drivers/video/offb.c linux-2.6.30/drivers/video/offb.c
> --- linux-orig/drivers/video/offb.c	2008-08-09 05:09:05.000000000 +0200
> +++ linux-2.6.30/drivers/video/offb.c	2009-05-04 00:14:28.000000000 +0200
> @@ -378,7 +378,6 @@ static void __init offb_init_fb(const ch
>  	struct fb_fix_screeninfo *fix;
>  	struct fb_var_screeninfo *var;
>  	struct fb_info *info;
> -	int size;
>  
>  	if (!request_mem_region(res_start, res_size, "offb"))
>  		return;
> @@ -393,15 +392,12 @@ static void __init offb_init_fb(const ch
>  		return;
>  	}
>  
> -	size = sizeof(struct fb_info) + sizeof(u32) * 16;
> -
> -	info = kmalloc(size, GFP_ATOMIC);
> +	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
>  	
>  	if (info == 0) {
>  		release_mem_region(res_start, res_size);
>  		return;
>  	}
> -	memset(info, 0, size);
>  
>  	fix = &info->fix;
>  	var = &info->var;
> 
> ----------------------------------------------------------------------
> Wygraj 3000 zl, wycieczke lub lot balonem!
> Sprawdz >> http://link.interia.pl/f2154
> 
> 
> ------------------------------------------------------------------------------
> Register Now & Save for Velocity, the Web Performance & Operations 
> Conference from O'Reilly Media. Velocity features a full day of 
> expert-led, hands-on workshops and two days of sessions from industry 
> leaders in dedicated Performance & Operations tracks. Use code vel09scf 
> and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
