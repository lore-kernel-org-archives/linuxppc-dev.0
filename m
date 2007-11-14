Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8B39DDDF7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 04:13:03 +1100 (EST)
Message-ID: <473B2C95.2060600@freescale.com>
Date: Wed, 14 Nov 2007 11:12:53 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: sivaji <rameshmrm@gmail.com>
Subject: Re: DMA interrupt is not generating in MPC8641D
References: <13747460.post@talk.nabble.com>
In-Reply-To: <13747460.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

sivaji wrote:
> Hai,
> 
> We have designed a MPC8641D based AMC card. As part of our customer
> requirement for a PCIe messaging driver for communicating between the
> MPC8641D AMC card as the PCIe target and the MPC8548E AMC card as the Host.
> 
> We are using the DMA for transferring data between the boards thru' PCIe.
> The DMA Interrupt on the target end is not getting registered and hence we
> face the issue (ie) No interrupt is generated after DMA transfer completion.
> 
> As per datasheet(Rev. 1, 05/2007) page no:445 interrupt number for
> DMAchannel 1 is 4. We are using linux kernel version :2.6.23-rc3. According
> to file (include/asm-powerpc/irq.h) line no:636 the interrupt number for DMA
> in linux is 20(decimal). When using this interrupt number 20 we are not able
> to registerd the DMA interrupts.

Since you're using 2.6.23, the IRQ for all devices is specified in the device 
tree, not some header file.  However, the device tree for the 8641 does not 
specify any DMA nodes, so you need to add that.  Here are the nodes for the 8610 
that I'm going to add:

                 dma@21300 {
                         #address-cells = <1>;
                         #size-cells = <1>;
                         compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
                         device-id = <0>;
                         reg = <21300 4>; /* DMA general status register */
                         ranges = <0 21100 200>;

                         dma-channel@0 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <0>;
				reg = <0 80>;
				interrupt-parent = <&mpic>;
				interrupts = <14 2>;
                         };
                         dma-channel@1 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <1>;
				reg = <80 80>;
				interrupt-parent = <&mpic>;
				interrupts = <15 2>;
                         };
                         dma-channel@2 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <2>;
				reg = <100 80>;
				interrupt-parent = <&mpic>;
				interrupts = <16 2>;
                         };
                         dma-channel@3 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <3>;
				reg = <180 80>;
				interrupt-parent = <&mpic>;
				interrupts = <17 2>;
                         };
                 };

                 dma@c300 {
                         #address-cells = <1>;
                         #size-cells = <1>;
                         compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
                         device-id = <1>;
                         reg = <c300 4>; /* DMA general status register */
                         ranges = <0 c100 200>;

                         dma-channel@0 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <0>;
				reg = <0 80>;
				interrupt-parent = <&mpic>;
				interrupts = <3c 2>;
                         };
                         dma-channel@1 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <1>;
				reg = <80 80>;
				interrupt-parent = <&mpic>;
				interrupts = <3d 2>;
                         };
                         dma-channel@2 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <2>;
				reg = <100 80>;
				interrupt-parent = <&mpic>;
				interrupts = <3e 2>;
                         };
                         dma-channel@3 {
				compatible = "fsl,mpc8610-dma-channel",
					"fsl,mpc8540-dma-channel";
				device-id = <3>;
				reg = <180 80>;
				interrupt-parent = <&mpic>;
				interrupts = <3f 2>;
                         };
                 };

	};

Please note that there is no support in the kernel for generic PowerPC DMA 
transfers, so in addition to adding these nodes, you would also need to write 
all the code to do the DMA transfers.

-- 
Timur Tabi
Linux kernel developer at Freescale
