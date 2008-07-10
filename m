Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jul 2008 11:32:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: John Linn <John.Linn@xilinx.com>
Subject: Re: [PATCH] [V2] powerpc: Xilinx: add dts file for ML507 board
Message-ID: <20080710013251.GA26724@yookeroo.seuss>
References: <20080707180508.4E2CBE8081@mail72-dub.bigfish.com>
	<20080708031641.GA1549@yookeroo.seuss>
	<20080708144112.6C49B1CC8073@mail66-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080708144112.6C49B1CC8073@mail66-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 08, 2008 at 08:41:11AM -0600, John Linn wrote:
> Thanks for the comments David.  
[snip]
> > > +	chosen {
> > > +		bootargs = "console=ttyS0 ip=on root=/dev/ram";
> > 
> > Bootargs like this should not typically go in the dts file.
> > 
> 
> My understanding is the bootloader would also fill these in.
> With the FGPA, a bootloader is not used many times so that's the 
> reason we have put it into the dts file.

Hrm.  There are several places you can encode a default command line
into a zImage, and I don't think the dts is the most sensible.  I'd
suggest in the config instead, it's easier for users to change if
necessary that way.

> > > +		linux,stdout-path = "/plb@0/serial@83e00000";
> > > +	} ;
> > > +	cpus {
> > > +		#address-cells = <1>;
> > > +		#cpus = <1>;
> > > +		#size-cells = <0>;
> > > +		ppc440_0: cpu@0 {
> > > +			clock-frequency = "";
> > 
> > Presumably this is supposed to be filled in by the bootloader.  But in
> > any case it shouldn't be a string.
> > 
> 
> I think this was my screw-up as it should have the same value as the
> timebase. 
> Interesting, it's not being used for anything that stops the system from
> working.

Ok.

> > [snip]
> > > +			DMA0: sdma@80 {
> > > +				compatible = "xlnx,ll-dma-1.00.a";
> > > +				dcr-reg = < 0x80 0x11 >;
> > > +				interrupt-parent = <&xps_intc_0>;
> > > +				interrupts = < 9 2 0xa 2 >;
> > > +			} ;
> > 
> > Putting devices under the cpu node is certainly... atypical.  It's not
> > obviously wrong, for a dcr device like this, but we probably want a
> > little more discussion before establishing a convention like this.
> 
> We had this discussion somewhat in a earlier message, 6/23 adding
> virtex5 
> Powerpc 440 support, and Stephen answered with the following which still
> seems
> applicable.
> 
> >From Stephenn:
> 
> In Virtex 5 FX, the processor block (as represented in all the processor
> design tools) is actually a processor block, plus a crossbar switch,
> plus dma blocks.  I think there's a tradeoff between modeling this
> independently, or modeling it as an FPGA user sees it.  From the
> perspective of the FPGA user, this is the way the system looks (although
> I agree that it's odd).   What would be even better, is if the processor
> block was modeled as a DTS I could write by hand, and to include it into
> the generated DTS.  (Another good use for grafting of device trees...)

Hmm.  Not really convinced either way.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
