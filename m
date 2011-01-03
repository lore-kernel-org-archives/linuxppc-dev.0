Return-Path: <scottwood@freescale.com>
Date: Mon, 3 Jan 2011 14:22:00 -0600
From: Scott Wood <scottwood@freescale.com>
To: Meador Inge <meador_inge@mentor.com>
Subject: Re: [RFC] MPIC Bindings and Bindings for AMP Systems
Message-ID: <20110103142200.738c0b17@udp111988uds.am.freescale.net>
In-Reply-To: <4D12E4F1.2030004@mentor.com>
References: <4D12E4F1.2030004@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Wed, 22 Dec 2010 23:58:09 -0600
Meador Inge <meador_inge@mentor.com> wrote:

> NOTE: The 'interrupt-parent' is implicit since message register nodes
>         are always children of interrupt controller nodes.
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
> 			cell-index = <0>;
> 			interrupts = <0xb0 0x2 0xb1 0x2
>                                        0xb2 0x2 0xb3 0x2>;
> 		};
> 
> 		msgr@2400 {
> 			compatible = "fsl,p2020-msgr", "fsl,mpic-msgr";
> 			reg = <0x2400 0x200>;
> 			cell-index = <1>;
> 			interrupts = <0xb4 0x2 0xb5 0x2
>                                        0xb6 0x2 0xb7 0x2>;
> 	         };	
> 	};

These nodes cannot go under the mpic node, because interrupt
controllers need #address-cells = <0>.

It would be nice if the binding provided some way of partitioning
up individual message interrupts within a block.

Interrupt generation could be exported as a "service", similar to
(inbound) interrupts and gpios.

Perhaps a something like this, with "doorbell" being a new standard
hw-independent service with its own binding:

msg1: mpic-msg@1400 {
	compatible = "fsl,mpic-v3.0-msg";
	reg = <0x1400 0x200>;
	interrupts <176 2 178 2>;

	// We have message registers 0 and 2 for sending,
	// and 1 and 3 for receiving.
	// If absent, we own all message registers in this block.
	fsl,mpic-msg-send-mask = <0x5>;
	fsl,mpic-msg-receive-mask = <0xa>;

	doorbell-controller;

	// split into #doorbell-send-cells and #doorbell-receive-cells?
	#doorbell-cells = <1>;
};

some-amp-protocol-thingy {
	send-doorbells = <&msg1 0>; // generate messages on MSGR0
	receive-doorbells = <&msg1 0>; // receive messages on MSGR1
};

some-other-amp-protocol-thingy {
	send-doorbells = <&msg1 1>; // generate messages on MSGR2
	receive-doorbells = <&msg1 1>; // receive messages on MSGR3
};

Doorbell capabilities such as passing a 32-bit message can be negotiated
between the drivers for the doorbell controller and the doorbell client.

-Scott
