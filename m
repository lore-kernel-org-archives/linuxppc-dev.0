Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6799679FC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 03:54:13 +1000 (EST)
In-Reply-To: <20060501074044.D552967B55@ozlabs.org>
References: <20060501074044.D552967B55@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7C163A77-FF5F-49E7-87CF-0EA0411FE7A6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Export flat device tree via debugfs for debugging
Date: Mon, 1 May 2006 12:54:04 -0500
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 1, 2006, at 2:40 AM, Michael Ellerman wrote:

> If DEBUG is turned on in prom.c, export the flat device tree via  
> debugfs.
> This has been handy on several occasions.
>
> To look at it:
>  # mount -t debugfs none /sys/kernel/debug
>  # od -a /sys/kernel/debug/powerpc/flat-device-tree
>  and/or
>  # dtc -fI dtb /sys/kernel/debug/powerpc/flat-device-tree -O dts
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>
>  arch/powerpc/kernel/prom.c |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> Index: to-merge/arch/powerpc/kernel/prom.c
> ===================================================================
> --- to-merge.orig/arch/powerpc/kernel/prom.c
> +++ to-merge/arch/powerpc/kernel/prom.c
> @@ -30,6 +30,7 @@
>  #include <linux/bitops.h>
>  #include <linux/module.h>
>  #include <linux/kexec.h>
> +#include <linux/debugfs.h>
>
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -2009,3 +2010,27 @@ void kdump_move_device_tree(void)
>  	/* XXX should we unreserve the old DT? */
>  }
>  #endif /* CONFIG_KEXEC */
> +
> +#ifdef DEBUG

Shouldn't this also depend on DEBUGFS being built in.

> +static struct debugfs_blob_wrapper flat_dt_blob;
> +
> +static int __init export_flat_device_tree(void)
> +{
> +	struct dentry *d;
> +
> +	d = debugfs_create_dir("powerpc", NULL);
> +	if (!d)
> +		return 1;
> +
> +	flat_dt_blob.data = initial_boot_params;
> +	flat_dt_blob.size = initial_boot_params->totalsize;
> +
> +	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
> +				d, &flat_dt_blob);
> +	if (!d)
> +		return 1;
> +
> +	return 0;
> +}
> +__initcall(export_flat_device_tree);
> +#endif
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
