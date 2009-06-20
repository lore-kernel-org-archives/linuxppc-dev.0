Return-Path: <smaclennan@pikatech.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B329FB7234
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 09:10:40 +1000 (EST)
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 321EEDDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 09:10:37 +1000 (EST)
Date: Sat, 20 Jun 2009 19:10:34 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Frans Pop <elendil@planet.nl>
Subject: Re: Badness on the Warp
Message-ID: <20090620191034.48fa085a@lappy.seanm.ca>
In-Reply-To: <200906202256.46073.elendil@planet.nl>
References: <20090620154824.72b5cd50@lappy.seanm.ca>
	<200906202256.46073.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 20 Jun 2009 22:56:45 +0200
Frans Pop <elendil@planet.nl> wrote:

> The fact that your bisect ended at a merge essentially means that it
> is invalid. As a merge does not introduce any actual change (unless
> it includes changes to resolve conflicts), it normally cannot be the
> cause of a regression.

Makes sense I messed up somewhere. This is the commit that causes
problems:

Merge branch 'topic/slab/earlyboot' of git://git./linux/kernel/git/penberg/slab-2.6


* 'topic/slab/earlyboot' of git://git.kernel.org/pub/scm/linux/kernel/git/penberg/slab-2.6:

  vgacon: use slab allocator instead of the bootmem allocator

  irq: use kcalloc() instead of the bootmem allocator

  sched: use slab in cpupri_init()

  sched: use alloc_cpumask_var() instead of alloc_bootmem_cpumask_var()

  memcg: don't use bootmem allocator in setup code

  irq/cpumask: make memoryless node zero happy

  x86: remove some alloc_bootmem_cpumask_var calling

  vt: use kzalloc() instead of the bootmem allocator

  sched: use kzalloc() instead of the bootmem allocator

  init: introduce mm_init()

  vmalloc: use kzalloc() instead of alloc_bootmem()

  slab: setup allocators earlier in the boot sequence

  bootmem: fix slab fallback on numa

  bootmem: use slab if bootmem is no longer available

Makes sense since it is very early in the boot I get the badness. Also, there is no mention of JFS in the above logs.

Cheers,
   Sean
