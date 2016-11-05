Return-Path: <aaro.koskinen@iki.fi>
Received: from emh06.mail.saunalahti.fi (emh06.mail.saunalahti.fi
 [62.142.5.116])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tB4CS5BqjzDvNW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Nov 2016 03:38:44 +1100 (AEDT)
Date: Sat, 5 Nov 2016 18:32:06 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Paul Burton <paul.burton@imgtec.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Problem with the commit "console: don't prefer first registered
 if DT specifies stdout-path"
Message-ID: <20161105163206.i2hic2fumbs4f25u@raspberrypi-2.musicnaut.iki.fi>
References: <b90923cc-a346-717f-fef0-807c91552d09@xenosoft.de>
 <23567bc3-f9e9-3a77-3def-6820ce3285df@candw.ms>
 <5a77bef0-50ac-801e-e486-08b524abaf0f@xenosoft.de>
 <19E9D3FF-6FD3-49D7-8E9B-2660DBBFBD6E@xenosoft.de>
 <9da8c949-c1a2-3032-a31f-61bafff270f9@candw.ms>
 <7ea85187-cc4b-b3fb-77c5-57f6c63b3aeb@xenosoft.de>
 <0f04fb38-a0d3-3fb4-6232-2951e0e9b666@xenosoft.de>
 <e102f3b9-9a3d-ac5b-193a-9b1073192e93@xenosoft.de>
 <0ff108f9-4112-7f13-2c9d-8881e5416431@xenosoft.de>
 <d71d79fa-ebe8-4f6f-f04f-ce3583b59019@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d71d79fa-ebe8-4f6f-f04f-ce3583b59019@xenosoft.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 05, 2016 at 04:11:11PM +0100, Christian Zigotzky wrote:
> After your commit "console: don't prefer first registered if DT specifies
> stdout-path" [1] we couldn't see any kernel boot messages anymore. I
> restored the old code and after that I was able to see the messages again.
> 
> System: Nemo board with P.A. Semi PA6T PowerPC CPU
> 
> I understand your idea of this patch but unfortunately it doesn't work with
> our system. There isn't a possibility to modify the DT.

I faced the same issue today with PowerBook G4.

/sys/firmware/devicetree/base/chosen # hexdump -C linux,stdout-path
00000000  2f 70 63 69 40 66 30 30  30 30 30 30 30 2f 4e 56  |/pci@f0000000/NV|
00000010  44 41 2c 50 61 72 65 6e  74 40 31 30 2f 4e 56 44  |DA,Parent@10/NVD|
00000020  41 2c 44 69 73 70 6c 61  79 2d 41 40 30 00        |A,Display-A@0.|
0000002e

# dmesg|grep -i console
[    0.000000] bootconsole [udbg0] enabled
[    0.000774] Console: colour dummy device 80x25
[    2.288125] Console: switching to colour frame buffer device 128x48
[    4.318611] Warning: unable to open an initial console.

A workaround seems to be explicitly pass console=tty0 on the kernel
command line...

A.

> We have created a patch for removing your commit but I hope you have a
> better idea.
> 
> Cheers,
> Christian
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=05fd007e46296afb24d15c7d589d535e5a5b9d5c

> diff -rupN a/drivers/of/base.c b/drivers/of/base.c
> --- a/drivers/of/base.c	2016-10-29 22:52:02.000000000 +0200
> +++ b/drivers/of/base.c	2016-11-04 11:59:07.049568281 +0100
> @@ -2077,8 +2077,6 @@ void of_alias_scan(void * (*dt_alloc)(u6
>  			name = of_get_property(of_aliases, "stdout", NULL);
>  		if (name)
>  			of_stdout = of_find_node_opts_by_path(name, &of_stdout_options);
> -		if (of_stdout)
> -			console_set_by_of();
>  	}
>  
>  	if (!of_aliases)
> diff -rupN a/include/linux/console.h b/include/linux/console.h
> --- a/include/linux/console.h	2016-10-29 22:52:02.000000000 +0200
> +++ b/include/linux/console.h	2016-11-04 12:00:22.808701652 +0100
> @@ -173,12 +173,6 @@ static inline void console_sysfs_notify(
>  #endif
>  extern bool console_suspend_enabled;
>  
> -#ifdef CONFIG_OF
> -extern void console_set_by_of(void);
> -#else
> -static inline void console_set_by_of(void) {}
> -#endif
> -
>  /* Suspend and resume console messages over PM events */
>  extern void suspend_console(void);
>  extern void resume_console(void);
> diff -rupN a/kernel/printk/printk.c b/kernel/printk/printk.c
> --- a/kernel/printk/printk.c	2016-10-29 22:52:02.000000000 +0200
> +++ b/kernel/printk/printk.c	2016-11-04 12:04:36.083094450 +0100
> @@ -253,17 +253,6 @@ static int preferred_console = -1;
>  int console_set_on_cmdline;
>  EXPORT_SYMBOL(console_set_on_cmdline);
>  
> -#ifdef CONFIG_OF
> -static bool of_specified_console;
> -
> -void console_set_by_of(void)
> -{
> -	of_specified_console = true;
> -}
> -#else
> -# define of_specified_console false
> -#endif
> -
>  /* Flag: console code may call schedule() */
>  static int console_may_schedule;
>  
> @@ -2657,7 +2646,7 @@ void register_console(struct console *ne
>  	 *	didn't select a console we take the first one
>  	 *	that registers here.
>  	 */
> -	if (preferred_console < 0 && !of_specified_console) {
> +	if (preferred_console < 0) {
>  		if (newcon->index < 0)
>  			newcon->index = 0;
>  		if (newcon->setup == NULL ||
