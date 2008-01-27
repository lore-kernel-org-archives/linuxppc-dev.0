Return-Path: <akpm@linux-foundation.org>
Date: Sat, 26 Jan 2008 22:01:33 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 04/11] ps3fb: Inline macros that are used only once
Message-Id: <20080126220133.eb99e5c4.akpm@linux-foundation.org>
In-Reply-To: <20080125153107.177014292@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.177014292@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Geert.Uytterhoeven@sonycom.com, linuxppc-dev@ozlabs.org,
	linux-fbdev-devel@lists.sourceforge.net, cbe-oss-dev@ozlabs.org,
	adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Fri, 25 Jan 2008 16:06:27 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> 
> ps3fb: inline the X_OFF(), Y_OFF(), WIDTH(), HEIGHT(), and VP_OFF() macros,
> as they're used in one place only
> 

I think the term "open-code" would be more suitable here.  "inlining" means
"make it an inline function".  I'll update the changelog.

> -#define X_OFF(i)	(ps3fb_res[i].xoff)	/* left/right margin (pixel) */
> -#define Y_OFF(i)	(ps3fb_res[i].yoff)	/* top/bottom margin (pixel) */
> -#define WIDTH(i)	(ps3fb_res[i].xres)	/* width of FB */
> -#define HEIGHT(i)	(ps3fb_res[i].yres)	/* height of FB */
>  #define BPP		4			/* number of bytes per pixel */
>  
> -/* Start of the virtual frame buffer (relative to fullscreen ) */
> -#define VP_OFF(i)	((WIDTH(i) * Y_OFF(i) + X_OFF(i)) * BPP)
> -
>  
>  static int ps3fb_mode;
>  module_param(ps3fb_mode, int, 0);
> @@ -611,7 +604,10 @@ static int ps3fb_set_par(struct fb_info 
>  
>  	par->width = info->var.xres;
>  	par->height = info->var.yres;
> -	offset = VP_OFF(i);
> +
> +	/* Start of the virtual frame buffer (relative to fullscreen) */
> +	offset = ps3fb_res[i].yoff * ddr_line_length + ps3fb_res[i].xoff * BPP;
> +
