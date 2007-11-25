Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 26045DDEC2
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 09:47:13 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so66527anc
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 14:47:13 -0800 (PST)
Message-ID: <fa686aa40711251447t57f96dd4iba51d68e1c9a9c5c@mail.gmail.com>
Date: Sun, 25 Nov 2007 15:47:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Segher Boessenkool" <segher@kernel.crashing.org>,
	"David Gibson" <david@gibson.dropbear.id.au>, "Jon Loeliger" <jdl@jdl.com>
Subject: Re: Xilinx EDK BSP generation of device trees for microblaze and
	PowerPC
In-Reply-To: <20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071120194411.E183B100060@mail17-sin.bigfish.com>
	<20071125062456.ABA4AA4804E@mail64-cpk.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, Michal Simek <simekm2@fel.cvut.cz>,
	git <git@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/24/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>

Thanks for all this work; comments below.

>
> Here's what I've gotten so far:
>
>                  Hard_Ethernet_MAC: xps-ll-temac@81c00000 {
>                          #address-cells = <1>;
>                          #size-cells = <1>;
>                          network@81c00000 {
>                                  compatible = "xlnx,xps-ll-temac-1.00.a",
> "xlnx,xps-ll-temac";

Drop "xlnx,xps-ll-temac"; it's 100% made up.  This should be simply:
      compatible = "xlnx,xps-ll-temac-1.00.a" for version 1.00.a and
      compatible =
"xlnx,xps-ll-temac-<version>","xlnx,xps-ll-temac-1.00.a" for a future
version if it maintains register level compatibility.

"xlnx,xps-ll-temac" is far to ambiguous.

>                                  interrupt-parent = <&xps_intc_0>;
>                                  interrupts = < 3 0 >;
>                                  llink-connected = <&PIM3>;

What's this property for?

>                                  reg = < 81c00000 40 >;

If these registers are addressable, then the parent needs a 'ranges' property.

>                                  xlnx,bus2core-clk-ratio = <1>;
>                                  xlnx,phy-type = <1>;
>                                  xlnx,phyaddr = <1>;
>                                  xlnx,rxcsum = <0>;
>                                  xlnx,rxfifo = <1000>;
>                                  xlnx,temac-type = <0>;
>                                  xlnx,txcsum = <0>;
>                                  xlnx,txfifo = <1000>;

Would be nice to have a 'phy-handle' property as that is what is being
used on other platforms; but that's not something that EDK knows
about.  It would be nice to have a way to tell EDK what PHY device is
on the board so it could generate the appropriate mdio and phy nodes.

>                          } ;
>                  } ;
>                  mpmc@90000000 {
>                          #address-cells = <1>;
>                          #size-cells = <1>;
>                          compatible = "xlnx,mpmc-3.00.a", "xlnx,mpmc";

Drop 'xlns,mpmc'

>                          PIM3: sdma@84600180 {
>                                  compatible = "xlnx,ll-dma-1.00a",
> "xlnx,ll-dma";
>                                  interrupt-parent = <&xps_intc_0>;
>                                  interrupts = < 1 0 0 0 >;
>                                  reg = < 84600180 80 >;

Are these directly addressable registers from the CPU?  If so, the
parent node needs a 'ranges' property.

>                          } ;
>                  } ;
>          DDR2_SDRAM: memory@90000000 {
>                  device_type = "memory";
>                  reg = < 90000000 10000000 >;
>          } ;
>
>  So: the mpmc generates a 'memory' node, corresponding to it's memory
> interface.  It also gets a separate entry which contains the (optional, not
> present in this example) slave management interface (for ECC and performance
> information), and any sdma ports.  In this case, this node is mpmc@90000000,
> because there is no management interface.  If a management interface was
> present, then it would be @ the management address.

I don't think this is right; but I'm not sure.  I don't know what the
best naming convention is for the case of no management interface, but
mpmc@90000000 doesn't feel right.

Segher, David; what's your opinion?

>  The mpmc gets a compatible string that describes its management interface.
>  The sdma port has information about the tx and rx interrupts and the slave
> management interface.  Note that the slave management interface has the
> correct baseaddress for port3, generated from the base SDMA_CTRL_ address
> from the mpmc + the port 3 offset.  Note that sdma has an artificial
> compatible name.  I'm not sure whether the ll_dma driver can be easily
> convinced to bind to this, or whether the ll_temac driver will just traverse
> the device tree and then do a match against this.

Don't worry about having a too-sparse compatible property.  Be
specific and we can always add entries to the bind list.  For the IP
cores, always specify specific device versions in the compatible
entries.

>
>  The temac works similarly, although the temac itself doesn't have a slave
> interface, so no compatible node for it.  The sub nodes get the compatible
> string for the ll_temac driver.  In this case, there is only one temac port
> active.  Some of the parameters are specific to port 0, in which case the
> parameter names (e.g. phyaddr) are generated by stripping off the complete
> C_TEMAC0 prefix.  Other parameters (e.g. phy-type) are common to both sub
> nodes, but are duplicated to make it easier for the driver to get the
> information out.  At runtime, the driver has to follow the llink-connected
> path to find what it is connected to, and use the dma code, or the fifo
> code.
>
>  the xps-ll-fifo structure is a bit simpler, with llink-connected pointing
> to the fifo, which looks like a 'normal' peripheral.
>
>  Points for comment:
>  1) I don't like the "PIM3" label, which is artificial (i.e. it doesn't
> correspond to a name in the .mhs) and not guaranteed to be unique.  However,
> in the BSP generator it seems awkward to generate path references easily in
> a single pass.  What I'd might prefer is:
>                  DDR2_SDRAM: mpmc@90000000 {
>                          sdma@3 {
>
>  and refer to the sdma port using something like <&DDR2_SDRAM/sdma@3>, but I
> don't think you can do that in dtc?

If not, it is possible to extend the dtc syntax.  Jon, David?  Thoughts?

>
>  2) Not sure whether this is really simpler than just having a 'simple' node
> with both temacs and letting the driver sort everything out.  In particular,
> I'm concerned about maintaining a bunch of semantic information about the
> ll_temac driver outside of the driver itself.

I wouldn't recommend it.  It is better for probing to have one node
per logical device.

However, you could either have the network nodes as children of the
xps-ll-temac node, or they could be children of their addressable bus
and have phandles to the xps-ll-temac node...
In fact, if the network nodes are children of the xps-ll-temac node,
then the xps-ll-temac node should itself be a child of the addressable
bus (be it PLB or OPB).

Cheers,
g.



>
>  3) All of this is very different in structure from the way that the
> xparameters are organized.  The ll_temac BSP code copies the xparameters out
> of the MPMC and they are simply other parameters of the ll_temac driver.
> Although the above structure better represents the actual system, there is
> another organization for people to be confused about.
>
>  Steve
>
>
>  -----Original Message-----
>  From:
> linuxppc-dev-bounces+stephen.neuendorffer=xilinx.com@ozlabs.org
> on behalf of Stephen Neuendorffer
>  Sent: Tue 11/20/2007 11:44 AM
>  To: microblaze-uclinux@itee.uq.edu.au;
> linuxppc-dev@ozlabs.org; Grant Likely; Michal Simek
>  Subject: Xilinx EDK BSP generation of device trees for microblaze and
> PowerPC
>
>
>
>  I've updated some code from Michel Simek to generate Flat Device Trees
>  from Xilinx EDK projects.  This code is now hosted at:
>  git://git.xilinx.com/gen-mhs-devtree.git
>
>  This has one major advantage over the gen-mhs-devtree.py approach:
>  default IP core parameters that are not specified in the mhs file can
>  now be generated, since EDK pulls these in from the core .mpd file.
>  I've also managed to incorporate a few more improvements from the
>  previous review, so the BSP generator should include at least as much
>  information as gen-mhs-devtree.py
>
>  The next major order of business is to represent the DMA engines in the
>  MPMC and locallink connections to the lltemac.
>
>  Steve
>
>  _______________________________________________
>  Linuxppc-dev mailing list
>  Linuxppc-dev@ozlabs.org
>  https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
>
>
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
