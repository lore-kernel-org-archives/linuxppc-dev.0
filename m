Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4qxY1ktQzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 08:08:01 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id n129so12161772wmn.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:08:01 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: linux-gpio@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 Kumar Gala <galak@codeaurora.org>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Alexandre Courbot <gnurou@gmail.com>,
 Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] gpio: dt-bindings: add ibm,ppc4xx-gpio binding
Date: Thu, 12 May 2016 00:07:48 +0200
Message-Id: <c7b118c342c161954126e2e82cf1a0a6a127b4c2.1463002267.git.chunkeey@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds binding information for IBM/AMCC/APM GPIO
Controllers of the PowerPC 4XX series and compatible SoCs.

The "PowerPC 405EP Embedded Processor Data Sheet" has the
following to say about the GPIO controllers: "

 - Controller functions and GPIO registers are programmed
   and accessed via memory-mapped OPB bus master accesses

 - All GPIOs are pin-shared with other functions. DCRs control
   whether a particular pin that has GPIO capabilities acts
   as a GPIO or is used for another purpose.

 - Each GPIO outputs is separately programmable to emulate
   an open-drain driver (i.e. drives to zero, threestated if
   output bit is 1)

"
The ppc4xx_gpio.c driver is part of the platform/sysdev drivers
in arch/powerpc/sysdev.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
I looked into arch/powerpc/sysdev/ppc4xx_gpio.c driver and
it doesn't have support for the tri-state logic (open drain
is disabled), but the hardware would support it.
(the #gpio-cells description suffers because of this, since
the high-z option isn't there).

Also there's another problem: There's no DCR pinmux driver?!
So sadly, there's not much information on how to use the DCRs
to control the which pin is muxed to the GPIO or to a SoC
function like the i2c.

This was all the valuable information I could find about the
hardware, so it is included it in the binding text, even
though there's no support for it... Is there anything else
to add?
---
 .../devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt   | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt b/Documentation/devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt
new file mode 100644
index 0000000..22aabb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/ibm,ppc4xx-gpio.txt
@@ -0,0 +1,24 @@
+* IBM/AMCC/APM GPIO Controller for PowerPC 4XX series and compatible SoCs
+
+All GPIOs are pin-shared with other functions. DCRs control whether a
+particular pin that has GPIO capabilities acts as a GPIO or is used for
+another purpose. GPIO outputs are separately programmable to emulate
+an open-drain driver.
+
+Required properties:
+	- compatible: must be "ibm,ppc4xx-gpio"
+	- reg: address and length of the register set for the device
+	- #gpio-cells: must be set to 2. The first cell is the pin number
+		and the second cell is used to specify the gpio polarity:
+		0 = active high
+		1 = active low
+	- gpio-controller: marks the device node as a gpio controller.
+
+Example:
+
+GPIO0: gpio@ef600b00 {
+	compatible = "ibm,ppc4xx-gpio";
+	reg = <0xef600b00 0x00000048>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
-- 
2.8.1
