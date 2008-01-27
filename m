Return-Path: <akpm@linux-foundation.org>
Date: Sat, 26 Jan 2008 22:01:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 09/11] ps3fb: Round up video modes
Message-Id: <20080126220143.16c8f821.akpm@linux-foundation.org>
In-Reply-To: <20080125153107.478948955@vixen.sonytel.be>
References: <20080125150623.202631389@vixen.sonytel.be>
	<20080125153107.478948955@vixen.sonytel.be>
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

> On Fri, 25 Jan 2008 16:06:32 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
>  static int ps3fb_cmp_mode(const struct fb_videomode *vmode,
>  			  const struct fb_var_screeninfo *var)
>  {
> -	/* resolution + black border must match a native resolution */
> -	if (vmode->left_margin + vmode->xres + vmode->right_margin !=
> -	    var->left_margin + var->xres + var->right_margin ||
> -	    vmode->upper_margin + vmode->yres + vmode->lower_margin !=
> -	    var->upper_margin + var->yres + var->lower_margin)
> +	long xres, yres, left_margin, right_margin, upper_margin, lower_margin;
> +	long dx, dy;

I don't think these need to be longs?  And they probably don't need to be
signed either.

If a switch to u32 improves the code any, it might be worth doing..

All the typecasting which this patch adds makes me wonder if the choice
of types requires a general revisit...
