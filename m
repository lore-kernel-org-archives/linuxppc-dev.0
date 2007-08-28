Return-Path: <dgibson@ozlabs.org>
Date: Tue, 28 Aug 2007 11:40:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: RFC: [PATCH] Copy over headers from arch/powerpc to arch/ppc to
	decouple them
Message-ID: <20070828014031.GA6811@localhost.localdomain>
References: <Pine.LNX.4.64.0708270945580.11455@blarg.am.freescale.net>
	<20070828013808.GC3470@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828013808.GC3470@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 28, 2007 at 11:38:08AM +1000, David Gibson wrote:
> On Mon, Aug 27, 2007 at 09:49:04AM -0500, Kumar Gala wrote:
> > Move over includes files that have CONFIG_PPC_MERGE in them to decouple
> > to interdepencies between ARCH=powerpc & ARCH=ppc.
> > 
> > Duplicate the following headers in both locations and remove CONFIG_PPC_MERGE:
> > 
> > <asm/dcr.h>
> > <asm/i8259.h>
> > <asm/ipic.h>
> > <asm/irq.h>
> > 
> > ---
> > 
> > Not sure what people think about this since removing include asm-powerpc
> > from ARCH=ppc builds will require a bunch of other copies beyond these
> > which had a CONFIG_PPC_MERGE in them.
> 
> Seems sensible to me.

Hrm... and it might be worth splitting arch/powerpc/kernel/irq.c,
too, which also has a very large #ifdef PPC_MERGE section.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
