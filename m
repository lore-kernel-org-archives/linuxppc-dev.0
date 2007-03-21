Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 11:01:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 4/7] bootwrapper: add a fatal error helper
Message-ID: <20070321000101.GB27969@localhost.localdomain>
References: <boot-00.miltonm@bga.com> <boot-04.miltonm@bga.com>
	<20070320003847.GB19728@localhost.localdomain>
	<7a08cdfd3ee0f04ed3e96601c9698de6@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7a08cdfd3ee0f04ed3e96601c9698de6@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:38:45AM -0500, Milton Miller wrote:
> 
> On Mar 19, 2007, at 7:38 PM, David Gibson wrote:
> 
> > On Mon, Mar 19, 2007 at 02:58:03PM -0600, Milton Miller wrote:
> >> Add a macro fatal that calls printf then exit.  User must include 
> >> stdio.h.
> >>
> >> Typically replaces 3 lines with 1, although I added back some 
> >> whitespace.
> >>
> >> Signed-off-by: Milton Miller <miltonm@bga.com>
> >
> > One tiny nit...
> >
> > [snip]
> >> Index: kernel/arch/powerpc/boot/ops.h
> >> ===================================================================
> >> --- kernel.orig/arch/powerpc/boot/ops.h	2007-03-19 08:32:50.000000000 
> >> -0500
> >> +++ kernel/arch/powerpc/boot/ops.h	2007-03-19 08:33:02.000000000 -0500
> >> @@ -157,6 +157,8 @@ static inline void exit(void)
> >>  		platform_ops.exit();
> >>  	for(;;);
> >>  }
> >> +#define fatal(args...) { printf(args); exit(); }
> >> +
> >
> > This is the old gcc way of doing a varargs macro, not the new C99
> > way.  The new way would be:
> >
> > #define fata(...)	{ printf(__VA_ARGS__); exit(); }
> >
> 
> I was following the example of fprintf in stdio.h.   Is the new C99
> way used elsewhere in the kernel?

Yes, in a variety of places.  Just grep for __VA_ARGS__.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
