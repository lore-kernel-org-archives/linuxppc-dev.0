Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 3AF0EDDF21
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 21:43:22 +1100 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 24 Jan 2007 11:43:13 +0100
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 7/10] local_t : powerpc
Message-ID: <20070124104313.GB22579@iram.es>
References: <20061221001545.GP28643@Krystal> <20061221002705.GW28643@Krystal>
	<17847.8700.118329.777644@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17847.8700.118329.777644@cargo.ozlabs.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
	Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@mbligh.org>,
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

On Wed, Jan 24, 2007 at 08:08:12PM +1100, Paul Mackerras wrote:
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
> > +/* Use these for per-cpu local_t variables: on some archs they are
> > + * much more efficient than these naive implementations.  Note they take
> > + * a variable, not an address.
> > + *
> > + * This could be done better if we moved the per cpu data directly
> > + * after GS.
> > + */
> 
> What's "GS"?  Does this comment really apply on powerpc?
> 

1) It's an (application visible) i386/x86_64 segment register used
   to make memory addressing more confusing.
2) Because of 1), obviously not ;-)

	Gabriel
