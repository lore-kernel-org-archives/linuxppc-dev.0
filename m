Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57CFE1A024B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:52:32 +1000 (AEST)
Message-ID: <1436874720.3948.252.camel@kernel.crashing.org>
Subject: Re: [RFC v4 17/25] powerpc, fbdev: Use arch_nvram_ops methods
 instead of nvram_read_byte() and nvram_write_byte()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen
 <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Date: Tue, 14 Jul 2015 21:52:00 +1000
In-Reply-To: <alpine.LNX.2.00.1507141725480.851@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102531.505897278@telegraphics.com.au>
 <alpine.LNX.2.00.1507141725480.851@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-14 at 17:58 +1000, Finn Thain wrote:
> Make use of arch_nvram_ops in device drivers so that the nvram_* function 
> exports can be removed.
> 
> Since they are no longer global symbols, rename the PPC32 nvram_* 
> functions appropriately.
> 
> Add the missing CONFIG_NVRAM test to imsttfb to avoid a build failure.
> 
> Add a CONFIG_PPC32 test to matroxfb because PPC64 doesn't implement the 
> read_byte() method.

This is a bit fishy in a way because some of that nvram stuff is really
about powermac/apple nvram offsets, ie, "XPRAM". Maybe we
should have a dedicated accessor for "mac_xpram" and NULL-check it
rather than using ifdef's ?

> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> ---
> 
> Changed since v4:
> - Added CONFIG_PPC32 test to matroxfb.
> 
> ---
>  arch/powerpc/kernel/setup_32.c             |    8 ++++----
>  drivers/char/generic_nvram.c               |    4 ++--
>  drivers/video/fbdev/controlfb.c            |    4 ++--
>  drivers/video/fbdev/imsttfb.c              |    7 +++----
>  drivers/video/fbdev/matrox/matroxfb_base.c |    4 ++--
>  drivers/video/fbdev/platinumfb.c           |    4 ++--
>  drivers/video/fbdev/valkyriefb.c           |    4 ++--
>  7 files changed, 17 insertions(+), 18 deletions(-)
> 
> Index: linux/arch/powerpc/kernel/setup_32.c
> ===================================================================
> --- linux.orig/arch/powerpc/kernel/setup_32.c	2015-07-13 21:33:01.000000000 +1000
> +++ linux/arch/powerpc/kernel/setup_32.c	2015-07-13 21:33:02.000000000 +1000
> @@ -170,20 +170,18 @@ __setup("l3cr=", ppc_setup_l3cr);
>  
>  #ifdef CONFIG_GENERIC_NVRAM
>  
> -unsigned char nvram_read_byte(int addr)
> +static unsigned char ppc_nvram_read_byte(int addr)
>  {
>  	if (ppc_md.nvram_read_val)
>  		return ppc_md.nvram_read_val(addr);
>  	return 0xff;
>  }
> -EXPORT_SYMBOL(nvram_read_byte);
>  
> -void nvram_write_byte(unsigned char val, int addr)
> +static void ppc_nvram_write_byte(unsigned char val, int addr)
>  {
>  	if (ppc_md.nvram_write_val)
>  		ppc_md.nvram_write_val(addr, val);
>  }
> -EXPORT_SYMBOL(nvram_write_byte);
>  
>  static ssize_t ppc_nvram_get_size(void)
>  {
> @@ -200,6 +198,8 @@ static long ppc_nvram_sync(void)
>  }
>  
>  const struct nvram_ops arch_nvram_ops = {
> +	.read_byte      = ppc_nvram_read_byte,
> +	.write_byte     = ppc_nvram_write_byte,
>  	.get_size       = ppc_nvram_get_size,
>  	.sync           = ppc_nvram_sync,
>  };
> Index: linux/drivers/char/generic_nvram.c
> ===================================================================
> --- linux.orig/drivers/char/generic_nvram.c	2015-07-13 21:33:01.000000000 +1000
> +++ linux/drivers/char/generic_nvram.c	2015-07-13 21:33:02.000000000 +1000
> @@ -64,7 +64,7 @@ static ssize_t read_nvram(struct file *f
>  	if (*ppos >= nvram_len)
>  		return 0;
>  	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count)
> -		if (__put_user(nvram_read_byte(i), p))
> +		if (__put_user(arch_nvram_ops.read_byte(i), p))
>  			return -EFAULT;
>  	*ppos = i;
>  	return p - buf;
> @@ -84,7 +84,7 @@ static ssize_t write_nvram(struct file *
>  	for (i = *ppos; count > 0 && i < nvram_len; ++i, ++p, --count) {
>  		if (__get_user(c, p))
>  			return -EFAULT;
> -		nvram_write_byte(c, i);
> +		arch_nvram_ops.write_byte(c, i);
>  	}
>  	*ppos = i;
>  	return p - buf;
> Index: linux/drivers/video/fbdev/controlfb.c
> ===================================================================
> --- linux.orig/drivers/video/fbdev/controlfb.c	2015-07-13 21:32:43.000000000 +1000
> +++ linux/drivers/video/fbdev/controlfb.c	2015-07-13 21:33:02.000000000 +1000
> @@ -415,7 +415,7 @@ static int __init init_control(struct fb
>  	/* Try to pick a video mode out of NVRAM if we have one. */
>  #ifdef CONFIG_NVRAM
>  	if (default_cmode == CMODE_NVRAM) {
> -		cmode = nvram_read_byte(NV_CMODE);
> +		cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  		if(cmode < CMODE_8 || cmode > CMODE_32)
>  			cmode = CMODE_8;
>  	} else
> @@ -423,7 +423,7 @@ static int __init init_control(struct fb
>  		cmode=default_cmode;
>  #ifdef CONFIG_NVRAM
>  	if (default_vmode == VMODE_NVRAM) {
> -		vmode = nvram_read_byte(NV_VMODE);
> +		vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (vmode < 1 || vmode > VMODE_MAX ||
>  		    control_mac_modes[vmode - 1].m[full] < cmode) {
>  			sense = read_control_sense(p);
> Index: linux/drivers/video/fbdev/matrox/matroxfb_base.c
> ===================================================================
> --- linux.orig/drivers/video/fbdev/matrox/matroxfb_base.c	2015-07-13 21:32:57.000000000 +1000
> +++ linux/drivers/video/fbdev/matrox/matroxfb_base.c	2015-07-13 21:33:02.000000000 +1000
> @@ -1886,9 +1886,9 @@ static int initMatrox2(struct matrox_fb_
>  		struct fb_var_screeninfo var;
>  		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
>  			default_vmode = VMODE_640_480_60;
> -#ifdef CONFIG_NVRAM
> +#if defined(CONFIG_NVRAM) && defined(CONFIG_PPC32)
>  		if (default_cmode == CMODE_NVRAM)
> -			default_cmode = nvram_read_byte(NV_CMODE);
> +			default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>  		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
>  			default_cmode = CMODE_8;
> Index: linux/drivers/video/fbdev/platinumfb.c
> ===================================================================
> --- linux.orig/drivers/video/fbdev/platinumfb.c	2015-07-13 21:32:43.000000000 +1000
> +++ linux/drivers/video/fbdev/platinumfb.c	2015-07-13 21:33:02.000000000 +1000
> @@ -349,7 +349,7 @@ static int platinum_init_fb(struct fb_in
>  	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
>  	if (default_vmode == VMODE_NVRAM) {
>  #ifdef CONFIG_NVRAM
> -		default_vmode = nvram_read_byte(NV_VMODE);
> +		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (default_vmode <= 0 || default_vmode > VMODE_MAX ||
>  		    !platinum_reg_init[default_vmode-1])
>  #endif
> @@ -362,7 +362,7 @@ static int platinum_init_fb(struct fb_in
>  		default_vmode = VMODE_640_480_60;
>  #ifdef CONFIG_NVRAM
>  	if (default_cmode == CMODE_NVRAM)
> -		default_cmode = nvram_read_byte(NV_CMODE);
> +		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>  	if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
>  		default_cmode = CMODE_8;
> Index: linux/drivers/video/fbdev/valkyriefb.c
> ===================================================================
> --- linux.orig/drivers/video/fbdev/valkyriefb.c	2015-07-13 21:32:43.000000000 +1000
> +++ linux/drivers/video/fbdev/valkyriefb.c	2015-07-13 21:33:02.000000000 +1000
> @@ -287,7 +287,7 @@ static void __init valkyrie_choose_mode(
>  	/* Try to pick a video mode out of NVRAM if we have one. */
>  #if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
>  	if (default_vmode == VMODE_NVRAM) {
> -		default_vmode = nvram_read_byte(NV_VMODE);
> +		default_vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  		if (default_vmode <= 0
>  		 || default_vmode > VMODE_MAX
>  		 || !valkyrie_reg_init[default_vmode - 1])
> @@ -300,7 +300,7 @@ static void __init valkyrie_choose_mode(
>  		default_vmode = VMODE_640_480_67;
>  #if !defined(CONFIG_MAC) && defined(CONFIG_NVRAM)
>  	if (default_cmode == CMODE_NVRAM)
> -		default_cmode = nvram_read_byte(NV_CMODE);
> +		default_cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  #endif
>  
>  	/*
> Index: linux/drivers/video/fbdev/imsttfb.c
> ===================================================================
> --- linux.orig/drivers/video/fbdev/imsttfb.c	2015-07-13 21:32:43.000000000 +1000
> +++ linux/drivers/video/fbdev/imsttfb.c	2015-07-13 21:33:02.000000000 +1000
> @@ -328,7 +328,6 @@ enum {
>  	TVP = 1
>  };
>  
> -#define USE_NV_MODES		1
>  #define INIT_BPP		8
>  #define INIT_XRES		640
>  #define INIT_YRES		480
> @@ -1391,17 +1390,17 @@ static void init_imstt(struct fb_info *i
>  		}
>  	}
>  
> -#if USE_NV_MODES && defined(CONFIG_PPC32)
> +#if defined(CONFIG_NVRAM) && defined(CONFIG_PPC32)
>  	{
>  		int vmode = init_vmode, cmode = init_cmode;
>  
>  		if (vmode == -1) {
> -			vmode = nvram_read_byte(NV_VMODE);
> +			vmode = arch_nvram_ops.read_byte(NV_VMODE);
>  			if (vmode <= 0 || vmode > VMODE_MAX)
>  				vmode = VMODE_640_480_67;
>  		}
>  		if (cmode == -1) {
> -			cmode = nvram_read_byte(NV_CMODE);
> +			cmode = arch_nvram_ops.read_byte(NV_CMODE);
>  			if (cmode < CMODE_8 || cmode > CMODE_32)
>  				cmode = CMODE_8;
>  		}
