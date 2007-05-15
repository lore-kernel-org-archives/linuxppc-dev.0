Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 11:17:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515011704.GB565@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
	<3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 02:59:31PM +0200, Segher Boessenkool wrote:
> > -			i-cache-size = <0>;
> > -			d-cache-size = <0>;
> > +			i-cache-size = <2000000>; /* 32 kB */
> > +			d-cache-size = <2000000>; /* 32 kB */
> 
> That's 32MB, not 32kB.  Better fix this :-)

Duh.  Fixed.

> >  	UIC0: interrupt-controller0 {
> 
> >  	UIC1: interrupt-controller1 {
> 
> It's a shame you can't use unit addresses for these since
> you use "dcr-reg" instead of "reg".  Oh well.
> 
> >  		SDRAM0: sdram {
> > -			device_type = "memory-controller";
> >  			compatible = "ibm,sdram-440gp", "ibm,sdram";
> 
> Maybe rename the node to "memory-controller"?

Hmm, yeah, I guess so.

> > +		SRAM0: sram {
> > +			compatible = "ibm,sram440gp";
> > +			dcr-reg = <020 8 00a 1>;
> > +		};
> 
> Is this thing _only_ addressable over DCRs?  Weird.

Well... the control registers are certainly DCR only.  I guess there's
the actual SRAM itself, though whether this belongs in this node, or
elsewhere isn't immediately clear.  I haven't yet investigated how the
SRAM is mapped (it depends on DIP switch settings) so I'm certainly
not considering this node complete yet.

> >  		MAL0: mcmal {
> > -			device_type = "mcmal-dma";
> > +			device_type = "dma-controller";
> >  			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
> 
> Remove "device_type", change name to "dma-controller"?

Don't really want to remove the device_type, because the MAL driver
looks for it at present.  Don't really want to change the name, since
that might encourage confusion with the other (more conventional) DMA
controller.

> >  			EBC0: ebc {
> > -				device_type = "ibm,ebc";
> >  				compatible = "ibm,ebc-440gp";
> 
> You forgot "ibm,ebc" here.

Hmm.. yeah, I guess.

Revised patch coming shortly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
