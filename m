Return-Path: <dgibson@ozlabs.org>
Date: Tue, 15 May 2007 15:46:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Small fixes for the Ebony device tree
Message-ID: <20070515054626.GB6998@localhost.localdomain>
References: <20070514045404.GP6517@localhost.localdomain>
	<3af16d1a6c09901f10dca3b6a3f8c698@kernel.crashing.org>
	<20070515011704.GB565@localhost.localdomain>
	<b353b330365fd9ede35fb1cbbbf09aec@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b353b330365fd9ede35fb1cbbbf09aec@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 15, 2007 at 06:59:49AM +0200, Segher Boessenkool wrote:
> >>> +		SRAM0: sram {
> >>> +			compatible = "ibm,sram440gp";
> >>> +			dcr-reg = <020 8 00a 1>;
> >>> +		};
> >>
> >> Is this thing _only_ addressable over DCRs?  Weird.
> >
> > Well... the control registers are certainly DCR only.  I guess there's
> > the actual SRAM itself, though whether this belongs in this node, or
> > elsewhere isn't immediately clear.  I haven't yet investigated how the
> > SRAM is mapped (it depends on DIP switch settings) so I'm certainly
> > not considering this node complete yet.
> 
> If it is supposed to have a "reg" property, and it doesn't
> yet, it might be a good idea to comment it out in the DTS
> for now, so later kernels can work with the older device
> tree correctly.

Given that I'm not aware of any Ebony firmwares that actually supply a
device tree, so in practice the kernel's tree will always come from an
attached zImage, I don't think this is really a big consideration.

> >>>  		MAL0: mcmal {
> >>> -			device_type = "mcmal-dma";
> >>> +			device_type = "dma-controller";
> >>>  			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
> >>
> >> Remove "device_type", change name to "dma-controller"?
> >
> > Don't really want to remove the device_type, because the MAL driver
> > looks for it at present.
> 
> Fair enough.  But you change the "device_type" in
> this patch, so presumably you change it in the kernel

The kernel driver recognizes both variants, but the one I had
previously is marked deprecated.

> driver as well -- can't you just *fix* the kernel driver,
> instead?

Well.. I guess, but I'd prefer to leave that to BenH, who wrote the
driver.

> > Don't really want to change the name, since
> > that might encourage confusion with the other (more conventional) DMA
> > controller.
> 
> Nah, just look at the other properties in the node and
> you know what is what.  It is quite common to have nodes
> with the same name representing different devices (for
> example, "ethernet" devices -- "dma-controller" would be
> a bit more unusual, sure).
> 
> I have no strong feelings about the name, "mcmal" is
> generic enough a name as far as I'm concerned.
> 
> >>>  			EBC0: ebc {
> >>> -				device_type = "ibm,ebc";
> >>>  				compatible = "ibm,ebc-440gp";
> >>
> >> You forgot "ibm,ebc" here.
> >
> > Hmm.. yeah, I guess.
> 
> Well that's what the kernel code matches on ;-)

Um.. yes.  I wonder how it was working before...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
