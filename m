Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Jun 2007 10:23:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 09/15] [POWERPC] 86xx: Add uli1575 pci-bridge sector to
	MPC8641HPCN dts file.
Message-ID: <20070628002342.GA15298@localhost.localdomain>
References: <11829070073637-git-send-email-galak@kernel.crashing.org>
	<11829070091056-git-send-email-galak@kernel.crashing.org>
	<11829070102887-git-send-email-galak@kernel.crashing.org>
	<11829070111239-git-send-email-galak@kernel.crashing.org>
	<1182907013252-git-send-email-galak@kernel.crashing.org>
	<1182907014549-git-send-email-galak@kernel.crashing.org>
	<1182907015126-git-send-email-galak@kernel.crashing.org>
	<11829070192461-git-send-email-galak@kernel.crashing.org>
	<C84F154C-EBC9-471F-A1E1-635A385E684A@freescale.com>
	<8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8fa84ed4810eb9aca18739bf709e71d9@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2007 at 10:39:14PM +0200, Segher Boessenkool wrote:
> >> -		ranges = <0 f8000000 00100000>;
> >> -		reg = <f8000000 00100000>;	// CCSRBAR 1M
> >> +		ranges = <00001000 f8001000 000ff000
> > [...]
> >> +		reg = <f8000000 00001000>;	// CCSRBAR
> >
> > This can't be right, and I suspect it will break any kernel access to
> > the first 0x1000 bytes of the CCSR_BAR space.  reg should actually
> > describe the register space of the SOC.  If ranges needs to specify
> > that, too, they should be able to be redundant.  But this looks like
> > a big hack, to me.  Am I missing something?
> 
> "reg" and "ranges" can never overlap really.

Is this really true, always?

What about something like a PReP PCI bridge, which has the registers
for indirect config-space access in the same range as the ISA IO
space?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
