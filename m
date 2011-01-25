Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id 43E511007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 Jan 2011 17:38:45 +1100 (EST)
Date: Tue, 25 Jan 2011 15:38:35 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 3/4 v4] video, sm501: add OF binding to support SM501
Message-ID: <20110125063834.GE11673@linux-sh.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de>
	<1295863058-11168-1-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295863058-11168-1-git-send-email-hs@denx.de>
Cc: linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org,
	Samuel Ortiz <sameo@linux.intel.com>, Vincent Sanders <vince@simtec.co.uk>,
	linux-kernel@vger.kernel.org, Ben Dooks <ben@simtec.co.uk>,
	Randy Dunlap <rdunlap@xenotime.net>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 24, 2011 at 10:57:38AM +0100, Heiko Schocher wrote:
> - changes since v1:
>   add Ben Dooks, Vincent Sanders and Samuel Ortiz to cc, as suggested from
>   Paul Mundt.
> - changes since v2:
>   add comments from Randy Dunlap:
>   - move parameter documentation to Documentation/fb/sm501.txt
> - changes since v3:
>   - rebased against v2.6.38-rc2
>   - split in 3 patches
>     - of support patch
>       - get rid of "#if defined(CONFIG_PPC_MPC52xx)" usage
>         hide this in DTS, as Paul suggested.
>     - i/o routine patch
>     - edid support patch
> 
[snip]

> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index 30b53ae..2ae57aa 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -1729,6 +1729,15 @@ static int sm501fb_init_fb(struct fb_info *fb,
>  		FBINFO_HWACCEL_COPYAREA | FBINFO_HWACCEL_FILLRECT |
>  		FBINFO_HWACCEL_XPAN | FBINFO_HWACCEL_YPAN;
>  
> +#if defined(CONFIG_PPC_MPC52xx)
> +#ifdef __BIG_ENDIAN
> +	if (of_get_property(info->dev->parent->of_node, "little-endian", NULL))
> +		fb->flags |= FBINFO_FOREIGN_ENDIAN;
> +#else
> +	if (of_get_property(info->dev->parent->of_node, "big-endian", NULL))
> +		fb->flags |= FBINFO_FOREIGN_ENDIAN;
> +#endif
> +#endif
>  	/* fixed data */
>  
>  	fb->fix.type		= FB_TYPE_PACKED_PIXELS;

Missed one?
