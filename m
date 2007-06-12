Return-Path: <dgibson@ozlabs.org>
Date: Tue, 12 Jun 2007 14:44:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
Message-ID: <20070612044459.GD4198@localhost.localdomain>
References: <bd6ef296692e8cfb81118f2dc85189a5@kernel.crashing.org>
	<4662EAA9.70104@ru.mvista.com>
	<e4197fd2753f2b4d548d5dde9e3fd1d3@kernel.crashing.org>
	<466308F4.8050004@ru.mvista.com>
	<8ac5664208e0f59329b62ac2138bbc8c@kernel.crashing.org>
	<466312C2.4090200@ru.mvista.com>
	<548a7e11ffb577f6395b8f5a9c2fba2d@kernel.crashing.org>
	<466323EF.5040807@ru.mvista.com>
	<1181228442.2785.60.camel@pmac.infradead.org>
	<18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18fbfbaf113ab76b602d279848d9b405@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	Milton Miller <miltonm@bga.com>, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 05:55:44PM +0200, Segher Boessenkool wrote:
> > Any representation of flash devices in the device-tree should ideally
> > have 'bus width' and 'interleave' properties to contain this
> > information.
> >
> > The 'bus width' cannot necessarily be inferred, especially where a 
> > given
> > bus can be configured to allow multiple sizes of access. It's purely a
> > function of how the flash chips are wired up. That's why we actually
> > call it 'bank width', not 'bus width' in the Linux code.
> 
> Ah, "bank width" as in "bus width" per chip select.  I see.
> 
> So I think the best thing to have would be
> 
> 	compatible      "cfi-flash"
> 	bank-width      like you said
> 	device-width    width of a single flash device
> 	reg             complete address range of this thing
> 
> and then the Linux OF CFI flash code / MTD code just keeps
> on probing devices from that address range until it has it
> filled.
> 
> Sounds good / comments / anything I missed?

Looks pretty sensible to me.  Presumably the compatible property could
also have more specific entries for the particular chip type.

Of course, Ebony has flash which is JEDEC rather than CFI probed, so I
have an interest in a binding for that, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
