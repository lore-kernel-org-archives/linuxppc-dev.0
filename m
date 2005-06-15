Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1118862046.25372.49.camel@cashmere.sps.mot.com>
References: <1117614390.19020.24.camel@gaston>
	<1117614484.19020.27.camel@gaston> <1117783104.31082.151.camel@gaston>
	<1117819176.6517.290.camel@cashmere.sps.mot.com>
	<1118199997.6850.106.camel@gaston>
	<1118862046.25372.49.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Thu, 16 Jun 2005 07:52:53 +1000
Message-Id: <1118872373.5986.242.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Discuss: Adding OF Flat Dev Tree to ppc32
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-15 at 14:00 -0500, Jon Loeliger wrote:
> On Tue, 2005-06-07 at 22:06, Benjamin Herrenschmidt wrote:
> 
> > It's basically used to extract some infos directly from the flattened
> > tree in order to construct the LMB list (list of memory blocks,
> > equivalent of ppc32's mem_pieces), 
> 
> 
> OK.  So the unflattenting process requires a small amount
> of memory allocation which is currently implemented using
> the lmb mechanism in PPC64 land.

Not only the unflattening process. The full MMU initialisation (ability
to map things etc...) needs mem_pieces too. The ppc32 kernel runs with a
very limited memory setup until that happens.

> As you indicate, there is also the mem_pieces implementation
> over in ppc32 land.  I think it is currently only used by
> arch/ppc/platforms/pmac_setup.c.

mem_pieces is used in several places in the early mmu setup too
in arch/ppc/mm/*

> In porting this code over to PPC32 land, there are roughly
> three choices:
> 
>    1) Copy the LMB implementation from ppc64 over to PPC32 land,

No, we can stick to mem_pieces

>    2) Change the unflattening code in PPC32 to use mem_pieces,
>       or rewrite it to allow a configurable choice between
>       LMB and mem_pieces,

mem_pieces is fine

>    3) Make up something new, yet very similar to LMB and
>       mem_pieces.
> 
> Does anyone have suggestions or advice on route 1) or 2)?
> Anyone?  Kumar?  Ben?  Bueller?

The main issues is not really there. The problem is that we will have to
scan the flattened tree at boot in order to setup the MMU and that will
have to be done with a very limited access to memory, possibly only the
low 32Mb of RAM for example (though we may manage something better
running in real mode with some CPUs).

That means maybe imposing some restrictions on where the flattened
device-tree block can be when passed to the kernel (unless we can run
that C code in real mode) and other niceties that will have to be dealt
per CPU family.

Ben.
