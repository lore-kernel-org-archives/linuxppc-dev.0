Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 74C6367B53
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 14:52:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5U53eso022332
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 22:03:40 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5U4qasF014464
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 23:52:37 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FEA@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: [PATCH] Add QE device tree definition
Date: Fri, 30 Jun 2006 12:52:27 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, June 30, 2006 12:11 PM
> To: Li Yang-r58472
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] Add QE device tree definition
> 
> [snip]
> 
> >>> +   2) SPI (Serial Peripheral Interface)
> >>> +
> >>> +   Required properties:
> >>> +   - device_type : should be "spi".
> >>> +   - compatible : should be "fsl_spi".
> >>> +   - mode : the spi operation mode, it can be "cpu" or "qe".
> >>
> >> What does it mean for the spi to be in "qe" mode?
> > That means:
> > The SPI can operate in QE mode or in CPU mode. In QE mode SPI is
> > compatible to the MPC826x SPI, and is controlled by QE RISC. In CPU
> > mode, the SPI is controlled wholly by the CPU without any QE RISC
> > intervention.
> 
> In QE mode does software get involved at all?

Yes, of course.  The driver needs to do initialization, and deal with the BDs.
> 
> >>> +   - reg : offset to the register set and its length.
> >>> +   - interrupts : <a b> where a is the interrupt number and b is a
> >>> +     field that represents an encoding of the sense and level
> >>> +     information for the interrupt.  This should be encoded
> >>> based on
> >>> +     the information in section 2) depending on the type of
> >>> interrupt
> >>> +     controller you have.
> >>> +   - interrupt-parent : the phandle for the interrupt controller
> >>> that
> >>> +     services interrupts for this device.
> >>> +
> >>> +   Example:
> >>> +	spi@4c0 {
> >>> +		device_type = "spi";
> >>> +		compatible = "fsl_spi";
> >>> +		reg = <4c0 40>;
> >>> +		interrupts = <82 0>;
> >>> +		interrupt-parent = <700>;
> >>> +		mode = "cpu";
> >>> +	};
> >>> +
> 
> [snip]
> 
> >>> +   5) Parallel I/O Ports
> >>> +
> >>> +   This node configures Parallel I/O ports for CPUs with QE
> >>> support.
> >>> +   The node should reside in the "soc" node of the tree.  For each
> >>> +   device that using parallel I/O ports, a child node should be
> >>> created.
> >>> +   See the definition of the Pin configuration nodes below for more
> >>> +   information.
> >>> +
> >>> +   Required properties:
> >>> +   - device_type : should be "par_io".
> >>> +   - reg : offset to the register set and its length.
> >>> +
> >>> +   Example:
> >>> +	par_io@1400 {
> >>> +		reg = <1400 100>;
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +		device_type = "par_io";
> >>> +		ucc_pin@01 {
> >>> +			......
> >>> +		};
> >>> +
> >>
> >> Can you explain this further, I'm not getting the relationship
> >> between a par_io & ucc_pin.  An example maybe helpful.
> >
> > Each QE device needs to configure Parallel I/O Ports pin
> > configuration in order to work, for example the configuration for
> > ucc1 is ucc_pin@01.  par_io is a container for all these
> > configurations and gives the base for parallel io port register.  I
> > will paste dts file for 8360 to give an example.
> 
> Maybe its the name that's confusing me, ucc_pin@01 describes what
> exactly?  A single pin? or all the pin configs for ucc 1?

All pin configs to ucc1.
Could you suggest a more proper name?
> 
> >>> +
> >>> +   6) Pin configuration nodes
> >>> +
> >>> +   Required properties:
> >>> +   - linux,phandle : phandle of this node; likely referenced by
> >>> a QE
> >>> +     device.
> >>> +   - pio-map : array of pin configurations.  Each pin is defined
> >>> by 6
> >>> +     integers.  The six numbers are respectively: port, pin, dir,
> >>> +     open_drain, assignment, has_irq.
> >>> +     - port : port number of the pin; 0-6 represent port A-G in UM.
> >>> +     - pin : pin number in the port.
> >>> +     - dir : direction of the pin, should encode as follows:
> >>> +
> >>> +	0 = The pin is disabled
> >>> +	1 = The pin is an output
> >>> +	2 = The pin is an input
> >>> +	3 = The pin is I/O
> >>> +
> >>> +     - open_drain : indicates the pin is normal or wired-OR:
> >>> +
> >>> +	0 = The pin is actively driven as an output
> >>> +	1 = The pin is an open-drain driver. As an output, the pin is
> >>> +	    driven active-low, otherwise it is three-stated.
> >>> +
> >>> +     - assignment : function number of the pin according to the
> >>> Pin Assignment
> >>> +       tables in User Manual.  Each pin can have up to 4 possible
> >>> functions in
> >>> +       QE and two options for CPM.
> >>> +     - has_irq : indicates if the pin is used as source of exteral
> >>> +       interrupts.
> >>> +
> >>> +   Example:
> >>> +	ucc_pin@01 {
> >>> +		linux,phandle = <140001>;
> >>> +		pio-map = <
> >>> +		/* port  pin  dir  open_drain  assignment  has_irq */
> >>> +			0  3  1  0  1  0 	/* TxD0 */
> >>> +			0  4  1  0  1  0 	/* TxD1 */
> >>> +			0  5  1  0  1  0 	/* TxD2 */
> >>> +			0  6  1  0  1  0 	/* TxD3 */
> >>> +			1  6  1  0  3  0 	/* TxD4 */
> >>> +			1  7  1  0  1  0 	/* TxD5 */
> >>> +			1  9  1  0  2  0 	/* TxD6 */
> >>> +			1  a  1  0  2  0 	/* TxD7 */
> >>> +			0  9  2  0  1  0 	/* RxD0 */
> >>> +			0  a  2  0  1  0 	/* RxD1 */
> >>> +			0  b  2  0  1  0 	/* RxD2 */
> >>> +			0  c  2  0  1  0 	/* RxD3 */
> >>> +			0  d  2  0  1  0 	/* RxD4 */
> >>> +			1  1  2  0  2  0 	/* RxD5 */
> >>> +			1  0  2  0  2  0 	/* RxD6 */
> >>> +			1  4  2  0  2  0 	/* RxD7 */
> >>> +			0  7  1  0  1  0 	/* TX_EN */
> >>> +			0  8  1  0  1  0 	/* TX_ER */
> >>> +			0  f  2  0  1  0 	/* RX_DV */
> >>> +			0  10 2  0  1  0 	/* RX_ER */
> >>> +			0  0  2  0  1  0 	/* RX_CLK */
> >>> +			2  9  1  0  3  0 	/* GTX_CLK - CLK10 */
> >>> +			2  8  2  0  1  0>;	/* GTX125 - CLK9 */
> >>> +	};
> >>> +
> >>> +
> >>>     More devices will be defined as this spec matures.
> >>>
> >>>
> >>> _______________________________________________
> >>> Linuxppc-dev mailing list
> >>> Linuxppc-dev@ozlabs.org
> >>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
