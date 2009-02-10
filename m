Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 6C017DDDA2
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 09:26:05 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 10 Feb 2009 23:26:03 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090210222049.44270@gmx.net>
Message-ID: <20090210222603.117610@gmx.net>
MIME-Version: 1.0
References: <20090210222049.44270@gmx.net>
Subject: [PATCH v3 2/4] powerpc: Generic device tree for all AmigaOne boards
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This device tree does not provide the correct CPU name, as various CPU
models and revisions are used in AmigaOnes. Also the PCI root node does
not contain a interrupt mapping property, as all boards have different
interrupt routing. However the kernel can do a 1:1 mapping of all PCI
interrupts, as only i8259 legacy interrupts are used.

Signed-off-by: Gerhard Pircher <gerhard_pircher@gmx.net>
---
 arch/powerpc/boot/dts/amigaone.dts |  173 ++++++++++++++++++++++++++++++++++++
 1 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/amigaone.dts

diff --git a/arch/powerpc/boot/dts/amigaone.dts b/arch/powerpc/boot/dts/amigaone.dts
new file mode 100644
index 0000000..26549fc
--- /dev/null
+++ b/arch/powerpc/boot/dts/amigaone.dts
@@ -0,0 +1,173 @@
+/*
+ * AmigaOne Device Tree Source
+ *
+ * Copyright 2008 Gerhard Pircher (gerhard_pircher@gmx.net)
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "AmigaOne";
+	compatible = "eyetech,amigaone";
+	coherency-off;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <32>;	// 32 bytes
+			i-cache-line-size = <32>;	// 32 bytes
+			d-cache-size = <32768>;		// L1, 32K
+			i-cache-size = <32768>;		// L1, 32K
+			timebase-frequency = <0>;	// 33.3 MHz, from U-boot
+			clock-frequency = <0>;		// From U-boot
+			bus-frequency = <0>;		// From U-boot
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;				// From U-boot
+	};
+
+	pci@80000000 {
+		device_type = "pci";
+		compatible = "mai-logic,articia-s";
+		bus-frequency = <33333333>;
+		bus-range = <0 0xff>;
+		ranges = <0x01000000 0 0x00000000 0xfe000000 0 0x00c00000	// PCI I/O
+		          0x02000000 0 0x80000000 0x80000000 0 0x7d000000	// PCI memory
+		          0x02000000 0 0x00000000 0xfd000000 0 0x01000000>;	// PCI alias memory (ISA)
+		// Configuration address and data register.
+		reg = <0xfec00cf8 4
+		       0xfee00cfc 4>;
+		8259-interrupt-acknowledge = <0xfef00000>;
+		// Do not define a interrupt-parent here, if there is no
+		// interrupt-map property.
+		#address-cells = <3>;
+		#size-cells = <2>;
+
+		isa@7 {
+			device_type = "isa";
+			compatible = "pciclass,0601";
+			vendor-id = <0x00001106>;
+			device-id = <0x00000686>;
+			revision-id = <0x00000010>;
+			class-code = <0x00060100>;
+			subsystem-id = <0>;
+			subsystem-vendor-id = <0>;
+			devsel-speed = <0x00000001>;
+			min-grant = <0>;
+			max-latency = <0>;
+			/* First 64k for I/O at 0x0 on PCI mapped to 0x0 on ISA. */
+			ranges = <0x00000001 0 0x01000000 0 0x00000000 0x00010000>;
+			interrupt-parent = <&i8259>;
+			#interrupt-cells = <2>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+
+			dma-controller@0 {
+				compatible = "pnpPNP,200";
+				reg = <1 0x00000000 0x00000020
+				       1 0x00000080 0x00000010
+				       1 0x000000c0 0x00000020>;
+			};
+
+			i8259: interrupt-controller@20 {
+				device_type = "interrupt-controller";
+				compatible = "pnpPNP,000";
+				interrupt-controller;
+				reg = <1 0x00000020 0x00000002
+				       1 0x000000a0 0x00000002
+				       1 0x000004d0 0x00000002>;
+				reserved-interrupts = <2>;
+				#interrupt-cells = <2>;
+			};
+
+			timer@40 {
+				// Also adds pcspkr to platform devices.
+				compatible = "pnpPNP,100";
+				reg = <1 0x00000040 0x00000020>;
+			};
+
+			8042@60 {
+				device_type = "8042";
+				reg = <1 0x00000060 0x00000001
+				       1 0x00000064 0x00000001>;
+				interrupts = <1 3 12 3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				keyboard@0 {
+					compatible = "pnpPNP,303";
+					reg = <0>;
+				};
+
+				mouse@1 {
+					compatible = "pnpPNP,f03";
+					reg = <1>;
+				};
+			};
+
+			rtc@70 {
+				compatible = "pnpPNP,b00";
+				reg = <1 0x00000070 0x00000002>;
+				interrupts = <8 3>;
+			};
+
+			serial@3f8 {
+				device_type = "serial";
+				compatible = "pnpPNP,501","pnpPNP,500";
+				reg = <1 0x000003f8 0x00000008>;
+				interrupts = <4 3>;
+				clock-frequency = <1843200>;
+				current-speed = <115200>;
+			};
+
+			serial@2f8 {
+				device_type = "serial";
+				compatible = "pnpPNP,501","pnpPNP,500";
+				reg = <1 0x000002f8 0x00000008>;
+				interrupts = <3 3>;
+				clock-frequency = <1843200>;
+				current-speed = <115200>;
+			};
+
+			parallel@378 {
+				device_type = "parallel";
+				// No ECP support for now, otherwise add "pnpPNP,401".
+				compatible = "pnpPNP,400";
+				reg = <1 0x00000378 0x00000003
+				       1 0x00000778 0x00000003>;
+			};
+
+			fdc@3f0 {
+				device_type = "fdc";
+				compatible = "pnpPNP,700";
+				reg = <1 0x000003f0 0x00000008>;
+				interrupts = <6 3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				disk@0 {
+					reg = <0>;
+				};
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = "/pci@80000000/isa@7/serial@3f8";
+	};
+};
-- 
1.5.3.4


-- 
Jetzt 1 Monat kostenlos! GMX FreeDSL - Telefonanschluss + DSL 
für nur 17,95 Euro/mtl.!* http://dsl.gmx.de/?ac=OM.AD.PD003K11308T4569a
