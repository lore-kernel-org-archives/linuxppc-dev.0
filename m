Return-Path: <dgibson@ozlabs.org>
Date: Mon, 10 Sep 2007 13:00:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Document and implement an improved flash device binding for
	powerpc (v5)
Message-ID: <20070910030030.GB23072@localhost.localdomain>
References: <20070907032353.GA3082@localhost.localdomain>
	<2fcd14e175d5a215cd8d602ac74fce21@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2fcd14e175d5a215cd8d602ac74fce21@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 04:25:10PM +0200, Segher Boessenkool wrote:
> > This patch replaces the binding for flash chips in
> > booting-without-of.txt with an clarified and improved version.  It
> > also makes drivers/mtd/maps/physmap_of.c recognize this new binding.
> > Finally it revises the Ebony device tree source to use the new binding
> > as an example.
> >
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
> 
> Thanks for doing this work David!
> 
> 
> > +	/* First look for RedBoot table or partitions on the command
> > +	 * line, these take precedence over device tree information */
> 
> Any specific reason you chose this order?  Just curious...

Well, RedBoot on the grounds that an on-device partition table, if
present, should take precedence over platform defaults.  And that
overriding partition information on the command line should, well,
override...

> > +		.data		= (void *)"jedec_probe",
> 
> Hrm, this cast is only getting rid of the const-ness of the
> string literal -- maybe .data should be declared const, or
> does the majority of users want it writable?

Not sure.  But this is defined in the core anyway, and I didn't really
want to bother with delving into that at this time.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
