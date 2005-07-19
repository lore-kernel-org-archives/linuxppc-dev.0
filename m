Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Jul 2005 11:17:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050719011717.GG24609@localhost.localdomain>
References: <1120859097.8609.15.camel@cashmere.sps.mot.com>
	<20050711045532.GC32545@localhost.localdomain>
	<1121116950.15394.14.camel@cashmere.sps.mot.com>
	<20050712040623.GG3945@localhost.localdomain>
	<1121371427.24467.34.camel@cashmere.sps.mot.com>
	<20050715071924.GA16797@localhost.localdomain>
	<1121437857.24864.12.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1121437857.24864.12.camel@cashmere.sps.mot.com>
Cc: linuxppc64-dev@ozlabs.org,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PATCH: Add memreserve to DTC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2005 at 09:30:58AM -0500, Jon Loeliger wrote:
> On Fri, 2005-07-15 at 02:19, David Gibson wrote:
> 
> > 
> > Ok, I've merged this, 
> 
> Excellent, thanks!
> 
> > although I've tweaked things substantially in the process.
> 
> No problem.
> 
> >   I did rename "header_tree" to "boot_info", moved some
> 
> Oh, good!
> 
> > things around, and changed the syntax.  Reserve ranges can now be
> > specified either as an address and length:
> > 
> > 	/memreserve/	10000000 00002000;
> > 
> > or as an (inclusive) address range:
> > 
> > 	/memreserve/	10000000-10001fff;
> > 
> > I am a bit worried that those two forms may be hard to distinguish at
> > a glance.  Any sugggestions for changes to the syntax soon please, I'd
> > really like to keep the source syntax as stable as possible.
> 
> Oh man.  With syntax you can demystify those in any number
> of ways.  Just a matter of what you are wanting.  You can
> always add sugar:
> 
>     /memreserve_block/    10000000 00002000;
>     /memreserve_range/    10000000 10001fff;
> 
>     /memreserve/    10000000 /for/     2000;        //  or /size/ ?
>     /memreserve/    10000000 /through/ 10001fff;
> 
>     /memreserve/    10000000 00002000;
>     /memreserve/   [10000000, 10001fff];     // or [10000000, 10002000)?
> 
> Stuff like that maybe?

Hrm.. don't really like any of those better than what I have already,
I'm afraid.  It does occur to me that size > base is going to be a
very rare situation, so the value of the numbers themselves will act
as a reasonable hint as to which form is in use.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
