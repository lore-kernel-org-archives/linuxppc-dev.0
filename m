Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 89B3EDE6AD
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 21:26:34 +1100 (EST)
Message-ID: <4965D4D1.2010901@ru.mvista.com>
Date: Thu, 08 Jan 2009 13:26:25 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] radeonfb: Fix 64 bits resources on 32 bits archs
References: <20080422012723.BA9F2DE13F@ozlabs.org>
In-Reply-To: <20080422012723.BA9F2DE13F@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, adaplas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

> This fixes radeonfb to not truncate 64 bits resources on 32 bits
> platforms. Unfortunately, there are still issues with addresses
> returned to userspace via struct fb_fix_screeninfo. This will
> have to be dealt with separately.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>   

   I'm seeing that this 3 patch series (dating back to April) still 
unapplied. Have everybody forgotten about them? I'd like to see them 
finally applied.

> --- linux-work.orig/drivers/video/aty/radeon_base.c	2008-04-22 11:04:19.000000000 +1000
> +++ linux-work/drivers/video/aty/radeon_base.c	2008-04-22 11:05:00.000000000 +1000
> @@ -1886,7 +1886,7 @@ static int __devinit radeon_set_fbinfo (
>  	info->screen_size = rinfo->mapped_vram;
>  	/* Fill fix common fields */
>  	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
> -        info->fix.smem_start = rinfo->fb_base_phys;
> +        info->fix.smem_start = (unsigned long)rinfo->fb_base_phys;
>          info->fix.smem_len = rinfo->video_ram;
>          info->fix.type = FB_TYPE_PACKED_PIXELS;
>          info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
> @@ -1894,7 +1894,7 @@ static int __devinit radeon_set_fbinfo (
>          info->fix.ypanstep = 1;
>          info->fix.ywrapstep = 0;
>          info->fix.type_aux = 0;
> -        info->fix.mmio_start = rinfo->mmio_base_phys;
> +        info->fix.mmio_start = (unsigned long)rinfo->mmio_base_phys;
>          info->fix.mmio_len = RADEON_REGSIZE;
>  	info->fix.accel = FB_ACCEL_ATI_RADEON;
>  
> Index: linux-work/drivers/video/aty/radeonfb.h
> ===================================================================
> --- linux-work.orig/drivers/video/aty/radeonfb.h	2008-04-22 11:03:17.000000000 +1000
> +++ linux-work/drivers/video/aty/radeonfb.h	2008-04-22 11:03:27.000000000 +1000
> @@ -287,8 +287,8 @@ struct radeonfb_info {
>  
>  	char			name[DEVICE_NAME_SIZE];
>  
> -	unsigned long		mmio_base_phys;
> -	unsigned long		fb_base_phys;
> +	resource_size_t		mmio_base_phys;
> +	resource_size_t		fb_base_phys;
>  
>  	void __iomem		*mmio_base;
>  	void __iomem		*fb_base;

WBR, Sergei
