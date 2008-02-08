Return-Path: <dgibson@ozlabs.org>
Date: Fri, 8 Feb 2008 22:02:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC][POWERPC] bootwrapper: Add a firmware-independent
	simpleboot target.
Message-ID: <20080208110219.GC27955@localhost.localdomain>
References: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080202065517.12920.20235.stgit@trillian.secretlab.ca>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 01, 2008 at 11:55:42PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>

[snip]
> +void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
> +		   unsigned long r6, unsigned long r7)
> +{
> +	const u32 *na, *ns, *reg, *timebase;
> +	u64 memsize64;
> +	int node, size, i;
> +
> +	/* Allocate initial heap for probing the tree */
> +	simple_alloc_init(initial_heap, sizeof(initial_heap), 32, 64);
> +
> +	/* Make sure FDT blob is sane */
> +	if (fdt_check_header(_dtb_start) != 0)
> +		fatal("Invalid device tree blob\n");

I think most of these fatal()s are pretty pointless.  This is
platform_init(), so the console won't even have been initialized to
actually print any of the messages.  Precisely because this is
simpleboot, in which every bit of information the wrapper has comes
from teh device tree, if the provided blob is so bad as to fail these
basic tests, we're totally stuffed anyway.  It'll take a hardware
debugger to track down, and I don't think the fatal()s will actually
help much at that point.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
