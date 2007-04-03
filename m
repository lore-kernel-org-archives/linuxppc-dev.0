Return-Path: <SRS0+3550a31010a0b33b2856+1318+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <4612C48F.9080805@am.sony.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
	<1175568133.16182.15.camel@concordia  <4612C48F.9080805@am.sony.com>
Content-Type: text/plain
Date: Tue, 03 Apr 2007 17:48:24 -0400
Message-Id: <1175636904.10567.8.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 14:18 -0700, Geoff Levand wrote:
> I'm in the middle of implementing the zImage and kexec support for the
> 2.6.21 kernel, but haven't pushed all of it out to ps3-linux.git yet.
> Once that is done, there is little need for a 2.6.16 based bootloader,
> since it would be just as well to use a recent kernel.

True, but there are people out there who _do_ have a 2.6.16-based
bootloader, and we don't really want to force them to update the
bootloader before they can update the kernel.

> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -1642,7 +1642,7 @@ _STATIC(__start_initialization_iSeries)
>  
>  #if defined(CONFIG_PPC_PS3)
>  _STATIC(__start_ps3_kexec)
> -#if 1 /* override DT passed from bootloader */
> +#if 0 /* override DT passed from bootloader */
>  	LOAD_REG_IMMEDIATE(r3, dt_blob_start)
>  	clrldi	r3, r3, 2 /* convert to physical */
>  #endif

I've been selective about which patches from ps3-linux-patches I've
included in the Fedora kernel -- I was after a _minimal_ set which
allows the machine to be functional. I haven't included the hacks in
head_64.S -- I'll probably need something like that when I come to build
the otheros.bld bootloader, but in fact that can probably live in the
zImage wrapper rather than the kernel itself. The otheros.bld is the
only time we'll be using a zImage wrapper.

> @@ -988,7 +990,15 @@ void __init early_init_devtree(void *params)
> -	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> +	if (!of_flat_dt_is_compatible(dt_root, "PS3"))
> +		of_scan_flat_dt(early_init_dt_scan_memory, NULL);

Yeah, that'll have much the same effect as my original patch, although
Ben suggested that I do it differently; hence the second version with
lmb_reset_available().

But to go back to the unanswered question.... why _did_ we change from
having the memory in the device-tree, to dynamically querying for it?

-- 
dwmw2
