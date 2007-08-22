Return-Path: <dgibson@ozlabs.org>
Date: Wed, 22 Aug 2007 11:30:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 20/20] bootwrapper: Add fsl_get_immr(), mpc885_get_clock(),
	and pq2_get_clocks().
Message-ID: <20070822013042.GE12472@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174013.GS30562@ld0162-tx32.am.freescale.net>
	<20070821032546.GS15469@localhost.localdomain>
	<46CB1425.1040709@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46CB1425.1040709@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 21, 2007 at 11:34:45AM -0500, Scott Wood wrote:
> David Gibson wrote:
> > On Mon, Aug 20, 2007 at 12:40:13PM -0500, Scott Wood wrote:
> > 
> >>fsl_get_immr() is equivalent to the kernel's get_immrbase() function.
> > 
> > I notice that this function assumes that P==V.  Is that true for all
> > relevant platforms at this point?
> 
> Yes.  If that ever changes, we'd probably need to add a virtual-immr or 
> similar.

Ok.

> >>mpc885_get_clock() transforms a crystal frequency into a system frequency
> >>according to the PLL register settings.
> >>
> >>pq2_get_clocks() does the same as the above for the PowerQUICC II,
> >>except that it produces several different clocks.
> > 
> > I'd prefer if these functions worked analagously to the
> > ibm440gp_fixup_clocks() function in ebony.c and fixed up the clock
> > values in the device tree directly, rather than returning them (where
> > the caller will presumably poke them into the device tree).
> 
> I wanted to separate the register interpretation from the knowledge of 
> where things are in the device tree.

Hrm.  I considered that for a while with 44x, before deciding it
wasn't worth the extra hassle of passing a bunch of things around.  If
you look at the 44x version, you'll see that the device tree poking
part is just the last few lines of the function and more-or-less
independent from the rest of it.  So it should be easy to make the
function separable into hw-logic vs. dt-logic portions if we ever need
to.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
