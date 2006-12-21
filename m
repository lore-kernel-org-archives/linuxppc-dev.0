Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D070BDDEBA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 14:16:35 +1100 (EST)
Subject: Re: [PATCH 7/9] atomic.h : powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
In-Reply-To: <20061221001204.GM28643@Krystal>
References: <20061221001204.GM28643@Krystal>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 14:15:05 +1100
Message-Id: <1166670905.6673.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@mbligh.org>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	Douglas Niehaus <niehaus@eecs.ku.edu>,
	Ingo Molnar <mingo@redhat.com>, paulus@samba.org,
	systemtap@sources.redhat.com, ltt-dev@shafik.org,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +
> +/**
> + * atomic64_add_unless - add unless the number is a given value
> + * @v: pointer of type atomic64_t
> + * @a: the amount to add to v...
> + * @u: ...unless v is equal to u.
> + *
> + * Atomically adds @a to @v, so long as it was not @u.
> + * Returns non-zero if @v was not @u, and zero otherwise.
> + */
> +static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> +{
> +	long t;
> +
> +	__asm__ __volatile__ (
> +	LWSYNC_ON_SMP
> +"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
> +	cmpd	0,%0,%3 \n\
> +	beq-	2f \n\
> +	add	%0,%2,%0 \n"
> +	PPC405_ERR77(0,%2)
> +"	stdcx.	%0,0,%1 \n\
> +	bne-	1b \n"
> +	ISYNC_ON_SMP
> +"	subf	%0,%2,%0 \n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&v->counter), "r" (a), "r" (u)
> +	: "cc", "memory");
> +
> +	return t != u;
> +}
> +

You shouldn't try to define those when building 32 bits code... Also,
the PPC405 errata, as it's name implies, is specific to 405 cores which
are all 32 bits.

Ben.
