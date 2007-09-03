Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E45ADDF1C
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 11:14:00 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l831E12B010752
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:14:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l831HXNO147654
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:17:33 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l831DxlR016114
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:13:59 +1000
Date: Mon, 3 Sep 2007 11:01:12 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 2/6] cuimage for Bamboo board
Message-ID: <20070903010111.GC31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
	<20070831200643.029244000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831200643.029244000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 03:04:51PM -0500, Josh Boyer wrote:
> Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> linker declarations that have been moved into ops.h
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

[snip]
> --- linux-2.6.orig/arch/powerpc/boot/bamboo.c
> +++ linux-2.6/arch/powerpc/boot/bamboo.c
> @@ -24,8 +24,7 @@
>  #include "4xx.h"
>  #include "44x.h"
>  
> -extern char _dtb_start[];
> -extern char _dtb_end[];
> +static u8 *bamboo_mac0, *bamboo_mac1;
>  
>  static void bamboo_fixups(void)
>  {
> @@ -34,12 +33,16 @@ static void bamboo_fixups(void)
>  	ibm440ep_fixup_clocks(sysclk, 11059200);
>  	ibm4xx_fixup_memsize();
>  	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> +	if (bamboo_mac0 && bamboo_mac1)
> +		dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);

Bit ugly that you only set the MAC address for any ethernet if they're
supplied for every ethernet.

>  }
>  
> -void bamboo_init(void)
> +void bamboo_init(void *mac0, void *mac1)
>  {
>  	platform_ops.fixups = bamboo_fixups;
>  	platform_ops.exit = ibm44x_dbcr_reset;
> +	bamboo_mac0 = mac0;
> +	bamboo_mac1 = mac1;
>  	ft_init(_dtb_start, 0, 32);
>  	serial_console_init();
>  }
> --- linux-2.6.orig/arch/powerpc/boot/treeboot-bamboo.c
> +++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c
> @@ -13,8 +13,6 @@
>  #include "stdio.h"
>  #include "44x.h"
>  
> -extern char _end[];
> -
>  BSS_STACK(4096);
>  
>  void platform_init(void)
> @@ -23,5 +21,5 @@ void platform_init(void)
>  	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
>  
>  	simple_alloc_init(_end, avail_ram, 32, 64);
> -	bamboo_init();
> +	bamboo_init(NULL, NULL);

There must surely be a way to get the MAC addresses out of OpenBIOS...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
