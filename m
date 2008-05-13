Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-wa4-R.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id E9667DDDF7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 10:17:11 +1000 (EST)
Message-ID: <4828DDFE.6050805@am.sony.com>
Date: Mon, 12 May 2008 17:17:02 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 5/5] [PPC] provide walk_memory_resource() for ppc
References: <1206664406.19368.2.camel@dyn9047017100.beaverton.ibm.com>
	<1206664795.19368.13.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1206664795.19368.13.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	lkml <linux-kernel@vger.kernel.org>, Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I've had some trouble with this change.

Badari Pulavarty wrote:
> Provide walk_memory_resource() for ppc64. PPC maintains 
> logic memory region mapping in lmb.memory structures. Walk
> through these structures and do the callbacks for the
> contiguous chunks.

...

> --- linux-2.6.25-rc3.orig/arch/powerpc/mm/mem.c	2008-03-05 10:14:28.000000000 -0800
> +++ linux-2.6.25-rc3/arch/powerpc/mm/mem.c	2008-03-05 10:32:16.000000000 -0800
> @@ -148,19 +148,35 @@ out:
>  
>  /*
>   * walk_memory_resource() needs to make sure there is no holes in a given
> - * memory range. On PPC64, since this range comes from /sysfs, the range
> - * is guaranteed to be valid, non-overlapping and can not contain any
> - * holes. By the time we get here (memory add or remove), /proc/device-tree
> - * is updated and correct. Only reason we need to check against device-tree
> - * would be if we allow user-land to specify a memory range through a
> - * system call/ioctl etc. instead of doing offline/online through /sysfs.
> + * memory range. PPC64 does not maintain the memory layout in /proc/iomem.
> + * Instead it maintains it in lmb.memory structures. Walk through the
> + * memory regions, find holes and callback for contiguous regions.
>   */
>  int
>  walk_memory_resource(unsigned long start_pfn, unsigned long nr_pages, void *arg,
>  			int (*func)(unsigned long, unsigned long, void *))
>  {
> -	return  (*func)(start_pfn, nr_pages, arg);
> +	struct lmb_property res;
> +	unsigned long pfn, len;
> +	u64 end;
> +	int ret = -1;
> +
> +	res.base = (u64) start_pfn << PAGE_SHIFT;
> +	res.size = (u64) nr_pages << PAGE_SHIFT;
> +
> +	end = res.base + res.size - 1;
> +	while ((res.base < end) && (lmb_find(&res) >= 0)) {
                                    ^^^^^^^^^^^^^^

In the PS3 platform code (arch/pwerpc/platfroms/ps3/mm.c) the hotplug
memory is added like this:

	...
	result = add_memory(0, start_addr, map.r1.size);
	...
	result = online_pages(start_pfn, nr_pages);
	...

In its work, online_pages() eventually calls walk_memory_resource(),
which has been changed as above to do a test on lmb_find(). I found
that this lmb_find() test always fails for PS3 since add_memory()
does not call lmb_add().

Is it the responsibility of the platform code to call lmb_add(), or
should that be done by add_memory()?

-Geoff
