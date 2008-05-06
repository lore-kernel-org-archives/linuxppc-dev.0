Return-Path: <dgibson@ozlabs.org>
Date: Tue, 6 May 2008 16:14:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] [POWERPC] Xilinx: Framebuffer: Use dcr infrastructure.
Message-ID: <20080506061444.GB17798@yookeroo.seuss>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175647.4F3AC1C9004A@mail57-sin.bigfish.com>
	<fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40805052155q43a7ebd8x14c1711bd4c6bbfa@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 05, 2008 at 10:55:53PM -0600, Grant Likely wrote:
> On Mon, May 5, 2008 at 11:56 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> > This device contains a dcr interface.  Previously, the dcr interface
> >  was assumed to be used in mmio mode, and the register space of the dcr
> >  interface was precomputed and stuffed in the device tree.  This patch
> >  makes use of the new dcr infrastructure to represent the dcr interface
> >  as any other dcr interface in the device tree.  This enables the dcr
> >  interface to be connected directly to a native dcr interface in a
> >  clean way.
> >
> >  In particular, the device tree expected looks like:
> >
> >                         dcr_v29_0: dcr@0 {
> >                                 #address-cells = <1>;
> >                                 #size-cells = <1>;
> >                                 compatible = "xlnx,dcr-v29-1.00.a";
> >                                 VGA_FrameBuffer: tft@80 {
> >                                         compatible = "xlnx,plb-tft-cntlr-ref-1.00.a";
> >                                         dcr-parent = <&opb2dcr_bridge_0>;
> >                                         dcr-reg = < 80 2 >;
> >                                         xlnx,default-tft-base-addr = <7f>;
> >                                         xlnx,dps-init = <1>;
> >                                         xlnx,on-init = <1>;
> >                                         xlnx,pixclk-is-busclk-divby4 = <1>;
> >                                 } ;
> >                         } ;
> >
> >                         opb2dcr_bridge_0: opb2dcr-bridge@40700000 {
> >                                 compatible = "xlnx,opb2dcr-bridge-1.00.b";
> >                                 dcr-access-method = "mmio";
> >                                 dcr-controller ;
> >                                 dcr-mmio-range = < 40700000 1000 >;
> >                                 dcr-mmio-stride = <4>;
> >                                 reg = < 40700000 1000 >;
> >                                 xlnx,family = "virtex2p";
> >                         } ;
> 
> Hmmm, something doesn't quite feel right about this.  The node
> describing the tft device is a child of the dcr@0 node which is the
> dcr bus.  However, dcr bindings use dcr-bus and dcr-reg instead of
> parent-child relationship to specify how to access the dcr registers.
> So, in this example; if the device is described by tft@80, and the dcr
> bus is described by opb2dcr-bridge@40700000, then what does dcr@0
> describe?  (I do understand what they really describe in EDK terms;
> but I'm looking at it through device tree glasses).
> 
> I don't think the presence of a dcr@0 node is a problem, but in this
> case #size/address-cells doesn't have any meaning (the child doesn't
> have a reg property) and it looks like it should be a child of the
> opb2dcr-bridge node (otherwise, what is it attached to?).

Yes, indeed.  If dcr@0 is representing the DCR bus / interface it
should really have the dcr-access-method property and have all the
dcr-parent handles point at it.

Current standard practice is not to represent the DCR bus as node with
subnodes for the DCR-controlled devices.  That's because the DCR bus
tends to run in addition to other on-chip busses, and some things have
to go on another on-chip bus to make sense, but still have DCR control
registers (for example the internal bus bridges on 4xx).

Arguably for DCR-only devices we should instead have a node
representing the DCR bus and just put the devices under it with the
DCR number encoded in reg in the normal way.  But then its
inconsistent with the devices that need the other DCR representation.

Segher and I did toss around some ideas for generalizing the DCR
representation to a way of representing that any node has some
presence on a bus other than its "primary" parent (e.g. other-bus-reg
= <&dcr-bus 0x0d0 0x010 &strange-i2c-control-bus 0xabc>).  Then
DCR-only devices would use normal "reg", devices that sit on another
bus would sit on that bus and use this representation to show their
DCR control registers.  Maybe one day.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
