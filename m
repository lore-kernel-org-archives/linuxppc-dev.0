Return-Path: <gicoviello@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by ozlabs.org (Postfix) with ESMTP id BEDF0DDFDF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 03:55:49 +1000 (EST)
Received: by mu-out-0910.google.com with SMTP id g7so166074muf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 10:55:46 -0700 (PDT)
Subject: Re: [PATCH] Sam440ep support
From: Giuseppe Coviello <cjg@cruxppc.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080520083450.57ab279a@zod.rchland.ibm.com>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<a265241c0805060937m25921c56o6fb2b132a3f821d6@mail.gmail.com>
	<20080519074701.4cb15c86@zod.rchland.ibm.com>
	<1211210447.11958.10.camel@marquez.cjg.home>
	<20080520075028.0b286c73@zod.rchland.ibm.com>
	<20080520083450.57ab279a@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 22 May 2008 19:51:37 +0200
Message-Id: <1211478697.4585.1.camel@marquez.cjg.home>
Mime-Version: 1.0
Sender: Giuseppe Coviello <gicoviello@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Il giorno mar, 20/05/2008 alle 08.34 -0500, Josh Boyer ha scritto:
> On Tue, 20 May 2008 07:50:28 -0500
> Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
> 
> > On Mon, 19 May 2008 17:20:47 +0200
> > Giuseppe Coviello <cjg@cruxppc.org> wrote:
> > 
> > 
> > > +			usb@ef601000 {
> > > +				compatible = "ohci-be";
> > > +				reg = <ef601000 80>;
> > > +				interrupts = <8 4 9 4>;
> > > +				interrupt-parent = < &UIC1 >;
> > 
> > Are you sure the trigger/level settings on those interrupts is
> > correct?
> > 

Yes, I am.

> > > +			};	
> > > +		};
> > > +
> > > +		PCI0: pci@ec000000 {
> > > +			device_type = "pci";
> > > +			#interrupt-cells = <1>;
> > > +			#size-cells = <2>;
> > > +			#address-cells = <3>;
> > > +			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
> > > +			primary;
> > > +			reg = <0 eec00000 8	/* Config space access */
> > > +			       0 eed00000 4	/* IACK */
> > > +			       0 eed00000 4	/* Special cycle */
> > > +			       0 ef400000 40>;	/* Internal registers */
> > > +
> > > +			/* Outbound ranges, one memory and one IO,
> > > +			 * later cannot be changed. Chip supports a second
> > > +			 * IO range but we don't use it for now
> > > +			 */
> > > +			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
> > > +				  01000000 0 00000000 0 e8000000 0 00010000>;
> > > +
> > > +			/* Inbound 2GB range starting at 0 */
> > > +			dma-ranges = <42000000 0 0 0 0 0 80000000>;
> > 
> > You have no interrupt mapping for the PCI node.  How do you have
> > working PCI here?
> 

U-Boot sets the interrupt map.

> Also, if these questions result in changes to the DTS, could you please
> convert it to a dts-v1 format?  Otherwise I'll have to do it myself and
> it's cleaner if it comes in that way.

This patch mades sam440ep.dts dts-v1 compliant.

Signed-off-by: Giuseppe Coviello <gicoviello@gmail.com>

diff --git a/arch/powerpc/boot/dts/sam440ep.dts b/arch/powerpc/boot/dts/sam440ep.dts
index 764cab0..a1a230a 100644
--- a/arch/powerpc/boot/dts/sam440ep.dts
+++ b/arch/powerpc/boot/dts/sam440ep.dts
@@ -13,12 +13,13 @@
  * any warranty of any kind, whether express or implied.
  */
 
+/dts-v1/;
+
 / {
 	#address-cells = <2>;
 	#size-cells = <1>;
 	model = "acube,sam440ep";
 	compatible = "acube,sam440ep";
-	dcr-parent = <&/cpus/cpu@0>;
 
 	aliases {
 		ethernet0 = &EMAC0;
@@ -39,10 +40,10 @@
 			reg = <0>;
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
@@ -57,7 +58,7 @@
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <0>;
-		dcr-reg = <0c0 009>;
+		dcr-reg = <0x0c0 9>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
@@ -67,22 +68,22 @@
 		compatible = "ibm,uic-440ep","ibm,uic";
 		interrupt-controller;
 		cell-index = <1>;
-		dcr-reg = <0d0 009>;
+		dcr-reg = <0x0d0 9>;
 		#address-cells = <0>;
 		#size-cells = <0>;
 		#interrupt-cells = <2>;
-		interrupts = <1e 4 1f 4>; /* cascade */
+		interrupts = <0x1e 4 0x1f 4>; /* cascade */
 		interrupt-parent = <&UIC0>;
 	};
 
 	SDR0: sdr {
 		compatible = "ibm,sdr-440ep";
-		dcr-reg = <00e 002>;
+		dcr-reg = <0x00e 2>;
 	};
 
 	CPR0: cpr {
 		compatible = "ibm,cpr-440ep";
-		dcr-reg = <00c 002>;
+		dcr-reg = <0x00c 2>;
 	};
 
 	plb {
@@ -94,17 +95,17 @@
 
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
-			dcr-reg = <010 2>;
+			dcr-reg = <0x010 2>;
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
@@ -112,8 +113,8 @@
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
 			#size-cells = <0>;
-			interrupt-map = </*TXEOB*/ 0 &UIC0 a 4
-					/*RXEOB*/ 1 &UIC0 b 4
+			interrupt-map = </*TXEOB*/ 0 &UIC0 10 4
+					/*RXEOB*/ 1 &UIC0 11 4
 					/*SERR*/  2 &UIC1 0 4
 					/*TXDE*/  3 &UIC1 1 4
 					/*RXDE*/  4 &UIC1 2 4>;
@@ -126,15 +127,15 @@
 			/* Bamboo is oddball in the 44x world and doesn't use the ERPN
 			 * bits.
 			 */
-		  	ranges = <00000000 0 00000000 80000000
-			          80000000 0 80000000 80000000>;
+		  	ranges = <0x00000000 0 0x00000000 0x80000000
+			          0x80000000 0 0x80000000 0x80000000>;
 		  	interrupt-parent = <&UIC1>;
 		  	interrupts = <7 4>;
 		  	clock-frequency = <0>; /* Filled in by zImage */
 
 			EBC0: ebc {
 				compatible = "ibm,ebc-440ep", "ibm,ebc-440gp", "ibm,ebc";
-				dcr-reg = <012 2>;
+				dcr-reg = <0x012 2>;
 				#address-cells = <2>;
 				#size-cells = <1>;
 				clock-frequency = <0>; /* Filled in by zImage */
@@ -145,10 +146,10 @@
 			UART0: serial@ef600300 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600300 8>;
-		   		virtual-reg = <ef600300>;
+		   		reg = <0xef600300 8>;
+		   		virtual-reg = <0xef600300>;
 		   		clock-frequency = <0>; /* Filled in by zImage */
-		   		current-speed = <1c200>;
+		   		current-speed = <0x1c200>;
 		   		interrupt-parent = <&UIC0>;
 		   		interrupts = <0 4>;
 	   		};
@@ -156,8 +157,8 @@
 			UART1: serial@ef600400 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600400 8>;
-		   		virtual-reg = <ef600400>;
+		   		reg = <0xef600400 8>;
+		   		virtual-reg = <0xef600400>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
@@ -167,8 +168,8 @@
 			UART2: serial@ef600500 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600500 8>;
-		   		virtual-reg = <ef600500>;
+		   		reg = <0xef600500 8>;
+		   		virtual-reg = <0xef600500>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
@@ -178,8 +179,8 @@
 			UART3: serial@ef600600 {
 		   		device_type = "serial";
 		   		compatible = "ns16550";
-		   		reg = <ef600600 8>;
-		   		virtual-reg = <ef600600>;
+		   		reg = <0xef600600 8>;
+		   		virtual-reg = <0xef600600>;
 		   		clock-frequency = <0>;
 		   		current-speed = <0>;
 		   		interrupt-parent = <&UIC0>;
@@ -191,26 +192,26 @@
                                 #size-cells = <0>;
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
 				index = <0>;
-				reg = <ef600700 14>;
+				reg = <0xef600700 0x14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <2 4>;
 				rtc@68 {
 					compatible = "stm,m41t80";
-					reg = <68>;
+					reg = <0x68>;
 				};
 			};
 
 			IIC1: i2c@ef600800 {
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
 				index = <5>;
-				reg = <ef600800 14>;
+				reg = <0xef600800 0x14>;
 				interrupt-parent = <&UIC0>;
 				interrupts = <7 4>;
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
-				reg = <ef600d00 c>;
+				reg = <0xef600d00 0xc>;
 			};
 
 			EMAC0: ethernet@ef600e00 {
@@ -218,16 +219,16 @@
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1c 4 1d 4>;
-				reg = <ef600e00 70>;
+				interrupts = <0x1c 4 0x1d 4>;
+				reg = <0xef600e00 0x70>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <0 1>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <0x5dc>;
+				rx-fifo-size = <0x1000>;
+				tx-fifo-size = <0x800>;
 				phy-mode = "rmii";
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
@@ -239,16 +240,16 @@
 				device_type = "network";
 				compatible = "ibm,emac-440ep", "ibm,emac-440gp", "ibm,emac";
 				interrupt-parent = <&UIC1>;
-				interrupts = <1e 4 1f 4>;
-				reg = <ef600f00 70>;
+				interrupts = <0x1e 4 0x1f 4>;
+				reg = <0xef600f00 0x70>;
 				local-mac-address = [000000000000];
 				mal-device = <&MAL0>;
 				mal-tx-channel = <2 3>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
-				rx-fifo-size = <1000>;
-				tx-fifo-size = <800>;
+				max-frame-size = <0x5dc>;
+				rx-fifo-size = <0x1000>;
+				tx-fifo-size = <0x800>;
 				phy-mode = "rmii";
 				phy-map = <00000000>;
 				zmii-device = <&ZMII0>;
@@ -256,9 +257,9 @@
 			};
 			usb@ef601000 {
 				compatible = "ohci-be";
-				reg = <ef601000 80>;
+				reg = <0xef601000 0x80>;
 				interrupts = <8 4 9 4>;
-				interrupt-parent = < &UIC1 >;
+				interrupt-parent = <&UIC1>;
 			};	
 		};
 
@@ -269,20 +270,20 @@
 			#address-cells = <3>;
 			compatible = "ibm,plb440ep-pci", "ibm,plb-pci";
 			primary;
-			reg = <0 eec00000 8	/* Config space access */
-			       0 eed00000 4	/* IACK */
-			       0 eed00000 4	/* Special cycle */
-			       0 ef400000 40>;	/* Internal registers */
+			reg = <0 0xeec00000 8	   /* Config space access */
+			       0 0xeed00000 4	   /* IACK */
+			       0 0xeed00000 4	   /* Special cycle */
+			       0 0xef400000 0x40>; /* Internal registers */
 
 			/* Outbound ranges, one memory and one IO,
 			 * later cannot be changed. Chip supports a second
 			 * IO range but we don't use it for now
 			 */
-			ranges = <02000000 0 a0000000 0 a0000000 0 20000000
-				  01000000 0 00000000 0 e8000000 0 00010000>;
+			ranges = <0x02000000 0 0xa0000000 0 0xa0000000 0 0x20000000
+				  0x01000000 0 0x00000000 0 0xe8000000 0 0x00010000>;
 
 			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <42000000 0 0 0 0 0 80000000>;
+			dma-ranges = <0x42000000 0 0 0 0 0 0x80000000>;
 		};
 	};
 
