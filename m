Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C987DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:45:44 +1100 (EST)
Message-Id: <7793CF97-2634-4EB2-B354-F842605BE2E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: robert lazarski <robertlazarski@gmail.com>
In-Reply-To: <f87675ee0711261026k65d2d4e3pe74697abbc39930e@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Device tree and /proc/iomem question
Date: Wed, 28 Nov 2007 01:02:19 -0600
References: <f87675ee0711261026k65d2d4e3pe74697abbc39930e@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 26, 2007, at 12:26 PM, robert lazarski wrote:

> Hi all, I'm using a recent pull of the paulus tree 2.6.24RC2 on my
> custom 85xx board. I'm trying to test my PCI1, PCI2 and PCIe . My
> device tree for PCI is:
>
> 		pci@8000 {
> 			compatible = "fsl,mpc8540-pci";
> 			device_type = "pci";
> 			interrupt-map-mask = <f800 0 0 7>;
> 			interrupt-map = <
>
> 				/* IDSEL 0x11 J17 Slot 1 */
> 				8800 0 0 1 &mpic 2 1
> 				8800 0 0 2 &mpic 3 1
> 				8800 0 0 3 &mpic 4 1
> 				8800 0 0 4 &mpic 1 1
>
> 				/* IDSEL 0x12 J16 Slot 2 */
>
> 				9000 0 0 1 &mpic 3 1
> 				9000 0 0 2 &mpic 4 1
> 				9000 0 0 3 &mpic 2 1
> 				9000 0 0 4 &mpic 1 1>;
>
> 			interrupt-parent = <&mpic>;
> 			interrupts = <18 2>;
> 			bus-range = <0 ff>;
> 			ranges = <02000000 0 80000000 80000000 0 20000000
> 				  01000000 0 00000000 e2000000 0 00100000>;
> 			clock-frequency = <3f940aa>;
> 			#interrupt-cells = <1>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			reg = <8000 1000>;
> 		};
>
> 		pci@c000 {
> 			compatible = "fsl,mpc8540-pci";
> 			device_type = "pci";
> 			interrupt-map-mask = <f800 0 0 7>;
> 			interrupt-map = <
>
> 				/* IDSEL 0x11 J17 Slot 1 */
> 				8800 0 0 1 &mpic 2 1
> 				8800 0 0 2 &mpic 3 1
> 				8800 0 0 3 &mpic 4 1
> 				8800 0 0 4 &mpic 1 1
>
> 				/* IDSEL 0x12 J16 Slot 2 */
>
> 				9000 0 0 1 &mpic 3 1
> 				9000 0 0 2 &mpic 4 1
> 				9000 0 0 3 &mpic 2 1
> 				9000 0 0 4 &mpic 1 1>;
>
> 			interrupt-parent = <&mpic>;
> 			interrupts = <18 2>;
> 			bus-range = <0 ff>;
> 			ranges = <02000000 0 c0000000 c0000000 0 20000000
> 				  01000000 0 00000000 e2800000 0 00100000>;
> 			clock-frequency = <3f940aa>;
> 			#interrupt-cells = <1>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			reg = <c000 1000>;
> 		};
>
> 		pcie@a000 {
> 			compatible = "fsl,mpc8548-pcie";
> 			device_type = "pci";
> 			#interrupt-cells = <1>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			reg = <a000 1000>;
> 			bus-range = <0 ff>;
> 			ranges = <02000000 0 a0000000 a0000000 0 20000000
> 				  01000000 0 00000000 e3000000 0 00100000>;
> 			clock-frequency = <1fca055>;
> 			interrupt-parent = <&mpic>;
> 			interrupts = <19 2>;
> 			interrupt-map-mask = <f800 0 0 7>;
> 			interrupt-map = <
> 				/* IDSEL 0x0 */
> 				0000 0 0 1 &mpic 0 1
> 				0000 0 0 2 &mpic 1 1
> 				0000 0 0 3 &mpic 2 1
> 				0000 0 0 4 &mpic 3 1
> 				>;
> 		};

Take a look at the device trees in the kernel source.  You'll see we  
moved PCI around so its at the root level.  Not sure if that's your  
issue.

> I see all the above in /proc/device-tree/soc8548@e0000000 when booting
> the kernel. I double checked my memory mapping in u-boot and it
> appears to match my device tree. Yet I don't see any pci here:
>
> root:~> cat /proc/iomem
> e0004500-e0004507 : serial
> e0004600-e0004607 : serial
> e0024000-e0024fff : ethernet
>  e0024520-e002453f : mdio
> e0025000-e0025fff : ethernet
> e0026000-e0026fff : ethernet
> e0027000-e0027fff : ethernet
>
> cat /proc/bus/pci/devices shows nothing though I have a card in PCI1,
> and all I see from dmesg is "PCI: Probing PCI hardware" . Any ideas?

It seems like its not even really probing or finding the buses.

Can you post what your board/platform code looks like?

- k
