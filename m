Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts20-srv.bellnexxia.net (tomts20.bellnexxia.net
	[209.226.175.74]) by ozlabs.org (Postfix) with ESMTP id 4D2C7DDEED
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 14:29:32 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.205.181])
	by tomts20-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20061221032929.RPQF24907.tomts20-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 22:29:29 -0500
Date: Wed, 20 Dec 2006 22:29:28 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/9] atomic.h : powerpc
Message-ID: <20061221032928.GB14930@Krystal>
References: <20061221001204.GM28643@Krystal>
	<1166670905.6673.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1166670905.6673.33.camel@localhost.localdomain>
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

* Benjamin Herrenschmidt (benh@kernel.crashing.org) wrote:
> 
> > +
> > +/**
> > + * atomic64_add_unless - add unless the number is a given value
> > + * @v: pointer of type atomic64_t
> > + * @a: the amount to add to v...
> > + * @u: ...unless v is equal to u.
> > + *
> > + * Atomically adds @a to @v, so long as it was not @u.
> > + * Returns non-zero if @v was not @u, and zero otherwise.
> > + */
> > +static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> > +{
> > +	long t;
> > +
> > +	__asm__ __volatile__ (
> > +	LWSYNC_ON_SMP
> > +"1:	ldarx	%0,0,%1		# atomic_add_unless\n\
> > +	cmpd	0,%0,%3 \n\
> > +	beq-	2f \n\
> > +	add	%0,%2,%0 \n"
> > +	PPC405_ERR77(0,%2)
> > +"	stdcx.	%0,0,%1 \n\
> > +	bne-	1b \n"
> > +	ISYNC_ON_SMP
> > +"	subf	%0,%2,%0 \n\
> > +2:"
> > +	: "=&r" (t)
> > +	: "r" (&v->counter), "r" (a), "r" (u)
> > +	: "cc", "memory");
> > +
> > +	return t != u;
> > +}
> > +
> 
> You shouldn't try to define those when building 32 bits code... Also,
> the PPC405 errata, as it's name implies, is specific to 405 cores which
> are all 32 bits.
> 
> Ben.
> 
> 

Hi Ben,

It is within a 
#ifdef __powerpc64__
...
#endif /* __powerpc64__ */

so it should only build on 64 bits.

You are right about the PPC405 errata, it seems unnecessary.

The same is true for my asm-powerpc/local.h modification.

Thanks,

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
