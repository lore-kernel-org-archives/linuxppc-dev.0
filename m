Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 39A61DDF08
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 01:12:38 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Help needed to describe a custom bus in the device tree
Date: Thu, 13 Mar 2008 15:12:32 +0100
References: <200803111527.32836.laurentp@cse-semaphore.com>
	<20080311225427.GD7642@localhost.localdomain>
In-Reply-To: <20080311225427.GD7642@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2153511.QjXjyq8OdR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803131512.35251.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2153511.QjXjyq8OdR
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dave,

On Tuesday 11 March 2008 23:54, David Gibson wrote:
> On Tue, Mar 11, 2008 at 03:27:26PM +0100, Laurent Pinchart wrote:
> > Hi everybody,
> >
> > the migration process from ARCH=3Dppc to ARCH=3Dpowerpc is easier than I
> > thought in some parts, but a few devices are still giving me
> > headaches. This should hopefully be one of my last major requests
> > for help (I'm sure most of you will be happy to see traffic on this
> > list going down when I'll be done :-))
> >
> > I'm having trouble describing a custom bus named MS bus (completely
> > unrelated to a well-known software company) in the device tree. The
> > hardware is MPC8248-based and has the following hardware topology.
> >
> > MPC8248 <-- localbus --> FPGA <-- ms bus --> Custom peripherals
> >
> > The bus interrupt controller, serial access (SPI) controller and
> > status registers are accessed through memory-mapped registers in the
> > FPGA. Parallel access to the MS bus is handled transparently by the
> > FPGA which handles address mapping.
> >
> > The FPGA is mapped on the locabus at address 0xf4000000. Bus control
> > registers are at 0xf4002000 - 0xf4003000. The parallel bus memory
> > window on the localbus is located at 0xf5000000.
> >
> > My current dts draft describes that topology as follows (unrelated
> > devices on the local bus such as flash memory are removed for
> > clarity).
> >
> > localbus@f0010100 {
> > 	compatible =3D "fsl,pq2-localbus";
> > 	#address-cells =3D <2>;
> > 	#size-cells =3D <1>;
> > 	reg =3D <f0010100 40>;
> >
> > 	ranges =3D <0 0 40000000 01000000
> > 		  2 0 f2000000 00100000
> > 		  3 0 f3000000 00100000
> > 		  4 0 f4000000 00100000
> > 		  5 0 f5000000 00100000>;
> >
> > 	fpga@4,0 {
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		ranges =3D <4 0 0 00010000>;
> >
> > 		msbus-arbitrer@2000 {
> > 			compatible =3D "tbox,cp11-msbus-arbitrer";
> > 			reg =3D <2000 4>;
> > 		};
> >
> > 		msbus_pic: interrupt-controller@2100 {
> > 			compatible =3D "tbox,cp11-msbus-pic";
> > 			reg =3D <2100 8>;
> > 			interrupts =3D <17 2>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 			#interrupt-cells =3D <1>;
> > 			interrupt-controller;
> > 		};
> >
> > 		msbus-spi@2200 {
> > 			compatible =3D "tbox,cp11-msbus-spi";
> > 			reg =3D <2200 100>;
> > 			interrupts =3D <18 8>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 		};
> >
> > 		sdhc@5000 {
> > 			compatible =3D "tbox,sdhci";
> > 			reg =3D <5000 1000>;
> > 			interrupts =3D <16 8>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 		};
> > 	};
> >
> > 	msbus@5,0 {
> > 		compatible =3D "tbox,cp11-msbus";
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		#interrupt-cells =3D <1>;
> > 		reg =3D <5 0 0 00000400>;
> > 		interrupt-parent =3D <&msbus_pic>;
> > 	};
> > };
> >
> > The device tree reflects the physical topology but makes driver
> > access to the bus quite complex. An OF platform device driver
> > matching on compatible =3D "tbox,cp11-msbus" will not have the bus
> > FPGA registers described in its device node.
> >
> > Having a look at the various device trees included in the kernel
> > sources, it seems platforms with a PCI bus experience a similar
> > problem. To solve it the PCI bus node address and registers describe
> > the configuration registers, and the memory window to access PCI
> > devices is described by the ranges property.  Applying that to my
> > custom bus would lead to the following tree.
> >
> > localbus@f0010100 {
> > 	compatible =3D "fsl,pq2-localbus";
> > 	#address-cells =3D <2>;
> > 	#size-cells =3D <1>;
> > 	reg =3D <f0010100 40>;
> >
> > 	ranges =3D <0 0 40000000 01000000
> > 		  2 0 f2000000 00100000
> > 		  3 0 f3000000 00100000
> > 		  4 0 f4000000 00100000
> > 		  4 1 f4002000 00000100
> > 		  5 0 f5000000 00100000>;
> >
> > 	fpga@4,0 {
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		ranges =3D <4 0 0 00010000>;
> >
> > 		msbus_pic: interrupt-controller@2100 {
> > 			compatible =3D "tbox,cp11-msbus-pic";
> > 			reg =3D <2100 8>;
> > 			interrupts =3D <17 2>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 			#interrupt-cells =3D <1>;
> > 			interrupt-controller;
> > 		};
> >
> > 		msbus-spi@2200 {
> > 			compatible =3D "tbox,cp11-msbus-spi";
> > 			reg =3D <2200 100>;
> > 			interrupts =3D <18 8>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 		};
> >
> > 		sdhc@5000 {
> > 			compatible =3D "tbox,sdhci";
> > 			reg =3D <5000 1000>;
> > 			interrupts =3D <16 8>;
> > 			interrupt-parent =3D <&cpm_pic>;
> > 		};
> > 	};
> >
> > 	msbus@4,1 {
> > 		compatible =3D "tbox,cp11-msbus";
> > 		#address-cells =3D <1>;
> > 		#size-cells =3D <1>;
> > 		#interrupt-cells =3D <1>;
> > 		reg =3D <4 1 4>;
> > 		interrupt-parent =3D <&msbus_pic>;
> > 		ranges =3D <5 0 0 00000400>;
> > 	};
> > };
> >
> > Is this correct ? Is that the best way to describe my custom bus in
> > the device tree ?
>
> Your second example looks closer to right.  Certainly you should use
> 'reg' only for bus control registers, and 'ranges' for windows into
> the bus address space itself.

Ok.

> The device tree describes hardware from a functional point of view, so
> I don't know that it's relevant that all the bus control functions are
> implemented in an FPGA.  Each of the subnodes are more-or-less
> independent devices, so they could just have separate nodes.
>
> Or, if this seems more sensible, you could decide that they're
> sufficiently closely related to put them all as one node, with
> multiple register blocks listed in the 'reg' property.  That would
> probably get messy for your PIC at the very least though.

I suppose I could implement PIC support in the bus driver itself, but havin=
g=20
separate nodes with separate OF devices and separate drivers seems cleaner =
to=20
me (although it can make dependencies a bit more difficult to handle).

> > How would the relationships between the bus and
> > its PIC and SPI controller be handled in the drivers ?
>
> If the msbus driver needs to work with the associated PIC and SPI
> controllers, then you should put properties in the msbus node giving
> their phandles.

The PIC can live pretty much by itself, but the SPI controller is used to=20
enumerate devices on the bus (and perform some other tasks at runtime). I=20
plan to have the SPI device and driver be self-contained, and have the bus=
=20
node reference the SPI device through its phandle. I will just have to make=
=20
sure the bus driver is initialised after the SPI driver.

> > I also don't
> > understand how interrupt mappings are supposed to be handled. PCI
> > busses have two CPM interrupt lines, one for the PCI PIC and one for
> > the PCI bus, with the PCI bus having the CPM PIC as its interrupt
> > controller. My bus PIC uses a single interrupt line. Is there some
> > documentation explaining how PICs and interrupt mappings should be
> > described ?
>
> Are interrupts from devices on the msbus routed over the msbus, or are
> they routed independently to the mspic or the cpm PIC?

There is a single active low interrupt line on the msbus. When the mspic=20
detects an interrupt condition, it will read the interrupt source registers=
=20
from all devices on the bus and generate a host interrupt to the cpm PIC. T=
he=20
mspic driver then process the CPM interrupt in its demux handler, reads the=
=20
interrupt sources from the mspic registers and dispatch the interrupts to t=
he=20
msbus device drivers.

If I understand things correctly, the mspic node should have an 'interrupts=
'=20
attribute describing the cascaded interrupt line (mspic -> cpm PIC irq), an=
d=20
the msbus node should have an 'interrupts' attribute describing the interru=
pt=20
line used to report bus-related events (hotplug events for instance). Is th=
at=20
right ?

To make things a bit more complex, the msbus interrupt and the bus-related=
=20
events interrupt share the same CPM irq line. Can I use the same virq numbe=
r=20
in both nodes, or do I have to demux the interrupts in a separate driver ? =
If=20
I have to demux the interrupts in a separate PIC driver, how do I know what=
=20
virtual irq number will be assigned to each device so that I can reference=
=20
them in the device tree ?

Thanks a lot for your help.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2153511.QjXjyq8OdR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH2TZT8y9gWxC9vpcRAuCsAJ9DIFM+5R+bKuXj5C3V8vjxz04QJgCeMDRH
koG4Y7G5Ge+K3on98RKqhy4=
=EIXi
-----END PGP SIGNATURE-----

--nextPart2153511.QjXjyq8OdR--
