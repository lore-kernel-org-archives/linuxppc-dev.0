Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 20C28B70A3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 20:08:31 +1100 (EST)
Message-ID: <4CAEDFFE.10404@windriver.com>
Date: Fri, 08 Oct 2010 17:10:22 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Fabian Bertholm <fabeisageek@googlemail.com>
Subject: Re: P1020RDB PCI-E Interrupt problem
References: <AANLkTikDsENpooCJZe68_WF4sb5qrQpjFN9ZqanUDMRx@mail.gmail.com>
In-Reply-To: <AANLkTikDsENpooCJZe68_WF4sb5qrQpjFN9ZqanUDMRx@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fabian Bertholm wrote:
> Hi,
> 
> I try to run ath9k on a P1020RDB Freescale board.
> I run into the problem similar to the Bug/Patch here:
> http://patchwork.ozlabs.org/patch/52137/
> 
> I get irq 16: nobody cared....

Firstly you should check if 'irq 16' is issue from your PCIe device.

> 
> I tried to fix the dts file in the same manner but this does not help.
> Currently I am using 2.6.33.7
> 
> Any hints? Anybody?
> 

Then if so I think it's unnecessary to add any #interrupt-map on dts since MSI
is used as interrupt mode on P1020RDB, not legacy interrupt. So please remove
all #interrupt-map on both pci nodes, then enable CONFIG_PCI_MSI to build/boot
again.

> The modified pci section from my dts:
> 
> 	pci0: pcie@ffe09000 {
> 		cell-index = <1>;
> 		compatible = "fsl,mpc8548-pcie";
> 		device_type = "pci";
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		reg = <0 0xffe09000 0 0x1000>;
> 		bus-range = <0 255>;
> 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
> 			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
> 		clock-frequency = <33333333>;
> 		interrupt-parent = <&mpic>;
> 		interrupts = <16 2>;
> 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> 		interrupt-map = <
> 			/* IDSEL 0x0 */
> 			0000 0x0 0x0 0x1 &mpic 0x4 0x2
> 			0000 0x0 0x0 0x2 &mpic 0x5 0x2
> 			0000 0x0 0x0 0x3 &mpic 0x6 0x2
> 			0000 0x0 0x0 0x4 &mpic 0x7 0x2

I don't know how you generate these interrupt-map. So even you really want to
use legacy interrupt you should make sure your PCIe bus number/device
number/function number, and actual interrupt number. Especially please check
interrupt trigger sense. Sometimes incorrect sense will issue your PCIe to
receive interrupt storm. As a result no interrupt handler deal with this
spurious interrupt like you saw 'irq 16: nobody cared'.

> 			>;
> 		pcie@0 {
> 			reg = <0x0 0x0 0x0 0x0 0x0>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			device_type = "pci";
> 			ranges = <0x2000000 0x0 0xa0000000
> 				  0x2000000 0x0 0xa0000000
> 				  0x0 0x20000000
> 
> 				  0x1000000 0x0 0x0
> 				  0x1000000 0x0 0x0
> 				  0x0 0x100000>;
> 		};
> 	};
> 
> 	pci1: pcie@ffe0a000 {
> 		cell-index = <2>;
> 		compatible = "fsl,mpc8548-pcie";
> 		device_type = "pci";
> 		#interrupt-cells = <1>;
> 		#size-cells = <2>;
> 		#address-cells = <3>;
> 		reg = <0 0xffe0a000 0 0x1000>;
> 		bus-range = <0 255>;
> 		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
> 			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
> 		clock-frequency = <33333333>;
> 		interrupt-parent = <&mpic>;
> 		interrupts = <16 2>;
> 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
> 		interrupt-map = <
> 			/* IDSEL 0x0 */
> 			0000 0x0 0x0 0x1 &mpic 0x0 0x1
> 			0000 0x0 0x0 0x2 &mpic 0x1 0x1
> 			0000 0x0 0x0 0x3 &mpic 0x2 0x1
> 			0000 0x0 0x0 0x4 &mpic 0x3 0x1
> 			>;
> 

There are two PCIe controller so you also have to make sure which controller
your device exist.

-Tiejun

> 		pcie@0 {
> 			reg = <0x0 0x0 0x0 0x0 0x0>;
> 			#size-cells = <2>;
> 			#address-cells = <3>;
> 			device_type = "pci";
> 			ranges = <0x2000000 0x0 0xc0000000
> 				  0x2000000 0x0 0xc0000000
> 				  0x0 0x20000000
> 
> 				  0x1000000 0x0 0x0
> 				  0x1000000 0x0 0x0
> 				  0x0 0x100000>;
> 		};
> 	};
> 
> 
> Best Regards,
> Fabian
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
