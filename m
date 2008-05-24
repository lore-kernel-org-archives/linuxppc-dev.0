Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id D1819DDED9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 10:28:31 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so948868ugf.0
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 17:28:29 -0700 (PDT)
Date: Sat, 24 May 2008 04:28:25 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 6/7] [POWERPC] booting-without-of: add FHCI USB, FSL
	MCU, FSL UPM and GPIO LEDs bindings
Message-ID: <20080524002825.GA636@zarina>
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163903.GF16137@polina.dev.rtsoft.ru>
	<25787c450a6a7e79435877a358ab819a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <25787c450a6a7e79435877a358ab819a@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, May 24, 2008 at 12:10:56AM +0200, Segher Boessenkool wrote:
>> +      - fsl,fullspeed-clock : specifies the full speed USB clock  
>> source in
>> +        "clk<num>" or "brg<num>" format.
>> +      - fsl,lowspeed-clock : specifies the low speed USB clock source  
>> in
>> +        "clk<num>" or "brg<num>" format.
>
> What format is "<num>" in?
>
>> +      - fsl,usb-mode : should be "host".
>
> If that's the only possible value,

This could be "peripheral" and "otg" in future.

> this property is unnecessary,
> no?  It probably would make sense to make this optional (and default
> to "host") anyway.
>
>> +      - linux,hub-power-budget : optional, USB power budget for the  
>> root hub
>> +        in mA.
>
> Why is this linux-specific?
>
>> +    w) Freescale MCU with MPC8349E-mITX compatible firmware
>> +
>> +    Required properties:
>> +      - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx";
>> +      - reg : should specify I2C address (0x0a).
>> +      - #address-cells : should be 0.
>> +      - #size-cells : should be 0.
>
>> +    x) Freescale Localbus UPM programmed to work with NAND flash
>
> Similar here, except this one is never a GPIO controller.
>
> If the point to have #a = #s = 0 is to not have a unit-address
> in the child nodes: you should do that simply by not specifying
> a "reg" in the child nodes.
>
>> +    y) LEDs on GPIOs
>
> This one is so full of "linux," stuff that I won't review it --
> I wouldn't know where to start, sorry.

How about this version? (diff against the previous version is here,
and new full version will follow)

Doubts:

1. I removed linux,name and now Linux will use node's name. Is this
   okay, or "name" property would be better?
2. I can't thinkout replacement for the linux,default-trigger, this is
   really linux-specific. The value could be anything Linux implements
   currently or will implement in the future...

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 07aad16..8e3f743 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -2951,18 +2951,22 @@ platforms are moved over to use the flattened-device-tree model.
 
     Required properties:
       - compatible : should be "fsl,<chip>-qe-usb", "fsl,mpc8323-qe-usb";
-      - reg : the first two cells should contain gtm registers location and
+      - reg : the first two cells should contain usb registers location and
         length, the next two two cells should contain PRAM location and
         length.
       - interrupts : should contain USB interrupt.
       - interrupt-parent : interrupt source phandle.
-      - fsl,fullspeed-clock : specifies the full speed USB clock source in
-        "clk<num>" or "brg<num>" format.
-      - fsl,lowspeed-clock : specifies the low speed USB clock source in
-        "clk<num>" or "brg<num>" format.
-      - fsl,usb-mode : should be "host".
-      - linux,hub-power-budget : optional, USB power budget for the root hub
-        in mA.
+      - fsl,fullspeed-clock : specifies the full speed USB clock source:
+        "none": clock source is disabled
+        "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+        "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+      - fsl,lowspeed-clock : specifies the low speed USB clock source:
+        "none": clock source is disabled
+        "brg1" through "brg16": clock source is BRG1-BRG16, respectively
+        "clk1" through "clk24": clock source is CLK1-CLK24, respectively
+      - fsl,usb-mode : (optional) so far acceptable value is "host" only
+        (this is default mode if property is absent).
+      - hub-power-budget : optional, USB power budget for the root hub, in mA.
       - gpios : should specify GPIOs in this order: USBOE, USBTP, USBTN, USBRP,
         USBRN, SPEED (optional), and POWER (optional).
 
@@ -2974,7 +2978,6 @@ platforms are moved over to use the flattened-device-tree model.
 		interrupts = <11>;
 		interrupt-parent = <&qeic>;
 		fsl,fullspeed-clock = "clk21";
-		fsl,usb-mode = "host";
 		gpios = <&qe_pio_b  2 0 /* USBOE */
 			 &qe_pio_b  3 0 /* USBTP */
 			 &qe_pio_b  8 0 /* USBTN */
@@ -2989,16 +2992,12 @@ platforms are moved over to use the flattened-device-tree model.
     Required properties:
       - compatible : "fsl,<mcu-chip>-<board>", "fsl,mcu-mpc8349emitx";
       - reg : should specify I2C address (0x0a).
-      - #address-cells : should be 0.
-      - #size-cells : should be 0.
       - #gpio-cells : should be 2.
       - gpio-controller : should be present;
 
     Example:
 
 	mcu_pio: mcu@0a {
-		#address-cells = <0>;
-		#size-cells = <0>;
 		#gpio-cells = <2>;
 		compatible = "fsl,mc9s08qg8-mpc8349emitx",
 			     "fsl,mcu-mpc8349emitx";
@@ -3009,8 +3008,6 @@ platforms are moved over to use the flattened-device-tree model.
     x) Freescale Localbus UPM programmed to work with NAND flash
 
       Required properties:
-      - #address-cells : should be 0;
-      - #size-cells : should be 0;
       - compatible : "fsl,upm-nand".
       - reg : should specify localbus chip select and size used for the chip.
       - fsl,upm-addr-offset : UPM pattern offset for the address latch.
@@ -3020,8 +3017,6 @@ platforms are moved over to use the flattened-device-tree model.
       Example:
 
 	upm@1,0 {
-		#address-cells = <0>;
-		#size-cells = <0>;
 		compatible = "fsl,upm-nand";
 		reg = <1 0 1>;
 		fsl,upm-addr-offset = <16>;
@@ -3042,30 +3037,24 @@ platforms are moved over to use the flattened-device-tree model.
     y) LEDs on GPIOs
 
     Required properties:
-      - compatible : should be "linux,gpio-led".
-      - linux,name : LED name.
-      - linux,active-low : property should be present if LED wired as
-        active-low.
-      - linux,default-trigger : Linux default trigger for this LED.
-      - linux,brightness : default brightness.
+      - compatible : should be "gpio-led".
+      - default-brightness : (optional) default brightness: 1 on, 0 off.
+        Assumed off if property doesn't present.
+      - linux,default-trigger : (optional) Linux default trigger for this LED.
       - gpios : should specify LED GPIO.
 
     Example:
 
-	led@0 {
-		compatible = "linux,gpio-led";
-		linux,name = "pwr";
-		linux,brightness = <1>;
-		linux,active-low;
-		gpios = <&mcu_pio 0>;
+	pwr-led@0 {
+		compatible = "gpio-led";
+		default-brightness = <1>;
+		gpios = <&mcu_pio 0 1>;
 	};
 
-	led@1 {
-	        compatible = "linux,gpio-led";
-	        linux,name = "hdd";
+	hdd-led@1 {
+	        compatible = "gpio-led";
 	        linux,default-trigger = "ide-disk";
-		linux,active-low;
-		gpios = <&mcu_pio 1>;
+		gpios = <&mcu_pio 1 0>;
 	};
 
 VII - Marvell Discovery mv64[345]6x System Controller chips

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
