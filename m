Return-Path: <Tony.Li@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9A29B67A33
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 12:40:34 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8Q2eXX6027026
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 19:40:33 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8Q2eT2l004840
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 21:40:31 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] QE device tree node definition
Date: Tue, 26 Sep 2006 10:40:28 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263516C375@zch01exm21.fsl.freescale.net>
In-Reply-To: <4517A922.503@freescale.com>
From: "Li Tony-r64360" <Tony.Li@freescale.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
1) Where is the QE embedded interrupt controller ?
I think the interrupt-parent of the QE function should point to it.

2) For the UCC, It is better to make rx-clock and tx-clock as required
properties.
 Almost all functions need this properties

Best Regards
> -----Original Message-----
> From: linuxppc-dev-bounces+tony.li=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+tony.li=3Dfreescale.com@ozlabs.org]
>  On Behalf Of Li Yang
> Sent: Monday, September 25, 2006 6:02 PM
> To: linuxppc-dev@ozlabs.org
> Subject: [RFC][PATCH] QE device tree node definition
>=20
> Here is OF device tree node spec used in QE/8360 support patches.
>=20
> Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>=20
> ---
> This is a repost of previous patch to be reviewed together=20
> with QE/8360 support patches.
> Vitaly will add CPM part and maybe post an integrated spec of=20
> QE/CPM later.
>=20
> diff --git a/Documentation/powerpc/booting-without-of.txt=20
> b/Documentation/powerpc/booting-without-of.txt
> index 5c0ba23..b3218a1 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1442,6 +1442,231 @@ platforms are moved over to use the flat
>         };
> =20
> =20
> +   h) Freescale QUICC Engine module (QE)
> +   This represents qe module that is installed on PowerQUICC II Pro.
> +   Hopefully it will merge backward compatibility with CPM/CPM2.
> +   Basically, it is a bus of devices, that could act more or less
> +   as a complete entity (UCC, USB etc ). All of them should=20
> be siblings on
> +   the "root" qe node, using the common properties from there.
> +   The description below applies to the the qe of MPC8360 and
> +   more nodes and properties would be extended in the future.
> +
> +   i) Root QE device
> +
> +   Required properties:
> +   - device_type : should be "qe";
> +   - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
> +   - reg : there will be two tuples of "address size".  The=20
> first tuple is
> +     offset and length of the device registers respectively;=20
> the second is
> +     offset and length of the device parameter RAM respectively.
> +   - bus-frequency : the clock frequency for QUICC Engine.
> + =20
> +   Recommended properties
> +   - brg-frequency : the internal clock source frequency for=20
> baud-rate
> +     generators in Hz.
> +
> +   Example:
> +	qe@e0100000 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		#interrupt-cells =3D <2>;
> +		device_type =3D "qe";
> +		model =3D "QE";
> +		ranges =3D <0 e0100000 00100000>;
> +		reg =3D <e0100000 480 e0110000 c000>;
> +		brg-frequency =3D <0>;
> +		bus-frequency =3D <179A7B00>;
> +	}
> +
> +
> +   ii) SPI (Serial Peripheral Interface)
> +
> +   Required properties:
> +   - device_type : should be "spi".
> +   - compatible : should be "fsl_spi".
> +   - mode : the spi operation mode, it can be "cpu" or "qe".
> +   - reg : offset to the register set and its length.
> +   - interrupts : <a b> where a is the interrupt number and b is a
> +     field that represents an encoding of the sense and level
> +     information for the interrupt.  This should be encoded based on
> +     the information in section 2) depending on the type of interrupt
> +     controller you have.
> +   - interrupt-parent : the phandle for the interrupt controller that
> +     services interrupts for this device.
> +
> +   Example:
> +	spi@4c0 {
> +		device_type =3D "spi";
> +		compatible =3D "fsl_spi";
> +		reg =3D <4c0 40>;
> +		interrupts =3D <82 0>;
> +		interrupt-parent =3D <700>;
> +		mode =3D "cpu";
> +	};
> +
> +
> +   iii) USB (Universal Serial Bus Controller)
> +
> +   Required properties:
> +   - device_type : should be "usb".
> +   - compatible : could be "qe_udc" or "fhci-hcd".
> +   - mode : the could be "host" or "slave".
> +   - reg : there will be two tuples of "address size".  The=20
> first tuple is
> +     offset and length of the device registers respectively;=20
> the second is
> +     offset and length of the device parameter RAM respectively.
> +   - interrupts : <a b> where a is the interrupt number and b is a
> +     field that represents an encoding of the sense and level
> +     information for the interrupt.  This should be encoded based on
> +     the information in section 2) depending on the type of interrupt
> +     controller you have.
> +   - interrupt-parent : the phandle for the interrupt controller that
> +     services interrupts for this device.
> +
> +   Example(slave):
> +	usb@6c0 {
> +		device_type =3D "usb";
> +		compatible =3D "qe_udc";
> +		reg =3D <6c0 40 8B00 100>;
> +		interrupts =3D <8b 0>;
> +		interrupt-parent =3D <700>;
> +		mode =3D "slave";
> +	};
> +
> +
> +   iv) UCC (Unified Communications Controllers)
> +
> +   Required properties:
> +   - device_type : should be "network", "hldc", "uart", "transparent"
> +    "bisync" or "atm".
> +   - compatible : could be "ucc_geth" or "fsl_atm" and so on.
> +   - model : should be "UCC".
> +   - device-id : the ucc number(1-8), corresponding to UCCx in UM.
> +   - reg : there will be two tuples of "address size".  The=20
> first tuple is
> +     offset and length of the device registers respectively;=20
> the second is
> +     offset and length of the device parameter RAM respectively.
> +   - interrupts : <a b> where a is the interrupt number and b is a
> +     field that represents an encoding of the sense and level
> +     information for the interrupt.  This should be encoded based on
> +     the information in section 2) depending on the type of interrupt
> +     controller you have.
> +   - interrupt-parent : the phandle for the interrupt controller that
> +     services interrupts for this device.
> +   - pio-handle : The phandle for the Parallel I/O port=20
> configuration.
> +
> +   Required properties for network device_type:
> +   - mac-address : list of bytes representing the ethernet address.
> +   - rx-clock : represents the UCC receive clock source.
> +     0x00 : clock source is disabled;
> +     0x1~0x10 : clock source is BRG1~BRG16 respectively;
> +     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
> +   - t--clock: represents the UCC transmit clock source;
> +     0x00 : clock source is disabled;
> +     0x1~0x10 : clock source is BRG1~BRG16 respectively;
> +     0x11~0x28: clock source is QE_CLK1~QE_CLK24 respectively.
> +   - phy-handle : The phandle for the PHY connected to this=20
> controller.
> +
> +   Example:
> +	ucc@2000 {
> +		device_type =3D "network";
> +		compatible =3D "ucc_geth";
> +		model =3D "UCC";
> +		device-id =3D <1>;
> +		reg =3D <2000 200 8400 100>;
> +		interrupts =3D <a0 0>;
> +		interrupt-parent =3D <700>;
> +		mac-address =3D [ 00 04 9f 00 23 23 ];
> +		rx-clock =3D "none";
> +		tx-clock =3D "clk9";
> +		phy-handle =3D <212000>;
> +		pio-handle =3D <140001>;
> +	};
> +
> +
> +   v) Parallel I/O Ports
> +
> +   This node configures Parallel I/O ports for CPUs with QE support.
> +   The node should reside in the "soc" node of the tree.  For each
> +   device that using parallel I/O ports, a child node should=20
> be created.
> +   See the definition of the Pin configuration nodes below for more
> +   information.
> +
> +   Required properties:
> +   - device_type : should be "par_io".
> +   - reg : offset to the register set and its length.
> +   - num-ports : number of Parallel I/O ports
> +
> +   Example:
> +	par_io@1400 {
> +		reg =3D <1400 100>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +		device_type =3D "par_io";
> +		num-ports =3D <7>;
> +		ucc_pin@01 {
> +			......
> +		};
> +
> +
> +   vi) Pin configuration nodes
> +
> +   Required properties:
> +   - linux,phandle : phandle of this node; likely referenced by a QE
> +     device.
> +   - pio-map : array of pin configurations.  Each pin is defined by 6
> +     integers.  The six numbers are respectively: port, pin, dir,
> +     open_drain, assignment, has_irq.
> +     - port : port number of the pin; 0-6 represent port A-G in UM.
> +     - pin : pin number in the port.
> +     - dir : direction of the pin, should encode as follows:
> +
> +	0 =3D The pin is disabled
> +	1 =3D The pin is an output
> +	2 =3D The pin is an input
> +	3 =3D The pin is I/O
> +
> +     - open_drain : indicates the pin is normal or wired-OR:
> +
> +	0 =3D The pin is actively driven as an output
> +	1 =3D The pin is an open-drain driver. As an output, the pin is
> +	    driven active-low, otherwise it is three-stated.
> +
> +     - assignment : function number of the pin according to=20
> the Pin Assignment
> +       tables in User Manual.  Each pin can have up to 4=20
> possible functions in
> +       QE and two options for CPM.
> +     - has_irq : indicates if the pin is used as source of exteral
> +       interrupts.
> +
> +   Example:
> +	ucc_pin@01 {
> +		linux,phandle =3D <140001>;
> +		pio-map =3D <
> +		/* port  pin  dir  open_drain  assignment  has_irq */
> +			0  3  1  0  1  0 	/* TxD0 */
> +			0  4  1  0  1  0 	/* TxD1 */
> +			0  5  1  0  1  0 	/* TxD2 */
> +			0  6  1  0  1  0 	/* TxD3 */
> +			1  6  1  0  3  0 	/* TxD4 */
> +			1  7  1  0  1  0 	/* TxD5 */
> +			1  9  1  0  2  0 	/* TxD6 */
> +			1  a  1  0  2  0 	/* TxD7 */
> +			0  9  2  0  1  0 	/* RxD0 */
> +			0  a  2  0  1  0 	/* RxD1 */
> +			0  b  2  0  1  0 	/* RxD2 */
> +			0  c  2  0  1  0 	/* RxD3 */
> +			0  d  2  0  1  0 	/* RxD4 */
> +			1  1  2  0  2  0 	/* RxD5 */
> +			1  0  2  0  2  0 	/* RxD6 */
> +			1  4  2  0  2  0 	/* RxD7 */
> +			0  7  1  0  1  0 	/* TX_EN */
> +			0  8  1  0  1  0 	/* TX_ER */
> +			0  f  2  0  1  0 	/* RX_DV */
> +			0  10 2  0  1  0 	/* RX_ER */
> +			0  0  2  0  1  0 	/* RX_CLK */
> +			2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
> +			2  8  2  0  1  0>;	/* GTX125 - CLK9 */
> +	};
> +
> +
>     More devices will be defined as this spec matures.
> =20
> =20
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
