Return-Path: <B07421@freescale.com>
Message-ID: <4EB8582A.3070303@freescale.com>
Date: Mon, 7 Nov 2011 16:14:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Robert Sciuk <robert.sciuk@exfo.com>
Subject: Re: fpga driver on custom PPC target platform (P4080) ...
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
 <20111105004050.GA1384@truffala.fritz.box>
 <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2011 02:09 PM, Robert Sciuk wrote:
> In my continuing saga of dev/tree driver development, I have a problem which might be obvious to those who have more experience in such matters.
> 
> I'm a bit perplexed on the tree nodes for the localbus/simplebus
> nodes for my FPGA.  CS0 is reserved for booting (from NOR flash as
> required by our design), CS1 is tied to an FPGA which will always be
> present.  CS2 actually is tied to both of two (optional) fpga's,
> which have been previously mapped by U-Boot (BRn/ORn configuration).
> Should I specify a ranges command as follows?  This seems somehow
> wrong, to me, and I'm wondering if there is an alternative
> representation which would work better in this case.  If you recall,
> the programming control lines are handled on the I2C bus, via a gpio
> controller.  In an ideal world, the optional FPE1 and FPE2 fpgas will
> have the identical .bts stream, and should support the option to
> program both simultaneously, or each individually, but I'm at a loss
> as how to best represent this in the tree.

If you need to poke an i2c bus to switch access between certain localbus
children, you should remove "simple-bus" from the compatible -- or
perhaps do something like:

localbus@ffe124000 {
	compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
	...

	flash@0,0 {
		...
	};

	switched-bank@2,0 {
		// no simple-bus here
		compatible = "something specific to your board's setup";
		ranges = <0 0 2 0 0x8000>;

		// reg is here just to make the unit-addres valid
		reg = <2 0 0>;

		#address-cells = <2>;
		#size-cells = <1>;

		// specify a phandle to the i2c device and any other
		// relevant details for identifying which knob of the
		// switch needs to be turned...

		// replace x/y with appropriate switch ID, and 0 0x8000
		// with appropriate portion of the window being used by
		// each device
		fpga@x,0 {
			compatible = ...
			reg = <x 0 0x8000>;			
			...
		};

		fpga@y,0 {
			compatible = ...
			reg = <y 0 0x8000>;
			...
		};
	};
};

> 
> 	        localbus@ffe124000 {
>                 compatible = "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
>                 reg = <0xf 0xfe124000 0 0x1000>;
>                 interrupts = <25 2 0 0>;
>                 interrupt-parent = <&mpic>;
>                 #address-cells = <2>;
>                 #size-cells = <1>;
> 
>                 /* Local bus region mappings */
>                 ranges = <0 0 0xf 0xe8000000 0x08000000         /* CS0: Boot flash */
>                           1 0 0xf 0xd0000000 0x7fff             /* CS1: FPGA0 -  LIM */
>                           2 0 0xf 0xd1000000 0x7fff             /* CS2: FPGA1 -  FPE1 */
>                           2 0 0xf 0xd2000000 0x7fff >;          /* CS2: FPGA2 -  FPE2 */

The binding for FSL localbus nodes
(Documentation/devicetree/bindings/powerpc/fsl/lbc.txt) says that there
is a one-to-one correspondence between "ranges" entries and chipselects,
based on how the eLBC is actually programmed.  The details of what is
attached come in the subnodes.

I don't see how the above mapping is possible with eLBC -- you're
splitting CS2 among 0xd1000000..0xd1007fff and 0xd2000000..0xd2007fff.
Since you have CS1 at 0xd0000000, alignment restrictions prevent CS2
from covering both of those regions -- unless you've got overlapping
mappings, with CS2 being at least 0xd0000000..0xd3ffffff, and are
relying on CS1 taking priority due to being lower-numbered.

I hope you're not doing that, and that these aren't the real addresses
(or they can be changed) -- but if you must do this, that breaks the
one-to-one model, so you'd need both ranges entries.

Also note that the final cell in each ranges entry should be the size,
not the size minus one.

>                 fpe1: fpga@2, {
>                 }
> 
>                 fpe2: fpga@2, {

This would be fine for a case where the devices are not switched, but
rather decode different addresses within the chipselect.

E.g. CS3 of arch/powerpc/boot/dts/socrates.dts

-Scott
