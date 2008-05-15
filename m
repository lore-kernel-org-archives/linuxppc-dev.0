Return-Path: <dgibson@ozlabs.org>
Date: Thu, 15 May 2008 16:46:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Convert remaining dts-v0 files to v1
Message-ID: <20080515064639.GB30996@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At the moment we have a mixture of left-over version 0 and new-format
version 1 files in arch/powerpc/boot/dts.  This is potentially
confusing to people new to the dts format attempting to figure it out.

So, this patch converts all the as-yet unconverted dts v0 files and
converts them to v1.  They're mechanically-converted, and not hand
tweaked so in some cases they're not 100% in keeping with usual v1
style, but the convertor program does have some heuristics so the
discrepancies aren't too bad.

I have checked that this patch produces no changes to the resulting
dtb binaries.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/dts/bamboo.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/bamboo.dts	2008-05-15 16:32:07.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/bamboo.dts	2008-05-15 16:32:07.000000000 +1000
@@ -11,12 +11,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,bamboo";
 	compatible = "amcc,bamboo";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -34,13 +36,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440EP";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -48,14 +50,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -65,22 +67,22 @@
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -92,29 +94,29 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		DMA0: dma {
 			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
 		};
 
 		POB0: opb {
@@ -124,101 +126,101 @@
 			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
 			 * bits.
 			 */
-		  	ranges = <00000000 0 00000000 80000000
-			          80000000 0 80000000 80000000>;
+		  	ranges = <0x00000000 0x00000000 0x00000000 0x80000000
+			          0x80000000 0x00000000 0x80000000 0x80000000>;
 		  	interrupt-parent = <&UIC1>;
-		  	interrupts = <7 4>;
+		  	interrupts = <0x7 0x4>;
 		  	clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 			};
 
 			UART0: serial@ef600300 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600300 8>;
-		   		virtual-reg = <ef600300>;
+		   		reg = <0xef600300 0x00000008>;
+		   		virtual-reg = <0xef600300>;
 		   		clock-frequency = <0>; /* Filled in by zImage */
-		   		current-speed = <1c200>;
+		   		current-speed = <115200>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <0 4>;
+		   		interrupts = <0x0 0x4>;
 	   		};
 
 			UART1: serial@ef600400 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600400 8>;
-		   		virtual-reg = <ef600400>;
+		   		reg = <0xef600400 0x00000008>;
+		   		virtual-reg = <0xef600400>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <1 4>;
+		   		interrupts = <0x1 0x4>;
 	   		};
 
 			UART2: serial@ef600500 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600500 8>;
-		   		virtual-reg = <ef600500>;
+		   		reg = <0xef600500 0x00000008>;
+		   		virtual-reg = <0xef600500>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <3 4>;
+		   		interrupts = <0x3 0x4>;
 	   		};
 
 			UART3: serial@ef600600 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600600 8>;
-		   		virtual-reg = <ef600600>;
+		   		reg = <0xef600600 0x00000008>;
+		   		virtual-reg = <0xef600600>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <4 4>;
+		   		interrupts = <0x4 0x4>;
 	   		};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <ef600e00 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0 1>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
@@ -227,26 +229,26 @@
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4 1f 4>;
-				reg = <ef600f00 70>;
+				interrupts = <0x1e 0x4 0x1f 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2 3>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
 
 			usb@ef601000 {
 				compatible = "ohci-be";
-				reg = <ef601000 80>;
-				interrupts = <8 1 9 1>;
+				reg = <0xef601000 0x00000080>;
+				interrupts = <0x8 0x1 0x9 0x1>;
 				interrupt-parent = < &UIC1 >;
 			};
 		};
@@ -258,35 +260,35 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
 			primary;
-			reg = <0 eec00000 8	/* Config space access */
-			       0 eed00000 4	/* IACK */
-			       0 eed00000 4	/* Special cycle */
-			       0 ef400000 40>;	/* Internal registers */
+			reg = <0x00000000 0xeec00000 0x00000008	/* Config space access */
+			       0x00000000 0xeed00000 0x00000004	/* IACK */
+			       0x00000000 0xeed00000 0x00000004	/* Special cycle */
+			       0x00000000 0xef400000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
-				  01000000 0 00000000 0 e8000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0xa0000000 0x00000000 0xa0000000 0x00000000 0x20000000
+				  0x01000000 0x00000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* Bamboo has all 4 IRQ pins tied together per slot */
-			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 0 &UIC0 1c 8
+				0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
 
 				/* IDSEL 2 */
-				1000 0 0 0 &UIC0 1b 8
+				0x1000 0x0 0x0 0x0 &UIC0 0x1b 0x8
 
 				/* IDSEL 3 */
-				1800 0 0 0 &UIC0 1a 8
+				0x1800 0x0 0x0 0x0 &UIC0 0x1a 0x8
 
 				/* IDSEL 4 */
-				2000 0 0 0 &UIC0 19 8
+				0x2000 0x0 0x0 0x0 &UIC0 0x19 0x8
 			>;
 		};
 	};
Index: working-2.6/arch/powerpc/boot/dts/canyonlands.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/canyonlands.dts	2008-05-15 16:32:07.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/canyonlands.dts	2008-05-15 16:32:07.000000000 +1000
@@ -8,12 +8,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,canyonlands";
 	compatible = "amcc,canyonlands";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -29,13 +31,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,460EX";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 			timebase-frequency = <0>; /* Filled in by U-Boot */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -43,14 +45,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-460ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -60,11 +62,11 @@
 		compatible = "ibm,uic-460ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -72,11 +74,11 @@
 		compatible = "ibm,uic-460ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <a 4 b 4>; /* cascade */
+		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -84,22 +86,22 @@
 		compatible = "ibm,uic-460ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <3>;
-		dcr-reg = <0f0 009>;
+		dcr-reg = <0x0f0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <10 4 11 4>; /* cascade */
+		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-460ex";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-460ex";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -111,74 +113,74 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-460ex", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460ex", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
-			num-rx-chans = <10>;
+			num-rx-chans = <16>;
 			#address-cells = <0>;
 			#size-cells = <0>;
 			interrupt-parent = <&UIC2>;
-			interrupts = <	/*TXEOB*/ 6 4
-					/*RXEOB*/ 7 4
-					/*SERR*/  3 4
-					/*TXDE*/  4 4
-					/*RXDE*/  5 4>;
+			interrupts = <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x3 0x4
+					/*TXDE*/  0x4 0x4
+					/*RXDE*/  0x5 0x4>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-460ex", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <b0000000 4 b0000000 50000000>;
+			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-460ex", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				/* ranges property is supplied by U-Boot */
-				interrupts = <6 4>;
+				interrupts = <0x6 0x4>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 1e0000>;
+						reg = <0x00000000 0x001e0000>;
 					};
 					partition@1e0000 {
 						label = "dtb";
-						reg = <1e0000 20000>;
+						reg = <0x001e0000 0x00020000>;
 					};
 					partition@200000 {
 						label = "ramdisk";
-						reg = <200000 1400000>;
+						reg = <0x00200000 0x01400000>;
 					};
 					partition@1600000 {
 						label = "jffs2";
-						reg = <1600000 400000>;
+						reg = <0x01600000 0x00400000>;
 					};
 					partition@1a00000 {
 						label = "user";
-						reg = <1a00000 2560000>;
+						reg = <0x01a00000 0x02560000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 			};
@@ -186,103 +188,103 @@
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			UART1: serial@ef600400 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600400 8>;
-				virtual-reg = <ef600400>;
+				reg = <0xef600400 0x00000008>;
+				virtual-reg = <0xef600400>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			UART2: serial@ef600500 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600500 8>;
-				virtual-reg = <ef600500>;
+				reg = <0xef600500 0x00000008>;
+				virtual-reg = <0xef600500>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1d 4>;
+				interrupts = <0x1d 0x4>;
 			};
 
 			UART3: serial@ef600600 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600600 8>;
-				virtual-reg = <ef600600>;
+				reg = <0xef600600 0x00000008>;
+				virtual-reg = <0xef600600>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4>;
+				interrupts = <0x1e 0x4>;
 			};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-460ex", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-460ex", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-460ex", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			RGMII0: emac-rgmii@ef601500 {
 				compatible = "ibm,rgmii-460ex", "ibm,rgmii";
-				reg = <ef601500 8>;
+				reg = <0xef601500 0x00000008>;
 				has-mdio;
 			};
 
 			TAH0: emac-tah@ef601350 {
 				compatible = "ibm,tah-460ex", "ibm,tah";
-				reg = <ef601350 30>;
+				reg = <0xef601350 0x00000030>;
 			};
 
 			TAH1: emac-tah@ef601450 {
 				compatible = "ibm,tah-460ex", "ibm,tah";
-				reg = <ef601450 30>;
+				reg = <0xef601450 0x00000030>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-460ex", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 10 4
-						 /*Wake*/   1 &UIC2 14 4>;
-				reg = <ef600e00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
+						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
 				tah-device = <&TAH0>;
@@ -295,23 +297,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-460ex", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 11 4
-						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
+						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <8>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
 				tah-device = <&TAH1>;
@@ -331,27 +333,27 @@
 			primary;
 			large-inbound-windows;
 			enable-msi-hole;
-			reg = <c 0ec00000   8	/* Config space access */
-			       0 0 0		/* no IACK cycles */
-			       c 0ed00000   4   /* Special cycles */
-			       c 0ec80000 100	/* Internal registers */
-			       c 0ec80100  fc>;	/* Internal messaging registers */
+			reg = <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
+			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
+			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000d 80000000 0 80000000
-				  01000000 0 00000000 0000000c 08000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0 to 0x3f */
-			bus-range = <0 3f>;
+			bus-range = <0x0 0x3f>;
 
 			/* All PCI interrupts are routed to ext IRQ 2 -> UIC1-0 */
-			interrupt-map-mask = <0000 0 0 0>;
-			interrupt-map = < 0000 0 0 0 &UIC1 0 8 >;
+			interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC1 0x0 0x8 >;
 		};
 
 		PCIE0: pciex@d00000000 {
@@ -361,23 +363,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <d 00000000 20000000	/* Config space access */
-			       c 08010000 00001000>;	/* Registers */
-			dcr-reg = <100 020>;
-			sdr-base = <300>;
+			port = <0x0>; /* port number */
+			reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08010000 0x00001000>;	/* Registers */
+			dcr-reg = <0x100 0x020>;
+			sdr-base = <0x300>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 00000000 0 80000000
-				  01000000 0 00000000 0000000f 80000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 40 to 0x7f */
-			bus-range = <40 7f>;
+			bus-range = <0x40 0x7f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -387,12 +389,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 c 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 d 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 e 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 f 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0xc 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0xd 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
 		};
 
 		PCIE1: pciex@d20000000 {
@@ -402,23 +404,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
 			primary;
-			port = <1>; /* port number */
-			reg = <d 20000000 20000000	/* Config space access */
-			       c 08011000 00001000>;	/* Registers */
-			dcr-reg = <120 020>;
-			sdr-base = <340>;
+			port = <0x1>; /* port number */
+			reg = <0x0000000d 0x20000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08011000 0x00001000>;	/* Registers */
+			dcr-reg = <0x120 0x020>;
+			sdr-base = <0x340>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 80000000 0 80000000
-				  01000000 0 00000000 0000000f 80010000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 80 to 0xbf */
-			bus-range = <80 bf>;
+			bus-range = <0x80 0xbf>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -428,12 +430,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 10 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 11 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 12 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 13 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0x10 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x11 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2008-05-15 16:32:08.000000000 +1000
@@ -11,12 +11,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "ibm,ebony";
 	compatible = "ibm,ebony";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -32,13 +34,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440GP";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; // Filled in by zImage
 			timebase-frequency = <0>; // Filled in by zImage
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>; /* 32 kB */
-			d-cache-size = <8000>; /* 32 kB */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>; /* 32 kB */
+			d-cache-size = <32768>; /* 32 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -46,14 +48,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; // Filled in by zImage
+		reg = <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440gp", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -64,17 +66,17 @@
 		compatible = "ibm,uic-440gp", "ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	CPC0: cpc {
 		compatible = "ibm,cpc-440gp";
-		dcr-reg = <0b0 003 0e0 010>;
+		dcr-reg = <0x0b0 0x003 0x0e0 0x010>;
 		// FIXME: anything else?
 	};
 
@@ -87,37 +89,37 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-440gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 			// FIXME: anything else?
 		};
 
 		SRAM0: sram {
 			compatible = "ibm,sram-440gp";
-			dcr-reg = <020 8 00a 1>;
+			dcr-reg = <0x020 0x008 0x00a 0x001>;
 		};
 
 		DMA0: dma {
 			// FIXME: ???
 			compatible = "ibm,dma-440gp";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
 			num-rx-chans = <4>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					 /*RXEOB*/ 1 &UIC0 b 4
-					 /*SERR*/  2 &UIC1 0 4
-					 /*TXDE*/  3 &UIC1 1 4
-					 /*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					 /*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					 /*SERR*/  0x2 &UIC1 0x0 0x4
+					 /*TXDE*/  0x3 &UIC1 0x1 0x4
+					 /*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
@@ -126,34 +128,34 @@
 			#size-cells = <1>;
 			/* Wish there was a nicer way of specifying a full 32-bit
 			   range */
-			ranges = <00000000 1 00000000 80000000
-				  80000000 1 80000000 80000000>;
-			dcr-reg = <090 00b>;
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			dcr-reg = <0x090 0x00b>;
 			interrupt-parent = <&UIC1>;
-			interrupts = <7 4>;
+			interrupts = <0x7 0x4>;
 			clock-frequency = <0>; // Filled in by zImage
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; // Filled in by zImage
 				// ranges property is supplied by zImage
 				// based on firmware's configuration of the
 				// EBC bridge
-				interrupts = <5 4>;
+				interrupts = <0x5 0x4>;
 				interrupt-parent = <&UIC1>;
 
 				small-flash@0,80000 {
 					compatible = "jedec-flash";
 					bank-width = <1>;
-					reg = <0 80000 80000>;
+					reg = <0x00000000 0x00080000 0x00080000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "OpenBIOS";
-						reg = <0 80000>;
+						reg = <0x00000000 0x00080000>;
 						read-only;
 					};
 				};
@@ -161,101 +163,101 @@
 				nvram@1,0 {
 					/* NVRAM & RTC */
 					compatible = "ds1743-nvram";
-					#bytes = <2000>;
-					reg = <1 0 2000>;
+					#bytes = <0x2000>;
+					reg = <0x00000001 0x00000000 0x00002000>;
 				};
 
 				large-flash@2,0 {
 					compatible = "jedec-flash";
 					bank-width = <1>;
-					reg = <2 0 400000>;
+					reg = <0x00000002 0x00000000 0x00400000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "fs";
-						reg = <0 380000>;
+						reg = <0x00000000 0x00380000>;
 					};
 					partition@380000 {
 						label = "firmware";
-						reg = <380000 80000>;
+						reg = <0x00380000 0x00080000>;
 					};
 				};
 
 				ir@3,0 {
-					reg = <3 0 10>;
+					reg = <0x00000003 0x00000000 0x00000010>;
 				};
 
 				fpga@7,0 {
 					compatible = "Ebony-FPGA";
-					reg = <7 0 10>;
-					virtual-reg = <e8300000>;
+					reg = <0x00000007 0x00000000 0x00000010>;
+					virtual-reg = <0xe8300000>;
 				};
 			};
 
 			UART0: serial@40000200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <40000200 8>;
-				virtual-reg = <e0000200>;
-				clock-frequency = <A8C000>;
-				current-speed = <2580>;
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+				clock-frequency = <11059200>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@40000300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <40000300 8>;
-				virtual-reg = <e0000300>;
-				clock-frequency = <A8C000>;
-				current-speed = <2580>;
+				reg = <0x40000300 0x00000008>;
+				virtual-reg = <0xe0000300>;
+				clock-frequency = <11059200>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC0: i2c@40000400 {
 				/* FIXME */
 				compatible = "ibm,iic-440gp", "ibm,iic";
-				reg = <40000400 14>;
+				reg = <0x40000400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 			IIC1: i2c@40000500 {
 				/* FIXME */
 				compatible = "ibm,iic-440gp", "ibm,iic";
-				reg = <40000500 14>;
+				reg = <0x40000500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 			};
 
 			GPIO0: gpio@40000700 {
 				/* FIXME */
 				compatible = "ibm,gpio-440gp";
-				reg = <40000700 20>;
+				reg = <0x40000700 0x00000020>;
 			};
 
 			ZMII0: emac-zmii@40000780 {
 				compatible = "ibm,zmii-440gp", "ibm,zmii";
-				reg = <40000780 c>;
+				reg = <0x40000780 0x0000000c>;
 			};
 
 			EMAC0: ethernet@40000800 {
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <40000800 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0x40000800 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0 1>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
@@ -263,18 +265,18 @@
 				device_type = "network";
 				compatible = "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4 1f 4>;
-				reg = <40000900 70>;
+				interrupts = <0x1e 0x4 0x1f 0x4>;
+				reg = <0x40000900 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2 3>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
@@ -282,9 +284,9 @@
 
 			GPT0: gpt@40000a00 {
 				/* FIXME */
-				reg = <40000a00 d4>;
+				reg = <0x40000a00 0x000000d4>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <12 4 13 4 14 4 15 4 16 4>;
+				interrupts = <0x12 0x4 0x13 0x4 0x14 0x4 0x15 0x4 0x16 0x4>;
 			};
 
 		};
@@ -296,35 +298,35 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440gp-pcix", "ibm,plb-pcix";
 			primary;
-			reg = <2 0ec00000 8	/* Config space access */
-			       0 0 0		/* no IACK cycles */
-			       2 0ed00000 4     /* Special cycles */
-			       2 0ec80000 f0	/* Internal registers */
-			       2 0ec80100 fc>;	/* Internal messaging registers */
+			reg = <0x00000002 0x0ec00000 0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x00000002 0x0ed00000 0x00000004     /* Special cycles */
+			       0x00000002 0x0ec80000 0x000000f0	/* Internal registers */
+			       0x00000002 0x0ec80100 0x000000fc>;	/* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 00000003 80000000 0 80000000
-				  01000000 0 00000000 00000002 08000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000003 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x00000002 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* Ebony has all 4 IRQ pins tied together per slot */
-			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 0 &UIC0 17 8
+				0x800 0x0 0x0 0x0 &UIC0 0x17 0x8
 
 				/* IDSEL 2 */
-				1000 0 0 0 &UIC0 18 8
+				0x1000 0x0 0x0 0x0 &UIC0 0x18 0x8
 
 				/* IDSEL 3 */
-				1800 0 0 0 &UIC0 19 8
+				0x1800 0x0 0x0 0x0 &UIC0 0x19 0x8
 
 				/* IDSEL 4 */
-				2000 0 0 0 &UIC0 1a 8
+				0x2000 0x0 0x0 0x0 &UIC0 0x1a 0x8
 			>;
 		};
 	};
Index: working-2.6/arch/powerpc/boot/dts/ep405.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ep405.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ep405.dts	2008-05-15 16:32:08.000000000 +1000
@@ -9,12 +9,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "ep405";
 	compatible = "ep405";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC;
@@ -29,13 +31,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405GP";
-			reg = <0>;
-			clock-frequency = <bebc200>; /* Filled in by zImage */
+			reg = <0x00000000>;
+			clock-frequency = <200000000>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <4000>;
-			d-cache-size = <4000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>;
+			d-cache-size = <16384>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -43,14 +45,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 9>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -65,91 +67,91 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL: mcmal {
 			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <1>;
 			num-rx-chans = <1>;
 			interrupt-parent = <&UIC0>;
 			interrupts = <
-				b 4 /* TXEOB */
-				c 4 /* RXEOB */
-				a 4 /* SERR */
-				d 4 /* TXDE */
-				e 4 /* RXDE */>;
+				0xb 0x4 /* TXEOB */
+				0xc 0x4 /* RXEOB */
+				0xa 0x4 /* SERR */
+				0xd 0x4 /* TXDE */
+				0xe 0x4 /* RXDE */>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <ef600000 ef600000 a00000>;
-			dcr-reg = <0a0 5>;
+			ranges = <0xef600000 0xef600000 0x00a00000>;
+			dcr-reg = <0x0a0 0x005>;
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <2580>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@ef600400 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600400 8>;
-				virtual-reg = <ef600400>;
+				reg = <0xef600400 0x00000008>;
+				virtual-reg = <0xef600400>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <2580>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC: i2c@ef600500 {
 				compatible = "ibm,iic-405gp", "ibm,iic";
-				reg = <ef600500 11>;
+				reg = <0xef600500 0x00000011>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			GPIO: gpio@ef600700 {
 				compatible = "ibm,gpio-405gp";
-				reg = <ef600700 20>;
+				reg = <0xef600700 0x00000020>;
 			};
 
 			EMAC: ethernet@ef600800 {
-				linux,network-index = <0>;
+				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
 				interrupts = <
-					f 4 /* Ethernet */
-					9 4 /* Ethernet Wake Up */>;
+					0xf 0x4 /* Ethernet */
+					0x9 0x4 /* Ethernet Wake Up */>;
 				local-mac-address = [000000000000]; /* Filled in by zImage */
-				reg = <ef600800 70>;
+				reg = <0xef600800 0x00000070>;
 				mal-device = <&MAL>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 			};
 
 		};
 
 		EBC0: ebc {
 			compatible = "ibm,ebc-405gp", "ibm,ebc";
-			dcr-reg = <012 2>;
+			dcr-reg = <0x012 0x002>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 
@@ -163,13 +165,13 @@
 			/* NVRAM and RTC */
 			nvrtc@4,200000 {
 				compatible = "ds1742";
-				reg = <4 200000 0>; /* size fixed up by zImage */
+				reg = <0x00000004 0x00200000 0x00000000>; /* size fixed up by zImage */
 			};
 
 			/* "BCSR" CPLD contains a PCI irq controller */
 			bcsr@4,0 {
 				compatible = "ep405-bcsr";
-				reg = <4 0 10>;
+				reg = <0x00000004 0x00000000 0x00000010>;
 				interrupt-controller;
 				/* Routing table */
 				irq-routing = [	00	/* SYSERR */
@@ -198,26 +200,26 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb405gp-pci", "ibm,plb-pci";
 			primary;
-			reg = <eec00000 8	/* Config space access */
-			       eed80000 4	/* IACK */
-			       eed80000 4	/* Special cycle */
-			       ef480000 40>;	/* Internal registers */
+			reg = <0xeec00000 0x00000008	/* Config space access */
+			       0xeed80000 0x00000004	/* IACK */
+			       0xeed80000 0x00000004	/* Special cycle */
+			       0xef480000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e8000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x20000000
+				  0x01000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* That's all I know about IRQs on that thing ... */
-			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
 				/* USB */
-				7000 0 0 0 &UIC0 1e 8 /* IRQ5 */
+				0x7000 0x0 0x0 0x0 &UIC0 0x1e 0x8 /* IRQ5 */
 			>;
 		};
 	};
Index: working-2.6/arch/powerpc/boot/dts/glacier.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/glacier.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/glacier.dts	2008-05-15 16:32:08.000000000 +1000
@@ -8,12 +8,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,glacier";
 	compatible = "amcc,glacier", "amcc,canyonlands";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -31,13 +33,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,460GT";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 			timebase-frequency = <0>; /* Filled in by U-Boot */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -45,14 +47,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-460gt","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -62,11 +64,11 @@
 		compatible = "ibm,uic-460gt","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -74,11 +76,11 @@
 		compatible = "ibm,uic-460gt","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <a 4 b 4>; /* cascade */
+		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -86,22 +88,22 @@
 		compatible = "ibm,uic-460gt","ibm,uic";
 		interrupt-controller;
 		cell-index = <3>;
-		dcr-reg = <0f0 009>;
+		dcr-reg = <0x0f0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <10 4 11 4>; /* cascade */
+		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-460gt";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-460gt";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -113,75 +115,75 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-460gt", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-460gt", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
-			num-rx-chans = <20>;
+			num-rx-chans = <32>;
 			#address-cells = <0>;
 			#size-cells = <0>;
 			interrupt-parent = <&UIC2>;
-			interrupts = <	/*TXEOB*/ 6 4
-					/*RXEOB*/ 7 4
-					/*SERR*/  3 4
-					/*TXDE*/  4 4
-					/*RXDE*/  5 4>;
-			desc-base-addr-high = <8>;
+			interrupts = <	/*TXEOB*/ 0x6 0x4
+					/*RXEOB*/ 0x7 0x4
+					/*SERR*/  0x3 0x4
+					/*TXDE*/  0x4 0x4
+					/*RXDE*/  0x5 0x4>;
+			desc-base-addr-high = <0x8>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-460gt", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <b0000000 4 b0000000 50000000>;
+			ranges = <0xb0000000 0x00000004 0xb0000000 0x50000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-460gt", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				/* ranges property is supplied by U-Boot */
-				interrupts = <6 4>;
+				interrupts = <0x6 0x4>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 1e0000>;
+						reg = <0x00000000 0x001e0000>;
 					};
 					partition@1e0000 {
 						label = "dtb";
-						reg = <1e0000 20000>;
+						reg = <0x001e0000 0x00020000>;
 					};
 					partition@200000 {
 						label = "ramdisk";
-						reg = <200000 1400000>;
+						reg = <0x00200000 0x01400000>;
 					};
 					partition@1600000 {
 						label = "jffs2";
-						reg = <1600000 400000>;
+						reg = <0x01600000 0x00400000>;
 					};
 					partition@1a00000 {
 						label = "user";
-						reg = <1a00000 2560000>;
+						reg = <0x01a00000 0x02560000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 			};
@@ -189,109 +191,109 @@
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			UART1: serial@ef600400 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600400 8>;
-				virtual-reg = <ef600400>;
+				reg = <0xef600400 0x00000008>;
+				virtual-reg = <0xef600400>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			UART2: serial@ef600500 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600500 8>;
-				virtual-reg = <ef600500>;
+				reg = <0xef600500 0x00000008>;
+				virtual-reg = <0xef600500>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1d 4>;
+				interrupts = <0x1d 0x4>;
 			};
 
 			UART3: serial@ef600600 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600600 8>;
-				virtual-reg = <ef600600>;
+				reg = <0xef600600 0x00000008>;
+				virtual-reg = <0xef600600>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>; /* Filled in by U-Boot */
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4>;
+				interrupts = <0x1e 0x4>;
 			};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-460gt", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-460gt", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-460gt", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			RGMII0: emac-rgmii@ef601500 {
 				compatible = "ibm,rgmii-460gt", "ibm,rgmii";
-				reg = <ef601500 8>;
+				reg = <0xef601500 0x00000008>;
 				has-mdio;
 			};
 
 			RGMII1: emac-rgmii@ef601600 {
 				compatible = "ibm,rgmii-460gt", "ibm,rgmii";
-				reg = <ef601600 8>;
+				reg = <0xef601600 0x00000008>;
 				has-mdio;
 			};
 
 			TAH0: emac-tah@ef601350 {
 				compatible = "ibm,tah-460gt", "ibm,tah";
-				reg = <ef601350 30>;
+				reg = <0xef601350 0x00000030>;
 			};
 
 			TAH1: emac-tah@ef601450 {
 				compatible = "ibm,tah-460gt", "ibm,tah";
-				reg = <ef601450 30>;
+				reg = <0xef601450 0x00000030>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-460gt", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 10 4
-						 /*Wake*/   1 &UIC2 14 4>;
-				reg = <ef600e00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x10 0x4
+						 /*Wake*/   0x1 &UIC2 0x14 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
 				tah-device = <&TAH0>;
@@ -304,23 +306,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-460gt", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 11 4
-						 /*Wake*/   1 &UIC2 15 4>;
-				reg = <ef600f00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x11 0x4
+						 /*Wake*/   0x1 &UIC2 0x15 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <8>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
 				tah-device = <&TAH1>;
@@ -334,23 +336,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-460gt", "ibm,emac4";
 				interrupt-parent = <&EMAC2>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 12 4
-						 /*Wake*/   1 &UIC2 16 4>;
-				reg = <ef601100 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x12 0x4
+						 /*Wake*/   0x1 &UIC2 0x16 0x4>;
+				reg = <0xef601100 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
-				mal-rx-channel = <10>;
+				mal-rx-channel = <16>;
 				cell-index = <2>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
 				rgmii-channel = <0>;
 				has-inverted-stacr-oc;
@@ -362,23 +364,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-460gt", "ibm,emac4";
 				interrupt-parent = <&EMAC3>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC2 13 4
-						 /*Wake*/   1 &UIC2 17 4>;
-				reg = <ef601200 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC2 0x13 0x4
+						 /*Wake*/   0x1 &UIC2 0x17 0x4>;
+				reg = <0xef601200 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
-				mal-rx-channel = <18>;
+				mal-rx-channel = <24>;
 				cell-index = <3>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
 				rgmii-channel = <1>;
 				has-inverted-stacr-oc;
@@ -396,27 +398,27 @@
 			primary;
 			large-inbound-windows;
 			enable-msi-hole;
-			reg = <c 0ec00000   8	/* Config space access */
-			       0 0 0		/* no IACK cycles */
-			       c 0ed00000   4   /* Special cycles */
-			       c 0ec80000 100	/* Internal registers */
-			       c 0ec80100  fc>;	/* Internal messaging registers */
+			reg = <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
+			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
+			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000d 80000000 0 80000000
-				  01000000 0 00000000 0000000c 08000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0 to 0x3f */
-			bus-range = <0 3f>;
+			bus-range = <0x0 0x3f>;
 
 			/* All PCI interrupts are routed to ext IRQ 2 -> UIC1-0 */
-			interrupt-map-mask = <0000 0 0 0>;
-			interrupt-map = < 0000 0 0 0 &UIC1 0 8 >;
+			interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC1 0x0 0x8 >;
 		};
 
 		PCIE0: pciex@d00000000 {
@@ -426,23 +428,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <d 00000000 20000000	/* Config space access */
-			       c 08010000 00001000>;	/* Registers */
-			dcr-reg = <100 020>;
-			sdr-base = <300>;
+			port = <0x0>; /* port number */
+			reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08010000 0x00001000>;	/* Registers */
+			dcr-reg = <0x100 0x020>;
+			sdr-base = <0x300>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 00000000 0 80000000
-				  01000000 0 00000000 0000000f 80000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 40 to 0x7f */
-			bus-range = <40 7f>;
+			bus-range = <0x40 0x7f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -452,12 +454,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 c 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 d 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 e 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 f 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0xc 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0xd 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0xe 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0xf 0x4 /* swizzled int D */>;
 		};
 
 		PCIE1: pciex@d20000000 {
@@ -467,23 +469,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-460ex", "ibm,plb-pciex";
 			primary;
-			port = <1>; /* port number */
-			reg = <d 20000000 20000000	/* Config space access */
-			       c 08011000 00001000>;	/* Registers */
-			dcr-reg = <120 020>;
-			sdr-base = <340>;
+			port = <0x1>; /* port number */
+			reg = <0x0000000d 0x20000000 0x20000000	/* Config space access */
+			       0x0000000c 0x08011000 0x00001000>;	/* Registers */
+			dcr-reg = <0x120 0x020>;
+			sdr-base = <0x340>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 80000000 0 80000000
-				  01000000 0 00000000 0000000f 80010000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 80 to 0xbf */
-			bus-range = <80 bf>;
+			bus-range = <0x80 0xbf>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -493,12 +495,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 10 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 11 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 12 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 13 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0x10 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x11 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x12 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x13 0x4 /* swizzled int D */>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/haleakala.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/haleakala.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/haleakala.dts	2008-05-15 16:32:08.000000000 +1000
@@ -8,12 +8,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "amcc,haleakala";
 	compatible = "amcc,haleakala", "amcc,kilauea";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -28,13 +30,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405EXr";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 			timebase-frequency = <0>; /* Filled in by U-Boot */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <4000>; /* 16 kB */
-			d-cache-size = <4000>; /* 16 kB */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>; /* 16 kB */
+			d-cache-size = <16384>; /* 16 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -42,14 +44,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0>; /* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic-405exr", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -59,11 +61,11 @@
 		compatible = "ibm,uic-405exr","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -71,11 +73,11 @@
 		compatible = "ibm,uic-405exr","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1c 4 1d 4>; /* cascade */
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -88,72 +90,72 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405exr";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-405exr", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405exr", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <80000000 80000000 10000000
-				  ef600000 ef600000 a00000
-				  f0000000 f0000000 10000000>;
-			dcr-reg = <0a0 5>;
+			ranges = <0x80000000 0x80000000 0x10000000
+				  0xef600000 0xef600000 0x00a00000
+				  0xf0000000 0xf0000000 0x10000000>;
+			dcr-reg = <0x0a0 0x005>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-405exr", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				/* ranges property is supplied by U-Boot */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 200000>;
+						reg = <0x00000000 0x00200000>;
 					};
 					partition@200000 {
 						label = "root";
-						reg = <200000 200000>;
+						reg = <0x00200000 0x00200000>;
 					};
 					partition@400000 {
 						label = "user";
-						reg = <400000 3b60000>;
+						reg = <0x00400000 0x03b60000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 			};
@@ -161,68 +163,68 @@
 			UART0: serial@ef600200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600200 8>;
-				virtual-reg = <ef600200>;
+				reg = <0xef600200 0x00000008>;
+				virtual-reg = <0xef600200>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1a 4>;
+				interrupts = <0x1a 0x4>;
 			};
 
 			UART1: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC0: i2c@ef600400 {
 				compatible = "ibm,iic-405exr", "ibm,iic";
-				reg = <ef600400 14>;
+				reg = <0xef600400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600500 {
 				compatible = "ibm,iic-405exr", "ibm,iic";
-				reg = <ef600500 14>;
+				reg = <0xef600500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 
 			RGMII0: emac-rgmii@ef600b00 {
 				compatible = "ibm,rgmii-405exr", "ibm,rgmii";
-				reg = <ef600b00 104>;
+				reg = <0xef600b00 0x00000104>;
 				has-mdio;
 			};
 
 			EMAC0: ethernet@ef600900 {
-				linux,network-index = <0>;
+				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-405exr", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 18 4
-						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600900 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
 				has-inverted-stacr-oc;
@@ -237,23 +239,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <a0000000 20000000	/* Config space access */
-			       ef000000 00001000>;	/* Registers */
-			dcr-reg = <040 020>;
-			sdr-base = <400>;
+			port = <0x0>; /* port number */
+			reg = <0xa0000000 0x20000000	/* Config space access */
+			       0xef000000 0x00001000>;	/* Registers */
+			dcr-reg = <0x040 0x020>;
+			sdr-base = <0x400>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 90000000 0 08000000
-				  01000000 0 00000000 e0000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x08000000
+				  0x01000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0x00 to 0x3f */
-			bus-range = <00 3f>;
+			bus-range = <0x0 0x3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -263,12 +265,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC2 0 4 /* swizzled int A */
-				0000 0 0 2 &UIC2 1 4 /* swizzled int B */
-				0000 0 0 3 &UIC2 2 4 /* swizzled int C */
-				0000 0 0 4 &UIC2 3 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC2 0x0 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC2 0x1 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC2 0x2 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/holly.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/holly.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/holly.dts	2008-05-15 16:32:08.000000000 +1000
@@ -10,6 +10,8 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	model = "41K7339";
 	compatible = "ibm,holly";
@@ -21,22 +23,22 @@
 		#size-cells =<0>;
 		PowerPC,750CL@0 {
 			device_type = "cpu";
-			reg = <0>;
-			d-cache-line-size = <20>;
-			i-cache-line-size = <20>;
-			d-cache-size = <8000>;
-			i-cache-size = <8000>;
-			d-cache-sets = <80>;
-			i-cache-sets = <80>;
-			timebase-frequency = <2faf080>;
-			clock-frequency = <23c34600>;
-			bus-frequency = <bebc200>;
+			reg = <0x00000000>;
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			d-cache-size = <32768>;
+			i-cache-size = <32768>;
+			d-cache-sets = <128>;
+			i-cache-sets = <128>;
+			timebase-frequency = <50000000>;
+			clock-frequency = <600000000>;
+			bus-frequency = <200000000>;
 		};
 	};
 
 	memory@0 {
 		device_type = "memory";
-		reg = <00000000 20000000>;
+		reg = <0x00000000 0x20000000>;
 	};
 
   	tsi109@c0000000 {
@@ -44,33 +46,33 @@
 		compatible = "tsi109-bridge", "tsi108-bridge";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <00000000 c0000000 00010000>;
-		reg = <c0000000 00010000>;
+		ranges = <0x00000000 0xc0000000 0x00010000>;
+		reg = <0xc0000000 0x00010000>;
 
 		i2c@7000 {
 			device_type = "i2c";
 			compatible  = "tsi109-i2c", "tsi108-i2c";
 			interrupt-parent = <&MPIC>;
-			interrupts = <e 2>;
-			reg = <7000 400>;
+			interrupts = <0xe 0x2>;
+			reg = <0x00007000 0x00000400>;
 		};
 
 		MDIO: mdio@6000 {
 			device_type = "mdio";
 			compatible = "tsi109-mdio", "tsi108-mdio";
-			reg = <6000 50>;
+			reg = <0x00006000 0x00000050>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 
 			PHY1: ethernet-phy@1 {
 				compatible = "bcm5461a";
-				reg = <1>;
+				reg = <0x00000001>;
 				txc-rxc-delay-disable;
 			};
 
 			PHY2: ethernet-phy@2 {
 				compatible = "bcm5461a";
-				reg = <2>;
+				reg = <0x00000002>;
 				txc-rxc-delay-disable;
 			};
 		};
@@ -80,10 +82,10 @@
 			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <6000 200>;
+			reg = <0x00006000 0x00000200>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&MPIC>;
-			interrupts = <10 2>;
+			interrupts = <0x10 0x2>;
 			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY1>;
 		};
@@ -93,10 +95,10 @@
 			compatible = "tsi109-ethernet", "tsi108-ethernet";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <6400 200>;
+			reg = <0x00006400 0x00000200>;
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupt-parent = <&MPIC>;
-			interrupts = <11 2>;
+			interrupts = <0x11 0x2>;
 			mdio-handle = <&MDIO>;
 			phy-handle = <&PHY2>;
 		};
@@ -104,23 +106,23 @@
 		serial@7808 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <7808 200>;
-			virtual-reg = <c0007808>;
-			clock-frequency = <3F9C6000>;
-			current-speed = <1c200>;
+			reg = <0x00007808 0x00000200>;
+			virtual-reg = <0xc0007808>;
+			clock-frequency = <1067212800>;
+			current-speed = <115200>;
 			interrupt-parent = <&MPIC>;
-			interrupts = <c 2>;
+			interrupts = <0xc 0x2>;
 		};
 
 		serial@7c08 {
 			device_type = "serial";
 			compatible = "ns16550";
-			reg = <7c08 200>;
-			virtual-reg = <c0007c08>;
-			clock-frequency = <3F9C6000>;
-			current-speed = <1c200>;
+			reg = <0x00007c08 0x00000200>;
+			virtual-reg = <0xc0007c08>;
+			clock-frequency = <1067212800>;
+			current-speed = <115200>;
 			interrupt-parent = <&MPIC>;
-			interrupts = <d 2>;
+			interrupts = <0xd 0x2>;
 		};
 
 	  	MPIC: pic@7400 {
@@ -128,7 +130,7 @@
 			compatible = "chrp,open-pic";
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reg = <7400 400>;
+			reg = <0x00007400 0x00000400>;
 			big-endian;
 		};
 
@@ -138,42 +140,42 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			reg = <1000 1000>;
-			bus-range = <0 0>;
+			reg = <0x00001000 0x00001000>;
+			bus-range = <0x0 0x0>;
 			/*----------------------------------------------------+
 			| PCI memory range.
 			| 01 denotes I/O space
 			| 02 denotes 32-bit memory space
 			+----------------------------------------------------*/
-			ranges = <02000000 0 40000000 40000000 0 10000000
-				  01000000 0 00000000 7e000000 0 00010000>;
-			clock-frequency = <7f28154>;
+			ranges = <0x02000000 0x00000000 0x40000000 0x40000000 0x00000000 0x10000000
+				  0x01000000 0x00000000 0x00000000 0x7e000000 0x00000000 0x00010000>;
+			clock-frequency = <133333332>;
 			interrupt-parent = <&MPIC>;
-			interrupts = <17 2>;
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupts = <0x17 0x2>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			/*----------------------------------------------------+
 			| The INTA, INTB, INTC, INTD are shared.
 			+----------------------------------------------------*/
 			interrupt-map = <
-				0800 0 0 1 &RT0 24 0
-				0800 0 0 2 &RT0 25 0
-				0800 0 0 3 &RT0 26 0
-				0800 0 0 4 &RT0 27 0
-
-				1000 0 0 1 &RT0 25 0
-				1000 0 0 2 &RT0 26 0
-				1000 0 0 3 &RT0 27 0
-				1000 0 0 4 &RT0 24 0
-
-				1800 0 0 1 &RT0 26 0
-				1800 0 0 2 &RT0 27 0
-				1800 0 0 3 &RT0 24 0
-				1800 0 0 4 &RT0 25 0
-
-				2000 0 0 1 &RT0 27 0
-				2000 0 0 2 &RT0 24 0
-				2000 0 0 3 &RT0 25 0
-				2000 0 0 4 &RT0 26 0
+				0x800 0x0 0x0 0x1 &RT0 0x24 0x0
+				0x800 0x0 0x0 0x2 &RT0 0x25 0x0
+				0x800 0x0 0x0 0x3 &RT0 0x26 0x0
+				0x800 0x0 0x0 0x4 &RT0 0x27 0x0
+
+				0x1000 0x0 0x0 0x1 &RT0 0x25 0x0
+				0x1000 0x0 0x0 0x2 &RT0 0x26 0x0
+				0x1000 0x0 0x0 0x3 &RT0 0x27 0x0
+				0x1000 0x0 0x0 0x4 &RT0 0x24 0x0
+
+				0x1800 0x0 0x0 0x1 &RT0 0x26 0x0
+				0x1800 0x0 0x0 0x2 &RT0 0x27 0x0
+				0x1800 0x0 0x0 0x3 &RT0 0x24 0x0
+				0x1800 0x0 0x0 0x4 &RT0 0x25 0x0
+
+				0x2000 0x0 0x0 0x1 &RT0 0x27 0x0
+				0x2000 0x0 0x0 0x2 &RT0 0x24 0x0
+				0x2000 0x0 0x0 0x3 &RT0 0x25 0x0
+				0x2000 0x0 0x0 0x4 &RT0 0x26 0x0
 				>;
 
 			RT0: router@1180 {
@@ -183,7 +185,7 @@
  				clock-frequency = <0>;
  				#address-cells = <0>;
  				#interrupt-cells = <2>;
- 				interrupts = <17 2>;
+ 				interrupts = <0x17 0x2>;
 				interrupt-parent = <&MPIC>;
 			};
 		};
Index: working-2.6/arch/powerpc/boot/dts/katmai.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/katmai.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/katmai.dts	2008-05-15 16:32:08.000000000 +1000
@@ -12,12 +12,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,katmai";
 	compatible = "amcc,katmai";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -33,13 +35,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440SPe";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -47,14 +49,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440spe","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -64,11 +66,11 @@
 		compatible = "ibm,uic-440spe","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -76,11 +78,11 @@
 		compatible = "ibm,uic-440spe","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <a 4 b 4>; /* cascade */
+		interrupts = <0xa 0x4 0xb 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -88,22 +90,22 @@
 		compatible = "ibm,uic-440spe","ibm,uic";
 		interrupt-controller;
 		cell-index = <3>;
-		dcr-reg = <0f0 009>;
+		dcr-reg = <0x0f0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <10 4 11 4>; /* cascade */
+		interrupts = <0x10 0x4 0x11 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440spe";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440spe";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -115,108 +117,108 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440spe", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440spe", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <1>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC1 6 4
-					 /*RXEOB*/ 1 &UIC1 7 4
-					 /*SERR*/  2 &UIC1 1 4
-					 /*TXDE*/  3 &UIC1 2 4
-					 /*RXDE*/  4 &UIC1 3 4>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC1 0x6 0x4
+					 /*RXEOB*/ 0x1 &UIC1 0x7 0x4
+					 /*SERR*/  0x2 &UIC1 0x1 0x4
+					 /*TXDE*/  0x3 &UIC1 0x2 0x4
+					 /*RXDE*/  0x4 &UIC1 0x3 0x4>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-440spe", "ibm,opb-440gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <00000000 4 e0000000 20000000>;
+			ranges = <0x00000000 0x00000004 0xe0000000 0x20000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440spe", "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 			};
 
 			UART0: serial@10000200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <10000200 8>;
-				virtual-reg = <a0000200>;
+				reg = <0x10000200 0x00000008>;
+				virtual-reg = <0xa0000200>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <1c200>;
+				current-speed = <115200>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@10000300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <10000300 8>;
-				virtual-reg = <a0000300>;
+				reg = <0x10000300 0x00000008>;
+				virtual-reg = <0xa0000300>;
 				clock-frequency = <0>;
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 
 			UART2: serial@10000600 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <10000600 8>;
-				virtual-reg = <a0000600>;
+				reg = <0x10000600 0x00000008>;
+				virtual-reg = <0xa0000600>;
 				clock-frequency = <0>;
 				current-speed = <0>;
 				interrupt-parent = <&UIC1>;
-				interrupts = <5 4>;
+				interrupts = <0x5 0x4>;
 			};
 
 			IIC0: i2c@10000400 {
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
-				reg = <10000400 14>;
+				reg = <0x10000400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@10000500 {
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
-				reg = <10000500 14>;
+				reg = <0x10000500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 			};
 
 			EMAC0: ethernet@10000800 {
-				linux,network-index = <0>;
+				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-440spe", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <10000800 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0x10000800 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "gmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				has-inverted-stacr-oc;
 				has-new-stacr-staopc;
 			};
@@ -231,23 +233,23 @@
 			primary;
 			large-inbound-windows;
 			enable-msi-hole;
-			reg = <c 0ec00000   8	/* Config space access */
-			       0 0 0		/* no IACK cycles */
-			       c 0ed00000   4   /* Special cycles */
-			       c 0ec80000 100	/* Internal registers */
-			       c 0ec80100  fc>;	/* Internal messaging registers */
+			reg = <0x0000000c 0x0ec00000   0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x0000000c 0x0ed00000   0x00000004   /* Special cycles */
+			       0x0000000c 0x0ec80000 0x00000100	/* Internal registers */
+			       0x0000000c 0x0ec80100  0x000000fc>;	/* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000d 80000000 0 80000000
-				  01000000 0 00000000 0000000c 08000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0 to 0xf */
-			bus-range = <0 f>;
+			bus-range = <0x0 0xf>;
 
 			/*
 			 * On Katmai, the following PCI-X interrupts signals
@@ -258,13 +260,13 @@
 			 * INTC: J2: 1-2
 			 * INTD: J1: 1-2
 			 */
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 1 &UIC1 14 8
-				0800 0 0 2 &UIC1 13 8
-				0800 0 0 3 &UIC1 12 8
-				0800 0 0 4 &UIC1 11 8
+				0x800 0x0 0x0 0x1 &UIC1 0x14 0x8
+				0x800 0x0 0x0 0x2 &UIC1 0x13 0x8
+				0x800 0x0 0x0 0x3 &UIC1 0x12 0x8
+				0x800 0x0 0x0 0x4 &UIC1 0x11 0x8
 			>;
 		};
 
@@ -275,23 +277,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <d 00000000 20000000	/* Config space access */
-			       c 10000000 00001000>;	/* Registers */
-			dcr-reg = <100 020>;
-			sdr-base = <300>;
+			port = <0x0>; /* port number */
+			reg = <0x0000000d 0x00000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10000000 0x00001000>;	/* Registers */
+			dcr-reg = <0x100 0x020>;
+			sdr-base = <0x300>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 00000000 0 80000000
-				  01000000 0 00000000 0000000f 80000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 10 to 0x1f */
-			bus-range = <10 1f>;
+			bus-range = <0x10 0x1f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -301,12 +303,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 0 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 1 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 2 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 3 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0x0 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x1 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x2 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x3 0x4 /* swizzled int D */>;
 		};
 
 		PCIE1: pciex@d20000000 {
@@ -316,23 +318,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
-			port = <1>; /* port number */
-			reg = <d 20000000 20000000	/* Config space access */
-			       c 10001000 00001000>;	/* Registers */
-			dcr-reg = <120 020>;
-			sdr-base = <340>;
+			port = <0x1>; /* port number */
+			reg = <0x0000000d 0x20000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10001000 0x00001000>;	/* Registers */
+			dcr-reg = <0x120 0x020>;
+			sdr-base = <0x340>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000e 80000000 0 80000000
-				  01000000 0 00000000 0000000f 80010000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 10 to 0x1f */
-			bus-range = <20 2f>;
+			bus-range = <0x20 0x2f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -342,12 +344,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 4 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 5 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 6 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 7 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0x4 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x5 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0x6 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0x7 0x4 /* swizzled int D */>;
 		};
 
 		PCIE2: pciex@d40000000 {
@@ -357,23 +359,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-440spe", "ibm,plb-pciex";
 			primary;
-			port = <2>; /* port number */
-			reg = <d 40000000 20000000	/* Config space access */
-			       c 10002000 00001000>;	/* Registers */
-			dcr-reg = <140 020>;
-			sdr-base = <370>;
+			port = <0x2>; /* port number */
+			reg = <0x0000000d 0x40000000 0x20000000	/* Config space access */
+			       0x0000000c 0x10002000 0x00001000>;	/* Registers */
+			dcr-reg = <0x140 0x020>;
+			sdr-base = <0x370>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 0000000f 00000000 0 80000000
-				  01000000 0 00000000 0000000f 80020000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x0000000f 0x00000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80020000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 10 to 0x1f */
-			bus-range = <30 3f>;
+			bus-range = <0x30 0x3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -383,12 +385,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC3 8 4 /* swizzled int A */
-				0000 0 0 2 &UIC3 9 4 /* swizzled int B */
-				0000 0 0 3 &UIC3 a 4 /* swizzled int C */
-				0000 0 0 4 &UIC3 b 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC3 0x8 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC3 0x9 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC3 0xa 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC3 0xb 0x4 /* swizzled int D */>;
 		};
 	};
 
Index: working-2.6/arch/powerpc/boot/dts/kilauea.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/kilauea.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/kilauea.dts	2008-05-15 16:32:08.000000000 +1000
@@ -8,12 +8,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "amcc,kilauea";
 	compatible = "amcc,kilauea";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -29,13 +31,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405EX";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 			timebase-frequency = <0>; /* Filled in by U-Boot */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <4000>; /* 16 kB */
-			d-cache-size = <4000>; /* 16 kB */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>; /* 16 kB */
+			d-cache-size = <16384>; /* 16 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -43,14 +45,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0>; /* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic-405ex", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -60,11 +62,11 @@
 		compatible = "ibm,uic-405ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -72,11 +74,11 @@
 		compatible = "ibm,uic-405ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1c 4 1d 4>; /* cascade */
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -89,72 +91,72 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405ex";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-405ex", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405ex", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <80000000 80000000 10000000
-				  ef600000 ef600000 a00000
-				  f0000000 f0000000 10000000>;
-			dcr-reg = <0a0 5>;
+			ranges = <0x80000000 0x80000000 0x10000000
+				  0xef600000 0xef600000 0x00a00000
+				  0xf0000000 0xf0000000 0x10000000>;
+			dcr-reg = <0x0a0 0x005>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-405ex", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				/* ranges property is supplied by U-Boot */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 200000>;
+						reg = <0x00000000 0x00200000>;
 					};
 					partition@200000 {
 						label = "root";
-						reg = <200000 200000>;
+						reg = <0x00200000 0x00200000>;
 					};
 					partition@400000 {
 						label = "user";
-						reg = <400000 3b60000>;
+						reg = <0x00400000 0x03b60000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 			};
@@ -162,68 +164,68 @@
 			UART0: serial@ef600200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600200 8>;
-				virtual-reg = <ef600200>;
+				reg = <0xef600200 0x00000008>;
+				virtual-reg = <0xef600200>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1a 4>;
+				interrupts = <0x1a 0x4>;
 			};
 
 			UART1: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC0: i2c@ef600400 {
 				compatible = "ibm,iic-405ex", "ibm,iic";
-				reg = <ef600400 14>;
+				reg = <0xef600400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600500 {
 				compatible = "ibm,iic-405ex", "ibm,iic";
-				reg = <ef600500 14>;
+				reg = <0xef600500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 
 			RGMII0: emac-rgmii@ef600b00 {
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
-				reg = <ef600b00 104>;
+				reg = <0xef600b00 0x00000104>;
 				has-mdio;
 			};
 
 			EMAC0: ethernet@ef600900 {
-				linux,network-index = <0>;
+				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-405ex", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 18 4
-						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600900 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
 				has-inverted-stacr-oc;
@@ -231,27 +233,27 @@
 			};
 
 			EMAC1: ethernet@ef600a00 {
-				linux,network-index = <1>;
+				linux,network-index = <0x1>;
 				device_type = "network";
 				compatible = "ibm,emac-405ex", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 19 4
-						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
+						/*Wake*/  0x1 &UIC1 0x1f 0x4>;
+				reg = <0xef600a00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
 				has-inverted-stacr-oc;
@@ -266,23 +268,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <a0000000 20000000	/* Config space access */
-			       ef000000 00001000>;	/* Registers */
-			dcr-reg = <040 020>;
-			sdr-base = <400>;
+			port = <0x0>; /* port number */
+			reg = <0xa0000000 0x20000000	/* Config space access */
+			       0xef000000 0x00001000>;	/* Registers */
+			dcr-reg = <0x040 0x020>;
+			sdr-base = <0x400>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 90000000 0 08000000
-				  01000000 0 00000000 e0000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x08000000
+				  0x01000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0x00 to 0x3f */
-			bus-range = <00 3f>;
+			bus-range = <0x0 0x3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -292,12 +294,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC2 0 4 /* swizzled int A */
-				0000 0 0 2 &UIC2 1 4 /* swizzled int B */
-				0000 0 0 3 &UIC2 2 4 /* swizzled int C */
-				0000 0 0 4 &UIC2 3 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC2 0x0 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC2 0x1 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC2 0x2 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
 		};
 
 		PCIE1: pciex@0c0000000 {
@@ -307,23 +309,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
-			port = <1>; /* port number */
-			reg = <c0000000 20000000	/* Config space access */
-			       ef001000 00001000>;	/* Registers */
-			dcr-reg = <060 020>;
-			sdr-base = <440>;
+			port = <0x1>; /* port number */
+			reg = <0xc0000000 0x20000000	/* Config space access */
+			       0xef001000 0x00001000>;	/* Registers */
+			dcr-reg = <0x060 0x020>;
+			sdr-base = <0x440>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 98000000 0 08000000
-				  01000000 0 00000000 e0010000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x98000000 0x00000000 0x08000000
+				  0x01000000 0x00000000 0x00000000 0xe0010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0x40 to 0x7f */
-			bus-range = <40 7f>;
+			bus-range = <0x40 0x7f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -333,12 +335,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC2 b 4 /* swizzled int A */
-				0000 0 0 2 &UIC2 c 4 /* swizzled int B */
-				0000 0 0 3 &UIC2 d 4 /* swizzled int C */
-				0000 0 0 4 &UIC2 e 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC2 0xb 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC2 0xc 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/makalu.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/makalu.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/makalu.dts	2008-05-15 16:32:08.000000000 +1000
@@ -8,12 +8,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "amcc,makalu";
 	compatible = "amcc,makalu";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -29,13 +31,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405EX";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 			timebase-frequency = <0>; /* Filled in by U-Boot */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <4000>; /* 16 kB */
-			d-cache-size = <4000>; /* 16 kB */
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>; /* 16 kB */
+			d-cache-size = <16384>; /* 16 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -43,14 +45,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0>; /* Filled in by U-Boot */
+		reg = <0x00000000 0x00000000>; /* Filled in by U-Boot */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic-405ex", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -60,11 +62,11 @@
 		compatible = "ibm,uic-405ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -72,11 +74,11 @@
 		compatible = "ibm,uic-405ex","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1c 4 1d 4>; /* cascade */
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -89,72 +91,72 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405ex";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-405ex", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405ex", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <80000000 80000000 10000000
-				  ef600000 ef600000 a00000
-				  f0000000 f0000000 10000000>;
-			dcr-reg = <0a0 5>;
+			ranges = <0x80000000 0x80000000 0x10000000
+				  0xef600000 0xef600000 0x00a00000
+				  0xf0000000 0xf0000000 0x10000000>;
+			dcr-reg = <0x0a0 0x005>;
 			clock-frequency = <0>; /* Filled in by U-Boot */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-405ex", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				/* ranges property is supplied by U-Boot */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 200000>;
+						reg = <0x00000000 0x00200000>;
 					};
 					partition@200000 {
 						label = "root";
-						reg = <200000 200000>;
+						reg = <0x00200000 0x00200000>;
 					};
 					partition@400000 {
 						label = "user";
-						reg = <400000 3b60000>;
+						reg = <0x00400000 0x03b60000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 			};
@@ -162,68 +164,68 @@
 			UART0: serial@ef600200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600200 8>;
-				virtual-reg = <ef600200>;
+				reg = <0xef600200 0x00000008>;
+				virtual-reg = <0xef600200>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1a 4>;
+				interrupts = <0x1a 0x4>;
 			};
 
 			UART1: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by U-Boot */
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC0: i2c@ef600400 {
 				compatible = "ibm,iic-405ex", "ibm,iic";
-				reg = <ef600400 14>;
+				reg = <0xef600400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600500 {
 				compatible = "ibm,iic-405ex", "ibm,iic";
-				reg = <ef600500 14>;
+				reg = <0xef600500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 
 			RGMII0: emac-rgmii@ef600b00 {
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
-				reg = <ef600b00 104>;
+				reg = <0xef600b00 0x00000104>;
 				has-mdio;
 			};
 
 			EMAC0: ethernet@ef600900 {
-				linux,network-index = <0>;
+				linux,network-index = <0x0>;
 				device_type = "network";
 				compatible = "ibm,emac-405ex", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 18 4
-						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600900 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600900 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <0000003f>;	/* Start at 6 */
+				phy-map = <0x0000003f>;	/* Start at 6 */
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
 				has-inverted-stacr-oc;
@@ -231,27 +233,27 @@
 			};
 
 			EMAC1: ethernet@ef600a00 {
-				linux,network-index = <1>;
+				linux,network-index = <0x1>;
 				device_type = "network";
 				compatible = "ibm,emac-405ex", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 19 4
-						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600a00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
+						/*Wake*/  0x1 &UIC1 0x1f 0x4>;
+				reg = <0xef600a00 0x00000070>;
 				local-mac-address = [000000000000]; /* Filled in by U-Boot */
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
 				has-inverted-stacr-oc;
@@ -266,23 +268,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
-			port = <0>; /* port number */
-			reg = <a0000000 20000000	/* Config space access */
-			       ef000000 00001000>;	/* Registers */
-			dcr-reg = <040 020>;
-			sdr-base = <400>;
+			port = <0x0>; /* port number */
+			reg = <0xa0000000 0x20000000	/* Config space access */
+			       0xef000000 0x00001000>;	/* Registers */
+			dcr-reg = <0x040 0x020>;
+			sdr-base = <0x400>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 90000000 0 08000000
-				  01000000 0 00000000 e0000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x90000000 0x00000000 0x08000000
+				  0x01000000 0x00000000 0x00000000 0xe0000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0x00 to 0x3f */
-			bus-range = <00 3f>;
+			bus-range = <0x0 0x3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -292,12 +294,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC2 0 4 /* swizzled int A */
-				0000 0 0 2 &UIC2 1 4 /* swizzled int B */
-				0000 0 0 3 &UIC2 2 4 /* swizzled int C */
-				0000 0 0 4 &UIC2 3 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC2 0x0 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC2 0x1 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC2 0x2 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC2 0x3 0x4 /* swizzled int D */>;
 		};
 
 		PCIE1: pciex@0c0000000 {
@@ -307,23 +309,23 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
 			primary;
-			port = <1>; /* port number */
-			reg = <c0000000 20000000	/* Config space access */
-			       ef001000 00001000>;	/* Registers */
-			dcr-reg = <060 020>;
-			sdr-base = <440>;
+			port = <0x1>; /* port number */
+			reg = <0xc0000000 0x20000000	/* Config space access */
+			       0xef001000 0x00001000>;	/* Registers */
+			dcr-reg = <0x060 0x020>;
+			sdr-base = <0x440>;
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 98000000 0 08000000
-				  01000000 0 00000000 e0010000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x98000000 0x00000000 0x08000000
+				  0x01000000 0x00000000 0x00000000 0xe0010000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* This drives busses 0x40 to 0x7f */
-			bus-range = <40 7f>;
+			bus-range = <0x40 0x7f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
 			 * to invert PCIe legacy interrupts).
@@ -333,12 +335,12 @@
 			 * below are basically de-swizzled numbers.
 			 * The real slot is on idsel 0, so the swizzling is 1:1
 			 */
-			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <
-				0000 0 0 1 &UIC2 b 4 /* swizzled int A */
-				0000 0 0 2 &UIC2 c 4 /* swizzled int B */
-				0000 0 0 3 &UIC2 d 4 /* swizzled int C */
-				0000 0 0 4 &UIC2 e 4 /* swizzled int D */>;
+				0x0 0x0 0x0 0x1 &UIC2 0xb 0x4 /* swizzled int A */
+				0x0 0x0 0x0 0x2 &UIC2 0xc 0x4 /* swizzled int B */
+				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
+				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/ps3.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/ps3.dts	2008-05-15 16:32:08.000000000 +1000
@@ -18,6 +18,8 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+/dts-v1/;
+
 / {
 	model = "SonyPS3";
 	compatible = "sony,ps3";
@@ -34,7 +36,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0 0>;
+		reg = <0x00000000 0x00000000 0x00000000 0x00000000>;
 	};
 
 	/*
@@ -55,14 +57,14 @@
 
 		cpu@0 {
 			device_type = "cpu";
-			reg = <0>;
-			ibm,ppc-interrupt-server#s = <0 1>;
+			reg = <0x00000000>;
+			ibm,ppc-interrupt-server#s = <0x0 0x1>;
 			clock-frequency = <0>;
 			timebase-frequency = <0>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
-			i-cache-line-size = <80>;
-			d-cache-line-size = <80>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			i-cache-line-size = <128>;
+			d-cache-line-size = <128>;
 		};
 	};
 };
Index: working-2.6/arch/powerpc/boot/dts/rainier.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/rainier.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/rainier.dts	2008-05-15 16:32:08.000000000 +1000
@@ -12,12 +12,14 @@
  *
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,rainier";
 	compatible = "amcc,rainier";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -35,13 +37,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440GRx";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -49,14 +51,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440grx","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -66,11 +68,11 @@
 		compatible = "ibm,uic-440grx","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -78,22 +80,22 @@
 		compatible = "ibm,uic-440grx","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1c 4 1d 4>; /* cascade */
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440grx", "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440grx", "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -105,80 +107,80 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440grx", "ibm,sdram-44x-ddr2denali";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		DMA0: dma {
 			compatible = "ibm,dma-440grx", "ibm,dma-4xx";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440grx", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
 		  	compatible = "ibm,opb-440grx", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-		  	ranges = <00000000 1 00000000 80000000
-			          80000000 1 80000000 80000000>;
+		  	ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+			          0x80000000 0x00000001 0x80000000 0x80000000>;
 		  	interrupt-parent = <&UIC1>;
-		  	interrupts = <7 4>;
+		  	interrupts = <0x7 0x4>;
 		  	clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440grx", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl256n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "Kernel";
-						reg = <0 180000>;
+						reg = <0x00000000 0x00180000>;
 					};
 					partition@180000 {
 						label = "ramdisk";
-						reg = <180000 200000>;
+						reg = <0x00180000 0x00200000>;
 					};
 					partition@380000 {
 						label = "file system";
-						reg = <380000 3aa0000>;
+						reg = <0x00380000 0x03aa0000>;
 					};
 					partition@3e20000 {
 						label = "kozio";
-						reg = <3e20000 140000>;
+						reg = <0x03e20000 0x00140000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 
@@ -187,69 +189,69 @@
 			UART0: serial@ef600300 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600300 8>;
-		   		virtual-reg = <ef600300>;
+		   		reg = <0xef600300 0x00000008>;
+		   		virtual-reg = <0xef600300>;
 		   		clock-frequency = <0>; /* Filled in by zImage */
-		   		current-speed = <1c200>;
+		   		current-speed = <115200>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <0 4>;
+		   		interrupts = <0x0 0x4>;
 	   		};
 
 			UART1: serial@ef600400 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600400 8>;
-		   		virtual-reg = <ef600400>;
+		   		reg = <0xef600400 0x00000008>;
+		   		virtual-reg = <0xef600400>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <1 4>;
+		   		interrupts = <0x1 0x4>;
 	   		};
 
 			UART2: serial@ef600500 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600500 8>;
-		   		virtual-reg = <ef600500>;
+		   		reg = <0xef600500 0x00000008>;
+		   		virtual-reg = <0xef600500>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC1>;
-		   		interrupts = <3 4>;
+		   		interrupts = <0x3 0x4>;
 	   		};
 
 			UART3: serial@ef600600 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600600 8>;
-		   		virtual-reg = <ef600600>;
+		   		reg = <0xef600600 0x00000008>;
+		   		virtual-reg = <0xef600600>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC1>;
-		   		interrupts = <4 4>;
+		   		interrupts = <0x4 0x4>;
 	   		};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-440grx", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-440grx", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440grx", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			RGMII0: emac-rgmii@ef601000 {
 				compatible = "ibm,rgmii-440grx", "ibm,rgmii";
-				reg = <ef601000 8>;
+				reg = <0xef601000 0x00000008>;
 				has-mdio;
 			};
 
@@ -257,23 +259,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-440grx", "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 18 4
-						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600e00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 				rgmii-device = <&RGMII0>;
@@ -286,23 +288,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-440grx", "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 19 4
-						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
+						/*Wake*/  0x1 &UIC1 0x1f 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 				rgmii-device = <&RGMII0>;
@@ -319,24 +321,24 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440grx-pci", "ibm,plb-pci";
 			primary;
-			reg = <1 eec00000 8	/* Config space access */
-			       1 eed00000 4	/* IACK */
-			       1 eed00000 4	/* Special cycle */
-			       1 ef400000 40>;	/* Internal registers */
+			reg = <0x00000001 0xeec00000 0x00000008	/* Config space access */
+			       0x00000001 0xeed00000 0x00000004	/* IACK */
+			       0x00000001 0xeed00000 0x00000004	/* Special cycle */
+			       0x00000001 0xef400000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 80000000 1 80000000 0 10000000
-				01000000 0 00000000 1 e8000000 0 00100000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000001 0x80000000 0x00000000 0x10000000
+				0x01000000 0x00000000 0x00000000 0x00000001 0xe8000000 0x00000000 0x00100000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* All PCI interrupts are routed to IRQ 67 */
-			interrupt-map-mask = <0000 0 0 0>;
-			interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
+			interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC2 0x3 0x8 >;
 		};
 	};
 
Index: working-2.6/arch/powerpc/boot/dts/sequoia.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/sequoia.dts	2008-05-15 16:32:08.000000000 +1000
@@ -12,12 +12,14 @@
  *
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,sequoia";
 	compatible = "amcc,sequoia";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -35,13 +37,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440EPx";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -49,14 +51,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440epx","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -66,11 +68,11 @@
 		compatible = "ibm,uic-440epx","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
@@ -78,22 +80,22 @@
 		compatible = "ibm,uic-440epx","ibm,uic";
 		interrupt-controller;
 		cell-index = <2>;
-		dcr-reg = <0e0 009>;
+		dcr-reg = <0x0e0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1c 4 1d 4>; /* cascade */
+		interrupts = <0x1c 0x4 0x1d 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440epx", "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440epx", "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -105,44 +107,44 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440epx", "ibm,sdram-44x-ddr2denali";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		DMA0: dma {
 			compatible = "ibm,dma-440epx", "ibm,dma-4xx";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440epx", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <2>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		USB1: usb@e0000400 {
 			compatible = "ohci-be";
-			reg = <0 e0000400 60>;
+			reg = <0x00000000 0xe0000400 0x00000060>;
 			interrupt-parent = <&UIC0>;
-			interrupts = <15 8>;
+			interrupts = <0x15 0x8>;
 		};
 
 		USB0: ehci@e0000300 {
 			compatible = "ibm,usb-ehci-440epx", "usb-ehci";
 			interrupt-parent = <&UIC0>;
-			interrupts = <1a 4>;
-			reg = <0 e0000300 90 0 e0000390 70>;
+			interrupts = <0x1a 0x4>;
+			reg = <0x00000000 0xe0000300 0x00000090 0x00000000 0xe0000390 0x00000070>;
 			big-endian;
 		};
 
@@ -150,50 +152,50 @@
 		  	compatible = "ibm,opb-440epx", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-		  	ranges = <00000000 1 00000000 80000000
-			          80000000 1 80000000 80000000>;
+		  	ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+			          0x80000000 0x00000001 0x80000000 0x80000000>;
 		  	interrupt-parent = <&UIC1>;
-		  	interrupts = <7 4>;
+		  	interrupts = <0x7 0x4>;
 		  	clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440epx", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl256n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 000000 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "Kernel";
-						reg = <0 180000>;
+						reg = <0x00000000 0x00180000>;
 					};
 					partition@180000 {
 						label = "ramdisk";
-						reg = <180000 200000>;
+						reg = <0x00180000 0x00200000>;
 					};
 					partition@380000 {
 						label = "file system";
-						reg = <380000 3aa0000>;
+						reg = <0x00380000 0x03aa0000>;
 					};
 					partition@3e20000 {
 						label = "kozio";
-						reg = <3e20000 140000>;
+						reg = <0x03e20000 0x00140000>;
 					};
 					partition@3f60000 {
 						label = "env";
-						reg = <3f60000 40000>;
+						reg = <0x03f60000 0x00040000>;
 					};
 					partition@3fa0000 {
 						label = "u-boot";
-						reg = <3fa0000 60000>;
+						reg = <0x03fa0000 0x00060000>;
 					};
 				};
 
@@ -202,69 +204,69 @@
 			UART0: serial@ef600300 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600300 8>;
-		   		virtual-reg = <ef600300>;
+		   		reg = <0xef600300 0x00000008>;
+		   		virtual-reg = <0xef600300>;
 		   		clock-frequency = <0>; /* Filled in by zImage */
-		   		current-speed = <1c200>;
+		   		current-speed = <115200>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <0 4>;
+		   		interrupts = <0x0 0x4>;
 	   		};
 
 			UART1: serial@ef600400 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600400 8>;
-		   		virtual-reg = <ef600400>;
+		   		reg = <0xef600400 0x00000008>;
+		   		virtual-reg = <0xef600400>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <1 4>;
+		   		interrupts = <0x1 0x4>;
 	   		};
 
 			UART2: serial@ef600500 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600500 8>;
-		   		virtual-reg = <ef600500>;
+		   		reg = <0xef600500 0x00000008>;
+		   		virtual-reg = <0xef600500>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC1>;
-		   		interrupts = <3 4>;
+		   		interrupts = <0x3 0x4>;
 	   		};
 
 			UART3: serial@ef600600 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600600 8>;
-		   		virtual-reg = <ef600600>;
+		   		reg = <0xef600600 0x00000008>;
+		   		virtual-reg = <0xef600600>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC1>;
-		   		interrupts = <4 4>;
+		   		interrupts = <0x4 0x4>;
 	   		};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-440epx", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-440epx", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440epx", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			RGMII0: emac-rgmii@ef601000 {
 				compatible = "ibm,rgmii-440epx", "ibm,rgmii";
-				reg = <ef601000 8>;
+				reg = <0xef601000 0x00000008>;
 				has-mdio;
 			};
 
@@ -272,23 +274,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC0>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 18 4
-						/*Wake*/  1 &UIC1 1d 4>;
-				reg = <ef600e00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x18 0x4
+						/*Wake*/  0x1 &UIC1 0x1d 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 				rgmii-device = <&RGMII0>;
@@ -301,23 +303,23 @@
 				device_type = "network";
 				compatible = "ibm,emac-440epx", "ibm,emac4";
 				interrupt-parent = <&EMAC1>;
-				interrupts = <0 1>;
+				interrupts = <0x0 0x1>;
 				#interrupt-cells = <1>;
 				#address-cells = <0>;
 				#size-cells = <0>;
-				interrupt-map = </*Status*/ 0 &UIC0 19 4
-						/*Wake*/  1 &UIC1 1f 4>;
-				reg = <ef600f00 70>;
+				interrupt-map = </*Status*/ 0x0 &UIC0 0x19 0x4
+						/*Wake*/  0x1 &UIC1 0x1f 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 				rgmii-device = <&RGMII0>;
@@ -334,10 +336,10 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440epx-pci", "ibm,plb-pci";
 			primary;
-			reg = <1 eec00000 8	/* Config space access */
-			       1 eed00000 4	/* IACK */
-			       1 eed00000 4	/* Special cycle */
-			       1 ef400000 40>;	/* Internal registers */
+			reg = <0x00000001 0xeec00000 0x00000008	/* Config space access */
+			       0x00000001 0xeed00000 0x00000004	/* IACK */
+			       0x00000001 0xeed00000 0x00000004	/* Special cycle */
+			       0x00000001 0xef400000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
@@ -347,16 +349,16 @@
 			 * I/O              1 E800 0000     1 E800 FFFF     64KB
 			 * I/O              1 E880 0000     1 EBFF FFFF     56MB
 			 */
-			ranges = <02000000 0 80000000 1 80000000 0 40000000
-				01000000 0 00000000 1 e8000000 0 00010000
-				01000000 0 00000000 1 e8800000 0 03800000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000001 0x80000000 0x00000000 0x40000000
+				0x01000000 0x00000000 0x00000000 0x00000001 0xe8000000 0x00000000 0x00010000
+				0x01000000 0x00000000 0x00000000 0x00000001 0xe8800000 0x00000000 0x03800000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* All PCI interrupts are routed to IRQ 67 */
-			interrupt-map-mask = <0000 0 0 0>;
-			interrupt-map = < 0000 0 0 0 &UIC2 3 8 >;
+			interrupt-map-mask = <0x0 0x0 0x0 0x0>;
+			interrupt-map = < 0x0 0x0 0x0 0x0 &UIC2 0x3 0x8 >;
 		};
 	};
 
Index: working-2.6/arch/powerpc/boot/dts/taishan.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/taishan.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/taishan.dts	2008-05-15 16:32:08.000000000 +1000
@@ -10,12 +10,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,taishan";
 	compatible = "amcc,taishan";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC2;
@@ -31,13 +33,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440GX";
-			reg = <0>;
-			clock-frequency = <2FAF0800>; // 800MHz
+			reg = <0x00000000>;
+			clock-frequency = <800000000>; // 800MHz
 			timebase-frequency = <0>; // Filled in by zImage
-			i-cache-line-size = <32>;
-			d-cache-line-size = <32>;
-			i-cache-size = <8000>; /* 32 kB */
-			d-cache-size = <8000>; /* 32 kB */
+			i-cache-line-size = <50>;
+			d-cache-line-size = <50>;
+			i-cache-size = <32768>; /* 32 kB */
+			d-cache-size = <32768>; /* 32 kB */
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -45,7 +47,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; // Filled in by zImage
+		reg = <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
 	};
 
 
@@ -53,7 +55,7 @@
 		compatible = "ibm,uic-440gx", "ibm,uic";
 		interrupt-controller;
 		cell-index = <3>;
-		dcr-reg = <200 009>;
+		dcr-reg = <0x200 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -64,11 +66,11 @@
 		compatible = "ibm,uic-440gx", "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <01 4 00 4>; /* cascade - first non-critical */
+		interrupts = <0x1 0x4 0x0 0x4>; /* cascade - first non-critical */
 		interrupt-parent = <&UICB0>;
 
 	};
@@ -77,11 +79,11 @@
 		compatible = "ibm,uic-440gx", "ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <03 4 02 4>; /* cascade */
+		interrupts = <0x3 0x4 0x2 0x4>; /* cascade */
 		interrupt-parent = <&UICB0>;
 	};
 
@@ -89,29 +91,29 @@
 		compatible = "ibm,uic-440gx", "ibm,uic";
 		interrupt-controller;
 		cell-index = <2>; /* was 1 */
-		dcr-reg = <210 009>;
+		dcr-reg = <0x210 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <05 4 04 4>; /* cascade */
+		interrupts = <0x5 0x4 0x4 0x4>; /* cascade */
 		interrupt-parent = <&UICB0>;
 	};
 
 
 	CPC0: cpc {
 		compatible = "ibm,cpc-440gp";
-		dcr-reg = <0b0 003 0e0 010>;
+		dcr-reg = <0x0b0 0x003 0x0e0 0x010>;
 		// FIXME: anything else?
 	};
 
 	L2C0: l2c {
 		compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
-		dcr-reg = <20 8			/* Internal SRAM DCR's */
-			   30 8>;		/* L2 cache DCR's */
-		cache-line-size = <20>;		/* 32 bytes */
-		cache-size = <40000>;		/* L2, 256K */
+		dcr-reg = <0x020 0x008			/* Internal SRAM DCR's */
+			   0x030 0x008>;		/* L2 cache DCR's */
+		cache-line-size = <32>;		/* 32 bytes */
+		cache-size = <262144>;		/* L2, 256K */
 		interrupt-parent = <&UIC2>;
-		interrupts = <17 1>;
+		interrupts = <0x17 0x1>;
 	};
 
 	plb {
@@ -119,41 +121,41 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		ranges;
-		clock-frequency = <9896800>; // 160MHz
+		clock-frequency = <160000000>; // 160MHz
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-440gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 			// FIXME: anything else?
 		};
 
 		SRAM0: sram {
 			compatible = "ibm,sram-440gp";
-			dcr-reg = <020 8 00a 1>;
+			dcr-reg = <0x020 0x008 0x00a 0x001>;
 		};
 
 		DMA0: dma {
 			// FIXME: ???
 			compatible = "ibm,dma-440gp";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440gx", "ibm,mcmal2";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
 			num-rx-chans = <4>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					 /*RXEOB*/ 1 &UIC0 b 4
-					 /*SERR*/  2 &UIC1 0 4
-					 /*TXDE*/  3 &UIC1 1 4
-					 /*RXDE*/  4 &UIC1 2 4>;
-			interrupt-map-mask = <ffffffff>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					 /*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					 /*SERR*/  0x2 &UIC1 0x0 0x4
+					 /*TXDE*/  0x3 &UIC1 0x1 0x4
+					 /*RXDE*/  0x4 &UIC1 0x2 0x4>;
+			interrupt-map-mask = <0xffffffff>;
 		};
 
 		POB0: opb {
@@ -162,26 +164,26 @@
 			#size-cells = <1>;
 			/* Wish there was a nicer way of specifying a full 32-bit
 			   range */
-			ranges = <00000000 1 00000000 80000000
-				  80000000 1 80000000 80000000>;
-			dcr-reg = <090 00b>;
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			dcr-reg = <0x090 0x00b>;
 			interrupt-parent = <&UIC1>;
-			interrupts = <7 4>;
-			clock-frequency = <4C4B400>; // 80MHz
+			interrupts = <0x7 0x4>;
+			clock-frequency = <80000000>; // 80MHz
 
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440gx", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
-				clock-frequency = <4C4B400>; // 80MHz
+				clock-frequency = <80000000>; // 80MHz
 
 				/* ranges property is supplied by zImage
 				 * based on firmware's configuration of the
 				 * EBC bridge */
 
-				interrupts = <5 4>;
+				interrupts = <0x5 0x4>;
 				interrupt-parent = <&UIC1>;
 
 				/* TODO: Add other EBC devices */
@@ -192,103 +194,103 @@
 			UART0: serial@40000200 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <40000200 8>;
-				virtual-reg = <e0000200>;
- 				clock-frequency = <A8C000>;
-				current-speed = <1C200>; /* 115200 */
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+ 				clock-frequency = <11059200>;
+				current-speed = <115200>; /* 115200 */
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@40000300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <40000300 8>;
-				virtual-reg = <e0000300>;
-				clock-frequency = <A8C000>;
-				current-speed = <1C200>; /* 115200 */
+				reg = <0x40000300 0x00000008>;
+				virtual-reg = <0xe0000300>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>; /* 115200 */
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC0: i2c@40000400 {
 				/* FIXME */
 				compatible = "ibm,iic-440gp", "ibm,iic";
-				reg = <40000400 14>;
+				reg = <0x40000400 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 			IIC1: i2c@40000500 {
 				/* FIXME */
 				compatible = "ibm,iic-440gp", "ibm,iic";
-				reg = <40000500 14>;
+				reg = <0x40000500 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 			};
 
 			GPIO0: gpio@40000700 {
 				/* FIXME */
 				compatible = "ibm,gpio-440gp";
-				reg = <40000700 20>;
+				reg = <0x40000700 0x00000020>;
 			};
 
 			ZMII0: emac-zmii@40000780 {
 				compatible = "ibm,zmii-440gx", "ibm,zmii";
-				reg = <40000780 c>;
+				reg = <0x40000780 0x0000000c>;
 			};
 
 			RGMII0: emac-rgmii@40000790 {
 				compatible = "ibm,rgmii";
-				reg = <40000790 8>;
+				reg = <0x40000790 0x00000008>;
 			};
 
 			TAH0: emac-tah@40000b50 {
 				compatible = "ibm,tah-440gx", "ibm,tah";
-				reg = <40000b50 30>;
+				reg = <0x40000b50 0x00000030>;
 			};
 
 			TAH1: emac-tah@40000d50 {
 				compatible = "ibm,tah-440gx", "ibm,tah";
-				reg = <40000d50 30>;
+				reg = <0x40000d50 0x00000030>;
 			};
 
 			EMAC0: ethernet@40000800 {
-				unused = <1>;
+				unused = <0x1>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <40000800 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0x40000800 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
 		 	EMAC1: ethernet@40000900 {
-				unused = <1>;
+				unused = <0x1>;
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4 1f 4>;
-				reg = <40000900 70>;
+				interrupts = <0x1e 0x4 0x1f 0x4>;
+				reg = <0x40000900 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
  				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
@@ -297,18 +299,18 @@
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
-				interrupts = <0 4 1 4>;
-				reg = <40000c00 70>;
+				interrupts = <0x0 0x4 0x1 0x4>;
+				reg = <0x40000c00 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2>;
 				mal-rx-channel = <2>;
 				cell-index = <2>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <0>;
  				zmii-device = <&ZMII0>;
@@ -321,18 +323,18 @@
 				device_type = "network";
 				compatible = "ibm,emac-440gx", "ibm,emac4";
 				interrupt-parent = <&UIC2>;
-				interrupts = <2 4 3 4>;
-				reg = <40000e00 70>;
+				interrupts = <0x2 0x4 0x3 0x4>;
+				reg = <0x40000e00 0x00000070>;
 				local-mac-address = [000000000000]; // Filled in by zImage
 				mal-device = <&MAL0>;
 				mal-tx-channel = <3>;
 				mal-rx-channel = <3>;
 				cell-index = <3>;
-				max-frame-size = <2328>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <9000>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rgmii";
-				phy-map = <00000003>;
+				phy-map = <0x00000003>;
 				rgmii-device = <&RGMII0>;
 				rgmii-channel = <1>;
  				zmii-device = <&ZMII0>;
@@ -344,9 +346,9 @@
 
 			GPT0: gpt@40000a00 {
 				/* FIXME */
-				reg = <40000a00 d4>;
+				reg = <0x40000a00 0x000000d4>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <12 4 13 4 14 4 15 4 16 4>;
+				interrupts = <0x12 0x4 0x13 0x4 0x14 0x4 0x15 0x4 0x16 0x4>;
 			};
 
 		};
@@ -360,34 +362,34 @@
 			primary;
 			large-inbound-windows;
 			enable-msi-hole;
-			reg = <2 0ec00000   8	/* Config space access */
-			       0 0 0		/* no IACK cycles */
-			       2 0ed00000   4   /* Special cycles */
-			       2 0ec80000 100	/* Internal registers */
-			       2 0ec80100  fc>;	/* Internal messaging registers */
+			reg = <0x00000002 0x0ec00000   0x00000008	/* Config space access */
+			       0x00000000 0x00000000 0x00000000		/* no IACK cycles */
+			       0x00000002 0x0ed00000   0x00000004   /* Special cycles */
+			       0x00000002 0x0ec80000 0x00000100	/* Internal registers */
+			       0x00000002 0x0ec80100  0x000000fc>;	/* Internal messaging registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed
 			 */
-			ranges = <02000000 0 80000000 00000003 80000000 0 80000000
-				  01000000 0 00000000 00000002 08000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000003 0x80000000 0x00000000 0x80000000
+				  0x01000000 0x00000000 0x00000000 0x00000002 0x08000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
-			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 1 &UIC0 17 8
-				0800 0 0 2 &UIC0 18 8
-				0800 0 0 3 &UIC0 19 8
-				0800 0 0 4 &UIC0 1a 8
+				0x800 0x0 0x0 0x1 &UIC0 0x17 0x8
+				0x800 0x0 0x0 0x2 &UIC0 0x18 0x8
+				0x800 0x0 0x0 0x3 &UIC0 0x19 0x8
+				0x800 0x0 0x0 0x4 &UIC0 0x1a 0x8
 
 				/* IDSEL 2 */
-				1000 0 0 1 &UIC0 18 8
-				1000 0 0 2 &UIC0 19 8
-				1000 0 0 3 &UIC0 1a 8
-				1000 0 0 4 &UIC0 17 8
+				0x1000 0x0 0x0 0x1 &UIC0 0x18 0x8
+				0x1000 0x0 0x0 0x2 &UIC0 0x19 0x8
+				0x1000 0x0 0x0 0x3 &UIC0 0x1a 0x8
+				0x1000 0x0 0x0 0x4 &UIC0 0x17 0x8
 			>;
 		};
 	};
Index: working-2.6/arch/powerpc/boot/dts/walnut.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/walnut.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/walnut.dts	2008-05-15 16:32:08.000000000 +1000
@@ -9,12 +9,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <1>;
 	#size-cells = <1>;
 	model = "ibm,walnut";
 	compatible = "ibm,walnut";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC;
@@ -29,13 +31,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,405GP";
-			reg = <0>;
-			clock-frequency = <bebc200>; /* Filled in by zImage */
+			reg = <0x00000000>;
+			clock-frequency = <200000000>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <4000>;
-			d-cache-size = <4000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <16384>;
+			d-cache-size = <16384>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -43,14 +45,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller {
 		compatible = "ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 9>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -65,63 +67,63 @@
 
 		SDRAM0: memory-controller {
 			compatible = "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		MAL: mcmal {
 			compatible = "ibm,mcmal-405gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <1>;
 			num-rx-chans = <1>;
 			interrupt-parent = <&UIC0>;
 			interrupts = <
-				b 4 /* TXEOB */
-				c 4 /* RXEOB */
-				a 4 /* SERR */
-				d 4 /* TXDE */
-				e 4 /* RXDE */>;
+				0xb 0x4 /* TXEOB */
+				0xc 0x4 /* RXEOB */
+				0xa 0x4 /* SERR */
+				0xd 0x4 /* TXDE */
+				0xe 0x4 /* RXDE */>;
 		};
 
 		POB0: opb {
 			compatible = "ibm,opb-405gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <ef600000 ef600000 a00000>;
-			dcr-reg = <0a0 5>;
+			ranges = <0xef600000 0xef600000 0x00a00000>;
+			dcr-reg = <0x0a0 0x005>;
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <2580>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@ef600400 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600400 8>;
-				virtual-reg = <ef600400>;
+				reg = <0xef600400 0x00000008>;
+				virtual-reg = <0xef600400>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <2580>;
+				current-speed = <9600>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			IIC: i2c@ef600500 {
 				compatible = "ibm,iic-405gp", "ibm,iic";
-				reg = <ef600500 11>;
+				reg = <0xef600500 0x00000011>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			GPIO: gpio@ef600700 {
 				compatible = "ibm,gpio-405gp";
-				reg = <ef600700 20>;
+				reg = <0xef600700 0x00000020>;
 			};
 
 			EMAC: ethernet@ef600800 {
@@ -129,26 +131,26 @@
 				compatible = "ibm,emac-405gp", "ibm,emac";
 				interrupt-parent = <&UIC0>;
 				interrupts = <
-					f 4 /* Ethernet */
-					9 4 /* Ethernet Wake Up */>;
+					0xf 0x4 /* Ethernet */
+					0x9 0x4 /* Ethernet Wake Up */>;
 				local-mac-address = [000000000000]; /* Filled in by zImage */
-				reg = <ef600800 70>;
+				reg = <0xef600800 0x00000070>;
 				mal-device = <&MAL>;
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000001>;
+				phy-map = <0x00000001>;
 			};
 
 		};
 
 		EBC0: ebc {
 			compatible = "ibm,ebc-405gp", "ibm,ebc";
-			dcr-reg = <012 2>;
+			dcr-reg = <0x012 0x002>;
 			#address-cells = <2>;
 			#size-cells = <1>;
 			/* The ranges property is supplied by the bootwrapper
@@ -158,18 +160,18 @@
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			sram@0,0 {
-				reg = <0 0 80000>;
+				reg = <0x00000000 0x00000000 0x00080000>;
 			};
 
 			flash@0,80000 {
 				compatible = "jedec-flash";
 				bank-width = <1>;
-				reg = <0 80000 80000>;
+				reg = <0x00000000 0x00080000 0x00080000>;
 				#address-cells = <1>;
 				#size-cells = <1>;
 				partition@0 {
 					label = "OpenBIOS";
-					reg = <0 80000>;
+					reg = <0x00000000 0x00080000>;
 					read-only;
 				};
 			};
@@ -177,24 +179,24 @@
 			nvram@1,0 {
 				/* NVRAM and RTC */
 				compatible = "ds1743-nvram";
-				#bytes = <2000>;
-				reg = <1 0 2000>;
+				#bytes = <0x2000>;
+				reg = <0x00000001 0x00000000 0x00002000>;
 			};
 
 			keyboard@2,0 {
 				compatible = "intel,82C42PC";
-				reg = <2 0 2>;
+				reg = <0x00000002 0x00000000 0x00000002>;
 			};
 
 			ir@3,0 {
 				compatible = "ti,TIR2000PAG";
-				reg = <3 0 10>;
+				reg = <0x00000003 0x00000000 0x00000010>;
 			};
 
 			fpga@7,0 {
 				compatible = "Walnut-FPGA";
-				reg = <7 0 10>;
-				virtual-reg = <f0300005>;
+				reg = <0x00000007 0x00000000 0x00000010>;
+				virtual-reg = <0xf0300005>;
 			};
 		};
 
@@ -205,35 +207,35 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb405gp-pci", "ibm,plb-pci";
 			primary;
-			reg = <eec00000 8	/* Config space access */
-			       eed80000 4	/* IACK */
-			       eed80000 4	/* Special cycle */
-			       ef480000 40>;	/* Internal registers */
+			reg = <0xeec00000 0x00000008	/* Config space access */
+			       0xeed80000 0x00000004	/* IACK */
+			       0xeed80000 0x00000004	/* Special cycle */
+			       0xef480000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 80000000 80000000 0 20000000
-				  01000000 0 00000000 e8000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0x80000000 0x80000000 0x00000000 0x20000000
+				  0x01000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* Walnut has all 4 IRQ pins tied together per slot */
-			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 0 &UIC0 1c 8
+				0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
 
 				/* IDSEL 2 */
-				1000 0 0 0 &UIC0 1d 8
+				0x1000 0x0 0x0 0x0 &UIC0 0x1d 0x8
 
 				/* IDSEL 3 */
-				1800 0 0 0 &UIC0 1e 8
+				0x1800 0x0 0x0 0x0 &UIC0 0x1e 0x8
 
 				/* IDSEL 4 */
-				2000 0 0 0 &UIC0 1f 8
+				0x2000 0x0 0x0 0x0 &UIC0 0x1f 0x8
 			>;
 		};
 	};
Index: working-2.6/arch/powerpc/boot/dts/warp.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/warp.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/warp.dts	2008-05-15 16:32:08.000000000 +1000
@@ -9,12 +9,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "pika,warp";
 	compatible = "pika,warp";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -28,13 +30,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440EP";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -42,14 +44,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -59,22 +61,22 @@
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -86,86 +88,86 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		DMA0: dma {
 			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
 		};
 
 		POB0: opb {
 		  	compatible = "ibm,opb-440ep", "ibm,opb-440gp", "ibm,opb";
 			#address-cells = <1>;
 			#size-cells = <1>;
-		  	ranges = <00000000 0 00000000 80000000
-			          80000000 0 80000000 80000000>;
+		  	ranges = <0x00000000 0x00000000 0x00000000 0x80000000
+			          0x80000000 0x00000000 0x80000000 0x80000000>;
 		  	interrupt-parent = <&UIC1>;
-		  	interrupts = <7 4>;
+		  	interrupts = <0x7 0x4>;
 		  	clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 
 				fpga@2,0 {
 					compatible = "pika,fpga";
-			   		reg = <2 0 2200>;
-					interrupts = <18 8>;
+			   		reg = <0x00000002 0x00000000 0x00002200>;
+					interrupts = <0x18 0x8>;
 					interrupt-parent = <&UIC0>;
 				};
 
 				nor_flash@0,0 {
 					compatible = "amd,s29gl512n", "cfi-flash";
 					bank-width = <2>;
-					reg = <0 0 4000000>;
+					reg = <0x00000000 0x00000000 0x04000000>;
 					#address-cells = <1>;
 					#size-cells = <1>;
 					partition@0 {
 						label = "kernel";
-						reg = <0 180000>;
+						reg = <0x00000000 0x00180000>;
 					};
 					partition@180000 {
 						label = "root";
-						reg = <180000 3480000>;
+						reg = <0x00180000 0x03480000>;
 					};
 					partition@3600000 {
 						label = "user";
-						reg = <3600000 900000>;
+						reg = <0x03600000 0x00900000>;
 					};
 					partition@3f00000 {
 						label = "fpga";
-						reg = <3f00000 40000>;
+						reg = <0x03f00000 0x00040000>;
 					};
 					partition@3f40000 {
 						label = "env";
-						reg = <3f40000 40000>;
+						reg = <0x03f40000 0x00040000>;
 					};
 					partition@3f80000 {
 						label = "u-boot";
-						reg = <3f80000 80000>;
+						reg = <0x03f80000 0x00080000>;
 					};
 				};
 			};
@@ -173,60 +175,60 @@
 			UART0: serial@ef600300 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600300 8>;
-		   		virtual-reg = <ef600300>;
+		   		reg = <0xef600300 0x00000008>;
+		   		virtual-reg = <0xef600300>;
 		   		clock-frequency = <0>; /* Filled in by zImage */
-		   		current-speed = <1c200>;
+		   		current-speed = <115200>;
 		   		interrupt-parent = <&UIC0>;
-		   		interrupts = <0 4>;
+		   		interrupts = <0x0 0x4>;
 	   		};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			GPIO0: gpio@ef600b00 {
 				compatible = "ibm,gpio-440ep";
-				reg = <ef600b00 48>;
+				reg = <0xef600b00 0x00000048>;
 			};
 
 			GPIO1: gpio@ef600c00 {
 				compatible = "ibm,gpio-440ep";
-				reg = <ef600c00 48>;
+				reg = <0xef600c00 0x00000048>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <ef600e00 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0 1>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
 
 			usb@ef601000 {
 				compatible = "ohci-be";
-				reg = <ef601000 80>;
-				interrupts = <8 1 9 1>;
+				reg = <0xef601000 0x00000080>;
+				interrupts = <0x8 0x1 0x9 0x1>;
 				interrupt-parent = < &UIC1 >;
 			};
 		};
Index: working-2.6/arch/powerpc/boot/dts/yosemite.dts
===================================================================
--- working-2.6.orig/arch/powerpc/boot/dts/yosemite.dts	2008-05-15 16:32:08.000000000 +1000
+++ working-2.6/arch/powerpc/boot/dts/yosemite.dts	2008-05-15 16:32:08.000000000 +1000
@@ -9,12 +9,14 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "amcc,yosemite";
 	compatible = "amcc,yosemite","amcc,bamboo";
-	dcr-parent = <&/cpus/cpu@0>;
+	dcr-parent = <&{/cpus/cpu@0}>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -32,13 +34,13 @@
 		cpu@0 {
 			device_type = "cpu";
 			model = "PowerPC,440EP";
-			reg = <0>;
+			reg = <0x00000000>;
 			clock-frequency = <0>; /* Filled in by zImage */
 			timebase-frequency = <0>; /* Filled in by zImage */
-			i-cache-line-size = <20>;
-			d-cache-line-size = <20>;
-			i-cache-size = <8000>;
-			d-cache-size = <8000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
 			dcr-controller;
 			dcr-access-method = "native";
 		};
@@ -46,14 +48,14 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0 0 0>; /* Filled in by zImage */
+		reg = <0x00000000 0x00000000 0x00000000>; /* Filled in by zImage */
 	};
 
 	UIC0: interrupt-controller0 {
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -63,22 +65,22 @@
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 0x009>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 0x002>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 0x002>;
 	};
 
 	plb {
@@ -90,29 +92,29 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 0x002>;
 		};
 
 		DMA0: dma {
 			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
-			dcr-reg = <100 027>;
+			dcr-reg = <0x100 0x027>;
 		};
 
 		MAL0: mcmal {
 			compatible = "ibm,mcmal-440ep", "ibm,mcmal-440gp", "ibm,mcmal";
-			dcr-reg = <180 62>;
+			dcr-reg = <0x180 0x062>;
 			num-tx-chans = <4>;
 			num-rx-chans = <2>;
 			interrupt-parent = <&MAL0>;
-			interrupts = <0 1 2 3 4>;
+			interrupts = <0x0 0x1 0x2 0x3 0x4>;
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
-					/*SERR*/  2 &UIC1 0 4
-					/*TXDE*/  3 &UIC1 1 4
-					/*RXDE*/  4 &UIC1 2 4>;
+			interrupt-map = </*TXEOB*/ 0x0 &UIC0 0xa 0x4
+					/*RXEOB*/ 0x1 &UIC0 0xb 0x4
+					/*SERR*/  0x2 &UIC1 0x0 0x4
+					/*TXDE*/  0x3 &UIC1 0x1 0x4
+					/*RXDE*/  0x4 &UIC1 0x2 0x4>;
 		};
 
 		POB0: opb {
@@ -122,110 +124,110 @@
 			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
 			 * bits.
 			 */
-			ranges = <00000000 0 00000000 80000000
-			          80000000 0 80000000 80000000>;
+			ranges = <0x00000000 0x00000000 0x00000000 0x80000000
+			          0x80000000 0x00000000 0x80000000 0x80000000>;
 			interrupt-parent = <&UIC1>;
-			interrupts = <7 4>;
+			interrupts = <0x7 0x4>;
 			clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 0x002>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				interrupts = <5 1>;
+				interrupts = <0x5 0x1>;
 				interrupt-parent = <&UIC1>;
 			};
 
 			UART0: serial@ef600300 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600300 8>;
-				virtual-reg = <ef600300>;
+				reg = <0xef600300 0x00000008>;
+				virtual-reg = <0xef600300>;
 				clock-frequency = <0>; /* Filled in by zImage */
-				current-speed = <1c200>;
+				current-speed = <115200>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <0 4>;
+				interrupts = <0x0 0x4>;
 			};
 
 			UART1: serial@ef600400 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600400 8>;
-				virtual-reg = <ef600400>;
+				reg = <0xef600400 0x00000008>;
+				virtual-reg = <0xef600400>;
 				clock-frequency = <0>;
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <1 4>;
+				interrupts = <0x1 0x4>;
 			};
 
 			UART2: serial@ef600500 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600500 8>;
-				virtual-reg = <ef600500>;
+				reg = <0xef600500 0x00000008>;
+				virtual-reg = <0xef600500>;
 				clock-frequency = <0>;
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <3 4>;
+				interrupts = <0x3 0x4>;
 				status = "disabled";
 			};
 
 			UART3: serial@ef600600 {
 				device_type = "serial";
 				compatible = "ns16550";
-				reg = <ef600600 8>;
-				virtual-reg = <ef600600>;
+				reg = <0xef600600 0x00000008>;
+				virtual-reg = <0xef600600>;
 				clock-frequency = <0>;
 				current-speed = <0>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <4 4>;
+				interrupts = <0x4 0x4>;
 				status = "disabled";
 			};
 
 			IIC0: i2c@ef600700 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <2 4>;
+				interrupts = <0x2 0x4>;
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x00000014>;
 				interrupt-parent = <&UIC0>;
-				interrupts = <7 4>;
+				interrupts = <0x7 0x4>;
 			};
 
 			spi@ef600900 {
 				compatible = "amcc,spi-440ep";
-				reg = <ef600900 6>;
-				interrupts = <8 4>;
+				reg = <0xef600900 0x00000006>;
+				interrupts = <0x8 0x4>;
 				interrupt-parent = <&UIC0>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0x0000000c>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <ef600e00 70>;
+				interrupts = <0x1c 0x4 0x1d 0x4>;
+				reg = <0xef600e00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0 1>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <0>;
 			};
@@ -234,26 +236,26 @@
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4 1f 4>;
-				reg = <ef600f00 70>;
+				interrupts = <0x1e 0x4 0x1f 0x4>;
+				reg = <0xef600f00 0x00000070>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2 3>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <1500>;
+				rx-fifo-size = <4096>;
+				tx-fifo-size = <2048>;
 				phy-mode = "rmii";
-				phy-map = <00000000>;
+				phy-map = <0x00000000>;
 				zmii-device = <&ZMII0>;
 				zmii-channel = <1>;
 			};
 
 			usb@ef601000 {
 				compatible = "ohci-be";
-				reg = <ef601000 80>;
-				interrupts = <8 4 9 4>;
+				reg = <0xef601000 0x00000080>;
+				interrupts = <0x8 0x4 0x9 0x4>;
 				interrupt-parent = < &UIC1 >;
 			};
 		};
@@ -265,35 +267,35 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
 			primary;
-			reg = <0 eec00000 8	/* Config space access */
-			       0 eed00000 4	/* IACK */
-			       0 eed00000 4	/* Special cycle */
-			       0 ef400000 40>;	/* Internal registers */
+			reg = <0x00000000 0xeec00000 0x00000008	/* Config space access */
+			       0x00000000 0xeed00000 0x00000004	/* IACK */
+			       0x00000000 0xeed00000 0x00000004	/* Special cycle */
+			       0x00000000 0xef400000 0x00000040>;	/* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
-				  01000000 0 00000000 0 e8000000 0 00010000>;
+			ranges = <0x02000000 0x00000000 0xa0000000 0x00000000 0xa0000000 0x00000000 0x20000000
+				  0x01000000 0x00000000 0x00000000 0x00000000 0xe8000000 0x00000000 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
 
 			/* Bamboo has all 4 IRQ pins tied together per slot */
-			interrupt-map-mask = <f800 0 0 0>;
+			interrupt-map-mask = <0xf800 0x0 0x0 0x0>;
 			interrupt-map = <
 				/* IDSEL 1 */
-				0800 0 0 0 &UIC0 1c 8
+				0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
 
 				/* IDSEL 2 */
-				1000 0 0 0 &UIC0 1b 8
+				0x1000 0x0 0x0 0x0 &UIC0 0x1b 0x8
 
 				/* IDSEL 3 */
-				1800 0 0 0 &UIC0 1a 8
+				0x1800 0x0 0x0 0x0 &UIC0 0x1a 0x8
 
 				/* IDSEL 4 */
-				2000 0 0 0 &UIC0 19 8
+				0x2000 0x0 0x0 0x0 &UIC0 0x19 0x8
 			>;
 		};
 	};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
