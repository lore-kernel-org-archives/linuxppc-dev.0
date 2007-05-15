Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 16:58:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515065826.GF6998@localhost.localdomain>
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
	<200705150811.09927.sr@denx.de>
	<20070515061855.GD6998@localhost.localdomain>
	<1950a79f97480ba96f1b00352ec449a5@kernel.crashing.org>
	<20070515063408.GE6998@localhost.localdomain>
	<5c785f662c13fdd938d48e40d3107050@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5c785f662c13fdd938d48e40d3107050@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 08:47:00AM +0200, Segher Boessenkool wrote:
> >>> finally "ibm,sdram-4xx".
> >>
> >> Is that last entry ever useful?  Do all those controllers
> >> have something in common?
> >
> > A quick glance over the descriptions in the 440GP and 405GP user
> > manuals suggests that they have most of the registers in common,
> > though I haven't checked to see if the semantics of those registers
> > are actually all the same.
> 
> Let me rephrase: can a kernel driver ever do anything
> useful with the device if it _only_ knows it is some
> 4xx memory controller?
> 
> If that isn't the case, but for example, the 440GP's
> controller can be driven by the 405GP driver, you
> can express exactly that in the "compatible" property.
> It is a bad plan in general to say "4xx", it suggests
> compatibility both ways, which almost never is true;
> so what _does_ it mean?  Lowest common denominator?
> Say exactly that, then.  "compatible" is meant for
> drivers to figure if they can drive the device (or,
> equivalently, for the kernel to figure out which driver
> can drive a given device).

Ok, I see what you mean.

Sod it, I think I'll just drop everything except "ibm,sdram-440gp" for
now.  The one place we access the SDRAM controller, it's under
platform control anyway we do it via direct DCR access anyway, so the
compatible property is pretty much irrelevant.

If a clearer pattern emerges later, we can add more compatible
strings.  If some later driver has to have an extra backwards
compatibility id_table entry for the Ebony/440GP it's no great
disaster.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
