Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCC42DE22C
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jan 2007 07:07:12 +1100 (EST)
Subject: Re: [PATCH 4/16] ps3: system bus minor mmio fix
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BAC20A.8040107@am.sony.com>
References: <45BAC20A.8040107@am.sony.com>
Content-Type: text/plain
Date: Sun, 28 Jan 2007 07:06:57 +1100
Message-Id: <1169928417.24996.205.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-01-26 at 19:07 -0800, Geoff Levand wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Fix two minor bugs in the PS3 system bus mmio region code.  First, on error or
> when freeing a region, retain the bus_addr and len fields to allow subsequent
> calls to create the region.  Second, correct the region address argument to the
> lv1_unmap_device_mmio_region() call.

Note that I personally think that drivers/ps3 is a very wrong place for
the ps3 system bus. It should stay in arch/powerpc/platform/ps3

Ben.

> Fixes modprobe/rmmod of some drivers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
> 
> ---
>  drivers/ps3/system-bus.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> --- ps3-linux-dev.orig/drivers/ps3/system-bus.c
> +++ ps3-linux-dev/drivers/ps3/system-bus.c
> @@ -50,7 +50,7 @@ int ps3_mmio_region_create(struct ps3_mm
>  	if (result) {
>  		pr_debug("%s:%d: lv1_map_device_mmio_region failed: %s\n",
>  			__func__, __LINE__, ps3_result(result));
> -		r->lpar_addr = r->len = r->bus_addr = 0;
> +		r->lpar_addr = 0;
>  	}
>  
>  	dump_mmio_region(r);
> @@ -62,13 +62,13 @@ int ps3_free_mmio_region(struct ps3_mmio
>  	int result;
>  
>  	result = lv1_unmap_device_mmio_region(r->did.bus_id, r->did.dev_id,
> -		r->bus_addr);
> +		r->lpar_addr);
>  
>  	if (result)
>  		pr_debug("%s:%d: lv1_unmap_device_mmio_region failed: %s\n",
>  			__func__, __LINE__, ps3_result(result));
>  
> -	r->lpar_addr = r->len = r->bus_addr = 0;
> +	r->lpar_addr = 0;
>  	return result;
>  }
>  
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
