Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BF936100C1C
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:14:26 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAGENeB031554
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:14:23 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH 07/30] powerpc/85xx: create dts components to build up an
 SoC
Date: Thu, 10 Nov 2011 10:13:50 -0600
Message-Id: <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
References: <1320941653-29797-1-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-2-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-3-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce some common components that we can utilize to build up the
various PQ3/85xx device trees.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi          |   66 +++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi          |   66 +++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi        |   51 ++++++++++
 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi        |   41 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi         |   41 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi       |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi       |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi       |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi       |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi |   39 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi       |   60 +++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi       |   60 +++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi       |   59 +++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi  |   42 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi  |   42 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi  |   42 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi         |   41 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi          |   43 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi          |   43 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi   |   42 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi           |   66 +++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi        |   40 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi        |   40 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi       |   43 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi       |   45 +++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi       |   45 +++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi       |   45 +++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi       |   65 ++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi      |   41 ++++++++
 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi      |   41 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi        |   66 +++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi        |   66 +++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi      |   51 ++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi      |   51 ++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi      |   40 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi       |   41 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi       |   41 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi        |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi        |   53 ++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi         |  106 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi        |   68 +++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi      |   39 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi      |   39 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi     |  100 +++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi     |  109 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi     |  109 +++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi    |   41 ++++++++
 arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi   |   41 ++++++++
 48 files changed, 2575 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
new file mode 100644
index 0000000..b5b37ad
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
@@ -0,0 +1,66 @@
+/*
+ * PQ3 DMA device tree stub [ controller @ offset 0x21000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+dma@21300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0x21300 0x4>;
+	ranges = <0x0 0x21100 0x200>;
+	cell-index = <0>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <20 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <21 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <22 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <23 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi
new file mode 100644
index 0000000..28cb8a5
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-dma-1.dtsi
@@ -0,0 +1,66 @@
+/*
+ * PQ3 DMA device tree stub [ controller @ offset 0xc300 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+dma@c300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0xc300 0x4>;
+	ranges = <0x0 0xc100 0x200>;
+	cell-index = <1>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <76 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <77 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <78 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <79 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
new file mode 100644
index 0000000..00fa1fd
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
@@ -0,0 +1,51 @@
+/*
+ * PQ3 DUART device tree stub [ controller @ offset 0x4000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+serial0: serial@4500 {
+	cell-index = <0>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4500 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
+
+serial1: serial@4600 {
+	cell-index = <1>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4600 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
new file mode 100644
index 0000000..5743433
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * PQ3 eSDHC device tree stub [ controller @ offset 0x2e000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sdhc@2e000 {
+	compatible = "fsl,esdhc";
+	reg = <0x2e000 0x1000>;
+	interrupts = <72 0x2 0 0>;
+	/* Filled in by U-Boot */
+	clock-frequency = <0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
new file mode 100644
index 0000000..75854b2
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * PQ3 eSPI device tree stub [ controller @ offset 0x7000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+spi@7000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,mpc8536-espi";
+	reg = <0x7000 0x1000>;
+	interrupts = <59 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
new file mode 100644
index 0000000..a1979ae
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
@@ -0,0 +1,53 @@
+/*
+ * PQ3 eTSEC device tree stub [ @ offsets 0x24000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+ethernet@24000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <0>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "gianfar";
+	reg = <0x24000 0x1000>;
+	ranges = <0x0 0x24000 0x1000>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+	interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
+};
+
+mdio@24520 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,gianfar-mdio";
+	reg = <0x24520 0x20>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
new file mode 100644
index 0000000..4c4fdde
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
@@ -0,0 +1,53 @@
+/*
+ * PQ3 eTSEC device tree stub [ @ offsets 0x25000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+ethernet@25000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "gianfar";
+	reg = <0x25000 0x1000>;
+	ranges = <0x0 0x25000 0x1000>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+	interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
+};
+
+mdio@25520 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,gianfar-tbi";
+	reg = <0x25520 0x20>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
new file mode 100644
index 0000000..4b8ab43
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
@@ -0,0 +1,53 @@
+/*
+ * PQ3 eTSEC device tree stub [ @ offsets 0x26000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+ethernet@26000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <2>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "gianfar";
+	reg = <0x26000 0x1000>;
+	ranges = <0x0 0x26000 0x1000>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+	interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
+};
+
+mdio@26520 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,gianfar-tbi";
+	reg = <0x26520 0x20>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
new file mode 100644
index 0000000..40c9137
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
@@ -0,0 +1,53 @@
+/*
+ * PQ3 eTSEC device tree stub [ @ offsets 0x27000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+ethernet@27000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	cell-index = <3>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "gianfar";
+	reg = <0x27000 0x1000>;
+	ranges = <0x0 0x27000 0x1000>;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+	interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
+};
+
+mdio@27520 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,gianfar-tbi";
+	reg = <0x27520 0x20>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi
new file mode 100644
index 0000000..efe2ca0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-timer-0.dtsi
@@ -0,0 +1,39 @@
+/*
+ * PQ3 eTSEC Timer (IEEE 1588) device tree stub [ @ offsets 0x24e00 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+ptp_clock@24e00 {
+	compatible = "fsl,etsec-ptp";
+	reg = <0x24e00 0xb0>;
+	interrupts = <68 2 0 0 69 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
new file mode 100644
index 0000000..1382fec
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -0,0 +1,60 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x24000/0xb0000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+
+mdio@24000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-mdio";
+	reg = <0x24000 0x1000 0xb0030 0x4>;
+};
+
+ethernet@b0000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@b0000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb0000 0x1000>;
+		interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
new file mode 100644
index 0000000..221cd2e
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
@@ -0,0 +1,60 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x25000/0xb1000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+
+mdio@25000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x25000 0x1000 0xb1030 0x4>;
+};
+
+ethernet@b1000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@b1000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb1000 0x1000>;
+		interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
new file mode 100644
index 0000000..61456c3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
@@ -0,0 +1,59 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x26000/0xb2000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+mdio@26000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x26000 0x1000 0xb1030 0x4>;
+};
+
+ethernet@b2000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "network";
+	model = "eTSEC";
+	compatible = "fsl,etsec2";
+	fsl,num_rx_queues = <0x8>;
+	fsl,num_tx_queues = <0x8>;
+	fsl,magic-packet;
+	local-mac-address = [ 00 00 00 00 00 00 ];
+
+	queue-group@b2000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb2000 0x1000>;
+		interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi
new file mode 100644
index 0000000..034ab8f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-0.dtsi
@@ -0,0 +1,42 @@
+/*
+ * PQ3 eTSEC2 Group 2 device tree stub [ @ offsets 0xb4000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&enet0_grp2 {
+	queue-group@b4000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb4000 0x1000>;
+		interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi
new file mode 100644
index 0000000..3be9ba3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-1.dtsi
@@ -0,0 +1,42 @@
+/*
+ * PQ3 eTSEC2 Group 2 device tree stub [ @ offsets 0xb5000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&enet1_grp2 {
+	queue-group@b5000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb5000 0x1000>;
+		interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi
new file mode 100644
index 0000000..02a3345
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-grp2-2.dtsi
@@ -0,0 +1,42 @@
+/*
+ * PQ3 eTSEC2 Group 2 device tree stub [ @ offsets 0xb6000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&enet2_grp2 {
+	queue-group@b6000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb6000 0x1000>;
+		interrupts = <25 2 0 0 26 2 0 0 27 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
new file mode 100644
index 0000000..72a3ef5
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * PQ3 GPIO device tree stub [ controller @ offset 0xf000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+gpio-controller@f000 {
+	#gpio-cells = <2>;
+	compatible = "fsl,pq3-gpio";
+	reg = <0xf000 0x100>;
+	interrupts = <47 0x2 0 0>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
new file mode 100644
index 0000000..d1dd6fb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
@@ -0,0 +1,43 @@
+/*
+ * PQ3 I2C device tree stub [ controller @ offset 0x3000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+i2c@3000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <0>;
+	compatible = "fsl-i2c";
+	reg = <0x3000 0x100>;
+	interrupts = <43 2 0 0>;
+	dfsrr;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
new file mode 100644
index 0000000..a9bd803
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
@@ -0,0 +1,43 @@
+/*
+ * PQ3 I2C device tree stub [ controller @ offset 0x3100 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+i2c@3100 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <1>;
+	compatible = "fsl-i2c";
+	reg = <0x3100 0x100>;
+	interrupts = <43 2 0 0>;
+	dfsrr;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
new file mode 100644
index 0000000..8734cff
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
@@ -0,0 +1,42 @@
+/*
+ * PQ3 MPIC Timer (Group B) device tree stub [ controller @ offset 0x42100 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+timer@42100 {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x42100 0x100 0x42300 4>;
+	interrupts = <4 0 3 0
+		      5 0 3 0
+		      6 0 3 0
+		      7 0 3 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
new file mode 100644
index 0000000..5c80460
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
@@ -0,0 +1,66 @@
+/*
+ * PQ3 MPIC device tree stub [ controller @ offset 0x40000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+mpic: pic@40000 {
+	interrupt-controller;
+	#address-cells = <0>;
+	#interrupt-cells = <4>;
+	reg = <0x40000 0x40000>;
+	compatible = "fsl,mpic";
+	device_type = "open-pic";
+};
+
+timer@41100 {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x41100 0x100 0x41300 4>;
+	interrupts = <0 0 3 0
+		      1 0 3 0
+		      2 0 3 0
+		      3 0 3 0>;
+};
+
+msi@41600 {
+	compatible = "fsl,mpic-msi";
+	reg = <0x41600 0x80>;
+	msi-available-ranges = <0 0x100>;
+	interrupts = <
+		0xe0 0 0 0
+		0xe1 0 0 0
+		0xe2 0 0 0
+		0xe3 0 0 0
+		0xe4 0 0 0
+		0xe5 0 0 0
+		0xe6 0 0 0
+		0xe7 0 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi
new file mode 100644
index 0000000..3c28dd0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sata2-0.dtsi
@@ -0,0 +1,40 @@
+/*
+ * PQ3 SATAv2 device tree stub [ controller @ offset 0x18000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sata@18000 {
+	compatible = "fsl,pq-sata-v2";
+	reg = <0x18000 0x1000>;
+	cell-index = <1>;
+	interrupts = <74 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi
new file mode 100644
index 0000000..eefaf28
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sata2-1.dtsi
@@ -0,0 +1,40 @@
+/*
+ * PQ3 SATAv2 device tree stub [ controller @ offset 0x19000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sata@19000 {
+	compatible = "fsl,pq-sata-v2";
+	reg = <0x19000 0x1000>;
+	cell-index = <2>;
+	interrupts = <41 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi
new file mode 100644
index 0000000..02a5c7a
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec2.1-0.dtsi
@@ -0,0 +1,43 @@
+/*
+ * PQ3 Sec/Crypto 2.1 device tree stub [ controller @ offset 0x30000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto@30000 {
+	compatible = "fsl,sec2.1", "fsl,sec2.0";
+	reg = <0x30000 0x10000>;
+	interrupts = <45 2 0 0>;
+	fsl,num-channels = <4>;
+	fsl,channel-fifo-len = <24>;
+	fsl,exec-units-mask = <0xfe>;
+	fsl,descriptor-types-mask = <0x12b0ebf>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi
new file mode 100644
index 0000000..bba1ba4
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec3.0-0.dtsi
@@ -0,0 +1,45 @@
+/*
+ * PQ3 Sec/Crypto 3.0 device tree stub [ controller @ offset 0x30000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto@30000 {
+	compatible = "fsl,sec3.0",
+		     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+		     "fsl,sec2.0";
+	reg = <0x30000 0x10000>;
+	interrupts = <45 2 0 0 58 2 0 0>;
+	fsl,num-channels = <4>;
+	fsl,channel-fifo-len = <24>;
+	fsl,exec-units-mask = <0x9fe>;
+	fsl,descriptor-types-mask = <0x3ab0ebf>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi
new file mode 100644
index 0000000..8f0a566
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec3.1-0.dtsi
@@ -0,0 +1,45 @@
+/*
+ * PQ3 Sec/Crypto 3.1 device tree stub [ controller @ offset 0x30000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto@30000 {
+	compatible = "fsl,sec3.1", "fsl,sec3.0",
+		     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+		     "fsl,sec2.0";
+	reg = <0x30000 0x10000>;
+	interrupts = <45 2 0 0 58 2 0 0>;
+	fsl,num-channels = <4>;
+	fsl,channel-fifo-len = <24>;
+	fsl,exec-units-mask = <0xbfe>;
+	fsl,descriptor-types-mask = <0x3ab0ebf>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi
new file mode 100644
index 0000000..c227f27
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi
@@ -0,0 +1,45 @@
+/*
+ * PQ3 Sec/Crypto 3.3 device tree stub [ controller @ offset 0x30000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto@30000 {
+	compatible = "fsl,sec3.3", "fsl,sec3.1", "fsl,sec3.0",
+		     "fsl,sec2.4", "fsl,sec2.2", "fsl,sec2.1",
+		     "fsl,sec2.0";
+	reg = <0x30000 0x10000>;
+	interrupts = <45 2 0 0 58 2 0 0>;
+	fsl,num-channels = <4>;
+	fsl,channel-fifo-len = <24>;
+	fsl,exec-units-mask = <0x97c>;
+	fsl,descriptor-types-mask = <0x3a30abf>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
new file mode 100644
index 0000000..bf957a7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
@@ -0,0 +1,65 @@
+/*
+ * PQ3 Sec/Crypto 4.4 device tree stub [ controller @ offset 0x30000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto@30000 {
+	compatible = "fsl,sec4.4", "fsl,sec4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg		 = <0x30000 0x10000>;
+	interrupts	 = <58 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		reg	   = <0x1000 0x1000>;
+		interrupts	 = <45 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		reg	   = <0x2000 0x1000>;
+		interrupts	 = <45 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		reg	   = <0x3000 0x1000>;
+		interrupts	 = <45 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		reg	   = <0x4000 0x1000>;
+		interrupts	 = <45 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi
new file mode 100644
index 0000000..185ab9d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * PQ3 USB DR device tree stub [ controller @ offset 0x22000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+usb@22000 {
+	compatible = "fsl-usb2-dr";
+	reg = <0x22000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <28 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi
new file mode 100644
index 0000000..fe24cd6
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-usb2-dr-1.dtsi
@@ -0,0 +1,41 @@
+/*
+ * PQ3 USB DR device tree stub [ controller @ offset 0x23000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+usb@23000 {
+	compatible = "fsl-usb2-dr";
+	reg = <0x23000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <46 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi
new file mode 100644
index 0000000..1aebf3e
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-dma-0.dtsi
@@ -0,0 +1,66 @@
+/*
+ * QorIQ DMA device tree stub [ controller @ offset 0x100000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+dma0: dma@100300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0x100300 0x4>;
+	ranges = <0x0 0x100100 0x200>;
+	cell-index = <0>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <28 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <29 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <30 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <31 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi
new file mode 100644
index 0000000..ecf5e18
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-dma-1.dtsi
@@ -0,0 +1,66 @@
+/*
+ * QorIQ DMA device tree stub [ controller @ offset 0x101000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+dma1: dma@101300 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,eloplus-dma";
+	reg = <0x101300 0x4>;
+	ranges = <0x0 0x101100 0x200>;
+	cell-index = <1>;
+	dma-channel@0 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x0 0x80>;
+		cell-index = <0>;
+		interrupts = <32 2 0 0>;
+	};
+	dma-channel@80 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x80 0x80>;
+		cell-index = <1>;
+		interrupts = <33 2 0 0>;
+	};
+	dma-channel@100 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x100 0x80>;
+		cell-index = <2>;
+		interrupts = <34 2 0 0>;
+	};
+	dma-channel@180 {
+		compatible = "fsl,eloplus-dma-channel";
+		reg = <0x180 0x80>;
+		cell-index = <3>;
+		interrupts = <35 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
new file mode 100644
index 0000000..66271e3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi
@@ -0,0 +1,51 @@
+/*
+ * QorIQ DUART device tree stub [ controller @ offset 0x11c000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+serial0: serial@11c500 {
+	cell-index = <0>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x11c500 0x100>;
+	clock-frequency = <0>;
+	interrupts = <36 2 0 0>;
+};
+
+serial1: serial@11c600 {
+	cell-index = <1>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x11c600 0x100>;
+	clock-frequency = <0>;
+	interrupts = <36 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
new file mode 100644
index 0000000..cf1a0ac
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi
@@ -0,0 +1,51 @@
+/*
+ * QorIQ DUART device tree stub [ controller @ offset 0x11d000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+serial2: serial@11d500 {
+	cell-index = <2>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x11d500 0x100>;
+	clock-frequency = <0>;
+	interrupts = <37 2 0 0>;
+};
+
+serial3: serial@11d600 {
+	cell-index = <3>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x11d600 0x100>;
+	clock-frequency = <0>;
+	interrupts = <37 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
new file mode 100644
index 0000000..20835ae
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
@@ -0,0 +1,40 @@
+/*
+ * QorIQ eSDHC device tree stub [ controller @ offset 0x114000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sdhc: sdhc@114000 {
+	compatible = "fsl,esdhc";
+	reg = <0x114000 0x1000>;
+	interrupts = <48 2 0 0>;
+	clock-frequency = <0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
new file mode 100644
index 0000000..6db0697
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-espi-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ eSPI device tree stub [ controller @ offset 0x110000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+spi@110000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,mpc8536-espi";
+	reg = <0x110000 0x1000>;
+	interrupts = <53 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
new file mode 100644
index 0000000..cf714f5
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-gpio-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ GPIO device tree stub [ controller @ offset 0x130000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+gpio0: gpio@130000 {
+	compatible = "fsl,qoriq-gpio";
+	reg = <0x130000 0x1000>;
+	interrupts = <55 2 0 0>;
+	#gpio-cells = <2>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
new file mode 100644
index 0000000..5f9bf7d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-0.dtsi
@@ -0,0 +1,53 @@
+/*
+ * QorIQ I2C device tree stub [ controller @ offset 0x118000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+i2c@118000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <0>;
+	compatible = "fsl-i2c";
+	reg = <0x118000 0x100>;
+	interrupts = <38 2 0 0>;
+	dfsrr;
+};
+
+i2c@118100 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <1>;
+	compatible = "fsl-i2c";
+	reg = <0x118100 0x100>;
+	interrupts = <38 2 0 0>;
+	dfsrr;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
new file mode 100644
index 0000000..7989bf5
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-i2c-1.dtsi
@@ -0,0 +1,53 @@
+/*
+ * QorIQ I2C device tree stub [ controller @ offset 0x119000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+i2c@119000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <2>;
+	compatible = "fsl-i2c";
+	reg = <0x119000 0x100>;
+	interrupts = <39 2 0 0>;
+	dfsrr;
+};
+
+i2c@119100 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	cell-index = <3>;
+	compatible = "fsl-i2c";
+	reg = <0x119100 0x100>;
+	interrupts = <39 2 0 0>;
+	dfsrr;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
new file mode 100644
index 0000000..b9bada6
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-mpic.dtsi
@@ -0,0 +1,106 @@
+/*
+ * QorIQ MPIC device tree stub [ controller @ offset 0x40000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+mpic: pic@40000 {
+	interrupt-controller;
+	#address-cells = <0>;
+	#interrupt-cells = <4>;
+	reg = <0x40000 0x40000>;
+	compatible = "fsl,mpic", "chrp,open-pic";
+	device_type = "open-pic";
+	clock-frequency = <0x0>;
+};
+
+timer@41100 {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x41100 0x100 0x41300 4>;
+	interrupts = <0 0 3 0
+		      1 0 3 0
+		      2 0 3 0
+		      3 0 3 0>;
+};
+
+msi0: msi@41600 {
+	compatible = "fsl,mpic-msi";
+	reg = <0x41600 0x200>;
+	msi-available-ranges = <0 0x100>;
+	interrupts = <
+		0xe0 0 0 0
+		0xe1 0 0 0
+		0xe2 0 0 0
+		0xe3 0 0 0
+		0xe4 0 0 0
+		0xe5 0 0 0
+		0xe6 0 0 0
+		0xe7 0 0 0>;
+};
+
+msi1: msi@41800 {
+	compatible = "fsl,mpic-msi";
+	reg = <0x41800 0x200>;
+	msi-available-ranges = <0 0x100>;
+	interrupts = <
+		0xe8 0 0 0
+		0xe9 0 0 0
+		0xea 0 0 0
+		0xeb 0 0 0
+		0xec 0 0 0
+		0xed 0 0 0
+		0xee 0 0 0
+		0xef 0 0 0>;
+};
+
+msi2: msi@41a00 {
+	compatible = "fsl,mpic-msi";
+	reg = <0x41a00 0x200>;
+	msi-available-ranges = <0 0x100>;
+	interrupts = <
+		0xf0 0 0 0
+		0xf1 0 0 0
+		0xf2 0 0 0
+		0xf3 0 0 0
+		0xf4 0 0 0
+		0xf5 0 0 0
+		0xf6 0 0 0
+		0xf7 0 0 0>;
+};
+
+timer@42100 {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x42100 0x100 0x42300 4>;
+	interrupts = <4 0 3 0
+		      5 0 3 0
+		      6 0 3 0
+		      7 0 3 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi
new file mode 100644
index 0000000..ca7fec7
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-rmu-0.dtsi
@@ -0,0 +1,68 @@
+/*
+ * QorIQ RIO Message Unit device tree stub [ controller @ offset 0xd3000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+rmu: rmu@d3000 {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,srio-rmu";
+	reg = <0xd3000 0x500>;
+	ranges = <0x0 0xd3000 0x500>;
+
+	message-unit@0 {
+		compatible = "fsl,srio-msg-unit";
+		reg = <0x0 0x100>;
+		interrupts = <
+			60 2 0 0  /* msg1_tx_irq */
+			61 2 0 0>;/* msg1_rx_irq */
+	};
+	message-unit@100 {
+		compatible = "fsl,srio-msg-unit";
+		reg = <0x100 0x100>;
+		interrupts = <
+			62 2 0 0  /* msg2_tx_irq */
+			63 2 0 0>;/* msg2_rx_irq */
+	};
+	doorbell-unit@400 {
+		compatible = "fsl,srio-dbell-unit";
+		reg = <0x400 0x80>;
+		interrupts = <
+			56 2 0 0  /* bell_outb_irq */
+			57 2 0 0>;/* bell_inb_irq */
+	};
+	port-write-unit@4e0 {
+		compatible = "fsl,srio-port-write-unit";
+		reg = <0x4e0 0x20>;
+		interrupts = <16 2 1 11>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi
new file mode 100644
index 0000000..b642047
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sata2-0.dtsi
@@ -0,0 +1,39 @@
+/*
+ * QorIQ SATAv2 device tree stub [ controller @ offset 0x220000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sata@220000 {
+	compatible = "fsl,pq-sata-v2";
+	reg = <0x220000 0x1000>;
+	interrupts = <68 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi
new file mode 100644
index 0000000..c573702
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sata2-1.dtsi
@@ -0,0 +1,39 @@
+/*
+ * QorIQ SATAv2 device tree stub [ controller @ offset 0x221000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+sata@221000 {
+	compatible = "fsl,pq-sata-v2";
+	reg = <0x221000 0x1000>;
+	interrupts = <69 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
new file mode 100644
index 0000000..0cbbac3
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.0-0.dtsi
@@ -0,0 +1,100 @@
+/*
+ * QorIQ Sec/Crypto 4.0 device tree stub [ controller @ offset 0x300000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto: crypto@300000 {
+	compatible = "fsl,sec-v4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg = <0x300000 0x10000>;
+	ranges = <0 0x300000 0x10000>;
+	interrupts = <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec-v4.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec-v4.0-job-ring";
+		reg = <0x2000 0x1000>;
+		interrupts = <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec-v4.0-job-ring";
+		reg = <0x3000 0x1000>;
+		interrupts = <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec-v4.0-job-ring";
+		reg = <0x4000 0x1000>;
+		interrupts = <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible = "fsl,sec-v4.0-rtic";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x6000 0x100>;
+		ranges = <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible = "fsl,sec-v4.0-rtic-memory";
+			reg = <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible = "fsl,sec-v4.0-rtic-memory";
+			reg = <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible = "fsl,sec-v4.0-rtic-memory";
+			reg = <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible = "fsl,sec-v4.0-rtic-memory";
+			reg = <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible = "fsl,sec-v4.0-mon";
+	reg = <0x314000 0x1000>;
+	interrupts = <93 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
new file mode 100644
index 0000000..3308986
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.1-0.dtsi
@@ -0,0 +1,109 @@
+/*
+ * QorIQ Sec/Crypto 4.1 device tree stub [ controller @ offset 0x300000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto: crypto@300000 {
+	compatible = "fsl,sec-v4.1", "fsl,sec-v4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg		 = <0x300000 0x10000>;
+	ranges		 = <0 0x300000 0x10000>;
+	interrupts	 = <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec-v4.1-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec-v4.1-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x2000 0x1000>;
+		interrupts = <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec-v4.1-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x3000 0x1000>;
+		interrupts = <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec-v4.1-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x4000 0x1000>;
+		interrupts = <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible = "fsl,sec-v4.1-rtic",
+			     "fsl,sec-v4.0-rtic";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x6000 0x100>;
+		ranges = <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible = "fsl,sec-v4.1-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible = "fsl,sec-v4.1-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible = "fsl,sec-v4.1-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible = "fsl,sec-v4.1-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible = "fsl,sec-v4.1-mon", "fsl,sec-v4.0-mon";
+	reg = <0x314000 0x1000>;
+	interrupts = <93 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
new file mode 100644
index 0000000..7990e0d
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-sec4.2-0.dtsi
@@ -0,0 +1,109 @@
+/*
+ * QorIQ Sec/Crypto 4.2 device tree stub [ controller @ offset 0x300000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+crypto: crypto@300000 {
+	compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	reg		 = <0x300000 0x10000>;
+	ranges		 = <0 0x300000 0x10000>;
+	interrupts	 = <92 2 0 0>;
+
+	sec_jr0: jr@1000 {
+		compatible = "fsl,sec-v4.2-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x1000 0x1000>;
+		interrupts = <88 2 0 0>;
+	};
+
+	sec_jr1: jr@2000 {
+		compatible = "fsl,sec-v4.2-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x2000 0x1000>;
+		interrupts = <89 2 0 0>;
+	};
+
+	sec_jr2: jr@3000 {
+		compatible = "fsl,sec-v4.2-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x3000 0x1000>;
+		interrupts = <90 2 0 0>;
+	};
+
+	sec_jr3: jr@4000 {
+		compatible = "fsl,sec-v4.2-job-ring",
+			     "fsl,sec-v4.0-job-ring";
+		reg = <0x4000 0x1000>;
+		interrupts = <91 2 0 0>;
+	};
+
+	rtic@6000 {
+		compatible = "fsl,sec-v4.2-rtic",
+			     "fsl,sec-v4.0-rtic";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x6000 0x100>;
+		ranges = <0x0 0x6100 0xe00>;
+
+		rtic_a: rtic-a@0 {
+			compatible = "fsl,sec-v4.2-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x00 0x20 0x100 0x80>;
+		};
+
+		rtic_b: rtic-b@20 {
+			compatible = "fsl,sec-v4.2-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x20 0x20 0x200 0x80>;
+		};
+
+		rtic_c: rtic-c@40 {
+			compatible = "fsl,sec-v4.2-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x40 0x20 0x300 0x80>;
+		};
+
+		rtic_d: rtic-d@60 {
+			compatible = "fsl,sec-v4.2-rtic-memory",
+				     "fsl,sec-v4.0-rtic-memory";
+			reg = <0x60 0x20 0x500 0x80>;
+		};
+	};
+};
+
+sec_mon: sec_mon@314000 {
+	compatible = "fsl,sec-v4.2-mon", "fsl,sec-v4.0-mon";
+	reg = <0x314000 0x1000>;
+	interrupts = <93 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi
new file mode 100644
index 0000000..4dd6f84
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-usb2-dr-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ USB DR device tree stub [ controller @ offset 0x211000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+usb@211000 {
+	compatible = "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+	reg = <0x211000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <45 0x2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi
new file mode 100644
index 0000000..f053835
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/qoriq-usb2-mph-0.dtsi
@@ -0,0 +1,41 @@
+/*
+ * QorIQ USB Host device tree stub [ controller @ offset 0x210000 ]
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+usb@210000 {
+	compatible = "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+	reg = <0x210000 0x1000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	interrupts = <44 0x2 0 0>;
+};
-- 
1.7.3.4
