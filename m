Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0D8A62C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 08:19:59 +1000 (EST)
Message-ID: <1348006783.2386.62.camel@pasglop>
Subject: Re: 44x: How to increase PCIe space (is it kernel/dts/...)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
Date: Wed, 19 Sep 2012 08:19:43 +1000
In-Reply-To: <20120918215027.GA26803@crust.elkhashab.com>
References: <20120918215027.GA26803@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-09-18 at 16:50 -0500, Ayman El-Khashab wrote:
> I've got a design that is 405EXr based so its got 32 bit
> address space.  We have an FPGA that sits on our pcie bus
> and we want it to have 2 BARs with 1G of space and maybe
> 256MB of space.  I cannot figure out what I need to change
> in the kernel/dts to make this work.  
> 
> Right now, if I go over 512MB in the DTS "ranges" parameter
> then I'll get an error during kernel boot.
> 
> My thought is that the magic happens in the function:
> 
> ppc4xx_pciex_port_init_mapping(...)
> 
> In there I see it setting up the REGBAH and REGBAL and then
> this curious statement:
> 
> /* XXX FIXME: Use size from reg property. For now, map * 512M */
> dcr_write(port->dcrs, DCRO_PEGPL_CFGMSK, 0xe0000001);

Nah, I think that's only the CFG/REG stuff isn't it ? Look at the OMR
settings in ppc4xx_setup_one_pciex_POM. Maybe something is wrong here,
or maybe it's overlapping with another region somewhere ?

Also make sure that the PCI side address is changed accordingly in
"ranges". My usual setup is to do map 512M of host space to 3.5G...4G
PCI.

If you're going to change that to 1G you need to change the PCI side to
be 1G aligned, ie, 3G..4G (and reduce the DMA window accordingly).

Cheers,
Ben.

> I figure I need to change that or fix it the right way
> (though I don't know how to do that).  The other thing is my
> dts file.  It is based on the amcc kilauea and here is the
> part that I am unsure of.  The PCIe entry falls under the
> PLB which could also be a problem but again, I am not sure.

> So basically, is there an easy way to change what I've got
> to map 1.25 or 2GB of space?
> 
Cheers,
Ben.

> Thanks
> Ayman
> 
> PCIE0: pciex@0a0000000 {
> 		device_type = "pci";
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
> 		primary;
> 		port = <0x0>; /* port number */
> 		reg = <0xa0000000 0x20000000    /* Config space access */
> 			   0xef000000 0x00001000>;  /* Registers */
> 		dcr-reg = <0x040 0x020>;
> 		sdr-base = <0x400>;
> 
> 		/* Outbound ranges, one memory and * one IO,
> 		 * later cannot be changed
> 		 */
> 		ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x08000000
> 				  0x01000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00010000>;
> 
> 		/* Inbound 2GB range starting at 0 * */
> 		dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
> 
> 		/* This drives busses 0x00 to 0x3f * */
> 		bus-range = <0x0 0x3f>;
> 
> 		/* Legacy interrupts (note the weird * polarity, the bridge seems
> 		 * to invert PCIe legacy
> 		 * interrupts).
> 		 * We are de-swizzling here because
> 		 * the numbers are actually for
> 		 * port of the root complex virtual
> 		 * P2P bridge. But I want
> 		 * to avoid putting a node for it in
> 		 * the tree, so the numbers
> 		 * below are basically de-swizzled
> 		 * numbers.
> 		 * The real slot is on idsel 0, so
> 		 * the swizzling is 1:1
> 		 */
> 		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> 		interrupt-map = < 0x0 0x0 0x0 0x1 &UIC2 0x0 0x4 /* swizzled int A */ 
> 						  0x0 0x0 0x0 0x2 &UIC2 0x1 0x4 /* swizzled int B */ 
> 						  0x0 0x0 0x0 0x3 &UIC2 0x2 0x4 /* swizzled int C */ 
> 						  0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
> };
> 
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
