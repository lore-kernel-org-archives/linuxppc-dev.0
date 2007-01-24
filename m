Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17847.8700.118329.777644@cargo.ozlabs.ibm.com>
Date: Wed, 24 Jan 2007 20:08:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH 7/10] local_t : powerpc
In-Reply-To: <20061221002705.GW28643@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002705.GW28643@Krystal>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Douglas Niehaus <niehaus@eecs.ku.edu>,
	Ingo Molnar <mingo@redhat.com>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mathieu Desnoyers writes:

> +static __inline__ int local_dec_if_positive(local_t *l)
> +{
> +	int t;
> +
> +	__asm__ __volatile__(
> +"1:	lwarx	%0,0,%1		# local_dec_if_positive\n\
> +	addic.	%0,%0,-1\n\
> +	blt-	2f\n"
> +	PPC405_ERR77(0,%1)
> +"	stwcx.	%0,0,%1\n\
> +	bne-	1b"

This has the same bugs that we fixed recently in atomic_dec_if_positive;
first, on 64-bit machines, the lwarx will zero-extend the word loaded
from memory, and so the result of the addic will be negative only if
the word was originally 0.  Secondly, even on 32-bit machines,
0x80000000 will be considered positive since decrementing it gives
0x7fffffff, which is positive.

> +/* Use these for per-cpu local_t variables: on some archs they are
> + * much more efficient than these naive implementations.  Note they take
> + * a variable, not an address.
> + *
> + * This could be done better if we moved the per cpu data directly
> + * after GS.
> + */

What's "GS"?  Does this comment really apply on powerpc?

Paul.
