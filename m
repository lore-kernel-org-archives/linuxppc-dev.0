Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D551B6F7F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 30 Sep 2011 00:20:48 +1000 (EST)
Subject: Re: [PATCH 4/4] powerpc/fsl: Document rapidio node binding-information
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1317263341-19010-4-git-send-email-Gang.Liu@freescale.com>
Date: Thu, 29 Sep 2011 09:20:47 -0500
Message-Id: <1953FF3D-EE9F-400F-880A-072DE37AEE8C@kernel.crashing.org>
References: <1317263341-19010-1-git-send-email-Gang.Liu@freescale.com>
	<1317263341-19010-4-git-send-email-Gang.Liu@freescale.com>
To: Liu Gang <Gang.Liu@freescale.com>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com,
	linux-kernel@vger.kernel.org, r61911@freescale.com,
	B11780@freescale.com, linuxppc-dev@lists.ozlabs.org,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 28, 2011, at 9:29 PM, Liu Gang wrote:

> This document is created for powerpc rapidio and rmu nodes in dts =
file. These nodes
> can support two rapidio ports and message units. In addition, It =
explicates the properties
> and gives examples about rapidio and rmu nodes.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> ---
> .../devicetree/bindings/powerpc/fsl/srio.txt       |   85 =
++++++++++++++++++++
> 1 files changed, 85 insertions(+), 0 deletions(-)
> create mode 100644 =
Documentation/devicetree/bindings/powerpc/fsl/srio.txt

You need to fix this for 80 char column line wrap.

>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/srio.txt =
b/Documentation/devicetree/bindings/powerpc/fsl/srio.txt
> new file mode 100644
> index 0000000..01f2da1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/srio.txt
> @@ -0,0 +1,85 @@
> +* Freescale Rapidio Controller
> +
> +Rapidio port node:
> +Properties:
> +	- compatible: "fsl,rapidio-delta".
> +	  "fsl,rapidio-delta" should be listed for any chip whose =
rapidio controller is compatible.
> +	  At first, rapidio controller was introduced with the version =
of delta and has no revision
> +	  register. Rapidio driver and controller were matched by =
"fsl,rapidio-delta". After the
> +	  addition of two revision registers in rapidio controller, we =
can read some revision and
> +	  configuration information about rapidio controller IP block, =
and the compatible with
> +	  "fsl,rapidio-delta" was still used.


Lets go ahead and change this from 'fsl,rapdio-delta' to 'fsl,srio' =
since you're changing how the binding is defined completely.  This way =
old .dts will fail graceful with the new code.

> +
> +	- reg: For devices compatible with "fsl,rapidio-delta", should =
contain the address and
> +	  the length about all the rapidio controller's registers.
> +
> +	- ranges: Should be defined according to the u-boot settings =
about SRIO. Describe the memory
> +	  mapped I/O space used by the rapidio controller.
> +
> +	- interrupts: Interrupt mapping for rapidio IRQ. Three =
interrupts in the group, and starting
> +	  with SRIO error/port-write IRQ, an error interrupt and with =
interrupt type 1. The other
> +	  two interrupts are doorbell outbound IRQ and doorbell inbound =
IRQ, and they are external
> +	  interrupts.

be clear about the order of the interrupts

> +
> +	- fsl,rio-num-ports: The number of rapidio ports supported by =
this controller.
> +
> +	- fsl,liodn: The logical I/O device number for the PAMU to be =
correctly configured for SRIO
> +	  accesses. This property is added in SRIO node by u-boot and =
usually used by hypervisor.
> +	  The number of elements may either be 2 or 4 LIODN values. For =
HW that only supports LIODNs
> +	  for ALL memory & maintenance transactions we have 2 cells.

We need to add something like:

In this case, the first cell is the LIODN associated with the port 1 and =
the second LIODN is associated with port 2.


> For HW that has separate LIODNs
> +	  for memory & maintenance transaction we utilize 4 cells.

In this case, the first pair of cells are associated with port 1.  The =
first cell is the LIODN associated with memory transactions, the second =
cell is the LIODN associated with maintenance transactions.  The 3 and 4 =
cells follow the same pattern for port 2.

> +
> +	- rmu-handle: The phandle for the rmu connected to this rapidio =
controller.
> +
> +Example:
> +
> +	rapidio: rapidio@ffe0c0000 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		compatible =3D "fsl,rapidio-delta";
> +		interrupts =3D <
> +			16 2 1 11 /* err_irq */
> +			56 2 0 0  /* bell_outb_irq */
> +			57 2 0 0>;/* bell_inb_irq */
> +		fsl,rio-num-ports =3D <2>;
> +		rmu-handle =3D <&rmu>;
> +	};
> +
> +Message unit node:
> +Properties:
> +	- compatible: "fsl,rmu".
> +	  "fsl,rmu" should be listed for any chip whose message unit is =
compatible. In addition,
> +	  RMAN will replace RMU for rapidio message transaction in some =
chips using DPAA architecture.
> +	  Then instead of RMU node, RMAN node will be used in dts file =
and the compatible property
> +	  "fsl,rmu" should be replaced.
> +
> +	- reg: Registers mapping for message unit.
> +
> +	- interrupts: Interrupt mapping for message unit controller. =
Every message
> +	  unit controller has two external interrupts: message outbound =
IRQ and
> +	  message inbound IRQ.

be clear about the order of the interrupts being TX first and RX second.

> +
> +	- fsl,liodn: The logical I/O device number for rmuliodnr and =
added by u-boot.
> +
> +Example:
> +
> +	rmu: rmu@d3000 {
> +		fsl,liodn =3D <0xc8>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,rmu";
> +		reg =3D <0xd3000 0x200>;
> +
> +		message-unit@0 {
> +		reg =3D <0x0 0x100>;
> +		interrupts =3D <
> +			60 2 0 0  /* msg1_tx_irq */
> +			61 2 0 0>;/* msg1_rx_irq */
> +		};
> +		message-unit@1 {

should be message-unit@100

> +		reg =3D <0x100 0x100>;
> +		interrupts =3D <
> +			62 2 0 0  /* msg2_tx_irq */
> +			63 2 0 0>;/* msg2_rx_irq */
> +		};
> +	};
> --=20
> 1.7.3.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
