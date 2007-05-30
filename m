Return-Path: <dgibson@ozlabs.org>
Date: Thu, 31 May 2007 01:12:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Consolidate cuboot initialization code
Message-ID: <20070530151236.GA14432@localhost.localdomain>
References: <20070530020110.GC21955@localhost.localdomain>
	<465D9397.7000008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <465D9397.7000008@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 30, 2007 at 10:09:11AM -0500, Scott Wood wrote:
> David Gibson wrote:
> > +void cuboot_init(unsigned long r4, unsigned long r5,
> > +		 unsigned long r6, unsigned long r7,
> > +		 unsigned long end_of_ram);
> > +
> > +#define CUBOOT_INIT() \
> > +	do { \
> > +		memcpy(&bd, (bd_t *)r3, sizeof(bd)); \
> > +		cuboot_init(r4, r5, r6, r7, bd.bi_memstart + bd.bi_memsize); \
> > +	} while (0)
> 
> Is there any particular reason to not just do a direct call to 
> cuboot_init, and move the memcpy and end-of-ram calculation there?  I'd 
> rather avoid macros if possible.

Uh.. yeah.. because cuboot_init() doesn't know the size to memcpy(),
because it doesn't have the right bd_t definition.

> Also, the "extern char _dtb_start[], _dtb_end[];" line in cuboot.c 
> doesn't appear to be needed.

Oh, yeah, that's a hangover from when I had the ft initialization in
there as well.  That works for 83xx and 85xx, but not ebony.

> Other than that, it looks good.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
