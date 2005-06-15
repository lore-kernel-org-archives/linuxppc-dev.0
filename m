Return-Path: <jdl@freescale.com>
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1118199997.6850.106.camel@gaston>
References: <1117614390.19020.24.camel@gaston>
	<1117614484.19020.27.camel@gaston> <1117783104.31082.151.camel@gaston>
	<1117819176.6517.290.camel@cashmere.sps.mot.com>
	<1118199997.6850.106.camel@gaston>
Content-Type: text/plain
Message-Id: <1118862046.25372.49.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 15 Jun 2005 14:00:46 -0500
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

On Tue, 2005-06-07 at 22:06, Benjamin Herrenschmidt wrote:

> It's basically used to extract some infos directly from the flattened
> tree in order to construct the LMB list (list of memory blocks,
> equivalent of ppc32's mem_pieces), 


OK.  So the unflattenting process requires a small amount
of memory allocation which is currently implemented using
the lmb mechanism in PPC64 land.

As you indicate, there is also the mem_pieces implementation
over in ppc32 land.  I think it is currently only used by
arch/ppc/platforms/pmac_setup.c.


In porting this code over to PPC32 land, there are roughly
three choices:

   1) Copy the LMB implementation from ppc64 over to PPC32 land,

   2) Change the unflattening code in PPC32 to use mem_pieces,
      or rewrite it to allow a configurable choice between
      LMB and mem_pieces,
or
   3) Make up something new, yet very similar to LMB and
      mem_pieces.

Does anyone have suggestions or advice on route 1) or 2)?
Anyone?  Kumar?  Ben?  Bueller?

Thanks,
jdl
