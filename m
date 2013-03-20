Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 692192C0110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 21:22:38 +1100 (EST)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/5][RFC] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860 and B4420
Date: Wed, 20 Mar 2013 15:52:16 +0530
Message-ID: <1363774939-29909-2-git-send-email-shaveta@freescale.com>
In-Reply-To: <1363774939-29909-1-git-send-email-shaveta@freescale.com>
References: <1363774939-29909-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Shaveta Leekha <shaveta@freescale.com>, Vakul Garg <vakul@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

B4860 and B4420 are personalities of same silicon

* common silicon related features have been added in b4si-pre.dtsi and b4si-post.dtsi
* the various silicon differences are in respective files of personalities

Enable a B4 SoC to boot.  There are several things missing
from the device trees for B4:

* DPAA related nodes (Qman, Bman, Fman, Rman)
* DSP related nodes/information
* PAMU topology information

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Vakul Garg <vakul@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |   94 ++++++++++++
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi  |   49 ++++++
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  135 +++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   59 ++++++++
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  216 +++++++++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi     |   65 ++++++++
 6 files changed, 618 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4si-post.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/b4si-pre.dtsi

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
new file mode 100644
index 0000000..fad46e4
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -0,0 +1,94 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+/include/ "b4si-post.dtsi"
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,b4420-pcie", "fsl,qoriq-pcie-v2.4";
+};
+
+&dcsr {
+	dcsr-epu@0 {
+		compatible = "fsl,b4420-dcsr-epu", "fsl,dcsr-epu";
+	};
+	dcsr-npc {
+		compatible = "fsl,b4420-dcsr-cnpc", "fsl,dcsr-cnpc";
+	};
+	dcsr-dpaa@9000 {
+		compatible = "fsl,b4420-dcsr-dpaa", "fsl,dcsr-dpaa";
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,b4420-dcsr-ocn", "fsl,dcsr-ocn";
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,b4420-dcsr-nal", "fsl,dcsr-nal";
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,b4420-dcsr-rcpm", "fsl,dcsr-rcpm";
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,b4420-dcsr-snpc", "fsl,dcsr-snpc";
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,b4420-dcsr-snpc", "fsl,dcsr-snpc";
+	};
+	dcsr-cpu-sb-proxy@108000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x108000 0x1000 0x109000 0x1000>;
+	};
+};
+
+&soc {
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,b4420-l3-cache-controller", "cache";
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,b4420-corenet-cf";
+	};
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,b4420-device-config";
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,b4420-clockgen", "fsl,qoriq-clockgen-2";
+	};
+
+	L2: l2-cache-controller@c20000 {
+		compatible = "fsl,b4420-l2-cache-controller";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
new file mode 100644
index 0000000..555b0e4
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi
@@ -0,0 +1,49 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+/dts-v1/;
+
+/include/ "b4si-pre.dtsi"
+
+/ {
+	compatible = "fsl,B4420";
+
+	cpus {
+		cpu1: PowerPC,e6500@1 {
+			device_type = "cpu";
+			reg = <2 3>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
new file mode 100644
index 0000000..8916cfb
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -0,0 +1,135 @@
+/*
+ * B4860 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+/include/ "b4si-post.dtsi"
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,b4860-pcie", "fsl,qoriq-pcie-v2.4";
+};
+
+&rio {
+	compatible = "fsl,srio";
+	interrupts = <16 2 1 11>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+	ranges;
+
+	port1 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <1>;
+	};
+
+	port2 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		cell-index = <2>;
+	};
+};
+
+&dcsr {
+	dcsr-epu@0 {
+		compatible = "fsl,b4860-dcsr-epu", "fsl,dcsr-epu";
+	};
+	dcsr-npc {
+		compatible = "fsl,b4860-dcsr-cnpc", "fsl,dcsr-cnpc";
+	};
+	dcsr-dpaa@9000 {
+		compatible = "fsl,b4860-dcsr-dpaa", "fsl,dcsr-dpaa";
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,b4860-dcsr-ocn", "fsl,dcsr-ocn";
+	};
+	dcsr-ddr@13000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr2>;
+		reg = <0x13000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,b4860-dcsr-nal", "fsl,dcsr-nal";
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,b4860-dcsr-rcpm", "fsl,dcsr-rcpm";
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,b4860-dcsr-snpc", "fsl,dcsr-snpc";
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,b4860-dcsr-snpc", "fsl,dcsr-snpc";
+	};
+	dcsr-cpu-sb-proxy@108000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu1>;
+		reg = <0x108000 0x1000 0x109000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@110000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu2>;
+		reg = <0x110000 0x1000 0x111000 0x1000>;
+	};
+	dcsr-cpu-sb-proxy@118000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu3>;
+		reg = <0x118000 0x1000 0x119000 0x1000>;
+	};
+};
+
+&soc {
+	ddr2: memory-controller@9000 {
+		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
+		reg = <0x9000 0x1000>;
+		interrupts = <16 2 1 9>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,b4860-l3-cache-controller", "cache";
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,b4860-corenet-cf";
+	};
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,b4860-device-config";
+	};
+
+	clockgen: global-utilities@e1000 {
+		compatible = "fsl,b4860-clockgen", "fsl,qoriq-clockgen-2";
+	};
+
+	L2: l2-cache-controller@c20000 {
+		compatible = "fsl,b4860-l2-cache-controller";
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
new file mode 100644
index 0000000..f5737a0
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
@@ -0,0 +1,59 @@
+/*
+ * B4860 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
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
+/dts-v1/;
+
+/include/ "b4si-pre.dtsi"
+
+/ {
+	compatible = "fsl,B4860";
+
+	cpus {
+		cpu1: PowerPC,e6500@1 {
+			device_type = "cpu";
+			reg = <2 3>;
+			next-level-cache = <&L2>;
+		};
+		cpu2: PowerPC,e6500@2 {
+			device_type = "cpu";
+			reg = <4 5>;
+			next-level-cache = <&L2>;
+		};
+		cpu3: PowerPC,e6500@3 {
+			device_type = "cpu";
+			reg = <6 7>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
new file mode 100644
index 0000000..18163e3b
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -0,0 +1,216 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (post include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+&ifc {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	compatible = "fsl,ifc", "simple-bus";
+	interrupts = <25 2 0 0>;
+};
+
+/* controller at 0x200000 */
+&pci0 {
+	compatible = "fsl,b4-pcie", "fsl,qoriq-pcie-v2.4";
+	device_type = "pci";
+	#size-cells = <2>;
+	#address-cells = <3>;
+	bus-range = <0x0 0xff>;
+	interrupts = <20 2 0 0>;
+	pcie@0 {
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		device_type = "pci";
+		interrupts = <20 2 0 0>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <
+			/* IDSEL 0x0 */
+			0000 0 0 1 &mpic 40 1 0 0
+			0000 0 0 2 &mpic 1 1 0 0
+			0000 0 0 3 &mpic 2 1 0 0
+			0000 0 0 4 &mpic 3 1 0 0
+			>;
+	};
+};
+
+&dcsr {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	compatible = "fsl,dcsr", "simple-bus";
+
+	dcsr-epu@0 {
+		compatible = "fsl,b4-dcsr-epu", "fsl,dcsr-epu";
+		interrupts = <52 2 0 0
+			      84 2 0 0
+			      85 2 0 0
+			      94 2 0 0
+			      95 2 0 0>;
+		reg = <0x0 0x1000>;
+	};
+	dcsr-npc {
+		compatible = "fsl,b4-dcsr-cnpc", "fsl,dcsr-cnpc";
+		reg = <0x1000 0x1000 0x1002000 0x10000>;
+	};
+	dcsr-nxc@2000 {
+		compatible = "fsl,dcsr-nxc";
+		reg = <0x2000 0x1000>;
+	};
+	dcsr-corenet {
+		compatible = "fsl,dcsr-corenet";
+		reg = <0x8000 0x1000 0x1A000 0x1000>;
+	};
+	dcsr-dpaa@9000 {
+		compatible = "fsl,b4-dcsr-dpaa", "fsl,dcsr-dpaa";
+		reg = <0x9000 0x1000>;
+	};
+	dcsr-ocn@11000 {
+		compatible = "fsl,b4-dcsr-ocn", "fsl,dcsr-ocn";
+		reg = <0x11000 0x1000>;
+	};
+	dcsr-ddr@12000 {
+		compatible = "fsl,dcsr-ddr";
+		dev-handle = <&ddr1>;
+		reg = <0x12000 0x1000>;
+	};
+	dcsr-nal@18000 {
+		compatible = "fsl,b4-dcsr-nal", "fsl,dcsr-nal";
+		reg = <0x18000 0x1000>;
+	};
+	dcsr-rcpm@22000 {
+		compatible = "fsl,b4-dcsr-rcpm", "fsl,dcsr-rcpm";
+		reg = <0x22000 0x1000>;
+	};
+	dcsr-snpc@30000 {
+		compatible = "fsl,b4-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x30000 0x1000 0x1022000 0x10000>;
+	};
+	dcsr-snpc@31000 {
+		compatible = "fsl,b4-dcsr-snpc", "fsl,dcsr-snpc";
+		reg = <0x31000 0x1000 0x1042000 0x10000>;
+	};
+	dcsr-cpu-sb-proxy@100000 {
+		compatible = "fsl,dcsr-e6500-sb-proxy", "fsl,dcsr-cpu-sb-proxy";
+		cpu-handle = <&cpu0>;
+		reg = <0x100000 0x1000 0x101000 0x1000>;
+	};
+};
+
+&soc {
+	#address-cells = <1>;
+	#size-cells = <1>;
+	device_type = "soc";
+	compatible = "simple-bus";
+
+	soc-sram-error {
+		compatible = "fsl,soc-sram-error";
+		interrupts = <16 2 1 2>;
+	};
+
+	corenet-law@0 {
+		compatible = "fsl,corenet-law";
+		reg = <0x0 0x1000>;
+		fsl,num-laws = <32>;
+	};
+
+	ddr1: memory-controller@8000 {
+		compatible = "fsl,qoriq-memory-controller-v4.5", "fsl,qoriq-memory-controller";
+		reg = <0x8000 0x1000>;
+		interrupts = <16 2 1 8>;
+	};
+
+	cpc: l3-cache-controller@10000 {
+		compatible = "fsl,b4-l3-cache-controller", "cache";
+		reg = <0x10000 0x1000>;
+		interrupts = <16 2 1 4>;
+	};
+
+	corenet-cf@18000 {
+		compatible = "fsl,b4-corenet-cf";
+		reg = <0x18000 0x1000>;
+		interrupts = <16 2 1 0>;
+		fsl,ccf-num-csdids = <32>;
+		fsl,ccf-num-snoopids = <32>;
+	};
+
+	iommu@20000 {
+		compatible = "fsl,pamu";
+		reg = <0x20000 0x4000>;
+		interrupts = <
+			24 2 0 0
+			16 2 1 1>;
+	};
+
+/include/ "qoriq-mpic.dtsi"
+
+	guts: global-utilities@e0000 {
+		compatible = "fsl,b4-device-config";
+		reg = <0xe0000 0xe00>;
+		fsl,has-rstcr;
+		fsl,liodn-bits = <12>;
+	};
+
+	rcpm: global-utilities@e2000 {
+		compatible = "fsl,b4-rcpm", "fsl,qoriq-rcpm-2";
+		reg = <0xe2000 0x1000>;
+	};
+
+/include/ "qoriq-dma-0.dtsi"
+/include/ "qoriq-dma-1.dtsi"
+
+/include/ "qonverge-usb2-dr-0.dtsi"
+	usb0: usb@210000 {
+		compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+	};
+
+/include/ "qoriq-espi-0.dtsi"
+	spi@110000 {
+		fsl,espi-num-chipselects = <4>;
+	};
+
+/include/ "qoriq-esdhc-0.dtsi"
+	sdhc@114000 {
+		sdhci,auto-cmd12;
+	};
+/include/ "qoriq-i2c-0.dtsi"
+/include/ "qoriq-i2c-1.dtsi"
+/include/ "qoriq-duart-0.dtsi"
+/include/ "qoriq-duart-1.dtsi"
+/include/ "qoriq-sec5.3-0.dtsi"
+
+	L2: l2-cache-controller@c20000 {
+		compatible = "fsl,b4-l2-cache-controller";
+                reg = <0xc20000 0x1000>;
+		next-level-cache = <&cpc>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-pre.dtsi b/arch/powerpc/boot/dts/fsl/b4si-pre.dtsi
new file mode 100644
index 0000000..b6161c8
--- /dev/null
+++ b/arch/powerpc/boot/dts/fsl/b4si-pre.dtsi
@@ -0,0 +1,65 @@
+/*
+ * B4420 Silicon/SoC Device Tree Source (pre include)
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+/ {
+	compatible = "fsl,B4";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	aliases {
+		ccsr = &soc;
+		dcsr = &dcsr;
+
+		serial0 = &serial0;
+		serial1 = &serial1;
+		serial2 = &serial2;
+		serial3 = &serial3;
+		pci0 = &pci0;
+		dma0 = &dma0;
+		dma1 = &dma1;
+		sdhc = &sdhc;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: PowerPC,e6500@0 {
+			device_type = "cpu";
+			reg = <0 1>;
+			next-level-cache = <&L2>;
+		};
+	};
+};
-- 
1.7.6.GIT
