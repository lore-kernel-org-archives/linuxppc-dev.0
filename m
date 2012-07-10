Return-Path: <B37781@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF9542C0086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 19:00:43 +1000 (EST)
From: Xu Jiucheng <Jiucheng.Xu@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode for
 P1021RDB-PC
Date: Tue, 10 Jul 2012 16:39:21 +0800
Message-ID: <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
In-Reply-To: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>,
 Xu Jiucheng <Jiucheng.Xu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Create the dts files for each core and splits the devices between
the two cores for P1021RDB-PC.

Core0 has l2, serial0, i2c, spi, gpio, tdm,dma, usb, eth0, eth1,
sdhc, crypto, global-util, message, pci0, pci1, msi, crypto.
Core1 has l2, serial1, eth2.

Signed-off-by: Xu Jiucheng <Jiucheng.Xu@freescale.com>
Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/boot/dts/p1021rdb-pc_camp_core0.dts |   91 +++++++++++
 arch/powerpc/boot/dts/p1021rdb-pc_camp_core1.dts |  179 ++++++++++++++++++++++
 2 files changed, 270 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_camp_core0.dts
 create mode 100644 arch/powerpc/boot/dts/p1021rdb-pc_camp_core1.dts

diff --git a/arch/powerpc/boot/dts/p1021rdb-pc_camp_core0.dts b/arch/powerpc/boot/dts/p1021rdb-pc_camp_core0.dts
new file mode 100644
index 0000000..199e94e
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1021rdb-pc_camp_core0.dts
@@ -0,0 +1,91 @@
+/*
+ * P1021 RDB Core0 Device Tree Source in CAMP mode.
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
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts file allows core0 to have memory, l2, serail0, i2c, spi, gpio,
+ * tdm, dma, usb, eth0, eth1, sdhc, crypto, global-util, message, pci0, pci1,
+ * msi.
+ *
+ * Please note to add "-b 0" for core0's dts compiling.
+ */
+
+/include/ "p1021rdb-pc_32b.dts"
+
+/ {
+	model = "fsl,P1021RDB";
+	compatible = "fsl,P1021RDB-PC";
+
+	aliases {
+		ethernet1 = &enet0;
+		ethernet2 = &enet1;
+		serial0 = &serial0;
+		pci0 = &pci0;
+		pci1 = &pci1;
+	};
+
+	cpus {
+		PowerPC,P1021@1 {
+			status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc@ffe00000 {
+		serial1: serial@4600 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			phy1: ethernet-phy@1 {
+				status = "disabled";
+			};
+		};
+
+		enet2: ethernet@b2000 {
+			status = "disabled";
+		};
+
+		mpic: pic@40000 {
+			protected-sources = <
+			42		/* serial1 */
+			31 32 33	/* enet2-queue-group0 */
+			25 26 27	/* enet2-queue-group1 */
+			>;
+			pic-no-reset;
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1021rdb-pc_camp_core1.dts b/arch/powerpc/boot/dts/p1021rdb-pc_camp_core1.dts
new file mode 100644
index 0000000..dfc9105
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1021rdb-pc_camp_core1.dts
@@ -0,0 +1,179 @@
+/*
+ * P1021 RDB Core1 Device Tree Source in CAMP mode.
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
+ *
+ * In CAMP mode, each core needs to have its own dts. Only mpic and L2 cache
+ * can be shared, all the other devices must be assigned to one core only.
+ * This dts allows core1 to have l2, eth2, serial1, crypto.
+ *
+ * Please note to add "-b 1" for core1's dts compiling.
+ */
+
+/include/ "p1021rdb-pc_32b.dts"
+
+/ {
+	model = "fsl,P1021RDB";
+	compatible = "fsl,P1021RDB-PC";
+
+	aliases {
+		ethernet0 = &enet2;
+		serial0 = &serial1;
+		};
+
+	cpus {
+		PowerPC,P1021@0 {
+			status = "disabled";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	localbus@ffe05000 {
+		status = "disabled";
+	};
+
+	soc@ffe00000 {
+		ecm-law@0 {
+			status = "disabled";
+		};
+
+		ecm@1000 {
+			status = "disabled";
+		};
+
+		memory-controller@2000 {
+			status = "disabled";
+		};
+
+		i2c@3000 {
+			status = "disabled";
+		};
+
+		i2c@3100 {
+			status = "disabled";
+		};
+
+		serial0: serial@4500 {
+			status = "disabled";
+		};
+
+		spi@7000 {
+			status = "disabled";
+		};
+
+		gpio: gpio-controller@f000 {
+			status = "disabled";
+		};
+
+		dma@21300 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				status = "disabled";
+			};
+
+			tbi0: tbi-phy@11 {
+				status = "disabled";
+			};
+		};
+
+		mdio@25000 {
+			status = "disabled";
+		};
+
+		mdio@26000 {
+			status = "disabled";
+		};
+
+		enet0: ethernet@b0000 {
+			status = "disabled";
+		};
+
+		enet1: ethernet@b1000 {
+			status = "disabled";
+		};
+
+		usb@22000 {
+			status = "disabled";
+		};
+
+		sdhci@2e000 {
+			status = "disabled";
+		};
+
+		crypto@30000 {
+                        status = "disabled";
+                };
+
+		mpic: pic@40000 {
+			protected-sources = <
+			16 		/* ecm, mem, L2, pci0, pci1 */
+			43 42 59	/* i2c, serial0, spi */
+			47 63 62 	/* gpio, tdm */
+			20 21 22 23	/* dma */
+			03 02 		/* mdio */
+			29 30 34	/* enet0-queue-group0 */
+			17 18 24	/* enet0-queue-group1 */
+			35 36 40	/* enet1-queue-group0 */
+			51 52 67	/* enet1-queue-group1 */
+			28 72 45 58 	/* usb, sdhci, crypto */
+			0xb0 0xb1 0xb2	/* message */
+			0xb3 0xb4 0xb5
+			0xb6 0xb7
+			0xe0 0xe1 0xe2	/* msi */
+			0xe3 0xe4 0xe5
+			0xe6 0xe7		/* sdhci, crypto , pci */
+			>;
+			pic-no-reset;
+		};
+
+		msi@41600 {
+			status = "disabled";
+		};
+
+		global-utilities@e0000 {	//global utilities block
+			status = "disabled";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		status = "disabled";
+	};
+
+	pci1: pcie@ffe0a000 {
+		status = "disabled";
+	};
+};
-- 
1.6.4
