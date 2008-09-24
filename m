Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DBD8DDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 11:46:39 +1000 (EST)
Date: Tue, 23 Sep 2008 20:46:18 -0500 (CDT)
Message-Id: <200809240146.m8O1kIpZ077447@sullivan.realtime.net>
To: Sebastian Siewior <bigeasy@linutronix.de>
Sender: Milton Miller <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
Subject: [RFC] powerpc/boot: compare _start against ei.loadsize instead
	ei.memsize
In-Reply-To: <20080923203857.GB10935@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Sep 24 at about 06:38:57 EST in 2008, Sebastian Siewior wrote:
> My mylinux binary incl. bss is ~5 MiB without bss less than 4 MiB.
> Therefore I though that I could replace ei.memsize with ei.loadsize. It
> didn't work. I'm not sure why it did not work but I guess that the
> memset() of bss in the initial kernel code overwrote the cuimage code
> which is required for some reason. Maybe some device-tree callbacks.

probably because the bss extended beyond the cuboot _end to include
where your device tree was copied (just a malloc and we start
simple_malloc at the boot _end on most platforms).

> 
> My current (working) solution is to move cuImage from 4 MiB to 8 MiB.
> Something similar has been done for pSeries in 9b09c6d "powerpc: Change
> the default link address for pSeries zImage kernels". Would it be
> appropriate to move initial address to 64 MiB as the default loading
> address or do we have here some boards which have only 64 MiB of memory?

I think there are some boards that have even less (8xx?).  Is the
link address a wrapper option yet?

> Does someone have another idea?
> 
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -56,7 +56,7 @@ static struct addr_range prep_kernel(void)
>  	if (platform_ops.vmlinux_alloc) {
>  		addr = platform_ops.vmlinux_alloc(ei.memsize);
>  	} else {
> -		if ((unsigned long)_start < ei.memsize)
> +		if ((unsigned long)_start < ei.loadsize)


I think this needs to be a two part test (add approprate casts):  
	_start < ei.loadsize || _end < ei.memsize

.. and a comment explaining why.

We could do better if we kept allocating more memory until we got
above it, but the current code has no such provision.  (prpmc2800, or
one of those, actually decompresses the header to peek at memsize
before starting the simple_alloc code).

>  			fatal("Insufficient memory for kernel at address 0!"
>  			       " (_start=%p)\n\r", _start);
>  	}
> -- 
> 
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -138,7 +138,7 @@ objflags=-S
>  tmp=$tmpdir/zImage.$$.o
>  ksection=.kernel:vmlinux.strip
>  isection=.kernel:initrd
> -link_address='0x400000'
> +link_address='0x800000'
>  
>  case "$platform" in
>  pseries)
> -- 
