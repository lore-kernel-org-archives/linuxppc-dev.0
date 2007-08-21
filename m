Return-Path: <dgibson@ozlabs.org>
Date: Tue, 21 Aug 2007 13:25:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 20/20] bootwrapper: Add fsl_get_immr(), mpc885_get_clock(),
	and pq2_get_clocks().
Message-ID: <20070821032546.GS15469@localhost.localdomain>
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174013.GS30562@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820174013.GS30562@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 20, 2007 at 12:40:13PM -0500, Scott Wood wrote:
> fsl_get_immr() is equivalent to the kernel's get_immrbase() function.

I notice that this function assumes that P==V.  Is that true for all
relevant platforms at this point?

> mpc885_get_clock() transforms a crystal frequency into a system frequency
> according to the PLL register settings.
> 
> pq2_get_clocks() does the same as the above for the PowerQUICC II,
> except that it produces several different clocks.

I'd prefer if these functions worked analagously to the
ibm440gp_fixup_clocks() function in ebony.c and fixed up the clock
values in the device tree directly, rather than returning them (where
the caller will presumably poke them into the device tree).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
