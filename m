Return-Path: <dgibson@ozlabs.org>
Date: Thu, 20 May 2010 11:18:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: make the padding for the device tree a
	configurable option
Message-ID: <20100520011820.GT25892@yookeroo>
References: <1274298809-12772-1-git-send-email-timur@freescale.com>
	<1274304013.1931.6.camel@pasglop> <4BF4593E.8030101@freescale.com>
	<1274309050.1931.21.camel@pasglop>
	<AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTilefxXcMnWqKSultu88r4D9W98adHLHxvUwi113@mail.gmail.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 19, 2010 at 07:03:17PM -0500, Timur Tabi wrote:
> On Wed, May 19, 2010 at 5:44 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> 
> > It's still not kernel business to have to deal with u-boot memory
> > allocation constraints.
> 
> I agree, but it still makes sense to me to allow the padding to be configurable.
> 
> > The padding in the kernel built is intended to
> > make space for DT changes done by the zImage wrapper.
> 
> Well, okay.  I think it would be nice if we expanded that to handle
> general usage.
> 
> > Maybe we could add to libfdt a way to provide a realloc() callback to it
> > when it hits the max size, and uboot can then move things around (or
> > fail).
> 
> The problem is that the code which allocates a block for the fdt is
> completely distinct from the code that manipulates the fdt.  We'd need
> to put in either some kind of funky callback mechanism, or insist that
> every fdt exist in a block of memory allocated by some specific method
> (e.g. lmb).
> 
> I'm stuck between a rock and a hard place, it seems.  No one is
> willing to compromise on any of my ideas.  It's hard to convince our
> BSP developers that they should be pushing more code upstream when I
> get so much resistance for a such a mundane change.

Couldn't you use the configurable padding, but put the stuff to do it
into u-boot.  i.e. repad the dtb at u-boot build time, rather than
u-boot runtime.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
