Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6FFAEB7BEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Sep 2009 16:21:45 +1000 (EST)
Subject: Re: [PATCH 1/1] powerpc: Fix to handle slb resize across migration
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian King <brking@linux.vnet.ibm.com>
In-Reply-To: <200908282206.n7SM6UK1011114@d03av01.boulder.ibm.com>
References: <200908282206.n7SM6UK1011114@d03av01.boulder.ibm.com>
Content-Type: text/plain
Date: Wed, 02 Sep 2009 16:21:37 +1000
Message-Id: <1251872497.14675.424.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-28 at 17:06 -0500, Brian King wrote:
> The SLB can change sizes across a live migration, which was not
> being handled, resulting in possible machine crashes during
> migration if migrating to a machine which has a smaller max SLB
> size than the source machine. Fix this by first reducing the
> SLB size to the minimum possible value, which is 32, prior to
> migration. Then during the device tree update which occurs after
> migration, we make the call to ensure the SLB gets updated. Also
> add the slb_size to the lparcfg output so that the migration
> tools can check to make sure the kernel has this capability
> before allowing migration in scenarios where the SLB size will change.

The patch causes a build error on 32-bit hash in rtas.c due to this:

> diff -puN arch/powerpc/kernel/rtas.c~powerpc_slb_resize arch/powerpc/kernel/rtas.c
> --- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
> +++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2009-08-21 16:14:41.000000000 -0500
> @@ -39,6 +39,7 @@
>  #include <asm/smp.h>
>  #include <asm/atomic.h>
>  #include <asm/time.h>
> +#include <asm/mmu-hash64.h>

This should just be asm/mmu.h

This is true of all occurences, ie, mmu-hash64.h isn't meant to be
directly included (though it causes no breakage in the other cases)

I'm going to commit a fixed version to powerpc-next today, you may want
to update the version you are sending to distros.

Cheers,
Ben.
