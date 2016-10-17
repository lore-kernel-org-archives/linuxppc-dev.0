Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syPnb222WzDvJY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:09:22 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>
CC: <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <benh@kernel.crashing.org>
Subject: [Patch v5 11/12] MIPS: xilfpga: Add DT node for AXI emaclite
Date: Mon, 17 Oct 2016 17:52:55 +0100
Message-ID: <1476723176-39891-12-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xilfpga platform has a Xilinx AXI emaclite block.

Add the DT node to use it.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
No change

V2 -> V3
No change

V1 -> V2
Removed accidental local-mac-address entry
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index f5ebab8..09a62f2 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -42,6 +42,32 @@
 		xlnx,tri-default = <0xffffffff>;
 	} ;
 
+	axi_ethernetlite: ethernet@10e00000 {
+		compatible = "xlnx,xps-ethernetlite-3.00.a";
+		device_type = "network";
+		interrupt-parent = <&axi_intc>;
+		interrupts = <1>;
+		phy-handle = <&phy0>;
+		reg = <0x10e00000 0x10000>;
+		xlnx,duplex = <0x1>;
+		xlnx,include-global-buffers = <0x1>;
+		xlnx,include-internal-loopback = <0x0>;
+		xlnx,include-mdio = <0x1>;
+		xlnx,instance = "axi_ethernetlite_inst";
+		xlnx,rx-ping-pong = <0x1>;
+		xlnx,s-axi-id-width = <0x1>;
+		xlnx,tx-ping-pong = <0x1>;
+		xlnx,use-internal = <0x0>;
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy0: phy@1 {
+				device_type = "ethernet-phy";
+				reg = <1>;
+			};
+		};
+	};
+
 	axi_uart16550: serial@10400000 {
 		compatible = "ns16550a";
 		reg = <0x10400000 0x10000>;
-- 
1.9.1
