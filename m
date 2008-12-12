Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp120.mail.mud.yahoo.com (smtp120.mail.mud.yahoo.com
	[209.191.84.77]) by ozlabs.org (Postfix) with SMTP id 69791DE11D
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 14:36:10 +1100 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Date: Fri, 12 Dec 2008 13:36:02 +1000
References: <200812101950.51958.yur@emcraft.com>
	<200812121331.34602.nickpiggin@yahoo.com.au>
	<20081211184753.97d0db7a.akpm@linux-foundation.org>
In-Reply-To: <20081211184753.97d0db7a.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <200812121436.03177.nickpiggin@yahoo.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: wd@denx.de, dzu@denx.de, miltonm@bga.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 12 December 2008 13:47, Andrew Morton wrote:
> On Fri, 12 Dec 2008 12:31:33 +1000 Nick Piggin <nickpiggin@yahoo.com.au> 
wrote:
> > On Friday 12 December 2008 07:43, Andrew Morton wrote:
> > > On Thu, 11 Dec 2008 20:28:00 +0000
> > >
> > > >  Do they actually cross the page boundaries?
> > >
> > > Some flavours of slab have at times done an order-1 allocation for
> > > objects which would fit into an order-0 page (etc) if it looks like
> > > that will be beneficial from a packing POV.  I'm unsure whether that
> > > still happens - I tried to get it stamped out for reliability reasons.
> >
> > Hmph, SLUB uses order-3 allocations for 832 byte sized objects
> > by default here (mm struct).
>
> That sucks, but at least it's <= PAGE_ALLOC_COSTLY_ORDER.

Which is somewhat arbitrary a value. order-1 is costly compared to
order-0...

After running my system here for a while and doing various things
with it, I have the ability to allocate 898 order-0 pages (3592K),
or 36 order-3 pages (1152K).

Not as bad as I expected, but the system's only been up for an hour,
and not exactly doing anything unusual (and it has nearly 30MB free,
out of 4GB).


> It's fortunate that everyone has more than 128GB of memory.

And that SLAB still works quite well :)
