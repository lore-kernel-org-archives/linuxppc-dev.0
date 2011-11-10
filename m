Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DB07B1007DC
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2011 03:07:20 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id pAAG7HUJ027713
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2011 10:07:17 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 08/11] powerpc/85xx: create dts components to build up an SoC
Date: Thu, 10 Nov 2011 10:07:06 -0600
Message-Id: <1320941229-29557-8-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1320941229-29557-7-git-send-email-galak@kernel.crashing.org>
References: <1320941229-29557-1-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-2-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-3-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-4-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-5-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-6-git-send-email-galak@kernel.crashing.org>
 <1320941229-29557-7-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi        |   66 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi      |   51 +++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi      |   41 ++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi       |   42 ++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi     |   67 +++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi     |   67 +++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi     |   66 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi       |   41 ++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi        |   43 +++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi        |   43 +++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi |   42 ++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi         |   66 ++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi     |   45 +++++++++++++++
 13 files changed, 680 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-i2c-1.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-timer-B.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-dma-0.dtsi
new file mode 100644
index 0000000..caf0b1e
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
+&dma0 {
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
diff --git a/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi
new file mode 100644
index 0000000..3cd2545
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
+&serial0 {
+	cell-index = <0>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4500 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
+
+&serial1 {
+	cell-index = <1>;
+	device_type = "serial";
+	compatible = "ns16550";
+	reg = <0x4600 0x100>;
+	clock-frequency = <0>;
+	interrupts = <42 2 0 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
new file mode 100644
index 0000000..b4e428c
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
+&sdhc0 {
+	compatible = "fsl,esdhc";
+	reg = <0x2e000 0x1000>;
+	interrupts = <72 0x2 0 0>;
+	/* Filled in by U-Boot */
+	clock-frequency = <0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
new file mode 100644
index 0000000..4a51bce
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-espi-0.dtsi
@@ -0,0 +1,42 @@
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
+&spi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,mpc8536-espi";
+	reg = <0x7000 0x1000>;
+	interrupts = <59 0x2 0 0>;
+	fsl,espi-num-chipselects = <4>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
new file mode 100644
index 0000000..c65b434
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-0.dtsi
@@ -0,0 +1,67 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x24000/0xb0000/0xb4000 ]
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
+&mdio0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-mdio";
+	reg = <0x24000 0x1000 0xb0030 0x4>;
+};
+
+&enet0 {
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
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb0000 0x1000>;
+		interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb4000 0x1000>;
+		interrupts = <17 2 0 0 18 2 0 0 24 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
new file mode 100644
index 0000000..9490f4f
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-1.dtsi
@@ -0,0 +1,67 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x25000/0xb1000/0xb5000 ]
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
+&mdio1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x25000 0x1000 0xb1030 0x4>;
+};
+
+&enet1 {
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
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb1000 0x1000>;
+		interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb5000 0x1000>;
+		interrupts = <51 2 0 0 52 2 0 0 67 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
new file mode 100644
index 0000000..61efc92
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec2-2.dtsi
@@ -0,0 +1,66 @@
+/*
+ * PQ3 eTSEC2 device tree stub [ @ offsets 0x26000/0xb2000/0xb6000 ]
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
+&mdio2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "fsl,etsec2-tbi";
+	reg = <0x26000 0x1000 0xb1030 0x4>;
+};
+
+&enet2 {
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
+	queue-group@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb2000 0x1000>;
+		interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
+	};
+
+	queue-group@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xb6000 0x1000>;
+		interrupts = <25 2 0 0 26 2 0 0 27 2 0 0>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi
new file mode 100644
index 0000000..a62a6d8
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
+&gpio0 {
+	#gpio-cells = <2>;
+	compatible = "fsl,pq3-gpio";
+	reg = <0xf000 0x100>;
+	interrupts = <47 0x2 0 0>;
+	gpio-controller;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-i2c-0.dtsi
new file mode 100644
index 0000000..82f5aaa
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
+&i2c0 {
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
index 0000000..ac077de
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
+&i2c1 {
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
index 0000000..274b16a
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
+&timerB {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x42100 0x100 0x42300 4>;
+	interrupts = <4 0 3 0
+		      5 0 3 0
+		      6 0 3 0
+		      7 0 3 0>;
+};
diff --git a/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi b/arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi
new file mode 100644
index 0000000..94ecd9f
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
+&mpic {
+	interrupt-controller;
+	#address-cells = <0>;
+	#interrupt-cells = <4>;
+	reg = <0x40000 0x40000>;
+	compatible = "chrp,open-pic";
+	device_type = "open-pic";
+};
+
+&timerA {
+	compatible = "fsl,mpic-global-timer";
+	reg = <0x41100 0x100 0x41300 4>;
+	interrupts = <0 0 3 0
+		      1 0 3 0
+		      2 0 3 0
+		      3 0 3 0>;
+};
+
+&msiA {
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
diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec3.3-0.dtsi
new file mode 100644
index 0000000..d06d2c4
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
+&crypto {
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
-- 
1.7.3.4
