Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A99CADDF85
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 07:44:49 +1100 (EST)
Date: Thu, 11 Dec 2008 12:43:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH][v2] fork_init: fix division by zero
Message-Id: <20081211124330.ff9b7483.akpm@linux-foundation.org>
In-Reply-To: <20081211202800.GQ28946@ZenIV.linux.org.uk>
References: <200812101950.51958.yur@emcraft.com>
	<20081211121635.ff58193f.akpm@linux-foundation.org>
	<20081211202800.GQ28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, miltonm@bga.com,
	Geert.Uytterhoeven@sonycom.com, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 11 Dec 2008 20:28:00 +0000
Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Thu, Dec 11, 2008 at 12:16:35PM -0800, Andrew Morton wrote:
> > > +#if (8 * THREAD_SIZE) > PAGE_SIZE
> > >  	max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
> > > +#else
> > > +	max_threads = mempages * (PAGE_SIZE / (8 * THREAD_SIZE));
> > > +#endif
> > 
> > The expression you've chosen here can be quite inacccurate, because
> > ((PAGE_SIZE / (8 * THREAD_SIZE)) is a small number.  The way to
> > preserve accuracy is
> > 
> > 	max_threads = (mempages * PAGE_SIZE) / (8 * THREAD_SIZE);
> > 
> > so how about avoiding the nasty ifdefs and doing
> 
> Are you sure?

No, not at all.  It's all too hard.  Which is why I'm looking for
simplification.

>  Do they actually cross the page boundaries?

Some flavours of slab have at times done an order-1 allocation for
objects which would fit into an order-0 page (etc) if it looks like
that will be beneficial from a packing POV.  I'm unsure whether that
still happens - I tried to get it stamped out for reliability reasons.
