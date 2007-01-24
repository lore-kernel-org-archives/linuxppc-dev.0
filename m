Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts5-srv.bellnexxia.net (tomts5.bellnexxia.net
	[209.226.175.25]) by ozlabs.org (Postfix) with ESMTP id 56BD9DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 04:00:27 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.204.133])
	by tomts5-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070124170025.TECH5067.tomts5-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 12:00:25 -0500
Date: Wed, 24 Jan 2007 12:00:22 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/10] local_t : powerpc
Message-ID: <20070124170022.GE4979@Krystal>
References: <20061221001545.GP28643@Krystal> <20061221002705.GW28643@Krystal>
	<17847.8700.118329.777644@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17847.8700.118329.777644@cargo.ozlabs.ibm.com>
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

* Paul Mackerras (paulus@samba.org) wrote:
> Mathieu Desnoyers writes:
> 
> > +static __inline__ int local_dec_if_positive(local_t *l)
> > +{
> > +	int t;
> > +
> > +	__asm__ __volatile__(
> > +"1:	lwarx	%0,0,%1		# local_dec_if_positive\n\
> > +	addic.	%0,%0,-1\n\
> > +	blt-	2f\n"
> > +	PPC405_ERR77(0,%1)
> > +"	stwcx.	%0,0,%1\n\
> > +	bne-	1b"
> 
> This has the same bugs that we fixed recently in atomic_dec_if_positive;
> first, on 64-bit machines, the lwarx will zero-extend the word loaded
> from memory, and so the result of the addic will be negative only if
> the word was originally 0.  Secondly, even on 32-bit machines,
> 0x80000000 will be considered positive since decrementing it gives
> 0x7fffffff, which is positive.
> 
Hi Paul,

Thanks, will fix.

Mathieu

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
