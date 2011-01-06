Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id C546BB70FB
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Jan 2011 15:49:01 +1100 (EST)
Date: Thu, 6 Jan 2011 13:47:02 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2 1/2] video, sm501: add OF binding to support SM501
Message-ID: <20110106044702.GO23889@linux-sh.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1292049075-1809-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292049075-1809-1-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 11, 2010 at 07:31:15AM +0100, Heiko Schocher wrote:
> - add binding to OF, compatible name "smi,sm501"
> 
> - add read/write functions for using this driver
>   also on powerpc plattforms
> 
> - add commandline options:
>   sm501.fb_mode:
>     Specify resolution as "<xres>x<yres>[-<bpp>][@<refresh>]"
>   sm501.bpp:
>     Specify bit-per-pixel if not specified mode
> 
> - Add support for encoding display mode information
>   in the device tree using verbatim EDID block.
> 
>   If the "edid" entry in the "smi,sm501" node is present,
>   the driver will build mode database using EDID data
>   and allow setting the display modes from this database.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: linux-fbdev@vger.kernel.org
> cc: devicetree-discuss@ozlabs.org
> cc: Ben Dooks <ben@simtec.co.uk>
> cc: Vincent Sanders <vince@simtec.co.uk>
> cc: Samuel Ortiz <sameo@linux.intel.com>
> cc: linux-kernel@vger.kernel.org
> 
> ---
> - changes since v1:
>   add Ben Dooks, Vincent Sanders and Samuel Ortiz to cc, as suggested from
>   Paul Mundt.
> 
>  Documentation/kernel-parameters.txt          |    7 +
>  Documentation/powerpc/dts-bindings/sm501.txt |   30 +++
>  drivers/mfd/sm501.c                          |  141 ++++++++------
>  drivers/video/sm501fb.c                      |  264 +++++++++++++++++---------
>  include/linux/sm501.h                        |    8 +
>  5 files changed, 299 insertions(+), 151 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/sm501.txt
> 
So has this stalled out? If Samuel wants to ack the MFD bits I don't mind
taking it through the fbdev tree. I can dust off an SM501 board to make
sure it still works for the non-OF case, although most of the changes
look fairly mechanical, so I don't forsee too much difficulty.

A few minor notes however. For starters, it would be nice to see this
patch split out a bit more logically. All of the items in your changelog
are more or less independent logical changes, and should really be
independent patches. As such, I'd like to see the EDID support as one
patch, the OF binding support layered on top of that, the documentation
split out as a trivial patch, and the I/O routine thing dealt with
separately. This should also make it easier for Samuel to simply ack the
OF bindings part that touch the MFD driver without having to be bothered
with any of the other stuff should regressions pop up at a later point in
time via a bisection.

As far as the DTS bindings documentation goes, I'm not sure what the best
way to split that out is. Perhaps simply lumping it in with the OF
bindings makes the most logical sense, and it's obviously a dependency
for the architecture-specific portion as well.

> @@ -1698,6 +1727,9 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  	fb->fbops = &par->ops;
>  	fb->flags = FBINFO_FLAG_DEFAULT | FBINFO_READS_FAST |
>  		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
> +#if defined(CONFIG_PPC_MPC52xx)
> +		FBINFO_FOREIGN_ENDIAN |
> +#endif
>  		FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
>  
>  	/* fixed data */

This is now getting in to deep hack territory. It's also not entirely
obvious how you expect things like the imageblit op to work given that
you're not selecting any of FB_{BIG,LITTLE,BOTH,FOREIGN}_ENDIAN, which
leads me to suspect you are manually doing this in your .config in a
relatively fragile way.

In the OF case I suppose you probably want something like:

#ifdef __BIG_ENDIAN
        if (of_get_property(dp, "little-endian", NULL))
                foreign_endian = FBINFO_FOREIGN_ENDIAN;
#else
        if (of_get_property(dp, "big-endian", NULL))
                foreign_endian = FBINFO_FOREIGN_ENDIAN;
#endif

and then simply hide the details in the DTS file in order to get rid of
CPU-specific hacks.

> +#if defined(CONFIG_PPC_MPC52xx)
> +#define smc501_readl(addr)	__do_readl_be((addr))
> +#define smc501_writel(val, addr)	__do_writel_be((val), (addr))
> +#else
> +#define smc501_readl(addr)		readl(addr)
> +#define smc501_writel(val, addr)	writel(val, addr)
> +#endif

Based on the Kconfig option for endianness you could probably just wrap these
to ioread/write32{,be} and hide the semantics in your iomap implementation?
