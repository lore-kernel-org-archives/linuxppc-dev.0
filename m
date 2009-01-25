Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 91942DE0A0
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 06:49:01 +1100 (EST)
Date: Sun, 25 Jan 2009 20:48:53 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/8] powerpc/5200: update device tree binding documentation
Message-ID: <20090125194853.GB26917@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
In-Reply-To: <20090121205506.31232.27908.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, devtree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Grant,

On Wed, Jan 21, 2009 at 01:55:07PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>=20
> This patch updates the mpc5200 binding documentation to match
> actual usage conventions, to remove incorrect information, and
> to remove topics which are more thoroughly described elsewhere.
>=20
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: devtree-discuss@ozlabs.org
> CC: Wolfram Sang <w.sang@pengutronix.de>
> ---
>=20
>  Documentation/powerpc/dts-bindings/fsl/mpc5200.txt |  181 +++++++++++++
>  .../powerpc/mpc52xx-device-tree-bindings.txt       |  277 --------------=
------
>  2 files changed, 181 insertions(+), 277 deletions(-)
>  create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
>  delete mode 100644 Documentation/powerpc/mpc52xx-device-tree-bindings.txt
>=20
>=20
> diff --git a/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt b/Documen=
tation/powerpc/dts-bindings/fsl/mpc5200.txt
> new file mode 100644
> index 0000000..1eddda7
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/fsl/mpc5200.txt
> @@ -0,0 +1,181 @@
> +MPC5200 Device Tree Bindings
> +----------------------------
> +
> +(c) 2006-2009 Secret Lab Technologies Ltd
> +Grant Likely <grant.likely@secretlab.ca>
> +
> +Naming conventions
> +------------------
> +For mpc5200 on-chip devices, the format for each compatible value is
> +<chip>-<device>[-<mode>].  The OS should be able to match a device driver
> +to the device based solely on the compatible value.  If two drivers
> +match on the compatible list; the 'most compatible' driver should be
> +selected.
> +
> +The split between the MPC5200 and the MPC5200B leaves a bit of a
> +conundrum.  How should the compatible property be set up to provide
> +maximum compatibility information; but still accurately describe the
> +chip?  For the MPC5200; the answer is easy.  Most of the SoC devices
> +originally appeared on the MPC5200.  Since they didn't exist anywhere
> +else; the 5200 compatible properties will contain only one item;
> +"fsl,mpc5200-<device>".
> +
> +The 5200B is almost the same as the 5200, but not quite.  It fixes
> +silicon bugs and it adds a small number of enhancements.  Most of the
> +devices either provide exactly the same interface as on the 5200.  A few
> +devices have extra functions but still have a backwards compatible mode.
> +To express this information as completely as possible, 5200B device trees
> +should have two items in the compatible list:
> +	compatible =3D "fsl,mpc5200b-<device>","fsl,mpc5200-<device>";
> +
> +It is *strongly* recommended that 5200B device trees follow this convent=
ion
> +(instead of only listing the base mpc5200 item).
> +
> +ie. ethernet on mpc5200: compatible =3D "fsl,mpc5200-ethernet";
> +    ethernet on mpc5200b: compatible =3D "fsl,mpc5200b-ethernet",
> +                                       "fsl,mpc5200-ethernet";
> +
> +Modal devices, like PSCs, also append the configured function to the
> +end of the compatible field.  ie. A PSC in i2s mode would specify
> +"fsl,mpc5200-psc-i2s", not "fsl,mpc5200-i2s".  This convention is chosen=
 to
> +avoid naming conflicts with non-psc devices providing the same
> +function.  For example, "fsl,mpc5200-spi" and "fsl,mpc5200-psc-spi" desc=
ribe
> +the mpc5200 simple spi device and a PSC spi mode respectively.
> +
> +At the time of writing, exact chip may be either 'fsl,mpc5200' or
> +'fsl,mpc5200b'.
> +
> +The soc node
> +------------
> +This node describes the on chip SOC peripherals.  Every mpc5200 based
> +board will have this node, and as such there is a common naming
> +convention for SOC devices.
> +
> +Required properties:
> +name			description
> +----			-----------
> +ranges			Memory range of the internal memory mapped registers.
> +			Should be <0 [baseaddr] 0xc000>
> +reg			Should be <[baseaddr] 0x100>
> +compatible		mpc5200: "fsl,mpc5200-immr"
> +			mpc5200b: "fsl,mpc5200b-immr"
> +system-frequency	Fsystem frequency; source of all

Fsystem? Typo? The unit would be nice here, too, I think.

> +			other clocks.
> +bus-frequency		IPB bus frequency in HZ.  Clock rate
> +			used by most of the soc devices.
> +
> +soc child nodes
> +---------------
> +Any on chip SOC devices available to Linux must appear as soc5200 child =
nodes.
> +
> +Note: The tables below show the value for the mpc5200.  A mpc5200b device
> +tree should use the "fsl,mpc5200b-<device>","fsl,mpc5200-<device>" form.
> +
> +Required soc5200 child nodes:
> +name				compatible		Description
> +----				----------		-----------
> +cdm@<addr>			fsl,mpc5200-cmd		Clock Distribution

					     ^^ cdm!

> +interrupt-controller@<addr>	fsl,mpc5200-pic		need an interrupt
> +							controller to boot
> +bestcomm@<addr>			fsl,mpc5200-bestcomm	Bestcomm DMA controller
> +
> +Recommended soc5200 child nodes; populate as needed for your board
> +name		compatible		Description
> +----		----------		-----------
> +timer@<addr>	fsl,mpc5200-gpt		 General purpose timers
> +gpio@<addr>	fsl,mpc5200-gpio	 MPC5200 simple gpio controller
> +gpio@<addr>	fsl,mpc5200-gpio-wkup	 MPC5200 wakeup gpio controller
> +rtc@<addr>	fsl,mpc5200-rtc		 Real time clock
> +mscan@<addr>	fsl,mpc5200-mscan	 CAN bus controller
> +pci@<addr>	fsl,mpc5200-pci		 PCI bridge
> +serial@<addr>	fsl,mpc5200-psc-uart	 PSC in serial mode
> +i2s@<addr>	fsl,mpc5200-psc-i2s	 PSC in i2s mode
> +ac97@<addr>	fsl,mpc5200-psc-ac97	 PSC in ac97 mode
> +spi@<addr>	fsl,mpc5200-psc-spi	 PSC in spi mode
> +irda@<addr>	fsl,mpc5200-psc-irda	 PSC in IrDA mode
> +spi@<addr>	fsl,mpc5200-spi		 MPC5200 spi device
> +ethernet@<addr>	fsl,mpc5200-fec		 MPC5200 ethernet device
> +ata@<addr>	fsl,mpc5200-ata		 IDE ATA interface
> +i2c@<addr>	fsl,mpc5200-i2c		 I2C controller
> +usb@<addr>	fsl,mpc5200-ohci,ohci-be USB controller
> +xlb@<addr>	fsl,mpc5200-xlb		 XLB arbitrator
> +
> +fsl,mpc5200-gpt nodes
> +---------------------
> +On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the bo=
ard
> +design supports the internal wdt, then the device node for GPT0 should
> +include the empty property 'fsl,has-wdt'.
> +
> +An mpc5200-gpt can be used as a single line GPIO controller.  To do so,
> +add the following properties to the gpt node:
> +	gpio-controller;
> +	#gpio-cells =3D <2>;
> +When referencing the GPIO line from another node, the first cell must al=
ways
> +be zero and the second cell represents the gpio flags and described in t=
he
> +gpio device tree binding.
> +
> +An mpc5200-gpt can be used as a single line edge sensitive interrupt
> +controller.  To do so, add the following properties to the gpt node:
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +When referencing the IRQ line from another node, the cell represents the
> +sense mode; 1 for edge rising, 2 for edge falling.
> +
> +fsl,mpc5200-psc nodes
> +---------------------
> +The PSCs should include a cell-index which is the index of the PSC in
> +hardware.  cell-index is used to determine which shared SoC registers to
> +use when setting up PSC clocking.  cell-index number starts at '0'.  ie:
> +	PSC1 has 'cell-index =3D <0>'
> +	PSC4 has 'cell-index =3D <3>'
> +
> +PSC in i2s mode:  The mpc5200 and mpc5200b PSCs are not compatible when =
in
> +i2s mode.  An 'mpc5200b-psc-i2s' node cannot include 'mpc5200-psc-i2s' i=
n the
> +compatible field.
> +
> +
> +fsl,mpc5200-gpio and fsl,mpc5200-gpio-wkup nodes
> +------------------------------------------------
> +Each GPIO controller node should have the empty property gpio-controller=
 and
> +#gpio-cells set to 2. First cell is the GPIO number which is interpreted
> +according to the bit numbers in the GPIO control registers. The second c=
ell
> +is for flags which is currently unsused.

Typo: should be "unused".

> +
> +fsl,mpc5200-fec nodes
> +---------------------
> +The FEC node can specify one of the following properties to configure
> +the MII link:
> +- fsl,7-wire-mode - An empty property that specifies the link uses 7-wire
> +                    mode instead of MII
> +- current-speed   - Specifies that the MII should be configured for a fi=
xed
> +                    speed.  This property should contain two cells.  The
> +                    first cell specifies the speed in Mbps and the second
> +                    should be '0' for half duplex and '1' for full duplex
> +- phy-handle      - Contains a phandle to an Ethernet PHY.
> +
> +Interrupt controller (fsl,mpc5200-pic) node
> +-------------------------------------------
> +The mpc5200 pic binding splits hardware IRQ numbers into two levels.  The
> +split reflects the layout of the PIC hardware itself, which groups
> +interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
> +Bestcomm dma engine has it's own set of interrupt sources which are
> +cascaded off of peripheral interrupt 0, which the driver interprets as a
> +fourth group, SDMA.
> +
> +The interrupts property for device nodes using the mpc5200 pic consists
> +of three cells; <L1 L2 level>
> +
> +    L1 :=3D [CRIT=3D0, MAIN=3D1, PERP=3D2, SDMA=3D3]
> +    L2 :=3D interrupt number; directly mapped from the value in the
> +          "ICTL PerStat, MainStat, CritStat Encoded Register"
> +    level :=3D [LEVEL_HIGH=3D0, EDGE_RISING=3D1, EDGE_FALLING=3D2, LEVEL=
_LOW=3D3]
> +
> +For external IRQs, use the following interrupt property values (how to
> +specify external interrupts is a frequently asked question):
> +External interrupts:
> +	external irq0:	interrupts =3D <0 0 n>;
> +	external irq1:	interrupts =3D <1 1 n>;
> +	external irq2:	interrupts =3D <1 2 n>;
> +	external irq3:	interrupts =3D <1 3 n>;
> +'n' is sense (0: level high, 1: edge rising, 2: edge falling 3: level lo=
w)
> +
> diff --git a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt b/Doc=
umentation/powerpc/mpc52xx-device-tree-bindings.txt
> deleted file mode 100644
> index 6f12f1c..0000000
> --- a/Documentation/powerpc/mpc52xx-device-tree-bindings.txt
> +++ /dev/null
> @@ -1,277 +0,0 @@
> -MPC5200 Device Tree Bindings
> -----------------------------
> -
> -(c) 2006-2007 Secret Lab Technologies Ltd
> -Grant Likely <grant.likely at secretlab.ca>
> -
> -********** DRAFT ***********
> -* WARNING: Do not depend on the stability of these bindings just yet.
> -* The MPC5200 device tree conventions are still in flux
> -* Keep an eye on the linuxppc-dev mailing list for more details
> -********** DRAFT ***********
> -
> -I - Introduction
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Boards supported by the arch/powerpc architecture require device tree be
> -passed by the boot loader to the kernel at boot time.  The device tree
> -describes what devices are present on the board and how they are
> -connected.  The device tree can either be passed as a binary blob (as
> -described in Documentation/powerpc/booting-without-of.txt), or passed
> -by Open Firmware (IEEE 1275) compatible firmware using an OF compatible
> -client interface API.
> -
> -This document specifies the requirements on the device-tree for mpc5200
> -based boards.  These requirements are above and beyond the details
> -specified in either the Open Firmware spec or booting-without-of.txt
> -
> -All new mpc5200-based boards are expected to match this document.  In
> -cases where this document is not sufficient to support a new board port,
> -this document should be updated as part of adding the new board support.
> -
> -II - Philosophy
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The core of this document is naming convention.  The whole point of
> -defining this convention is to reduce or eliminate the number of
> -special cases required to support a 5200 board.  If all 5200 boards
> -follow the same convention, then generic 5200 support code will work
> -rather than coding special cases for each new board.
> -
> -This section tries to capture the thought process behind why the naming
> -convention is what it is.
> -
> -1.  names
> ----------
> -There is strong convention/requirements already established for children
> -of the root node.  'cpus' describes the processor cores, 'memory'
> -describes memory, and 'chosen' provides boot configuration.  Other nodes
> -are added to describe devices attached to the processor local bus.
> -
> -Following convention already established with other system-on-chip
> -processors, 5200 device trees should use the name 'soc5200' for the
> -parent node of on chip devices, and the root node should be its parent.
> -
> -Child nodes are typically named after the configured function.  ie.
> -the FEC node is named 'ethernet', and a PSC in uart mode is named 'seria=
l'.
> -
> -2. device_type property
> ------------------------
> -similar to the node name convention above; the device_type reflects the
> -configured function of a device.  ie. 'serial' for a uart and 'spi' for
> -an spi controller.  However, while node names *should* reflect the
> -configured function, device_type *must* match the configured function
> -exactly.
> -
> -3. compatible property
> -----------------------
> -Since device_type isn't enough to match devices to drivers, there also
> -needs to be a naming convention for the compatible property.  Compatible
> -is an list of device descriptions sorted from specific to generic.  For
> -the mpc5200, the required format for each compatible value is
> -<chip>-<device>[-<mode>].  The OS should be able to match a device driver
> -to the device based solely on the compatible value.  If two drivers
> -match on the compatible list; the 'most compatible' driver should be
> -selected.
> -
> -The split between the MPC5200 and the MPC5200B leaves a bit of a
> -conundrum.  How should the compatible property be set up to provide
> -maximum compatibility information; but still accurately describe the
> -chip?  For the MPC5200; the answer is easy.  Most of the SoC devices
> -originally appeared on the MPC5200.  Since they didn't exist anywhere
> -else; the 5200 compatible properties will contain only one item;
> -"mpc5200-<device>".
> -
> -The 5200B is almost the same as the 5200, but not quite.  It fixes
> -silicon bugs and it adds a small number of enhancements.  Most of the
> -devices either provide exactly the same interface as on the 5200.  A few
> -devices have extra functions but still have a backwards compatible mode.
> -To express this information as completely as possible, 5200B device trees
> -should have two items in the compatible list;
> -"mpc5200b-<device>\0mpc5200-<device>".  It is *strongly* recommended
> -that 5200B device trees follow this convention (instead of only listing
> -the base mpc5200 item).
> -
> -If another chip appear on the market with one of the mpc5200 SoC
> -devices, then the compatible list should include mpc5200-<device>.
> -
> -ie. ethernet on mpc5200: compatible =3D "mpc5200-ethernet"
> -    ethernet on mpc5200b: compatible =3D "mpc5200b-ethernet\0mpc5200-eth=
ernet"
> -
> -Modal devices, like PSCs, also append the configured function to the
> -end of the compatible field.  ie. A PSC in i2s mode would specify
> -"mpc5200-psc-i2s", not "mpc5200-i2s".  This convention is chosen to
> -avoid naming conflicts with non-psc devices providing the same
> -function.  For example, "mpc5200-spi" and "mpc5200-psc-spi" describe
> -the mpc5200 simple spi device and a PSC spi mode respectively.
> -
> -If the soc device is more generic and present on other SOCs, the
> -compatible property can specify the more generic device type also.
> -
> -ie. mscan: compatible =3D "mpc5200-mscan\0fsl,mscan";
> -
> -At the time of writing, exact chip may be either 'mpc5200' or
> -'mpc5200b'.
> -
> -Device drivers should always try to match as generically as possible.
> -
> -III - Structure
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -The device tree for an mpc5200 board follows the structure defined in
> -booting-without-of.txt with the following additional notes:
> -
> -0) the root node
> -----------------
> -Typical root description node; see booting-without-of
> -
> -1) The cpus node
> -----------------
> -The cpus node follows the basic layout described in booting-without-of.
> -The bus-frequency property holds the XLB bus frequency
> -The clock-frequency property holds the core frequency
> -
> -2) The memory node
> -------------------
> -Typical memory description node; see booting-without-of.
> -
> -3) The soc5200 node
> --------------------
> -This node describes the on chip SOC peripherals.  Every mpc5200 based
> -board will have this node, and as such there is a common naming
> -convention for SOC devices.
> -
> -Required properties:
> -name			type		description
> -----			----		-----------
> -device_type		string		must be "soc"
> -ranges			int		should be <0 baseaddr baseaddr+10000>
> -reg			int		must be <baseaddr 10000>
> -compatible		string		mpc5200: "mpc5200-soc"
> -					mpc5200b: "mpc5200b-soc\0mpc5200-soc"
> -system-frequency	int		Fsystem frequency; source of all
> -					other clocks.
> -bus-frequency		int		IPB bus frequency in HZ.  Clock rate
> -					used by most of the soc devices.
> -#interrupt-cells	int		must be <3>.
> -
> -Recommended properties:
> -name			type		description
> -----			----		-----------
> -model			string		Exact model of the chip;
> -					ie: model=3D"fsl,mpc5200"
> -revision		string		Silicon revision of chip
> -					ie: revision=3D"M08A"
> -
> -The 'model' and 'revision' properties are *strongly* recommended.  Having
> -them presence acts as a bit of a safety net for working around as yet
> -undiscovered bugs on one version of silicon.  For example, device drivers
> -can use the model and revision properties to decide if a bug fix should
> -be turned on.
> -
> -4) soc5200 child nodes
> -----------------------
> -Any on chip SOC devices available to Linux must appear as soc5200 child =
nodes.
> -
> -Note: The tables below show the value for the mpc5200.  A mpc5200b device
> -tree should use the "mpc5200b-<device>\0mpc5200-<device> form.
> -
> -Required soc5200 child nodes:
> -name		device_type		compatible	Description
> -----		-----------		----------	-----------
> -cdm@<addr>	cdm			mpc5200-cmd	Clock Distribution
> -pic@<addr>	interrupt-controller	mpc5200-pic	need an interrupt
> -							controller to boot
> -bestcomm@<addr>	dma-controller		mpc5200-bestcomm 5200 pic also requires
> -							 the bestcomm device
> -
> -Recommended soc5200 child nodes; populate as needed for your board
> -name		device_type	compatible	  Description
> -----		-----------	----------	  -----------
> -gpt@<addr>	gpt		fsl,mpc5200-gpt	  General purpose timers
> -gpt@<addr>	gpt		fsl,mpc5200-gpt-gpio	General purpose
> -							timers in GPIO mode
> -gpio@<addr>			fsl,mpc5200-gpio	MPC5200 simple gpio
> -							controller
> -gpio@<addr>			fsl,mpc5200-gpio-wkup	MPC5200 wakeup gpio
> -							controller
> -rtc@<addr>	rtc		mpc5200-rtc	  Real time clock
> -mscan@<addr>	mscan		mpc5200-mscan	  CAN bus controller
> -pci@<addr>	pci		mpc5200-pci	  PCI bridge
> -serial@<addr>	serial		mpc5200-psc-uart  PSC in serial mode
> -i2s@<addr>	sound		mpc5200-psc-i2s	  PSC in i2s mode
> -ac97@<addr>	sound		mpc5200-psc-ac97  PSC in ac97 mode
> -spi@<addr>	spi		mpc5200-psc-spi	  PSC in spi mode
> -irda@<addr>	irda		mpc5200-psc-irda  PSC in IrDA mode
> -spi@<addr>	spi		mpc5200-spi	  MPC5200 spi device
> -ethernet@<addr>	network		mpc5200-fec	  MPC5200 ethernet device
> -ata@<addr>	ata		mpc5200-ata	  IDE ATA interface
> -i2c@<addr>	i2c		mpc5200-i2c	  I2C controller
> -usb@<addr>	usb-ohci-be	mpc5200-ohci,ohci-be	USB controller
> -xlb@<addr>	xlb		mpc5200-xlb	  XLB arbitrator
> -
> -Important child node properties
> -name		type		description
> -----		----		-----------
> -cell-index	int		When multiple devices are present, is the
> -				index of the device in the hardware (ie. There
> -				are 6 PSC on the 5200 numbered PSC1 to PSC6)
> -				    PSC1 has 'cell-index =3D <0>'
> -				    PSC4 has 'cell-index =3D <3>'
> -
> -5) General Purpose Timer nodes (child of soc5200 node)
> -On the mpc5200 and 5200b, GPT0 has a watchdog timer function.  If the bo=
ard
> -design supports the internal wdt, then the device node for GPT0 should
> -include the empty property 'fsl,has-wdt'.
> -
> -6) PSC nodes (child of soc5200 node)
> -PSC nodes can define the optional 'port-number' property to force assign=
ment
> -order of serial ports.  For example, PSC5 might be physically connected =
to
> -the port labeled 'COM1' and PSC1 wired to 'COM1'.  In this case, PSC5 wo=
uld
> -have a "port-number =3D <0>" property, and PSC1 would have "port-number =
=3D <1>".
> -
> -PSC in i2s mode:  The mpc5200 and mpc5200b PSCs are not compatible when =
in
> -i2s mode.  An 'mpc5200b-psc-i2s' node cannot include 'mpc5200-psc-i2s' i=
n the
> -compatible field.
> -
> -7) GPIO controller nodes
> -Each GPIO controller node should have the empty property gpio-controller=
 and
> -#gpio-cells set to 2. First cell is the GPIO number which is interpreted
> -according to the bit numbers in the GPIO control registers. The second c=
ell
> -is for flags which is currently unsused.
> -
> -8) FEC nodes
> -The FEC node can specify one of the following properties to configure
> -the MII link:
> -"fsl,7-wire-mode" - An empty property that specifies the link uses 7-wire
> -                    mode instead of MII
> -"current-speed"   - Specifies that the MII should be configured for a fi=
xed
> -                    speed.  This property should contain two cells.  The
> -                    first cell specifies the speed in Mbps and the second
> -                    should be '0' for half duplex and '1' for full duplex
> -"phy-handle"      - Contains a phandle to an Ethernet PHY.
> -
> -IV - Extra Notes
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -
> -1. Interrupt mapping
> ---------------------
> -The mpc5200 pic driver splits hardware IRQ numbers into two levels.  The
> -split reflects the layout of the PIC hardware itself, which groups
> -interrupts into one of three groups; CRIT, MAIN or PERP.  Also, the
> -Bestcomm dma engine has it's own set of interrupt sources which are
> -cascaded off of peripheral interrupt 0, which the driver interprets as a
> -fourth group, SDMA.
> -
> -The interrupts property for device nodes using the mpc5200 pic consists
> -of three cells; <L1 L2 level>
> -
> -    L1 :=3D [CRIT=3D0, MAIN=3D1, PERP=3D2, SDMA=3D3]
> -    L2 :=3D interrupt number; directly mapped from the value in the
> -          "ICTL PerStat, MainStat, CritStat Encoded Register"
> -    level :=3D [LEVEL_HIGH=3D0, EDGE_RISING=3D1, EDGE_FALLING=3D2, LEVEL=
_LOW=3D3]
> -
> -2. Shared registers
> --------------------
> -Some SoC devices share registers between them.  ie. the i2c devices use
> -a single clock control register, and almost all device are affected by
> -the port_config register.  Devices which need to manipulate shared regs
> -should look to the parent SoC node.  The soc node is responsible
> -for arbitrating all shared register access.
>=20

Regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkl8wiUACgkQD27XaX1/VRveYgCfaVFeiDESoracA0R7fj02sVCF
CO4AoKu6Y9+UAHWCC8VeL3WtNFDYST14
=Xuin
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--
