Return-Path: <dgibson@ozlabs.org>
Date: Tue, 14 Aug 2007 11:35:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
Message-ID: <20070814013510.GA31123@localhost.localdomain>
References: <20070730163517.GA10087@ru.mvista.com>
	<20070802034848.GA837@localhost.localdomain>
	<1186103889.5495.650.camel@localhost.localdomain>
	<20070803045705.GA2392@localhost.localdomain>
	<20070803062346.GA14456@localhost.localdomain>
	<20070813010848.GC18526@localhost.localdomain>
	<46C04F07.3040909@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46C04F07.3040909@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 13, 2007 at 04:31:03PM +0400, Valentine Barshak wrote:
[snip]
> >> Ok, here's a patch which fixes up the flow handling on the UIC.  It
> >> needs some polish yet, but should be ok to test.  Valentine, can you
> >> test this on your setup, *without* your original proposed patch.
> >> Eventually, for robustness, we'll want something like your original
> >> patch as well for robustness, but in the meantime leaving it out
> >> should tell us if my patch is actually having the intended effect.
> > 
> > Valentine, it would be really helpful if you could test this on the
> > problem you observed with the cascade interrupt.  Any word on this?
> > 
> 
> Thanks David,
> the patch works fine here (without the original one).

Ok, great.

> Don't think we really need a "fastcall" here on a powerpc though.

Oh, yeah, that's just copied from the generic handle_level_irq().

> The original patch also fixes a minor issue with /proc/interrupts
> (the the "if (trigger)" stuff).
> Currently level-triggered interrupts are displayed as edge-triggered 
> ones and vice versa.

Yes, we'll still want two patches similar to your original: one to fix
the cosmetic /proc/interrupts problem, the other to make the cascade
handler more robust against spurious interrupts.  I just wanted to see
if this flow handler change fixed the basic problem.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
