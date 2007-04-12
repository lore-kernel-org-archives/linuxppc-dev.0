Return-Path: <mikey@neuling.org>
To: Milton Miller <miltonm@bga.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] export retained initrd in debugfs 
In-reply-to: <boot-4-misc-01.miltonm@bga.com> 
References: <boot-4-misc-01.miltonm@bga.com>
Date: Thu, 12 Apr 2007 16:17:19 +1000
Message-ID: <26066.1176358639@neuling.org>
Cc: linuxppc-dev@ozlabs.org, klibc@zytor.com, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This needs to goto lkml

In message <boot-4-misc-01.miltonm@bga.com> you wrote:
> Export initrd in debugfs when retained.
> 
> As a side effect, initrd_start and initrd_end are not cleared when the
> initrd is retained.
> 
> After this patch, one can then copy the initrd space from debugfs and
> pass it to kexec as the initrd, or do something else with it (maybe it
> was an initrd not an initramfs).
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> --- 
> This is a lot more reliable than extracting it via dd from /dev/mem.
> 
> Currently debugfs doesn't have a getattr even for blobs, so one has
> to cp elsewhere before using kexec from kexec-tools.
> 
> Index: kernel/init/initramfs.c
> ===================================================================
> --- kernel.orig/init/initramfs.c	2007-03-28 00:12:15.000000000 -0500
> +++ kernel/init/initramfs.c	2007-03-28 00:35:56.000000000 -0500
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/string.h>
>  #include <linux/syscalls.h>
> +#include <linux/debugfs.h>
>  
>  static __initdata char *message;
>  static void __init error(char *x)
> @@ -519,7 +520,7 @@ static void __init free_initrd(void)
>  	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
>  #endif
>  	if (do_retain_initrd)
> -		goto skip;
> +		return;
>  
>  #ifdef CONFIG_KEXEC
>  	/*
> @@ -588,3 +589,29 @@ static int __init populate_rootfs(void)
>  	return 0;
>  }
>  rootfs_initcall(populate_rootfs);
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +static struct debugfs_blob_wrapper initrd_blob;
> +
> +static int __init export_initrd(void)
> +{
> +	struct dentry *d;
> +	initrd_blob.data = (char *)initrd_start;
> +	initrd_blob.size = initrd_end - initrd_start;
> +
> +	if (!do_retain_initrd)
> +		return 0;
> +
> +	if (!initrd_start)
> +		return 0;
> +
> +	d = debugfs_create_blob("initrd", S_IFREG, NULL, &initrd_blob);
> +
> +	if (!d)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +__initcall(export_initrd);
> +#endif
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
