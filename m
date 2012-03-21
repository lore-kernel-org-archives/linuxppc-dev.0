Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2DE9BB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 18:23:40 +1100 (EST)
Message-ID: <1332314613.2982.38.camel@pasglop>
Subject: Re: [PATCH] Disable /dev/port interface on powerpc systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2012 18:23:33 +1100
In-Reply-To: <1332308237.23222.49.camel@hbabu-laptop>
References: <1332308237.23222.49.camel@hbabu-laptop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-03-20 at 22:37 -0700, Haren Myneni wrote:
> Some power systems do not have legacy ISA devices. So, /dev/port is not
> a valid interface on these systems. User level tools such as kbdrate is
> trying to access the device using this interface which is causing the
> system crash. 
> 
> This patch will fix this issue by not creating this interface on these
> powerpc systems. 

Doesn't fix 32-bit... not a big deal for now I suppose... But I'd rather
you change the patch a tiny bit to change legacy_isa_device_found() to
arch_has_dev_port() instead. There may be other reason than legacy ISA
to enable dev/port or not so let's make the arch hook more generic.

Another approach which might be even better is to filter per-access,
ie for each read/write to /dev/port, have a hook to check if that
specific port is valid, but that may be overkill for what is
essentially a legacy interface that should have died a long time ago :)

Cheers,
Ben.

> Signed-off-by: Haren Myneni <haren@us.ibm.com>
> 
> 
> diff -Naurp linux.orig/arch/powerpc/kernel/isa-bridge.c
> linux/arch/powerpc/kernel/isa-bridge.c
> --- linux.orig/arch/powerpc/kernel/isa-bridge.c	2012-02-11
> 02:08:08.780005293 -0800
> +++ linux/arch/powerpc/kernel/isa-bridge.c	2012-02-11 02:16:25.080003386
> -0800
> @@ -255,6 +255,14 @@ static struct notifier_block isa_bridge_
>  	.notifier_call = isa_bridge_notify
>  };
>  
> +int __init legacy_isa_device_found(void)
> +{
> +	if (isa_bridge_pcidev)
> +		return 1;
> +	
> +	return 0;
> +}
> +
>  /**
>   * isa_bridge_init - register to be notified of ISA bridge
> addition/removal
>   *
> diff -Naurp linux.orig/drivers/char/mem.c linux/drivers/char/mem.c
> --- linux.orig/drivers/char/mem.c	2012-02-11 02:08:42.710002440 -0800
> +++ linux/drivers/char/mem.c	2012-03-20 20:40:43.650000003 -0700
> @@ -35,6 +35,8 @@
>  # include <linux/efi.h>
>  #endif
>  
> +#define DEVPORT_MINOR	4
> +
>  static inline unsigned long size_inside_page(unsigned long start,
>  					     unsigned long size)
>  {
> @@ -910,6 +912,11 @@ static char *mem_devnode(struct device *
>  
>  static struct class *mem_class;
>  
> +int __init __weak legacy_isa_device_found(void)
> +{
> +	return 1;
> +}
> +
>  static int __init chr_dev_init(void)
>  {
>  	int minor;
> @@ -930,6 +937,13 @@ static int __init chr_dev_init(void)
>  	for (minor = 1; minor < ARRAY_SIZE(devlist); minor++) {
>  		if (!devlist[minor].name)
>  			continue;
> +
> +		/*
> +		 * Create /dev/port? 
> +		 */
> +		if ((minor == DEVPORT_MINOR) && !legacy_isa_device_found())
> +			continue;
> +
>  		device_create(mem_class, NULL, MKDEV(MEM_MAJOR, minor),
>  			      NULL, devlist[minor].name);
>  	}
> diff -Naurp linux.orig/include/linux/isa.h linux/include/linux/isa.h
> --- linux.orig/include/linux/isa.h	2012-02-11 02:07:52.030019810 -0800
> +++ linux/include/linux/isa.h	2012-02-11 02:16:49.810002296 -0800
> @@ -36,4 +36,5 @@ static inline void isa_unregister_driver
>  }
>  #endif
>  
> +extern int __init legacy_isa_device_found(void);
>  #endif /* __LINUX_ISA_H */
> 
