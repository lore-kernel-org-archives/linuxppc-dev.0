Return-Path: <fabeisageek@googlemail.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id 68A27B6F11
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Oct 2010 00:45:37 +1100 (EST)
Received: by bwz5 with SMTP id 5so725450bwz.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Oct 2010 06:45:34 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 7 Oct 2010 15:45:29 +0200
Message-ID: <AANLkTikDsENpooCJZe68_WF4sb5qrQpjFN9ZqanUDMRx@mail.gmail.com>
Subject: P1020RDB PCI-E Interrupt problem
From: Fabian Bertholm <fabeisageek@googlemail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I try to run ath9k on a P1020RDB Freescale board.
I run into the problem similar to the Bug/Patch here:
http://patchwork.ozlabs.org/patch/52137/

I get irq 16: nobody cared....

I tried to fix the dts file in the same manner but this does not help.
Currently I am using 2.6.33.7

Any hints? Anybody?

The modified pci section from my dts:

	pci0: pcie@ffe09000 {
		cell-index = <1>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0 0xffe09000 0 0x1000>;
		bus-range = <0 255>;
		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
		clock-frequency = <33333333>;
		interrupt-parent = <&mpic>;
		interrupts = <16 2>;
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		interrupt-map = <
			/* IDSEL 0x0 */
			0000 0x0 0x0 0x1 &mpic 0x4 0x2
			0000 0x0 0x0 0x2 &mpic 0x5 0x2
			0000 0x0 0x0 0x3 &mpic 0x6 0x2
			0000 0x0 0x0 0x4 &mpic 0x7 0x2
			>;
		pcie@0 {
			reg = <0x0 0x0 0x0 0x0 0x0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <0x2000000 0x0 0xa0000000
				  0x2000000 0x0 0xa0000000
				  0x0 0x20000000

				  0x1000000 0x0 0x0
				  0x1000000 0x0 0x0
				  0x0 0x100000>;
		};
	};

	pci1: pcie@ffe0a000 {
		cell-index = <2>;
		compatible = "fsl,mpc8548-pcie";
		device_type = "pci";
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		reg = <0 0xffe0a000 0 0x1000>;
		bus-range = <0 255>;
		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
		clock-frequency = <33333333>;
		interrupt-parent = <&mpic>;
		interrupts = <16 2>;
		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
		interrupt-map = <
			/* IDSEL 0x0 */
			0000 0x0 0x0 0x1 &mpic 0x0 0x1
			0000 0x0 0x0 0x2 &mpic 0x1 0x1
			0000 0x0 0x0 0x3 &mpic 0x2 0x1
			0000 0x0 0x0 0x4 &mpic 0x3 0x1
			>;

		pcie@0 {
			reg = <0x0 0x0 0x0 0x0 0x0>;
			#size-cells = <2>;
			#address-cells = <3>;
			device_type = "pci";
			ranges = <0x2000000 0x0 0xc0000000
				  0x2000000 0x0 0xc0000000
				  0x0 0x20000000

				  0x1000000 0x0 0x0
				  0x1000000 0x0 0x0
				  0x0 0x100000>;
		};
	};


Best Regards,
Fabian
