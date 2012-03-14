Return-Path: <r66093@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 288ABB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 20:18:28 +1100 (EST)
Received: from mail85-am1 (localhost [127.0.0.1])	by mail85-am1-R.bigfish.com
 (Postfix) with ESMTP id 0B160A0153	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 14 Mar 2012 09:18:17 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.225])	by
 mail85-am1.bigfish.com (Postfix) with ESMTP id C7F0316001D	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 09:18:15 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] powerpc/85xx: add the P1020MBG-PC DTS support
Date: Wed, 14 Mar 2012 17:08:29 +0800
Message-ID: <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/boot/dts/p1020mbg-pc.dtsi    |  153 +++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts |   89 +++++++++++++++++
 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts |   89 +++++++++++++++++
 3 files changed, 331 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts

diff --git a/arch/powerpc/boot/dts/p1020mbg-pc.dtsi b/arch/powerpc/boot/dts/p1020mbg-pc.dtsi
new file mode 100644
index 0000000..dc0f0dd
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020mbg-pc.dtsi
@@ -0,0 +1,153 @@
+/*
+ * P1020 MBG-PC Device Tree Source stub (no addresses or top-level ranges)
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
+&lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x4000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			/* 128KB for DTB Image */
+			reg = <0x0 0x00020000>;
+			label = "NOR (RO) DTB Image";
+			read-only;
+		};
+
+		partition@20000 {
+			/* 3.875 MB for Linux Kernel Image */
+			reg = <0x00020000 0x003e0000>;
+			label = "NOR (RO) Linux Kernel Image";
+			read-only;
+		};
+
+		partition@400000 {
+			/* 58MB for Root file System */
+			reg = <0x00400000 0x03a00000>;
+			label = "NOR (RW) Root File System";
+		};
+
+		partition@3e00000 {
+			/* This location must not be altered  */
+			/* 1M for Vitesse 7385 Switch firmware */
+			reg = <0x3e00000 0x00100000>;
+			label = "NOR (RO) Vitesse-7385 Firmware";
+			read-only;
+		};
+
+		partition@3f00000 {
+			/* This location must not be altered  */
+			/* 512KB for u-boot Bootloader Image */
+			/* 512KB for u-boot Environment Variables */
+			reg = <0x03f00000 0x00100000>;
+			label = "NOR (RO) U-Boot Image";
+			read-only;
+		};
+	};
+
+	L2switch@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "vitesse-7385";
+		reg = <0x2 0x0 0x20000>;
+	};
+};
+
+&soc {
+	i2c@3000 {
+		rtc@68 {
+			compatible = "dallas,ds1339";
+			reg = <0x68>;
+		};
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x0>;
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <2 1 0 0>;
+			reg = <0x1>;
+		};
+	};
+
+	mdio@25000 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26000 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		fixed-link = <1 1 1000 0 0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	enet1: ethernet@b1000 {
+		phy-handle = <&phy0>;
+		tbi-handle = <&tbi1>;
+		phy-connection-type = "sgmii";
+	};
+
+	enet2: ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	/* USB2 is shared with localbus, so it must be disabled
+	   by default. We can't put 'status = "disabled";' here
+	   since U-Boot doesn't clear the status property when
+	   it enables USB2. OTOH, U-Boot does create a new node
+	   when there isn't any. So, just comment it out.
+	*/
+	usb@23000 {
+		status = "disabled";
+		phy_type = "ulpi";
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts b/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
new file mode 100644
index 0000000..ab8f076
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
@@ -0,0 +1,89 @@
+/*
+ * P1020 MBG-PC Device Tree Source (32-bit address map)
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
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1020MBG-PC";
+	compatible = "fsl,P1020MBG-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0x0 0xffe05000 0x0 0x1000>;
+
+		/* NOR and L2 switch */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
+			  0x1 0x0 0x0 0xffa00000 0x00040000
+			  0x2 0x0 0x0 0xffb00000 0x00020000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0x0 0xffe09000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0x0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0x0 0xffe0a000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0x0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1020mbg-pc.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
new file mode 100644
index 0000000..9e9f401
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
@@ -0,0 +1,89 @@
+/*
+ * P1020 MBG-PC Device Tree Source (36-bit address map)
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
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1020MBG-PC";
+	compatible = "fsl,P1020MBG-PC";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0x0 0x1000>;
+
+		/* NOR and L2 switch */
+		ranges = <0x0 0x0 0xf 0xec000000 0x04000000
+			  0x1 0x0 0xf 0xffa00000 0x00040000
+			  0x2 0x0 0xf 0xffb00000 0x00020000>;
+	};
+
+	soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "p1020mbg-pc.dtsi"
+/include/ "fsl/p1020si-post.dtsi"
-- 
1.7.5.4
