Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4E560DE026
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 13:48:58 +1100 (EST)
Date: Thu, 11 Dec 2008 18:47:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Message-Id: <20081211184753.97d0db7a.akpm@linux-foundation.org>
In-Reply-To: <200812121331.34602.nickpiggin@yahoo.com.au>
References: <200812101950.51958.yur@emcraft.com>
	<20081211202800.GQ28946@ZenIV.linux.org.uk>
	<20081211124330.ff9b7483.akpm@linux-foundation.org>
	<200812121331.34602.nickpiggin@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 12 Dec 2008 12:31:33 +1000 Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> On Friday 12 December 2008 07:43, Andrew Morton wrote:
> > On Thu, 11 Dec 2008 20:28:00 +0000
> 
> > >  Do they actually cross the page boundaries?
> >
> > Some flavours of slab have at times done an order-1 allocation for
> > objects which would fit into an order-0 page (etc) if it looks like
> > that will be beneficial from a packing POV.  I'm unsure whether that
> > still happens - I tried to get it stamped out for reliability reasons.
> 
> Hmph, SLUB uses order-3 allocations for 832 byte sized objects
> by default here (mm struct).

That sucks, but at least it's <= PAGE_ALLOC_COSTLY_ORDER.

It's fortunate that everyone has more than 128GB of memory.
