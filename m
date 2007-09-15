Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (E23SMTP05.au.ibm.com [202.81.18.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3358EDDE32
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:38 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8F2TdWc028709
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:39 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8F2Tb4k4435992
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 12:29:37 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8F3TLdg024144
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 13:29:21 +1000
Date: Sat, 15 Sep 2007 12:19:52 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 1/4] cuimage for Bamboo board
Message-ID: <20070915021952.GD25414@localhost.localdomain>
References: <20070914185410.387074000@linux.vnet.ibm.com>>
	<20070914185648.698807000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070914185648.698807000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2007 at 01:54:11PM -0500, Josh Boyer wrote:
> Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> linker declarations that have been moved into ops.h
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Heh, well, I know I acked this already, but...

[snip]
> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/cuboot-bamboo.c
> @@ -0,0 +1,30 @@
> +/*
> + * Old U-boot compatibility for Ebony

Error in the comment here.

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

This additional handling of the MAC addresses should really also be
mentioned in the commit comment.

>  
>  static void bamboo_fixups(void)
>  {
> @@ -34,12 +33,15 @@ static void bamboo_fixups(void)
>  	ibm440ep_fixup_clocks(sysclk, 11059200);
>  	ibm4xx_fixup_memsize();
>  	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
> +	dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
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
> @@ -12,16 +12,32 @@
>  #include "ops.h"
>  #include "stdio.h"
>  #include "44x.h"
> -
> -extern char _end[];
> +#include "stdlib.h"
>  
>  BSS_STACK(4096);
>  
> +#define PIBS_MAC0 0xfffc0400
> +#define PIBS_MAC1 0xfffc0500
> +char pibs_mac0[6];
> +char pibs_mac1[6];
> +
> +static void read_pibs_mac(void)
> +{
> +	unsigned long long mac64;
> +
> +	mac64 = strtoull((char *)PIBS_MAC0, 0, 16);
> +	memcpy(&pibs_mac0, (char *)&mac64+2, 6);
> +
> +	mac64 = strtoull((char *)PIBS_MAC1, 0, 16);
> +	memcpy(&pibs_mac1, (char *)&mac64+2, 6);
> +}
> +
>  void platform_init(void)
>  {
>  	unsigned long end_of_ram = 0x8000000;
>  	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
>  
>  	simple_alloc_init(_end, avail_ram, 32, 64);
> -	bamboo_init();
> +	read_pibs_mac();
> +	bamboo_init((u8 *)&pibs_mac0, (u8 *)&pibs_mac1);
>  }
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
