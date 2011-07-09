Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4D9BE1007D1
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Jul 2011 00:38:13 +1000 (EST)
Date: Sat, 9 Jul 2011 16:38:09 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] drivers/video: use strings to specify the Freescale DIU
	monitor port
Message-ID: <20110709163809.53f18fea@wker>
In-Reply-To: <1310057466-14599-1-git-send-email-timur@freescale.com>
References: <1310057466-14599-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, lethal@linux-sh.org,
	linux-fbdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 7 Jul 2011 11:51:06 -0500
Timur Tabi <timur@freescale.com> wrote:

> Instead of using ill-defined numbers (0, 1, and 2) for the monitor port, allow
> the user to specify the port by name ("dvi", "lvds", or "dlvds").  This works
> on the kernel command line, the module command-line, and the sysfs "monitor"
> device.
> 
> Note that changing the monitor port does not currently work on the P1022DS,
> because the code that talks to the PIXIS FPGA is broken.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/platforms/512x/mpc512x_shared.c |   22 +++-----
>  arch/powerpc/platforms/85xx/p1022_ds.c       |   47 ++++++++---------
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   55 +++++++++-----------
>  arch/powerpc/sysdev/fsl_soc.h                |   25 ++++++---
>  drivers/video/fsl-diu-fb.c                   |   73 +++++++++++++++++++------
>  5 files changed, 128 insertions(+), 94 deletions(-)

It mostly looks okay to me, please see one comment below.
Otherwise
Acked-by: Anatolij Gustschin <agust@denx.de>

...
> diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
> index 0acc7d6..9c6837e 100644
> --- a/drivers/video/fsl-diu-fb.c
> +++ b/drivers/video/fsl-diu-fb.c
...
> @@ -832,8 +862,8 @@ static int fsl_diu_set_par(struct fb_info *info)
>  	}
>  
>  	ad->pix_fmt =
> -		diu_ops.get_pixel_format(var->bits_per_pixel,
> -					 machine_data->monitor_port);
> +		cpu_to_be32(diu_ops.get_pixel_format(machine_data->monitor_port,
> +						     var->bits_per_pixel));

I think you can drop cpu_to_be32 here, it is somehow confusing. The
descriptor fields are LE32, get_pixel_format() returns LE32 value.

>  	ad->addr    = cpu_to_le32(info->fix.smem_start);

Thanks,
Anatolij
