Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 753B767C38
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 23:43:00 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/15] powerpc, celleb: Basic supports for Celleb
Date: Tue, 12 Dec 2006 13:42:51 +0100
References: <200612120314.kBC3EZqp026763@toshiba.co.jp>
In-Reply-To: <200612120314.kBC3EZqp026763@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612121342.52306.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 04:14, Ishizaki Kou wrote:

> @@ -0,0 +1,10 @@
> +obj-$(CONFIG_PPC_CELLEB)		+= interrupt.o iommu.o setup.o \
> +					   lpar.o beat.o pci.o \
> +					   scc_epci.o scc_uhc.o

Generally, you should only add the file names to the Makefile in the
patch that actually adds the respective files, so that applying only
part of the series does not prevent you from building the kernel.


> +int64_t	beat_errno;
> +

As mentioned in the last review, this global errno causes trouble
sooner or later, so you should get rid of it. Any beat hcall that
returns an error condition should do that as the return value
or through a pointer argument.

> +#ifdef CONFIG_SERIAL_TXX9
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#endif
> +

The serial_txx9 stuff should not really be in setup.c, but in a separate
file. There are other pieces of code that could be moved to separate
source files (e.g. nvram, time, udbg), but this one is the most
obvious candidate.

> +static void celleb_show_cpuinfo(struct seq_file *m)
> +{
> +	struct device_node *root;
> +	const char *model = "";
> +
> +	root = of_find_node_by_path("/");
> +	if (root)
> +		model = get_property(root, "model", NULL);
> +	seq_printf(m, "machine\t\t: CHRP %s\n", model);
> +	of_node_put(root);
> +}

I'm not sure if it's a good idea to claim CHRP compatibility
here. Is that a workaround for a specific incompatibility? Normally,
I'd say you should print "machine\t\t: BEAT %s\n" or
"machine\t\t: Celleb %s\n", since you are definitely not running
a CHRP compatible firmware.

> Index: linux-powerpc-git/include/asm-powerpc/firmware.h
> diff -u linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/firmware.h:1.2
> --- linux-powerpc-git/include/asm-powerpc/firmware.h:1.1.1.1	Wed Dec  6 08:24:04 2006
> +++ linux-powerpc-git/include/asm-powerpc/firmware.h	Wed Dec  6 08:43:16 2006
> @@ -61,6 +61,8 @@
>  	FW_FEATURE_ISERIES_ALWAYS = FW_FEATURE_ISERIES | FW_FEATURE_LPAR,
>  	FW_FEATURE_PS3_POSSIBLE = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
>  	FW_FEATURE_PS3_ALWAYS = FW_FEATURE_LPAR | FW_FEATURE_PS3_LV1,
> +	FW_FEATURE_CELLEB_POSSIBLE = FW_FEATURE_LPAR,
> +	FW_FEATURE_CELLEB_ALWAYS = FW_FEATURE_LPAR,
>  	FW_FEATURE_NATIVE_POSSIBLE = 0,
>  	FW_FEATURE_NATIVE_ALWAYS = 0,
>  	FW_FEATURE_POSSIBLE =

It's probably reasonable to define a FW_FEATURE_BEAT that is always set
for celleb, so you can test that feature before attempting a beat
specific hcall.

	Arnd <><
