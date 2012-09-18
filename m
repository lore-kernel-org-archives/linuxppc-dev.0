Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 80D692C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 07:50:30 +1000 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
 by crust.elkhashab.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id q8ILoRUG027010
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 16:50:28 -0500
Received: (from ayman@localhost)
 by crust.elkhashab.com (8.14.3/8.14.3/Submit) id q8ILoR0H027009
 for linuxppc-dev@lists.ozlabs.org; Tue, 18 Sep 2012 16:50:27 -0500
Date: Tue, 18 Sep 2012 16:50:27 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: 44x: How to increase PCIe space (is it kernel/dts/...)
Message-ID: <20120918215027.GA26803@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got a design that is 405EXr based so its got 32 bit
address space.  We have an FPGA that sits on our pcie bus
and we want it to have 2 BARs with 1G of space and maybe
256MB of space.  I cannot figure out what I need to change
in the kernel/dts to make this work.  

Right now, if I go over 512MB in the DTS "ranges" parameter
then I'll get an error during kernel boot.

My thought is that the magic happens in the function:

ppc4xx_pciex_port_init_mapping(...)

In there I see it setting up the REGBAH and REGBAL and then
this curious statement:

/* XXX FIXME: Use size from reg property. For now, map * 512M */
dcr_write(port->dcrs, DCRO_PEGPL_CFGMSK, 0xe0000001);

I figure I need to change that or fix it the right way
(though I don't know how to do that).  The other thing is my
dts file.  It is based on the amcc kilauea and here is the
part that I am unsure of.  The PCIe entry falls under the
PLB which could also be a problem but again, I am not sure.

So basically, is there an easy way to change what I've got
to map 1.25 or 2GB of space?

Thanks
Ayman

PCIE0: pciex@0a0000000 {
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
		primary;
		port = <0x0>; /* port number */
		reg = <0xa0000000 0x20000000    /* Config space access */
			   0xef000000 0x00001000>;  /* Registers */
		dcr-reg = <0x040 0x020>;
		sdr-base = <0x400>;

		/* Outbound ranges, one memory and * one IO,
		 * later cannot be changed
		 */
		ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x08000000
				  0x01000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00010000>;

		/* Inbound 2GB range starting at 0 * */
		dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;

		/* This drives busses 0x00 to 0x3f * */
		bus-range = <0x0 0x3f>;

		/* Legacy interrupts (note the weird * polarity, the bridge seems
		 * to invert PCIe legacy
		 * interrupts).
		 * We are de-swizzling here because
		 * the numbers are actually for
		 * port of the root complex virtual
		 * P2P bridge. But I want
		 * to avoid putting a node for it in
		 * the tree, so the numbers
		 * below are basically de-swizzled
		 * numbers.
		 * The real slot is on idsel 0, so
		 * the swizzling is 1:1
		 */
		interrupt-map-mask = <0x0 0x0 0x0 0x7>;
		interrupt-map = < 0x0 0x0 0x0 0x1 &UIC2 0x0 0x4 /* swizzled int A */ 
						  0x0 0x0 0x0 0x2 &UIC2 0x1 0x4 /* swizzled int B */ 
						  0x0 0x0 0x0 0x3 &UIC2 0x2 0x4 /* swizzled int C */ 
						  0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
};
