Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 486A5DDFB3
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 10:33:11 +1100 (EST)
Subject: Re: [PATCH 1/3] add of_find_next_cache_node()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20081215223333.GP6958@localdomain>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
	<1229296287.26324.87.camel@pasglop> <20081215223333.GP6958@localdomain>
Content-Type: text/plain
Date: Tue, 16 Dec 2008 10:33:04 +1100
Message-Id: <1229383984.26324.134.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 16:33 -0600, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > On Wed, 2008-12-10 at 18:46 -0600, Nathan Lynch wrote:
> > > +       /* OF on pmac has nodes instead of properties named "l2-cache"
> > > +        * beneath CPU nodes.
> > > +        */
> > > +       if (!strcmp(np->type, "cpu"))
> > > +               for_each_child_of_node(np, child)
> > > +                       if (!strcmp(child->type, "cache"))
> > > +                               return child;
> > > +
> > 
> > pmac has both actually. And the property points to the node. It's a
> > problem for /proc/device-tree so we rename them iirc, but only in /proc,
> > ie, they should still be intact in the tree I think.
> 
> I see the 'l2-cache' property (renamed to 'l2-cache#1' in /proc) on a
> G4 iBook, but it is not present on the two G5 models I've checked.

Ah crap.

Oh well, keep your fallback then.

Don't 970MP have a shared L2 tho ? That will make it look like it's not,
I suppose there isn't much we can do about it tho...

Cheers,
Ben.
