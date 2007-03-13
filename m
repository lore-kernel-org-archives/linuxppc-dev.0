Return-Path: <dgibson@ozlabs.org>
Date: Tue, 13 Mar 2007 16:10:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Message-ID: <20070313051031.GQ29506@localhost.localdomain>
References: <200703122254.27087.sr@denx.de>
	<17910.12015.508991.966593@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17910.12015.508991.966593@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 13, 2007 at 03:56:15PM +1100, Paul Mackerras wrote:
> Stefan Roese writes:
> 
> > +config PPC_PAGE_SHIFT
> > +	int "Page size (12=>4KB; 16=>64KB)"
> > +	default "12"
> > +	range 12 16
> > +	help
> > +	  The PAGE_SIZE definition. Increasing the page size may 
> > +	  improve the system performance in some dedicated cases.
> > +
> > +	  If unsure, set it to 12 (4KB).
> 
> [snip]
> 
> > +#else
> > +#error "Unsupported PAGE_SIZE"
> > +#endif
> 
> If you only support 4k and 64k page sizes, why do you let the user
> choose 13, 14 or 15 for PPC_PAGE_SHIFT?  Why not just have a "64k
> pages" boolean option like 64-bit powerpc does?

As far as I can tell from the patch, 14 should work too (16kB pages).
13 or 15 won't, since only power-of-4 pagesizes are supported on 44x.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
