Return-Path: <nathan.french@onrampwireless.com>
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.55])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A17E2B6F34
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 02:14:11 +1000 (EST)
Subject: need help getting SPI controller working on 405EX
From: Nathan French <nathan.french@onrampwireless.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain
Date: Thu, 6 Aug 2009 09:08:06 -0700
Message-ID: <1249574886.3747.2650.camel@localhost.localdomain>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, I am trying to add support for the 405EX's SPI controller on a Kilauea board.  I've added the below to the device tree (under plb/opb/):

[nfrench@nfrench-laptop linux-2.6-denx]$ diff -C2 arch/powerpc/boot/dts/kilauea.dts spi.dts
*** arch/powerpc/boot/dts/kilauea.dts	2009-05-05 15:56:16.000000000 -0700
--- spi.dts	2009-08-06 08:42:19.000000000 -0700
***************
*** 207,210 ****
--- 207,221 ----
  				#size-cells = <0>;
  			};
+             
+             SPI0: spi@ef600600 {
+                 cell-index = <0>;
+                 compatible = "ibm,spi-405ex", "ibm,spi";
+                 reg = <ef600600 6>;
+                 interrupts = <8 4>;
+                 interrupt-parent = <&UIC0>;
+                 mode = "cpu";
+             };
  
  			RGMII0: emac-rgmii@ef600b00 {

I've also compiled my kernel with the following enabled:

        CONFIG_SPI=y
        CONFIG_SPI_MASTER=y
        CONFIG_SPI_SPIDEV=y

I see this make it into the device tree after boot:

        [root@10.2.3.28 /]$ find /proc/device-tree/ | grep spi
        /proc/device-tree/plb/opb/spi@ef600600
        /proc/device-tree/plb/opb/spi@ef600600/name
        /proc/device-tree/plb/opb/spi@ef600600/mode
        /proc/device-tree/plb/opb/spi@ef600600/interrupt-parent
        /proc/device-tree/plb/opb/spi@ef600600/interrupts
        /proc/device-tree/plb/opb/spi@ef600600/reg
        /proc/device-tree/plb/opb/spi@ef600600/compatible
        /proc/device-tree/plb/opb/spi@ef600600/cell-index

But I don't see any /dev/spidev* devices created or any mention of SPI
at boot time.  I'm starting to suspect that I don't have the kernel
configured right, otherwise I would see at least the SPI driver
complaining about something, right?

Thanks,

Nathan French
