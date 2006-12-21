Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts13-srv.bellnexxia.net (tomts13.bellnexxia.net
	[209.226.175.34]) by ozlabs.org (Postfix) with ESMTP id D3714DDE39
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 14:34:26 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.205.181])
	by tomts13-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20061221033424.PGDC1773.tomts13-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 22:34:24 -0500
Date: Wed, 20 Dec 2006 22:34:23 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Christoph Hellwig <hch@infradead.org>, paulus@samba.org
Subject: Re: [Ltt-dev] [PATCH 7/10] local_t : powerpc
Message-ID: <20061221033423.GC14930@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002705.GW28643@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061221002705.GW28643@Krystal>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>, linuxppc-dev@ozlabs.org,
	Douglas Niehaus <niehaus@eecs.ku.edu>, ltt-dev@shafik.org,
	systemtap@sources.redhat.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Mathieu Desnoyers (mathieu.desnoyers@polymtl.ca) wrote:
> --- a/include/asm-powerpc/local.h
> +++ b/include/asm-powerpc/local.h
> +/**
> + * local_add_unless - add unless the number is a given value
> + * @l: pointer of type local_t
> + * @a: the amount to add to l...
> + * @u: ...unless l is equal to u.
> + *
> + * Atomically adds @a to @l, so long as it was not @u.
> + * Returns non-zero if @l was not @u, and zero otherwise.
> + */
> +static __inline__ int local_add_unless(local_t *l, long a, long u)
> +{
> +	long t;
> +
> +	__asm__ __volatile__ (
> +"1:	ldarx	%0,0,%1		# local_add_unless\n\
> +	cmpd	0,%0,%3 \n\
> +	beq-	2f \n\
> +	add	%0,%2,%0 \n"
> +	PPC405_ERR77(0,%2)

Sorry, the previous line is unnecessary : PPC405 is a 32 bits arch errata and
this code is compiled on 64 bits arch only.

> +"	stdcx.	%0,0,%1 \n\
> +	bne-	1b \n"
> +"	subf	%0,%2,%0 \n\
> +2:"
> +	: "=&r" (t)
> +	: "r" (&(l->a.counter)), "r" (a), "r" (u)
> +	: "cc", "memory");
> +
> +	return t != u;
> +}
> +

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
