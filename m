Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6621ADDE35
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 08:24:58 +1000 (EST)
Date: Tue, 15 May 2007 17:20:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0705151715200.17092@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

These are fixes/cleanups intended for 2.6.22.

to receive the following updates:

 arch/powerpc/boot/dts/kuroboxHD.dts   |   44 +++++++------------
 arch/powerpc/boot/dts/kuroboxHG.dts   |   45 +++++++------------
 arch/powerpc/boot/dts/lite5200.dts    |   69 +++++++++++++++---------------
 arch/powerpc/boot/dts/lite5200b.dts   |   77 ++++++++++++++++------------------
 arch/powerpc/boot/dts/mpc7448hpc2.dts |   72 ++++++++++++++-----------------
 arch/powerpc/boot/dts/mpc8540ads.dts  |   16 +++++++
 arch/powerpc/boot/dts/mpc8541cds.dts  |   16 +++++++
 arch/powerpc/boot/dts/mpc8544ds.dts   |   16 +++++++
 arch/powerpc/boot/dts/mpc8548cds.dts  |   16 +++++++
 arch/powerpc/boot/dts/mpc8555cds.dts  |   16 +++++++
 arch/powerpc/boot/dts/mpc8560ads.dts  |   18 +++++++
 arch/powerpc/boot/dts/mpc8568mds.dts  |   16 +++++++
 arch/powerpc/kernel/cputable.c        |    2
 arch/powerpc/kernel/entry_32.S        |   18 ++++++-
 arch/powerpc/lib/rheap.c              |   22 +++------
 arch/powerpc/mm/hash_low_32.S         |   18 ++++++-
 arch/ppc/kernel/entry.S               |   18 ++++++-
 arch/ppc/mm/hashtable.S               |   18 ++++++-
 arch/ppc/syslib/pq2_sys.c             |   36 ++++++++-------
 drivers/char/watchdog/booke_wdt.c     |    2
 include/asm-powerpc/cputable.h        |    6 ++
 include/asm-powerpc/mpc8260.h         |    6 +-
 include/asm-powerpc/pmac_feature.h    |    6 +-
 include/asm-powerpc/tsi108_irq.h      |    6 +-
 include/asm-powerpc/tsi108_pci.h      |    6 +-
 include/asm-powerpc/unistd.h          |    6 +-
 26 files changed, 361 insertions(+), 230 deletions(-)

Becky Bruce (1):
      [POWERPC] Change include protections to ASM_POWERPC

Dave Jiang (2):
      [POWERPC] Fix comment in booke_wdt
      [POWERPC] 85xx: Add device nodes for error reporting devices used by EDAC

James.Yang (1):
      [POWERPC] Remove CPU_FTR_NEED_COHERENT for 7448.

Kumar Gala (4):
      [POWERPC] Fix COMMON symbol warnings
      [PPC] Fix COMMON symbol warnings
      [POWERPC] 85xx: Add device nodes for error reporting devices used by EDAC
      [POWERPC] Removed hardcoded phandles from dts

Morten Banzon (1):
      [PPC] MCC2 missing in MPC826x device_list

Timur Tabi (1):
      [POWERPC] Fix alignment problem in rh_alloc_align() with exact-sized blocks

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 157dc98..a983680 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -21,19 +21,16 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
  */

 / {
-	linux,phandle = <1000>;
 	model = "KuroboxHD";
 	compatible = "linkstation";
 	#address-cells = <1>;
 	#size-cells = <1>;

 	cpus {
-		linux,phandle = <2000>;
 		#address-cells = <1>;
 		#size-cells = <0>;

 		PowerPC,603e { /* Really 8241 */
-			linux,phandle = <2100>;
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <bebc200>;	/* Fixed by bootwrapper */
@@ -48,13 +45,11 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 	};

 	memory {
-		linux,phandle = <3000>;
 		device_type = "memory";
 		reg = <00000000 04000000>;
 	};

 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
-		linux,phandle = <4000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
@@ -69,38 +64,34 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			  fef00000 fef00000 00100000>;	/* pci iack */

 		i2c@80003000 {
-			linux,phandle = <4300>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

 		serial@80004500 {
-			linux,phandle = <4511>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004500 8>;
 			clock-frequency = <5d08d88>;
 			current-speed = <2580>;
 			interrupts = <9 2>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

 		serial@80004600 {
-			linux,phandle = <4512>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004600 8>;
 			clock-frequency = <5d08d88>;
 			current-speed = <e100>;
 			interrupts = <a 0>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

-		pic@80040000 {
-			linux,phandle = <4400>;
+		mpic: pic@80040000 {
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			device_type = "open-pic";
@@ -111,7 +102,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 		};

 		pci@fec00000 {
-			linux,phandle = <4500>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
@@ -122,24 +112,24 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 				  02000000 0 80000000 80000000 0 70000000>;
 			bus-range = <0 ff>;
 			clock-frequency = <7f28155>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 11 - IRQ0 ETH */
-				5800 0 0 1 4400 0 1
-				5800 0 0 2 4400 1 1
-				5800 0 0 3 4400 2 1
-				5800 0 0 4 4400 3 1
+				5800 0 0 1 &mpic 0 1
+				5800 0 0 2 &mpic 1 1
+				5800 0 0 3 &mpic 2 1
+				5800 0 0 4 &mpic 3 1
 				/* IDSEL 12 - IRQ1 IDE0 */
-				6000 0 0 1 4400 1 1
-				6000 0 0 2 4400 2 1
-				6000 0 0 3 4400 3 1
-				6000 0 0 4 4400 0 1
+				6000 0 0 1 &mpic 1 1
+				6000 0 0 2 &mpic 2 1
+				6000 0 0 3 &mpic 3 1
+				6000 0 0 4 &mpic 0 1
 				/* IDSEL 14 - IRQ3 USB2.0 */
-				7000 0 0 1 4400 3 1
-				7000 0 0 2 4400 3 1
-				7000 0 0 3 4400 3 1
-				7000 0 0 4 4400 3 1
+				7000 0 0 1 &mpic 3 1
+				7000 0 0 2 &mpic 3 1
+				7000 0 0 3 &mpic 3 1
+				7000 0 0 4 &mpic 3 1
 			>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 919eb29..5cf42dc 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -21,19 +21,16 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
  */

 / {
-	linux,phandle = <1000>;
 	model = "KuroboxHG";
 	compatible = "linkstation";
 	#address-cells = <1>;
 	#size-cells = <1>;

 	cpus {
-		linux,phandle = <2000>;
 		#address-cells = <1>;
 		#size-cells = <0>;

 		PowerPC,603e { /* Really 8241 */
-			linux,phandle = <2100>;
 			device_type = "cpu";
 			reg = <0>;
 			clock-frequency = <fdad680>;	/* Fixed by bootwrapper */
@@ -48,13 +45,11 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 	};

 	memory {
-		linux,phandle = <3000>;
 		device_type = "memory";
 		reg = <00000000 08000000>;
 	};

 	soc10x { /* AFAICT need to make soc for 8245's uarts to be defined */
-		linux,phandle = <4000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
@@ -69,38 +64,35 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			  fef00000 fef00000 00100000>;	/* pci iack */

 		i2c@80003000 {
-			linux,phandle = <4300>;
 			device_type = "i2c";
 			compatible = "fsl-i2c";
 			reg = <80003000 1000>;
 			interrupts = <5 2>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

 		serial@80004500 {
-			linux,phandle = <4511>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004500 8>;
 			clock-frequency = <7c044a8>;
 			current-speed = <2580>;
 			interrupts = <9 2>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

 		serial@80004600 {
-			linux,phandle = <4512>;
 			device_type = "serial";
 			compatible = "ns16550";
 			reg = <80004600 8>;
 			clock-frequency = <7c044a8>;
 			current-speed = <e100>;
 			interrupts = <a 0>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 		};

-		pic@80040000 {
-			linux,phandle = <4400>;
+		mpic: pic@80040000 {
+			interrupt-parent = <&mpic>;
 			#interrupt-cells = <2>;
 			#address-cells = <0>;
 			device_type = "open-pic";
@@ -111,7 +103,6 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 		};

 		pci@fec00000 {
-			linux,phandle = <4500>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
@@ -122,24 +113,24 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 				  02000000 0 80000000 80000000 0 70000000>;
 			bus-range = <0 ff>;
 			clock-frequency = <7f28155>;
-			interrupt-parent = <4400>;
+			interrupt-parent = <&mpic>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 				/* IDSEL 11 - IRQ0 ETH */
-				5800 0 0 1 4400 0 1
-				5800 0 0 2 4400 1 1
-				5800 0 0 3 4400 2 1
-				5800 0 0 4 4400 3 1
+				5800 0 0 1 &mpic 0 1
+				5800 0 0 2 &mpic 1 1
+				5800 0 0 3 &mpic 2 1
+				5800 0 0 4 &mpic 3 1
 				/* IDSEL 12 - IRQ1 IDE0 */
-				6000 0 0 1 4400 1 1
-				6000 0 0 2 4400 2 1
-				6000 0 0 3 4400 3 1
-				6000 0 0 4 4400 0 1
+				6000 0 0 1 &mpic 1 1
+				6000 0 0 2 &mpic 2 1
+				6000 0 0 3 &mpic 3 1
+				6000 0 0 4 &mpic 0 1
 				/* IDSEL 14 - IRQ3 USB2.0 */
-				7000 0 0 1 4400 3 1
-				7000 0 0 2 4400 3 1
-				7000 0 0 3 4400 3 1
-				7000 0 0 4 4400 3 1
+				7000 0 0 1 &mpic 3 1
+				7000 0 0 2 &mpic 3 1
+				7000 0 0 3 &mpic 3 1
+				7000 0 0 4 &mpic 3 1
 			>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index e13ac6e..eae68ab 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -49,7 +49,7 @@
 	soc5200@f0000000 {
 		model = "fsl,mpc5200";
 		compatible = "mpc5200";
-		revision = ""			// from bootloader
+		revision = "";			// from bootloader
 		#interrupt-cells = <3>;
 		device_type = "soc";
 		ranges = <0 f0000000 f0010000>;
@@ -62,13 +62,12 @@
 			reg = <200 38>;
 		};

-		pic@500 {
+		mpc5200_pic: pic@500 {
 			// 5200 interrupts are encoded into two levels;
-			linux,phandle = <500>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200-pic";
+			compatible = "mpc5200_pic";
 			reg = <500 80>;
 			built-in;
 		};
@@ -79,7 +78,7 @@
 			cell-index = <0>;
 			reg = <600 10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			has-wdt;
 		};

@@ -89,7 +88,7 @@
 			cell-index = <1>;
 			reg = <610 10>;
 			interrupts = <1 a 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@620 {	// General Purpose Timer
@@ -98,7 +97,7 @@
 			cell-index = <2>;
 			reg = <620 10>;
 			interrupts = <1 b 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@630 {	// General Purpose Timer
@@ -107,7 +106,7 @@
 			cell-index = <3>;
 			reg = <630 10>;
 			interrupts = <1 c 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@640 {	// General Purpose Timer
@@ -116,7 +115,7 @@
 			cell-index = <4>;
 			reg = <640 10>;
 			interrupts = <1 d 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@650 {	// General Purpose Timer
@@ -125,7 +124,7 @@
 			cell-index = <5>;
 			reg = <650 10>;
 			interrupts = <1 e 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@660 {	// General Purpose Timer
@@ -134,7 +133,7 @@
 			cell-index = <6>;
 			reg = <660 10>;
 			interrupts = <1 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@670 {	// General Purpose Timer
@@ -143,7 +142,7 @@
 			cell-index = <7>;
 			reg = <670 10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		rtc@800 {	// Real time clock
@@ -151,7 +150,7 @@
 			device_type = "rtc";
 			reg = <800 100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		mscan@900 {
@@ -159,7 +158,7 @@
 			compatible = "mpc5200-mscan";
 			cell-index = <0>;
 			interrupts = <2 11 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			reg = <900 80>;
 		};

@@ -168,7 +167,7 @@
 			compatible = "mpc5200-mscan";
 			cell-index = <1>;
 			interrupts = <2 12 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			reg = <980 80>;
 		};

@@ -176,14 +175,14 @@
 			compatible = "mpc5200-gpio";
 			reg = <b00 40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpio-wkup@c00 {
 			compatible = "mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		pci@0d00 {
@@ -194,13 +193,13 @@
 			compatible = "mpc5200-pci";
 			reg = <d00 100>;
 			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <c000 0 0 1 500 0 0 3
-			                 c000 0 0 2 500 0 0 3
-			                 c000 0 0 3 500 0 0 3
-			                 c000 0 0 4 500 0 0 3>;
+			interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3
+			                 c000 0 0 2 &mpc5200_pic 0 0 3
+			                 c000 0 0 3 &mpc5200_pic 0 0 3
+			                 c000 0 0 4 &mpc5200_pic 0 0 3>;
 			clock-frequency = <0>; // From boot loader
 			interrupts = <2 8 0 2 9 0 2 a 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			bus-range = <0 0>;
 			ranges = <42000000 0 80000000 80000000 0 20000000
 			          02000000 0 a0000000 a0000000 0 10000000
@@ -212,7 +211,7 @@
 			compatible = "mpc5200-spi";
 			reg = <f00 20>;
 			interrupts = <2 d 0 2 e 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		usb@1000 {
@@ -220,7 +219,7 @@
 			compatible = "mpc5200-ohci\0ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		bestcomm@1200 {
@@ -231,7 +230,7 @@
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 a 0  3 b 0
 			              3 c 0  3 d 0  3 e 0  3 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		xlb@1f00 {
@@ -246,7 +245,7 @@
 			cell-index = <0>;
 			reg = <2000 100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		// PSC2 in ac97 mode example
@@ -256,7 +255,7 @@
 		//	cell-index = <1>;
 		//	reg = <2200 100>;
 		//	interrupts = <2 2 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC3 in CODEC mode example
@@ -266,7 +265,7 @@
 		//	cell-index = <2>;
 		//	reg = <2400 100>;
 		//	interrupts = <2 3 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC4 in uart mode example
@@ -276,7 +275,7 @@
 		//	cell-index = <3>;
 		//	reg = <2600 100>;
 		//	interrupts = <2 b 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC5 in uart mode example
@@ -286,7 +285,7 @@
 		//	cell-index = <4>;
 		//	reg = <2800 100>;
 		//	interrupts = <2 c 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC6 in spi mode example
@@ -296,7 +295,7 @@
 		//	cell-index = <5>;
 		//	reg = <2c00 100>;
 		//	interrupts = <2 4 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		ethernet@3000 {
@@ -305,7 +304,7 @@
 			reg = <3000 800>;
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		ata@3a00 {
@@ -313,7 +312,7 @@
 			compatible = "mpc5200-ata";
 			reg = <3a00 100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		i2c@3d00 {
@@ -322,7 +321,7 @@
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};

@@ -332,7 +331,7 @@
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 		sram@8000 {
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 00211b3..5185625 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -62,13 +62,12 @@
 			reg = <200 38>;
 		};

-		pic@500 {
+		mpc5200_pic: pic@500 {
 			// 5200 interrupts are encoded into two levels;
-			linux,phandle = <500>;
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200b-pic\0mpc5200-pic";
+			compatible = "mpc5200b-pic\0mpc5200_pic";
 			reg = <500 80>;
 			built-in;
 		};
@@ -79,7 +78,7 @@
 			cell-index = <0>;
 			reg = <600 10>;
 			interrupts = <1 9 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			has-wdt;
 		};

@@ -89,7 +88,7 @@
 			cell-index = <1>;
 			reg = <610 10>;
 			interrupts = <1 a 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@620 {	// General Purpose Timer
@@ -98,7 +97,7 @@
 			cell-index = <2>;
 			reg = <620 10>;
 			interrupts = <1 b 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@630 {	// General Purpose Timer
@@ -107,7 +106,7 @@
 			cell-index = <3>;
 			reg = <630 10>;
 			interrupts = <1 c 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@640 {	// General Purpose Timer
@@ -116,7 +115,7 @@
 			cell-index = <4>;
 			reg = <640 10>;
 			interrupts = <1 d 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@650 {	// General Purpose Timer
@@ -125,7 +124,7 @@
 			cell-index = <5>;
 			reg = <650 10>;
 			interrupts = <1 e 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@660 {	// General Purpose Timer
@@ -134,7 +133,7 @@
 			cell-index = <6>;
 			reg = <660 10>;
 			interrupts = <1 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpt@670 {	// General Purpose Timer
@@ -143,7 +142,7 @@
 			cell-index = <7>;
 			reg = <670 10>;
 			interrupts = <1 10 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		rtc@800 {	// Real time clock
@@ -151,7 +150,7 @@
 			device_type = "rtc";
 			reg = <800 100>;
 			interrupts = <1 5 0 1 6 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		mscan@900 {
@@ -159,7 +158,7 @@
 			compatible = "mpc5200b-mscan\0mpc5200-mscan";
 			cell-index = <0>;
 			interrupts = <2 11 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			reg = <900 80>;
 		};

@@ -168,7 +167,7 @@
 			compatible = "mpc5200b-mscan\0mpc5200-mscan";
 			cell-index = <1>;
 			interrupts = <2 12 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			reg = <980 80>;
 		};

@@ -176,14 +175,14 @@
 			compatible = "mpc5200b-gpio\0mpc5200-gpio";
 			reg = <b00 40>;
 			interrupts = <1 7 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		gpio-wkup@c00 {
 			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		pci@0d00 {
@@ -194,18 +193,18 @@
 			compatible = "mpc5200b-pci\0mpc5200-pci";
 			reg = <d00 100>;
 			interrupt-map-mask = <f800 0 0 7>;
-			interrupt-map = <c000 0 0 1 500 0 0 3 // 1st slot
-			                 c000 0 0 2 500 1 1 3
-			                 c000 0 0 3 500 1 2 3
-			                 c000 0 0 4 500 1 3 3
-
-			                 c800 0 0 1 500 1 1 3 // 2nd slot
-			                 c800 0 0 2 500 1 2 3
-			                 c800 0 0 3 500 1 3 3
-			                 c800 0 0 4 500 0 0 3>;
+			interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
+			                 c000 0 0 2 &mpc5200_pic 1 1 3
+			                 c000 0 0 3 &mpc5200_pic 1 2 3
+			                 c000 0 0 4 &mpc5200_pic 1 3 3
+
+			                 c800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
+			                 c800 0 0 2 &mpc5200_pic 1 2 3
+			                 c800 0 0 3 &mpc5200_pic 1 3 3
+			                 c800 0 0 4 &mpc5200_pic 0 0 3>;
 			clock-frequency = <0>; // From boot loader
 			interrupts = <2 8 0 2 9 0 2 a 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			bus-range = <0 0>;
 			ranges = <42000000 0 80000000 80000000 0 20000000
 			          02000000 0 a0000000 a0000000 0 10000000
@@ -217,7 +216,7 @@
 			compatible = "mpc5200b-spi\0mpc5200-spi";
 			reg = <f00 20>;
 			interrupts = <2 d 0 2 e 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		usb@1000 {
@@ -225,7 +224,7 @@
 			compatible = "mpc5200b-ohci\0mpc5200-ohci\0ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		bestcomm@1200 {
@@ -236,7 +235,7 @@
 			              3 4 0  3 5 0  3 6 0  3 7 0
 			              3 8 0  3 9 0  3 a 0  3 b 0
 			              3 c 0  3 d 0  3 e 0  3 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		xlb@1f00 {
@@ -251,7 +250,7 @@
 			cell-index = <0>;
 			reg = <2000 100>;
 			interrupts = <2 1 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		// PSC2 in ac97 mode example
@@ -261,7 +260,7 @@
 		//	cell-index = <1>;
 		//	reg = <2200 100>;
 		//	interrupts = <2 2 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC3 in CODEC mode example
@@ -271,7 +270,7 @@
 		//	cell-index = <2>;
 		//	reg = <2400 100>;
 		//	interrupts = <2 3 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC4 in uart mode example
@@ -281,7 +280,7 @@
 		//	cell-index = <3>;
 		//	reg = <2600 100>;
 		//	interrupts = <2 b 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC5 in uart mode example
@@ -291,7 +290,7 @@
 		//	cell-index = <4>;
 		//	reg = <2800 100>;
 		//	interrupts = <2 c 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		// PSC6 in spi mode example
@@ -301,7 +300,7 @@
 		//	cell-index = <5>;
 		//	reg = <2c00 100>;
 		//	interrupts = <2 4 0>;
-		//	interrupt-parent = <500>;
+		//	interrupt-parent = <&mpc5200_pic>;
 		//};

 		ethernet@3000 {
@@ -310,7 +309,7 @@
 			reg = <3000 800>;
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		ata@3a00 {
@@ -318,7 +317,7 @@
 			compatible = "mpc5200b-ata\0mpc5200-ata";
 			reg = <3a00 100>;
 			interrupts = <2 7 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 		};

 		i2c@3d00 {
@@ -327,7 +326,7 @@
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};

@@ -337,7 +336,7 @@
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
-			interrupt-parent = <500>;
+			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 		};
 		sram@8000 {
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 6fa3754..765c306 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -16,12 +16,10 @@
 	compatible = "mpc74xx";
 	#address-cells = <1>;
 	#size-cells = <1>;
-	linux,phandle = <100>;

 	cpus {
 		#address-cells = <1>;
 		#size-cells =<0>;
-		linux,phandle = <200>;

 		PowerPC,7448@0 {
 			device_type = "cpu";
@@ -34,13 +32,11 @@
 			clock-frequency = <0>;		// From U-Boot
 			bus-frequency = <0>;		// From U-Boot
 			32-bit;
-			linux,phandle = <201>;
 		};
 	};

 	memory {
 		device_type = "memory";
-		linux,phandle = <300>;
 		reg = <00000000 20000000	// DDR2   512M at 0
 		       >;
 	};
@@ -55,7 +51,7 @@
 		bus-frequency = <0>;

 		i2c@7000 {
-			interrupt-parent = <7400>;
+			interrupt-parent = <&mpic>;
 			interrupts = <E 0>;
 			reg = <7000 400>;
 			device_type = "i2c";
@@ -66,18 +62,16 @@
 			device_type = "mdio";
 			compatible = "tsi-ethernet";

-			ethernet-phy@6000 {
-				linux,phandle = <6000>;
-				interrupt-parent = <7400>;
+			phy8: ethernet-phy@6000 {
+				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
 				reg = <6000 50>;
 				phy-id = <8>;
 				device_type = "ethernet-phy";
 			};

-			ethernet-phy@6400 {
-				linux,phandle = <6400>;
-				interrupt-parent = <7400>;
+			phy9: ethernet-phy@6400 {
+				interrupt-parent = <&mpic>;
 				interrupts = <2 1>;
 				reg = <6000 50>;
 				phy-id = <9>;
@@ -94,8 +88,8 @@
 			reg = <6000 200>;
 			address = [ 00 06 D2 00 00 01 ];
 			interrupts = <10 2>;
-			interrupt-parent = <7400>;
-			phy-handle = <6000>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy8>;
 		};

 		ethernet@6600 {
@@ -107,8 +101,8 @@
 			reg = <6400 200>;
 			address = [ 00 06 D2 00 00 02 ];
 			interrupts = <11 2>;
-			interrupt-parent = <7400>;
-			phy-handle = <6400>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy9>;
 		};

 		serial@7808 {
@@ -117,7 +111,7 @@
 			reg = <7808 200>;
 			clock-frequency = <3f6b5a00>;
 			interrupts = <c 0>;
-			interrupt-parent = <7400>;
+			interrupt-parent = <&mpic>;
 		};

 		serial@7c08 {
@@ -126,11 +120,10 @@
 			reg = <7c08 200>;
 			clock-frequency = <3f6b5a00>;
 			interrupts = <d 0>;
-			interrupt-parent = <7400>;
+			interrupt-parent = <&mpic>;
 		};

-	  	pic@7400 {
-			linux,phandle = <7400>;
+	  	mpic: pic@7400 {
 			clock-frequency = <0>;
 			interrupt-controller;
 			#address-cells = <0>;
@@ -144,7 +137,6 @@
 		pci@1000 {
 			compatible = "tsi10x";
 			device_type = "pci";
-			linux,phandle = <1000>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
@@ -153,37 +145,37 @@
 			ranges = <02000000 0 e0000000 e0000000 0 1A000000
 				  01000000 0 00000000 fa000000 0 00010000>;
 			clock-frequency = <7f28154>;
-			interrupt-parent = <7400>;
+			interrupt-parent = <&mpic>;
 			interrupts = <17 2>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <

 				/* IDSEL 0x11 */
-				0800 0 0 1 1180 24 0
-				0800 0 0 2 1180 25 0
-				0800 0 0 3 1180 26 0
-				0800 0 0 4 1180 27 0
+				0800 0 0 1 &RT0 24 0
+				0800 0 0 2 &RT0 25 0
+				0800 0 0 3 &RT0 26 0
+				0800 0 0 4 &RT0 27 0

 				/* IDSEL 0x12 */
-				1000 0 0 1 1180 25 0
-				1000 0 0 2 1180 26 0
-				1000 0 0 3 1180 27 0
-				1000 0 0 4 1180 24 0
+				1000 0 0 1 &RT0 25 0
+				1000 0 0 2 &RT0 26 0
+				1000 0 0 3 &RT0 27 0
+				1000 0 0 4 &RT0 24 0

 				/* IDSEL 0x13 */
-				1800 0 0 1 1180 26 0
-				1800 0 0 2 1180 27 0
-				1800 0 0 3 1180 24 0
-				1800 0 0 4 1180 25 0
+				1800 0 0 1 &RT0 26 0
+				1800 0 0 2 &RT0 27 0
+				1800 0 0 3 &RT0 24 0
+				1800 0 0 4 &RT0 25 0

 				/* IDSEL 0x14 */
-				2000 0 0 1 1180 27 0
-				2000 0 0 2 1180 24 0
-				2000 0 0 3 1180 25 0
-				2000 0 0 4 1180 26 0
+				2000 0 0 1 &RT0 27 0
+				2000 0 0 2 &RT0 24 0
+				2000 0 0 3 &RT0 25 0
+				2000 0 0 4 &RT0 26 0
 				>;
-			router@1180 {
-				linux,phandle = <1180>;
+
+			RT0: router@1180 {
 				clock-frequency = <0>;
 				interrupt-controller;
 				device_type = "pic-router";
@@ -192,7 +184,7 @@
 				built-in;
 				big-endian;
 				interrupts = <17 2>;
-				interrupt-parent = <7400>;
+				interrupt-parent = <&mpic>;
 			};
 		};
 	};
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index f261d64..d91e81c 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;

+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 5fdcb69..4f2c3af 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;

+		memory-controller@2000 {
+			compatible = "fsl,8541-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8541-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 6b08460..3033599 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled out by uboot.

+		memory-controller@2000 {
+			compatible = "fsl,8544-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8544-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index b2b2200..ad96381 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;

+		memory-controller@2000 {
+			compatible = "fsl,8548-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8548-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 68a4795..951ed92 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;

+		memory-controller@2000 {
+			compatible = "fsl,8555-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8555-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1f2afe9..8068215 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -48,6 +48,22 @@
 		reg = <e0000000 00000200>;
 		bus-frequency = <13ab6680>;

+		memory-controller@2000 {
+			compatible = "fsl,8540-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8540-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <40000>;	// L2, 256K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		mdio@24520 {
 			device_type = "mdio";
 			compatible = "gianfar";
@@ -110,7 +126,7 @@
 			#address-cells = <3>;
 			compatible = "85xx";
 			device_type = "pci";
-			reg = <8000 400>;
+			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 948a3b6..a123ec9 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -57,6 +57,22 @@
 		reg = <e0000000 00100000>;
 		bus-frequency = <0>;

+		memory-controller@2000 {
+			compatible = "fsl,8568-memory-controller";
+			reg = <2000 1000>;
+			interrupt-parent = <&mpic>;
+			interrupts = <2 2>;
+		};
+
+		l2-cache-controller@20000 {
+			compatible = "fsl,8568-l2-cache-controller";
+			reg = <20000 1000>;
+			cache-line-size = <20>;	// 32 bytes
+			cache-size = <80000>;	// L2, 512K
+			interrupt-parent = <&mpic>;
+			interrupts = <0 2>;
+		};
+
 		i2c@3000 {
 			device_type = "i2c";
 			compatible = "fsl-i2c";
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9cb24d2..6ef87fb 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -836,7 +836,7 @@ static struct cpu_spec cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80040000,
 		.cpu_name		= "7448",
-		.cpu_features		= CPU_FTRS_7447A,
+		.cpu_features		= CPU_FTRS_7448,
 		.cpu_user_features	= COMMON_USER |
 			PPC_FEATURE_HAS_ALTIVEC_COMP | PPC_FEATURE_PPC_LE,
 		.icache_bsize		= 32,
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index c29d165..4074c0b 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -596,7 +596,11 @@ fast_exception_return:
 	mr	r12,r4		/* restart at exc_exit_restart */
 	b	2b

-	.comm	fee_restarts,4
+	.section .bss
+	.align	2
+fee_restarts:
+	.space	4
+	.previous

 /* aargh, a nonrecoverable interrupt, panic */
 /* aargh, we don't know which trap this is */
@@ -851,7 +855,11 @@ load_dbcr0:
 	mtspr	SPRN_DBSR,r11	/* clear all pending debug events */
 	blr

-	.comm	global_dbcr0,8
+	.section .bss
+	.align	4
+global_dbcr0:
+	.space	8
+	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

 do_work:			/* r10 contains MSR_KERNEL here */
@@ -926,7 +934,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	/* shouldn't return */
 	b	4b

-	.comm	ee_restarts,4
+	.section .bss
+	.align	2
+ee_restarts:
+	.space	4
+	.previous

 /*
  * PROM code for specific machines follows.  Put it
diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index b2f6dcc..180ee29 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -468,25 +468,19 @@ unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const ch
 	if (blk->size == size) {
 		/* Move from free list to taken list */
 		list_del(&blk->list);
-		blk->owner = owner;
-		start = blk->start;
-
-		attach_taken_block(info, blk);
+		newblk = blk;
+	} else {
+		newblk = get_slot(info);
+		newblk->start = blk->start;
+		newblk->size = size;

-		return start;
+		/* blk still in free list, with updated start, size */
+		blk->start += size;
+		blk->size -= size;
 	}

-	newblk = get_slot(info);
-	newblk->start = blk->start;
-	newblk->size = size;
 	newblk->owner = owner;
-
-	/* blk still in free list, with updated start, size */
-	blk->start += size;
-	blk->size -= size;
-
 	start = newblk->start;
-
 	attach_taken_block(info, newblk);

 	/* for larger alignment return fixed up pointer  */
diff --git a/arch/powerpc/mm/hash_low_32.S b/arch/powerpc/mm/hash_low_32.S
index ddceefc..7f830a4 100644
--- a/arch/powerpc/mm/hash_low_32.S
+++ b/arch/powerpc/mm/hash_low_32.S
@@ -30,7 +30,11 @@
 #include <asm/asm-offsets.h>

 #ifdef CONFIG_SMP
-	.comm	mmu_hash_lock,4
+	.section .bss
+	.align	2
+	.globl mmu_hash_lock
+mmu_hash_lock:
+	.space	4
 #endif /* CONFIG_SMP */

 /*
@@ -455,9 +459,15 @@ found_slot:
 	sync		/* make sure pte updates get to memory */
 	blr

-	.comm	next_slot,4
-	.comm	primary_pteg_full,4
-	.comm	htab_hash_searches,4
+	.section .bss
+	.align	2
+next_slot:
+	.space	4
+primary_pteg_full:
+	.space	4
+htab_hash_searches:
+	.space	4
+	.previous

 /*
  * Flush the entry for a particular page from the hash table.
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index ab64256..fba7ca1 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -596,7 +596,11 @@ fast_exception_return:
 	mr	r12,r4		/* restart at exc_exit_restart */
 	b	2b

-	.comm	fee_restarts,4
+	.section .bss
+	.align	2
+fee_restarts:
+	.space	4
+	.previous

 /* aargh, a nonrecoverable interrupt, panic */
 /* aargh, we don't know which trap this is */
@@ -851,7 +855,11 @@ load_dbcr0:
 	mtspr	SPRN_DBSR,r11	/* clear all pending debug events */
 	blr

-	.comm	global_dbcr0,8
+	.section .bss
+	.align	4
+global_dbcr0:
+	.space	8
+	.previous
 #endif /* !(CONFIG_4xx || CONFIG_BOOKE) */

 do_work:			/* r10 contains MSR_KERNEL here */
@@ -926,4 +934,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_601)
 	/* shouldn't return */
 	b	4b

-	.comm	ee_restarts,4
+	.section .bss
+	.align	2
+ee_restarts:
+	.space	4
+	.previous
diff --git a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
index e756942..fc30b6f 100644
--- a/arch/ppc/mm/hashtable.S
+++ b/arch/ppc/mm/hashtable.S
@@ -30,7 +30,11 @@
 #include <asm/asm-offsets.h>

 #ifdef CONFIG_SMP
-	.comm	mmu_hash_lock,4
+	.section .bss
+	.align	2
+	.globl mmu_hash_lock
+mmu_hash_lock:
+	.space	4
 #endif /* CONFIG_SMP */

 /*
@@ -461,9 +465,15 @@ found_slot:
 	sync		/* make sure pte updates get to memory */
 	blr

-	.comm	next_slot,4
-	.comm	primary_pteg_full,4
-	.comm	htab_hash_searches,4
+	.section .bss
+	.align	2
+next_slot:
+	.space	4
+primary_pteg_full:
+	.space	4
+htab_hash_searches:
+	.space	4
+	.previous

 /*
  * Flush the entry for a particular page from the hash table.
diff --git a/arch/ppc/syslib/pq2_sys.c b/arch/ppc/syslib/pq2_sys.c
index f52600c..9c85300 100644
--- a/arch/ppc/syslib/pq2_sys.c
+++ b/arch/ppc/syslib/pq2_sys.c
@@ -26,7 +26,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC2, MPC82xx_CPM_SMC1,
 			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
 		}
 	},
@@ -39,7 +39,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_SCC1,
 			MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3, MPC82xx_CPM_SCC4,
-			MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2,
+			MPC82xx_CPM_MCC2, MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2,
 			MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
 		}
 	},
@@ -47,52 +47,56 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8260",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000000,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C,
 		}
 	},
 	{
 		.ppc_sys_name	= "8264",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000000,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C,
 		}
 	},
 	{
 		.ppc_sys_name	= "8265",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000000,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C,
 		}
 	},
 	{
 		.ppc_sys_name	= "8266",
 		.mask		= 0x0000ff00,
 		.value		= 0x00000000,
-		.num_devices	= 12,
+		.num_devices	= 13,
 		.device_list = (enum ppc_sys_devices[])
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
-			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_MCC2,
+			MPC82xx_CPM_SMC1, MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI,
+			MPC82xx_CPM_I2C,
 		}
 	},
 	/* below is a list of the 8272 family of processors */
@@ -159,7 +163,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC2, MPC82xx_CPM_SMC1,
 			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
 		},
 	},
@@ -172,7 +176,7 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		{
 			MPC82xx_CPM_FCC1, MPC82xx_CPM_FCC2, MPC82xx_CPM_FCC3,
 			MPC82xx_CPM_SCC1, MPC82xx_CPM_SCC2, MPC82xx_CPM_SCC3,
-			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC1, MPC82xx_CPM_SMC1,
+			MPC82xx_CPM_SCC4, MPC82xx_CPM_MCC2, MPC82xx_CPM_SMC1,
 			MPC82xx_CPM_SMC2, MPC82xx_CPM_SPI, MPC82xx_CPM_I2C,
 		},
 	},
diff --git a/drivers/char/watchdog/booke_wdt.c b/drivers/char/watchdog/booke_wdt.c
index 0e23f29..0f5c77d 100644
--- a/drivers/char/watchdog/booke_wdt.c
+++ b/drivers/char/watchdog/booke_wdt.c
@@ -24,7 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>

-/* If the kernel parameter wdt_enable=1, the watchdog will be enabled at boot.
+/* If the kernel parameter wdt=1, the watchdog will be enabled at boot.
  * Also, the wdt_period sets the watchdog timer period timeout.
  * For E500 cpus the wdt_period sets which bit changing from 0->1 will
  * trigger a watchog timeout. This watchdog timeout will occur 3 times, the
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 4345249..82d595a 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -302,6 +302,12 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
 	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
 	    CPU_FTR_NEED_COHERENT | CPU_FTR_PPC_LE)
+#define CPU_FTRS_7448	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
+	    CPU_FTR_USE_TB | \
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | \
+	    CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS | \
+	    CPU_FTR_PPC_LE)
 #define CPU_FTRS_82XX	(CPU_FTR_COMMON | CPU_FTR_SPLIT_ID_CACHE | \
 	    CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB)
 #define CPU_FTRS_G2_LE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_MAYBE_CAN_DOZE | \
diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
index f1b83b0..e0d4807 100644
--- a/include/asm-powerpc/mpc8260.h
+++ b/include/asm-powerpc/mpc8260.h
@@ -5,8 +5,8 @@
  * this one and the configuration switching is done here.
  */
 #ifdef __KERNEL__
-#ifndef __ASM_PPC_MPC8260_H__
-#define __ASM_PPC_MPC8260_H__
+#ifndef __ASM_POWERPC_MPC8260_H__
+#define __ASM_POWERPC_MPC8260_H__


 #ifdef CONFIG_8260
@@ -20,5 +20,5 @@
 #endif

 #endif /* CONFIG_8260 */
-#endif /* !__ASM_PPC_MPC8260_H__ */
+#endif /* !__ASM_POWERPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/pmac_feature.h b/include/asm-powerpc/pmac_feature.h
index d43d91b..26bcb0a 100644
--- a/include/asm-powerpc/pmac_feature.h
+++ b/include/asm-powerpc/pmac_feature.h
@@ -28,8 +28,8 @@
  */

 #ifdef __KERNEL__
-#ifndef __PPC_ASM_PMAC_FEATURE_H
-#define __PPC_ASM_PMAC_FEATURE_H
+#ifndef __ASM_POWERPC_PMAC_FEATURE_H
+#define __ASM_POWERPC_PMAC_FEATURE_H

 #include <asm/macio.h>
 #include <asm/machdep.h>
@@ -393,5 +393,5 @@ extern u32 __iomem *uninorth_base;
 #define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))


-#endif /* __PPC_ASM_PMAC_FEATURE_H */
+#endif /* __ASM_POWERPC_PMAC_FEATURE_H */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/tsi108_irq.h b/include/asm-powerpc/tsi108_irq.h
index 3e4d04e..6ed9397 100644
--- a/include/asm-powerpc/tsi108_irq.h
+++ b/include/asm-powerpc/tsi108_irq.h
@@ -26,8 +26,8 @@
  * demultiplexing on TSI108EMU/SVB boards.
  */

-#ifndef _ASM_PPC_TSI108_IRQ_H
-#define _ASM_PPC_TSI108_IRQ_H
+#ifndef _ASM_POWERPC_TSI108_IRQ_H
+#define _ASM_POWERPC_TSI108_IRQ_H

 /*
  * Tsi108 interrupts
@@ -121,4 +121,4 @@ typedef enum {
 	TSI108_IRQ_DIRECTED,
 	TSI108_IRQ_DISTRIBUTED,
 } TSI108_IRQ_MODE;
-#endif				/*  _ASM_PPC_TSI108_IRQ_H */
+#endif				/*  _ASM_POWERPC_TSI108_IRQ_H */
diff --git a/include/asm-powerpc/tsi108_pci.h b/include/asm-powerpc/tsi108_pci.h
index a9f92f7..5653d7c 100644
--- a/include/asm-powerpc/tsi108_pci.h
+++ b/include/asm-powerpc/tsi108_pci.h
@@ -18,8 +18,8 @@
  * MA 02111-1307 USA
  */

-#ifndef _ASM_PPC_TSI108_PCI_H
-#define _ASM_PPC_TSI108_PCI_H
+#ifndef _ASM_POWERPC_TSI108_PCI_H
+#define _ASM_POWERPC_TSI108_PCI_H

 #include <asm/tsi108.h>

@@ -42,4 +42,4 @@ extern void tsi108_pci_int_init(struct device_node *node);
 extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 extern void tsi108_clear_pci_cfg_error(void);

-#endif				/*  _ASM_PPC_TSI108_PCI_H */
+#endif				/*  _ASM_POWERPC_TSI108_PCI_H */
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 21f004a..908dfe4 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_PPC_UNISTD_H_
-#define _ASM_PPC_UNISTD_H_
+#ifndef _ASM_POWERPC_UNISTD_H_
+#define _ASM_POWERPC_UNISTD_H_

 /*
  * This file contains the system call numbers.
@@ -381,4 +381,4 @@
 #endif		/* __ASSEMBLY__ */
 #endif		/* __KERNEL__ */

-#endif /* _ASM_PPC_UNISTD_H_ */
+#endif /* _ASM_POWERPC_UNISTD_H_ */
