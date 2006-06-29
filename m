Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6590C67B87
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 09:55:26 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FE5@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FE5@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <32BCC34C-0CEC-42C1-B42B-A0C78D369D20@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add QE device tree definition
Date: Thu, 29 Jun 2006 18:55:19 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2006, at 7:53 AM, Li Yang-r58472 wrote:

> This is the device tree definition for QE SOC for Freescale CPUs.
>
> I have discussed with Vitaly.  We agreed on having CPM and QE  
> definition ultimately merged.  He will add in CPM specified  
> definition later.
>
> Signed-off-by: Jiang Bo <Tanya.jiang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
>
> ---
> Documentation/powerpc/booting-without-of.txt |  222 ++++++++++++++++ 
> ++++++++++
>  1 files changed, 222 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 217e517..096063f 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1442,6 +1442,227 @@ platforms are moved over to use the flat
>         };
>
>
> +   h) Freescale QUICC Engine module (QE)
> +   This represents qe module that is installed on PowerQUICC II Pro.
> +   Hopefully it will merge backward compatibility with CPM/CPM2.
> +   Basically, it is a bus of devices, that could act more or less
> +   as a complete entity (UCC, USB etc ). All of them should be  
> siblings on
> +   the "root" qe node, using the common properties from there.
> +   The description below applies to the the qe of MPC8360 and
> +   more nodes and properties would be extended in the future.	
> +
> +   1) Root QE device
> +
> +   Required properties:
> +   - device_type : should be "qe";
> +   - model : precise model of the QE, Can be "QE", "CPM", or "CPM2"
> +   - reg : Offset and length of the register set for the device.
> +   - bus-frequency : the clock frequency for QUICC Engine.
> +
> +   Recommended properties
> +   - brg-frequency : the internal clock source frequency for baud- 
> rate
> +     generators in Hz.
> +
> +   Example:
> +	qe@e0100000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "qe";
> +		model = "QE";
> +		ranges = <0 e0100000 00100000>;
> +		reg = <e0100000 480>;
> +		brg-frequency = <0>;
> +		bus-frequency = <179A7B00>;
> +	}
> +
> +
> +   2) SPI (Serial Peripheral Interface)
> +
> +   Required properties:
> +   - device_type : should be "spi".
> +   - compatible : should be "fsl_spi".
> +   - mode : the spi operation mode, it can be "cpu" or "qe".

What does it mean for the spi to be in "qe" mode?

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
> +		device_type = "spi";
> +		compatible = "fsl_spi";
> +		reg = <4c0 40>;
> +		interrupts = <82 0>;
> +		interrupt-parent = <700>;
> +		mode = "cpu";
> +	};
> +

How do we tell the difference between the various spi controllers.  I  
think we have four of them, three of which are probably pretty  
similar.  We have the 834x spi, and QE, CPM1, CPM2 SPI.

> +
> +   3) USB (Universal Serial Bus Controller)
> +
> +   Required properties:
> +   - device_type : should be "usb".
> +   - compatible : could be "qe_udc" or "fhci-hcd".
> +   - model : the could be "host" or "slave".

got a 'l' on mode, if we are slave should we provide more info about  
what kinda slave we are (ie, what gadget driver should apply).

> +   - reg : there will be two tuples of "address size".  The first  
> tuple is
> +     offset and length of the device registers respectively; the  
> second is
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
> +		device_type = "usb";
> +		compatible = "qe_udc";
> +		reg = <6c0 40 8B00 100>;
> +		interrupts = <8b 0>;
> +		interrupt-parent = <700>;
> +		mode = "slave";
> +	};
> +
> +
> +   4) UCC (Unified Communications Controllers)

Why dont you create a sub section for network, and in the future  
additional subsections can be added for the different device_types.

> +
> +   Required properties:
> +   - device_type : should be "network", "hldc", "uart", "transparent"
> +    "bisync" or "atm".
> +   - compatible : could be "ucc_geth" or "fsl_atm" and so on.
> +   - model : should be "UCC".
> +   - device-id : the ucc number(1-8), corresponding to UCCx in UM.
> +   - reg : there will be two tuples of "address size".  The first  
> tuple is
> +     offset and length of the device registers respectively; the  
> second is
> +     offset and length of the device parameter RAM respectively.
> +   - interrupts : <a b> where a is the interrupt number and b is a
> +     field that represents an encoding of the sense and level
> +     information for the interrupt.  This should be encoded based on
> +     the information in section 2) depending on the type of interrupt
> +     controller you have.
> +   - interrupt-parent : the phandle for the interrupt controller that
> +     services interrupts for this device.
> +   - pio-handle : The phandle for the Parallel I/O port  
> configuration.
> +
> +   Required properties for network device_type:
> +   - mac-address : list of bytes representing the ethernet address.
> +   - rx-clock : a string represents the UCC receive clock source.
> +     "brgx" : clock source is BRG1~BRG16 respectively;
> +     "clkx" : clock source is QE_CLK1~QE_CLK24 respectively.
> +     others : clock source is disabled;
> +   - tx-clock: a string represents the UCC transmit clock source;
> +     "brgx" : clock source is BRG1~BRG16 respectively;
> +     "clkx" : clock source is QE_CLK1~QE_CLK24 respectively.
> +     others : clock source is disabled;
> +   - phy-handle : The phandle for the PHY connected to this  
> controller.
> +
> +   Example:
> +	ucc@2000 {
> +		device_type = "network";
> +		compatible = "ucc_geth";
> +		model = "UCC";
> +		device-id = <1>;
> +		reg = <2000 200 8400 100>;
> +		interrupts = <a0 0>;
> +		interrupt-parent = <700>;
> +		mac-address = [ 00 04 9f 00 23 23 ];
> +		rx-clock = "none";
> +		tx-clock = "clk9";
> +		phy-handle = <212000>;
> +		pio-handle = <140001>;
> +	};
> +
> +
> +   5) Parallel I/O Ports
> +
> +   This node configures Parallel I/O ports for CPUs with QE support.
> +   The node should reside in the "soc" node of the tree.  For each
> +   device that using parallel I/O ports, a child node should be  
> created.
> +   See the definition of the Pin configuration nodes below for more
> +   information.
> +
> +   Required properties:
> +   - device_type : should be "par_io".
> +   - reg : offset to the register set and its length.
> +
> +   Example:
> +	par_io@1400 {
> +		reg = <1400 100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;		
> +		device_type = "par_io";
> +		ucc_pin@01 {
> +			......
> +		};
> +

Can you explain this further, I'm not getting the relationship  
between a par_io & ucc_pin.  An example maybe helpful.

> +
> +   6) Pin configuration nodes
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
> +	0 = The pin is disabled
> +	1 = The pin is an output
> +	2 = The pin is an input
> +	3 = The pin is I/O
> +
> +     - open_drain : indicates the pin is normal or wired-OR:
> +
> +	0 = The pin is actively driven as an output
> +	1 = The pin is an open-drain driver. As an output, the pin is
> +	    driven active-low, otherwise it is three-stated.
> +
> +     - assignment : function number of the pin according to the  
> Pin Assignment
> +       tables in User Manual.  Each pin can have up to 4 possible  
> functions in
> +       QE and two options for CPM.
> +     - has_irq : indicates if the pin is used as source of exteral
> +       interrupts.
> +
> +   Example:
> +	ucc_pin@01 {
> +		linux,phandle = <140001>;
> +		pio-map = <
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
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
