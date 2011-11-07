Return-Path: <robert.sciuk@exfo.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: fpga driver on custom PPC target platform (P4080) ...
Date: Mon, 7 Nov 2011 18:29:15 -0500
Message-ID: <2DD52030B5146141BEB762A11AE97C4C0100CBB2@SPQCEXC05.exfo.com>
In-reply-to: <4EB8582A.3070303@freescale.com>
References: <2DD52030B5146141BEB762A11AE97C4C0100C735@SPQCEXC05.exfo.com>
 <CAOZdJXWjS4t9cOKRB3rxy0iCFAYRyEgg6kfQwvydUQSyO1ttoA@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4C0100C8C1@SPQCEXC05.exfo.com>
 <20111105004050.GA1384@truffala.fritz.box>
 <2DD52030B5146141BEB762A11AE97C4C0100CB3D@SPQCEXC05.exfo.com>
 <4EB8582A.3070303@freescale.com>
From: "Robert Sciuk" <robert.sciuk@exfo.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Scott Wood [mailto:scottwood@freescale.com]
> Sent: Monday, November 07, 2011 5:14 PM
> To: Robert Sciuk
> Cc: linuxppc-dev@lists.ozlabs.org; devicetree-discuss@lists.ozlabs.org
> Subject: Re: fpga driver on custom PPC target platform (P4080) ...
>=20
...=20
> If you need to poke an i2c bus to switch access between certain
> localbus children, you should remove "simple-bus" from the compatible =
-- or
> perhaps do something like:
>=20

Actually, the gpio expander on the I2C bus don't select the localbus =
children, but the programming pins are driven by the i2c bus, and each =
FPGA has its own gpio expander (PCA9539).  ... Ultimately, I will link =
the i2c address and localbus (8 bit programming port) via phandles, but =
both of the optional fpga's have their databus tied to the same chip =
select on the localbus.  The intent was to perform simultaneous =
programming, but I would like the option to do both simultaneous and =
individual programming ... eg:  set either one or both of the FPGAs to =
programming mode, and then mmap the localbus port from user land (uio =
driver), and transmit the bit stream.  The DONE (success/fail) bit would =
be returned by the device close ... or at least that's how I dreamed it =
might work ... again, I will stare at the fsl elbc device tree doc, and =
I can certainly re-map the addressing (36bit ... it=92s a P4080 target).



> localbus@ffe124000 {
> 	compatible =3D "fsl,p4080-elbc", "fsl,elbc", "simple-bus";
> 	...
>=20
> 	flash@0,0 {
> 		...
> 	};
>=20
> 	switched-bank@2,0 {
> 		// no simple-bus here
> 		compatible =3D "something specific to your board's setup";
> 		ranges =3D <0 0 2 0 0x8000>;
>=20
> 		// reg is here just to make the unit-addres valid
> 		reg =3D <2 0 0>;
>=20
> 		#address-cells =3D <2>;
> 		#size-cells =3D <1>;
>=20
> 		// specify a phandle to the i2c device and any other
> 		// relevant details for identifying which knob of the
> 		// switch needs to be turned...
>=20
> 		// replace x/y with appropriate switch ID, and 0 0x8000
> 		// with appropriate portion of the window being used by
> 		// each device
> 		fpga@x,0 {
> 			compatible =3D ...
> 			reg =3D <x 0 0x8000>;
> 			...
> 		};
>=20
> 		fpga@y,0 {
> 			compatible =3D ...
> 			reg =3D <y 0 0x8000>;
> 			...
> 		};
> 	};
> };
>=20
> >
> > 	        localbus@ffe124000 {
> >                 compatible =3D "fsl,p4080-elbc", "fsl,elbc", =
"simple-
> bus";
> >                 reg =3D <0xf 0xfe124000 0 0x1000>;
> >                 interrupts =3D <25 2 0 0>;
> >                 interrupt-parent =3D <&mpic>;
> >                 #address-cells =3D <2>;
> >                 #size-cells =3D <1>;
> >
> >                 /* Local bus region mappings */
> >                 ranges =3D <0 0 0xf 0xe8000000 0x08000000         /*
> CS0: Boot flash */
> >                           1 0 0xf 0xd0000000 0x7fff             /*
> CS1: FPGA0 -  LIM */
> >                           2 0 0xf 0xd1000000 0x7fff             /*
> CS2: FPGA1 -  FPE1 */
> >                           2 0 0xf 0xd2000000 0x7fff >;          /*
> CS2: FPGA2 -  FPE2 */
>=20
> The binding for FSL localbus nodes
> (Documentation/devicetree/bindings/powerpc/fsl/lbc.txt) says that =
there
> is a one-to-one correspondence between "ranges" entries and
> chipselects,
> based on how the eLBC is actually programmed.  The details of what is
> attached come in the subnodes.
>=20
> I don't see how the above mapping is possible with eLBC -- you're
> splitting CS2 among 0xd1000000..0xd1007fff and 0xd2000000..0xd2007fff.
> Since you have CS1 at 0xd0000000, alignment restrictions prevent CS2
> from covering both of those regions -- unless you've got overlapping
> mappings, with CS2 being at least 0xd0000000..0xd3ffffff, and are
> relying on CS1 taking priority due to being lower-numbered.
>=20
> I hope you're not doing that, and that these aren't the real addresses
> (or they can be changed) -- but if you must do this, that breaks the
> one-to-one model, so you'd need both ranges entries.
>=20
> Also note that the final cell in each ranges entry should be the size,
> not the size minus one.
>=20
> >                 fpe1: fpga@2, {
> >                 }
> >
> >                 fpe2: fpga@2, {
>=20
> This would be fine for a case where the devices are not switched, but
> rather decode different addresses within the chipselect.
>=20
> E.g. CS3 of arch/powerpc/boot/dts/socrates.dts
>=20
> -Scott
