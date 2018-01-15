Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zKdrz5kdRzF0bm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jan 2018 14:20:19 +1100 (AEDT)
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4/6] dt-bindings: gpio: Add binding for Wii GPIO controller
Date: Mon, 15 Jan 2018 04:13:59 +0100
Message-Id: <20180115031401.19577-5-j.neuschaefer@gmx.net>
In-Reply-To: <20180115031401.19577-1-j.neuschaefer@gmx.net>
References: <20180115031401.19577-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 .../bindings/gpio/nintendo,hollywood-gpio.txt      | 27 ++++++++++++++++++++++
 .../devicetree/bindings/powerpc/nintendo/wii.txt   |  9 +-------
 2 files changed, 28 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt

diff --git a/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
new file mode 100644
index 000000000000..a97ce6b5b724
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
@@ -0,0 +1,27 @@
+Nintendo Wii (Hollywood) GPIO controller
+
+Required properties:
+- compatible: "nintendo,hollywood-gpio
+- reg: Physical base address and length of the controller's registers.
+- gpio-controller: Marks the device node as a GPIO controller.
+- #gpio-cells: Should be <2>. The first cell is the pin number and the
+  second cell is used to specify optional parameters:
+   - bit 0 specifies polarity (0 for normal, 1 for inverted).
+
+Optional properties:
+- ngpios: see Documentation/devicetree/bindings/gpio/gpio.txt
+- interrupt-controller: Marks the device node as an interrupt controller.
+- #interrupt-cells: Should be two.
+- interrupts: Interrupt specifier for the controller's Broadway (PowerPC)
+  interrupt.
+- interrupt-parent: phandle of the parent interrupt controller.
+
+Example:
+
+	GPIO: gpio@0d8000c0 {
+		#gpio-cells = <2>;
+		compatible = "nintendo,hollywood-gpio";
+		reg = <0x0d8000c0 0x40>;
+		gpio-controller;
+		ngpios = <24>;
+	}
diff --git a/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt b/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
index 36afa322b04b..a3dc4b9fa11a 100644
--- a/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
+++ b/Documentation/devicetree/bindings/powerpc/nintendo/wii.txt
@@ -152,14 +152,7 @@ Nintendo Wii device tree
 
 1.l) The General Purpose I/O (GPIO) controller node
 
-  Represents the dual access 32 GPIO controller interface.
-
-  Required properties:
-
-  - #gpio-cells : <2>
-  - compatible : should be "nintendo,hollywood-gpio"
-  - reg : should contain the IPC registers location and length
-  - gpio-controller
+  see Documentation/devicetree/bindings/gpio/nintendo,hollywood-gpio.txt
 
 1.m) The control node
 
-- 
2.15.1
