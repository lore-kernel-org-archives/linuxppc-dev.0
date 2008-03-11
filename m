Return-Path: <dgibson@ozlabs.org>
Date: Wed, 12 Mar 2008 09:54:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: Help needed to describe a custom bus in the device tree
Message-ID: <20080311225427.GD7642@localhost.localdomain>
References: <200803111527.32836.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
In-Reply-To: <200803111527.32836.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2008 at 03:27:26PM +0100, Laurent Pinchart wrote:
> Hi everybody,
>=20
> the migration process from ARCH=3Dppc to ARCH=3Dpowerpc is easier than I
> thought in some parts, but a few devices are still giving me
> headaches. This should hopefully be one of my last major requests
> for help (I'm sure most of you will be happy to see traffic on this
> list going down when I'll be done :-))
>=20
> I'm having trouble describing a custom bus named MS bus (completely
> unrelated to a well-known software company) in the device tree. The
> hardware is MPC8248-based and has the following hardware topology.
>=20
> MPC8248 <-- localbus --> FPGA <-- ms bus --> Custom peripherals
>=20
> The bus interrupt controller, serial access (SPI) controller and
> status registers are accessed through memory-mapped registers in the
> FPGA. Parallel access to the MS bus is handled transparently by the
> FPGA which handles address mapping.
>=20
> The FPGA is mapped on the locabus at address 0xf4000000. Bus control
> registers are at 0xf4002000 - 0xf4003000. The parallel bus memory
> window on the localbus is located at 0xf5000000.
>=20
> My current dts draft describes that topology as follows (unrelated
> devices on the local bus such as flash memory are removed for
> clarity).
>=20
> localbus@f0010100 {
> 	compatible =3D "fsl,pq2-localbus";
> 	#address-cells =3D <2>;
> 	#size-cells =3D <1>;
> 	reg =3D <f0010100 40>;
>=20
> 	ranges =3D <0 0 40000000 01000000
> 		  2 0 f2000000 00100000
> 		  3 0 f3000000 00100000
> 		  4 0 f4000000 00100000
> 		  5 0 f5000000 00100000>;
>=20
> 	fpga@4,0 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		ranges =3D <4 0 0 00010000>;
>=20
> 		msbus-arbitrer@2000 {
> 			compatible =3D "tbox,cp11-msbus-arbitrer";
> 			reg =3D <2000 4>;
> 		};
>=20
> 		msbus_pic: interrupt-controller@2100 {
> 			compatible =3D "tbox,cp11-msbus-pic";
> 			reg =3D <2100 8>;
> 			interrupts =3D <17 2>;
> 			interrupt-parent =3D <&cpm_pic>;
> 			#interrupt-cells =3D <1>;
> 			interrupt-controller;
> 		};
>=20
> 		msbus-spi@2200 {
> 			compatible =3D "tbox,cp11-msbus-spi";
> 			reg =3D <2200 100>;
> 			interrupts =3D <18 8>;
> 			interrupt-parent =3D <&cpm_pic>;
> 		};
>=20
> 		sdhc@5000 {
> 			compatible =3D "tbox,sdhci";
> 			reg =3D <5000 1000>;
> 			interrupts =3D <16 8>;
> 			interrupt-parent =3D <&cpm_pic>;
> 		};
> 	};
>=20
> 	msbus@5,0 {
> 		compatible =3D "tbox,cp11-msbus";
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		#interrupt-cells =3D <1>;
> 		reg =3D <5 0 0 00000400>;
> 		interrupt-parent =3D <&msbus_pic>;
> 	};
> };
>=20
> The device tree reflects the physical topology but makes driver
> access to the bus quite complex. An OF platform device driver
> matching on compatible =3D "tbox,cp11-msbus" will not have the bus
> FPGA registers described in its device node.
>=20
> Having a look at the various device trees included in the kernel
> sources, it seems platforms with a PCI bus experience a similar
> problem. To solve it the PCI bus node address and registers describe
> the configuration registers, and the memory window to access PCI
> devices is described by the ranges property.  Applying that to my
> custom bus would lead to the following tree.
>=20
> localbus@f0010100 {
> 	compatible =3D "fsl,pq2-localbus";
> 	#address-cells =3D <2>;
> 	#size-cells =3D <1>;
> 	reg =3D <f0010100 40>;
>=20
> 	ranges =3D <0 0 40000000 01000000
> 		  2 0 f2000000 00100000
> 		  3 0 f3000000 00100000
> 		  4 0 f4000000 00100000
> 		  4 1 f4002000 00000100
> 		  5 0 f5000000 00100000>;
>=20
> 	fpga@4,0 {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		ranges =3D <4 0 0 00010000>;
>=20
> 		msbus_pic: interrupt-controller@2100 {
> 			compatible =3D "tbox,cp11-msbus-pic";
> 			reg =3D <2100 8>;
> 			interrupts =3D <17 2>;
> 			interrupt-parent =3D <&cpm_pic>;
> 			#interrupt-cells =3D <1>;
> 			interrupt-controller;
> 		};
>=20
> 		msbus-spi@2200 {
> 			compatible =3D "tbox,cp11-msbus-spi";
> 			reg =3D <2200 100>;
> 			interrupts =3D <18 8>;
> 			interrupt-parent =3D <&cpm_pic>;
> 		};
>=20
> 		sdhc@5000 {
> 			compatible =3D "tbox,sdhci";
> 			reg =3D <5000 1000>;
> 			interrupts =3D <16 8>;
> 			interrupt-parent =3D <&cpm_pic>;
> 		};
> 	};
>=20
> 	msbus@4,1 {
> 		compatible =3D "tbox,cp11-msbus";
> 		#address-cells =3D <1>;
> 		#size-cells =3D <1>;
> 		#interrupt-cells =3D <1>;
> 		reg =3D <4 1 4>;
> 		interrupt-parent =3D <&msbus_pic>;
> 		ranges =3D <5 0 0 00000400>;
> 	};
> };
>=20
> Is this correct ? Is that the best way to describe my custom bus in
> the device tree ?

Your second example looks closer to right.  Certainly you should use
'reg' only for bus control registers, and 'ranges' for windows into
the bus address space itself.

The device tree describes hardware from a functional point of view, so
I don't know that it's relevant that all the bus control functions are
implemented in an FPGA.  Each of the subnodes are more-or-less
independent devices, so they could just have separate nodes.

Or, if this seems more sensible, you could decide that they're
sufficiently closely related to put them all as one node, with
multiple register blocks listed in the 'reg' property.  That would
probably get messy for your PIC at the very least though.

> How would the relationships between the bus and
> its PIC and SPI controller be handled in the drivers ?

If the msbus driver needs to work with the associated PIC and SPI
controllers, then you should put properties in the msbus node giving
their phandles.

> I also don't
> understand how interrupt mappings are supposed to be handled. PCI
> busses have two CPM interrupt lines, one for the PCI PIC and one for
> the PCI bus, with the PCI bus having the CPM PIC as its interrupt
> controller. My bus PIC uses a single interrupt line. Is there some
> documentation explaining how PICs and interrupt mappings should be
> described ?

Are interrupts from devices on the msbus routed over the msbus, or are
they routed independently to the mspic or the cpm PIC?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH1w2jaILKxv3ab8YRAqqeAJ931Psonl9aqFSEHQGR3icXWCXEzwCfdR0J
QM7aBTMPx2GqWy5BrQXwcLE=
=WI5I
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
