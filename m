Return-Path: <dgibson@ozlabs.org>
Date: Sat, 20 Jan 2007 14:22:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: EDAC platform devices for fsl_soc
Message-ID: <20070120032254.GA7727@localhost.localdomain>
References: <8746466a0701161246wbe4268esab51bc07a7efb2a3@mail.gmail.com>
	<F5C9484B-93D7-4B08-813A-8B14D3F0F878@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F5C9484B-93D7-4B08-813A-8B14D3F0F878@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, Jan 16, 2007 at 03:17:20PM -0600, Kumar Gala wrote:
> 
> On Jan 16, 2007, at 2:46 PM, Dave wrote:
> 
> > I'm trying to write an EDAC driver for the mpc8560 board. I will need
> > to access the DDR error management registers, the L2 error management
> > registers, the PCI management registers, and also the related IRQs
> > (internal 0, 2, and 8). So I would like to insert some entries into
> > the 8560 fdt in order to parse them and map the hw irq to virq in
> > order to setup the platform device resources.
> >
> > Below is what I was thinking the fdt should look like. Is that  
> > reasonable?
> 
> I dont see the reason to introduce nodes that are specific to EDAC.   
> You should add nodes for the full device (which includes the error  
> mgmt).  In the case of PCI the node should be there and fixing the  
> dts to report the proper irq is all that is needed.
> 
> >
> >     soc8560@e0000000 {
> >        #address-cells = <1>;
> >        #size-cells = <1>;
> >        #interrupt-cells = <2>;
> >        device_type = "soc";
> >        ranges = <0 e0000000 00100000>;
> >        reg = <e0000000 00000200>;
> >        bus-frequency = <13ab6680>;
> >
> >        dram_control@2000 {
> >            device_type = "edac";
> >            compatible = "85xx";
> >            reg = <2000 e5c>;
> 
> expand to cover the full 4k allocated to ddr controller
> 
> >            linux,phandle = <2000>;
> >            interrupt-parent = <40000>;

Probably best to have dtc assign the phandles, rather than doing them
explicitly, too.  Less fragile if things move about.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
