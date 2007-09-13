Return-Path: <dgibson@ozlabs.org>
Date: Thu, 13 Sep 2007 14:21:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070913042138.GB14905@localhost.localdomain>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<a58bb9a05680c3befc4d3588992caed0@kernel.crashing.org>
	<39A1A44F-CD73-4CC1-89DE-608A1041AAF7@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39A1A44F-CD73-4CC1-89DE-608A1041AAF7@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 10:28:24PM -0500, Kumar Gala wrote:
[snip]
> >> +	soc8572@ffe00000 {
> >
> > You should put an interrupt-parent in here, so you can get rid of
> > it in all the children.
> 
> Are interrupt-parent's inherited by child nodes?

Strictly speaking, a node's default interrupt-parent is its physical
parent.  And a node without interrupt-map identity maps all interrupts
to *its* parent.  So the interrupt is notionally wired from the child
to its parent and so forth up the bus tree until it reaches a node
with a specified interrupt-parent or interrupt-map.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
