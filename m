Return-Path: <dgibson@ozlabs.org>
Date: Tue, 11 Dec 2007 10:32:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] Use embedded libfdt in the bootwrapper
Message-ID: <20071210233225.GD5495@localhost.localdomain>
References: <20071210032343.GB29611@localhost.localdomain>
	<20071210032839.71412DDDFA@ozlabs.org>
	<20071210173217.GB4497@loki.buserror.net>
	<20071210231056.GC5495@localhost.localdomain>
	<475DC966.6070301@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <475DC966.6070301@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 10, 2007 at 05:19:02PM -0600, Scott Wood wrote:
> David Gibson wrote:
> > On Mon, Dec 10, 2007 at 11:32:17AM -0600, Scott Wood wrote:
> >> How does using offsets as devps work if a devp was previously
> >> acquired to a node that has to be moved due to a change later made
> >> in an earlier part of the tree?
> > 
> > It doesn't; don't do that.  I just don't think truly persistent 
> > phandles are worth the code complexity to implement them.
> 
> We already have working code to implement them.  This is a regression 
> over flatdevicetree.c, and it (or something else in libfdt) seems to be 
> breaking the ep8248e wrapper (it didn't make it in to the last window 
> because of dependency on a netdev patch, but I'll probably send it out 
> tomorrow).
> 
> It breaks the extremely common and useful usage of:
> 
> devp = create node;
> setprop(devp, "foo", something);
> setprop(devp, "bar", something);

Uh.. no, that idiom is fine.  setprop() in the node itself, or any
descendent is guaranteed to be safe.

> 
> > Especially since their use more-or-less completely precludes libfdt's
> > "stateless" approach, which has significant other advantages.
> 
> It doesn't preclude stateless read-only -- what are the benefits to 
> stateless read-write that are worth invalidating all node references any 
> time something changes?

It precludes stateless read-only too, unless you have an interface
where devps for read-write are different from those for read-only
which would be nasty.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
