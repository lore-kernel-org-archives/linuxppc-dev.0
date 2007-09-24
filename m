Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 12:58:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/15] boot: find initrd location from device-tree
Message-ID: <20070924025824.GD8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <boot-8-01.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <boot-8-01.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:03:24PM -0500, Milton Miller wrote:
> Some platforms have a boot agent that can create or modify properties in
> the device-tree and load images into memory.  Provide a helper to set
> loader_info used by prep_initrd().
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>

Hrm, despite my earlier ack, I'm going to whinge about a few nits
here.

> --- 
> re 12168
> rediffed types.h, offset in ops.h
> 
> Index: kernel/arch/powerpc/boot/ops.h
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/ops.h	2007-09-17 22:12:47.000000000 -0500
> +++ kernel/arch/powerpc/boot/ops.h	2007-09-17 22:12:51.000000000 -0500
> @@ -163,6 +163,7 @@ void dt_fixup_clock(const char *path, u3
>  void __dt_fixup_mac_addresses(u32 startindex, ...);
>  #define dt_fixup_mac_addresses(...) \
>  	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
> +void dt_find_initrd(void);
>  
>  
>  static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
> Index: kernel/arch/powerpc/boot/types.h
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/types.h	2007-09-17 22:12:47.000000000 -0500
> +++ kernel/arch/powerpc/boot/types.h	2007-09-17 22:12:51.000000000 -0500
> @@ -12,6 +12,8 @@ typedef short			s16;
>  typedef int			s32;
>  typedef long long		s64;
>  
> +#define UINT_MAX	0xFFFFFFFF

I actually don't like this constant - at the point you compare you
care, explicitly, about the value not being over 32-bits, rather than
whether it fits a uint, so the named constant is more misleading than
helpful.

> +
>  #define min(x,y) ({ \
>  	typeof(x) _x = (x);	\
>  	typeof(y) _y = (y);	\
> Index: kernel/arch/powerpc/boot/devtree.c
> ===================================================================
> --- kernel.orig/arch/powerpc/boot/devtree.c	2007-09-17 22:12:47.000000000 -0500
> +++ kernel/arch/powerpc/boot/devtree.c	2007-09-17 22:12:51.000000000 -0500
> @@ -1,6 +1,7 @@
>  /*
>   * devtree.c - convenience functions for device tree manipulation
>   * Copyright 2007 David Gibson, IBM Corporation.
> + * Copyright 2007 Milton Miller, IBM Corporation.
>   * Copyright (c) 2007 Freescale Semiconductor, Inc.
>   *
>   * Authors: David Gibson <david@gibson.dropbear.id.au>
> @@ -333,3 +334,68 @@ int dt_is_compatible(void *node, const c
>  
>  	return 0;
>  }
> +
> +/**
> + * dt_find_initrd - set loader initrd location based on existing properties
> + *
> + * finds the linux,initrd-start and linux,initrd-end properties in
> + * the /chosen node and sets the loader initrd fields accordingly.
> + *
> + * Use this if your loader sets the properties to allow other code to
> + * relocate the tree and/or cause r3 and r4 to be set on true OF
> + * platforms.

I am unable to make sense of the paragraph above.

> + */
> +void dt_find_initrd(void)
> +{
> +	int rc;
> +	unsigned long long initrd_start, initrd_end;
> +	void *devp;
> +	static const char start_prop[] = "linux,initrd-start";
> +	static const char end_prop[] = "linux,initrd-end";

I think these constants are more obscuring than useful.

> +
> +	devp = finddevice("/chosen");
> +	if (! devp) {
> +		return;
> +	}

CodingStyle would not put { } here.

> +
> +	rc = getprop(devp, start_prop, &initrd_start, sizeof(initrd_start));
> +	if (rc < 0)
> +		return;				/* not found */
> +	/* The properties had to be 8 bytes until 2.6.22 */
> +	if (rc == sizeof(unsigned long)) {
> +		unsigned long tmp;
> +		memcpy(&tmp, &initrd_start, rc);
> +		initrd_start = tmp;
> +	} else if (rc != sizeof(initrd_start)) {	/* now they
> can be 4 */

Right.  8 bytes and 4 bytes, so you should be using explicit length
types instead of long and long long.

> +		printf("unexpected length of %s in /chosen!\n\r", start_prop);
> +		return;

All these printf() / return stanzas add a lot of verbosity to this
function.  Any way they can be consolidated a bit, maybe a single
error path that just prints the property values, so the user can
figure out what was wrong with them.

> +	}
> +
> +	rc = getprop(devp, end_prop, &initrd_end, sizeof(initrd_end));
> +	if (rc < 0) {
> +		printf("chosen has %s but no %s!\n\r", start_prop, end_prop);
> +		return;
> +	}
> +	if (rc == sizeof(unsigned long)) {
> +		unsigned long tmp;
> +		memcpy(&tmp, &initrd_end, rc);
> +		initrd_end = tmp;
> +	} else if (rc != sizeof(initrd_end)) {
> +		printf("unexpected length of %s in /chosen!\n\r", end_prop);
> +		return;
> +	}
> +
> +	/* Check for presence, ignore if (partially) loaded above 32 bits */
> +	if (initrd_start == initrd_end) {
> +		printf("ignoring empty device-tree supplied initrd\n");
> +	} else if (initrd_start > initrd_end) {
> +		printf("ignoring device-tree supplied initrd: start 0x%llx"
> +				" > end 0x%llx \n", initrd_start, initrd_end);
> +	} else if (initrd_end > UINT_MAX) {
> +		printf("ignoring device-tree supplied initrd:"
> +				" end 0x%llx > 32 bits\n", initrd_end);
> +	} else {
> +		loader_info.initrd_addr = initrd_start;
> +		loader_info.initrd_size  = initrd_end - initrd_start;
> +	}
> +}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
