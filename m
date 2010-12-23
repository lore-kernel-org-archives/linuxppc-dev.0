Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 23 Dec 2010 11:56:23 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Message-ID: <20101223185623.GA20384@angua.secretlab.ca>
References: <4D12F171.7010103@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D12F171.7010103@mentor.com>
Cc: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	"Blanchard, Hollis" <Hollis_Blanchard@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 23, 2010 at 12:51:29AM -0600, Meador Inge wrote:
> Hi All,
> 
> I am currently doing some work on Linux PPC AMP systems (with Hollis,
> CC'd).  We are using device trees to partition resources between the
> different OSes.  To help with this effort, we would like to introduce
> some new bindings to the MPIC.
> 
> Currently, there are no bindings for the MPIC under
> '.../Documentation/powerpc/dts-bindings/'.  I think most folks are
> following the IEEE 1275 bindings for Open PIC.
> 
> It would be nice to check-in a binding for the MPIC that is a superset
> of the 1275 bindings as a place to document extensions.  The already in
> use property 'protected-sources', for example, could be placed there.
> 
> I have included a draft proposal of what this would like.  It includes
> some properties ('no-reset') and a node (for message registers) that we
> are currently using for our AMP implementation and we would really
> like to push upstream.  If the general idea seems sound, then I will
> clean up the proposal and submit a patch for the bindings.
> 
> Thoughts?

Hi Meador.  Comments below.

g.

> 
> ===============
> 
> * MPIC Binding
> 
> This binding specifies what properties and child nodes must be
> available on the device tree representation of the MPIC interrupt
> controller.  This binding is a superset of the binding defined for
> Open PIC in [1].
> 
> ** Required properties:
> 
>     - All of the required properties mentioned in [1].

You should probably list them here anyway to aid the reader.

> 
> ** Optional properties:
> 
>     - no-reset : the presence of this property indicates that the
>                  interrupt controller should not be reset during OS
>                  initialization.
>     - protected-sources : a list of interrupt sources that are not
>                           available for use.

What is the use case for the protected-sources property?  Wouldn't the
irqs simply not be referenced by any device nodes?  Documenting the
reason for this property would be useful here.

> 
> ** Example:
> 
> 	mpic: pic@40000 {
> 		interrupt-controller;
> 		#address-cells = <0>;
> 		#interrupt-cells = <2>;
> 		reg = <0x40000 0x40000>;
> 		compatible = "chrp,open-pic";
> 		device_type = "open-pic";
> 		protected-sources = <0xb1 0xb2>;
> 		no-reset;
> 	};
> 
> * MPIC Message Registers
> 
> This binding specifies how the MPIC message registers implemented on
> some Freescale platforms for interprocessor communication should be
> represented.
> 
> ** Required parent:
> 
>     - Message register nodes should always been nested under a MPIC
>       node.
> 
> ** Required properties:
> 
>     - compatible : compatible list, contains 2 entries, first is
>                    "fsl,CHIP-msgr", where CHIP is the processor
>                    (p2020, mpc8572, etc ...) and the second is
>                    "fsl,mpic-msgr".

I'd rather see the 'generic' value of mpic-msgr omitted and instead
allow new parts to claim compatibility with an older chip.  Generic
or wildcard compatible values can be troublesome because the meaning
has a tendency to change over time.

>     - reg        : should contain the address and the length of the
>                    message register block.
>     - cell-index : the index of the message register block.

?  This needs some more explanation.  cell-index often gets abused as
a way to enumerate devices.  Typically, the address of the device
itself is sufficient to identify the device.

>     - interrupts : each one of the interrupts here represents the
>                    interrupt line for one message register.  These
>                    interrupts are routed internally to the MPIC.
> 
> NOTE: The 'interrupt-parent' is implicit since message register nodes
>        are always children of interrupt controller nodes.
> 
> ** Example:
> 
> 	mpic: pic@40000 {
> 		interrupt-controller;
> 		#address-cells = <0>;
> 		#interrupt-cells = <2>;
> 		reg = <0x40000 0x40000>;
> 		compatible = "chrp,open-pic";
> 		device_type = "open-pic";
> 		protected-sources = <0xb1>;
> 
> 		msgr@1400 {
> 			compatible = "fsl,p2020-msgr", "fsl,mpic-msgr";
> 			reg = <0x1400 0x200>;

Are these registers memory mapped?  If so, then the parent node
needs to have a 'ranges' property.

> 			cell-index = <0>;
> 			interrupts = <0xb0 0x2 0xb1 0x2
>                                       0xb2 0x2 0xb3 0x2>;
> 		};
> 
> 		msgr@2400 {
> 			compatible = "fsl,p2020-msgr", "fsl,mpic-msgr";
> 			reg = <0x2400 0x200>;
> 			cell-index = <1>;
> 			interrupts = <0xb4 0x2 0xb5 0x2
>                                       0xb6 0x2 0xb7 0x2>;
> 	         };	
> 	};
> 
> * References
> 
> [1] PowerPC Microprocessor Common Hardware Reference Platform (CHRP)
>      Binding, Version 1.8, 1998. Published by the Open Firmware Working
>      Group. (http://playground.sun.com/1275/bindings/chrp/chrp1_8a.ps)
> 
> 
> -- 
> Meador Inge     | meador_inge AT mentor.com
> Mentor Embedded | http://www.mentor.com/embedded-software
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
