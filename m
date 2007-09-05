Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B80C0DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:15:36 +1000 (EST)
Date: Wed, 5 Sep 2007 14:15:27 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 2/3] CPM: Introduce new device tree bindings.
Message-ID: <20070905191527.GA31985@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905191313.GA31927@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This introduces a new device binding for the CPM and other devices on
these boards.  Some of the changes include:

1. Proper namespace scoping for Freescale compatibles and properties.

2. Use compatible rather than things like device_type and model
to determine which particular variant of a device is present.

3. Give the drivers the relevant CPM command word directly, rather than
requiring it to have a lookup table based on device-id, SCC v. SMC, and
CPM version.

4. Specify the CPCR and the usable DPRAM region in the CPM's reg property.

Boards that do not require the legacy bindings should select
CONFIG_PPC_CPM_NEW_BINDING to enable the of_platform CPM devices. Once
all existing boards are converted and tested, the config option can
become default y to prevent new boards from using the old model.  Once
arch/ppc is gone, the config option can be removed altogether.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |  170 +++++++++++++++++++++++++-
 arch/powerpc/platforms/Kconfig               |   11 ++
 arch/powerpc/sysdev/fsl_soc.c                |    2 +
 3 files changed, 182 insertions(+), 1 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 76733a3..4332c2d 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1510,7 +1510,10 @@ platforms are moved over to use the flattened-device-tree model.
 
    i) Freescale QUICC Engine module (QE)
    This represents qe module that is installed on PowerQUICC II Pro.
-   Hopefully it will merge backward compatibility with CPM/CPM2.
+
+   NOTE:  This is an interim binding; it should be updated to fit
+   in with the CPM binding later in this document.
+
    Basically, it is a bus of devices, that could act more or less
    as a complete entity (UCC, USB etc ). All of them should be siblings on
    the "root" qe node, using the common properties from there.
@@ -1824,6 +1827,171 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,has-rstcr;
 	};
 
+   l) Freescale Communications Processor Module
+
+   NOTE: This is an interim binding, and will likely change slightly,
+   as more devices are supported.  The QE bindings especially are
+   incomplete.
+
+   i) Root CPM node
+
+   Properties:
+   - compatible : "fsl,cpm1", "fsl,cpm2", or "fsl,qe".
+   - reg : The first resource is a 48-byte region beginning with
+           CPCR.  The second is the available general-purpose
+           DPRAM.
+
+   Example:
+	cpm@119c0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
+		reg = <119c0 30 0 2000>;
+	}
+
+   ii) Properties common to mulitple CPM/QE devices
+
+   - fsl,cpm-command : This value is ORed with the opcode and command flag
+                       to specify the device on which a CPM command operates.
+
+   - fsl,cpm-brg : Indicates which baud rate generator the device
+                   is associated with.  If absent, an unused BRG
+                   should be dynamically allocated.
+
+   - reg : Unless otherwise specified, the first resource represents the
+           scc/fcc/ucc registers, and the second represents the device's
+           parameter RAM region (if it has one).
+
+   iii) Serial
+
+   Currently defined compatibles:
+   - fsl,cpm1-smc-uart
+   - fsl,cpm2-smc-uart
+   - fsl,cpm1-scc-uart
+   - fsl,cpm2-scc-uart
+   - fsl,qe-uart
+
+   Example:
+
+	serial@11a00 {
+		device_type = "serial";
+		compatible = "fsl,mpc8272-scc-uart",
+		             "fsl,cpm2-scc-uart";
+		reg = <11a00 20 8000 100>;
+		interrupts = <28 8>;
+		interrupt-parent = <&PIC>;
+		fsl,cpm-brg = <1>;
+		fsl,cpm-command = <00800000>;
+	};
+
+   iii) Network
+
+   Currently defined compatibles:
+   - fsl,cpm1-scc-enet
+   - fsl,cpm2-scc-enet
+   - fsl,cpm1-fec-enet
+   - fsl,cpm2-fcc-enet (third resource is GFEMR)
+   - fsl,qe-enet
+
+   Example:
+
+	ethernet@11300 {
+		device_type = "network";
+		compatible = "fsl,mpc8272-fcc-enet",
+		             "fsl,cpm2-fcc-enet";
+		reg = <11300 20 8400 100 11390 1>;
+		local-mac-address = [ 00 00 00 00 00 00 ];
+		interrupts = <20 8>;
+		interrupt-parent = <&PIC>;
+		phy-handle = <&PHY0>;
+		linux,network-index = <0>;
+		fsl,cpm-command = <12000300>;
+	};
+
+   iv) MDIO
+
+   Currently defined compatibles:
+   fsl,pq1-fec-mdio (reg is same as first resource of FEC device)
+   fsl,cpm2-mdio-bitbang (reg is port C registers)
+
+   Properties for fsl,cpm2-mdio-bitbang:
+   fsl,mdio-pin : pin of port C controlling mdio data
+   fsl,mdc-pin : pin of port C controlling mdio clock
+
+   Example:
+
+	mdio@10d40 {
+		device_type = "mdio";
+		compatible = "fsl,mpc8272ads-mdio-bitbang",
+		             "fsl,mpc8272-mdio-bitbang",
+		             "fsl,cpm2-mdio-bitbang";
+		reg = <10d40 14>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		fsl,mdio-pin = <12>;
+		fsl,mdc-pin = <13>;
+	};
+
+   v) Baud Rate Generators
+
+   Currently defined compatibles:
+   fsl,cpm-brg
+   fsl,cpm1-brg
+   fsl,cpm2-brg
+
+   Properties:
+   - reg : There may be an arbitrary number of reg resources; BRG
+     numbers are assigned to these in order.
+   - clock-frequency : Specifies the base frequency driving
+     the BRG.
+
+   Example:
+
+	brg@119f0 {
+		compatible = "fsl,mpc8272-brg",
+		             "fsl,cpm2-brg",
+		             "fsl,cpm-brg";
+		reg = <119f0 10 115f0 10>;
+		clock-frequency = <d#25000000>;
+	};
+
+   vi) Interrupt Controllers
+
+   Currently defined compatibles:
+   - fsl,cpm1-pic
+     - only one interrupt cell
+   - fsl,pq1-pic
+   - fsl,pq2-pic
+     - second interrupt cell is level/sense:
+       - 2 is falling edge
+       - 8 is active low
+
+   Example:
+
+	interrupt-controller@10c00 {
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <10c00 80>;
+		compatible = "mpc8272-pic", "fsl,pq2-pic";
+	};
+
+   vii) USB (Universal Serial Bus Controller)
+
+   Properties:
+   - compatible : "fsl,cpm1-usb", "fsl,cpm2-usb", "fsl,qe-usb"
+
+   Example:
+	usb@11bc0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,cpm2-usb";
+		reg = <11b60 18 8b00 100>;
+		interrupts = <b 8>;
+		interrupt-parent = <&PIC>;
+		fsl,cpm-command = <2e600000>;
+	};
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 041df77..8ddbd84 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -273,6 +273,17 @@ config CPM2
 	  you wish to build a kernel for a machine with a CPM2 coprocessor
 	  on it (826x, 827x, 8560).
 
+config PPC_CPM_NEW_BINDING
+	bool
+	depends on CPM1 || CPM2
+	help
+	  Select this if your board has been converted to use the new
+	  device tree bindings for CPM, and no longer needs the
+	  ioport callbacks or the platform device glue code.
+
+	  The fs_enet and cpm_uart drivers will be built as
+	  of_platform devices.
+
 config AXON_RAM
 	tristate "Axon DDR2 memory device driver"
 	depends on PPC_IBM_CELL_BLADE
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3ea35fe..0db5daf 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -673,6 +673,7 @@ err:
 
 arch_initcall(fsl_usb_of_init);
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 #ifdef CONFIG_CPM2
 
 extern void init_scc_ioports(struct fs_uart_platform_info*);
@@ -1212,3 +1213,4 @@ err:
 arch_initcall(cpm_smc_uart_of_init);
 
 #endif /* CONFIG_8xx */
+#endif /* CONFIG_PPC_CPM_NEW_BINDING */
-- 
1.5.3
