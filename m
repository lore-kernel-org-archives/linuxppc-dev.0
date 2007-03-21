Return-Path: <dgibson@ozlabs.org>
Date: Wed, 21 Mar 2007 14:12:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 03/17] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070321031214.GH27969@localhost.localdomain>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172757.GC29784@ld0162-tx32.am.freescale.net>
	<20070320035005.GB21124@localhost.localdomain>
	<20070320163422.GA6290@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070320163422.GA6290@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 11:34:22AM -0500, Scott Wood wrote:
> On Tue, Mar 20, 2007 at 02:50:05PM +1100, David Gibson wrote:
> > On Fri, Mar 16, 2007 at 12:27:57PM -0500, Scott Wood wrote:
> > > xlate_reg() uses the ranges properties of a node's parentage to find the
> > > absolute physical address of the node's registers.
> > > 
> > > The ns16550 driver uses this when no virtual-reg property is found.
> > 
> > This is a pretty large chunk of code for use on just some platforms.
> 
> It'd be useful on most flatdevicetree platforms that don't have
> physical addresses larger than virtual addresses...

> > Remind me why we can't just insist on the presence of virtual-reg?
> 
> We can, if that's what the general consensus is... but I'd prefer not to.
> 
> For one thing, it impairs mobility of the SOC register block -- the
> knowledge of where the SOC is mapped would be contained both in the SOC
> node and in the serial nodes (and have to be updated both places).  This
> could be a bit of a pain if macros and/or overlays are implemented.

Hrm, yeah, okay, I'm convinced.  I hope to get a patch out later today
which is a merger of yours and my ideas for devtree.c, excluding
xlate_reg().  Can you rebase on top of that?

> And I don't really understand complaining about the wastage for platforms
> that don't need it in this specific case, when it happens in many others:
> flatdevtree code with true OF, command line editing when it can be edited
> just fine in the bootloader, simple_alloc with true OF, gzip code when
> not compressing vmlinux, etc.  

Um.. flatdevtree and simple_alloc aren't included on OF (they're
built, but not linked in).  Command line editing will be probably be
included in some redundant cases at present, because it's in the same
module as the rest of the serial stuff, but that would be
straightforward to fix.  zlib is always included, it would be nice to
avoid that, but it's a bit less straightforward (but I think we can do
it with some dummy store-only versions of the gunzip_util.c functions,
plus some more weak symbol magic).

> Not to mention the duplication of device
> tree manipulation code that could have been shared with the kernel if
> this stuff weren't forced into the wrapper (why is OF allowed to have a
> special prom_init, but nothing else?).

Legacy.  We'd like to get rid of OF's special casing eventually.

> If we really want to optimize for size, the approach of including
> everything except small bits of code for specific other platforms
> probably isn't the best one.  Does anyone actually do the
> wrap-kernels-separate-from-building thing?

But we *don't* include everything - only the modules that are actually
needed from wrapper.a will be linked in.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
