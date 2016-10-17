Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syPnb21tyzDvJF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:09:22 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>
CC: <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <benh@kernel.crashing.org>
Subject: [Patch v5 08/12] MIPS: xilfpga: Use Xilinx Interrupt Controller
Date: Mon, 17 Oct 2016 17:52:52 +0100
Message-ID: <1476723176-39891-9-git-send-email-Zubair.Kakakhel@imgtec.com>
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

IRQs from peripherals such as i2c/uart/ethernet come via
the AXI Interrupt controller.

Select it in Kconfig for xilfpga and add the DT node

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V4 -> V5
Rebase to v4.9-rc1
Renamed XILINX_AXI_INTC to XILINX_INTC

V3 -> V4
No change

V2 -> V3
No change

V1 -> V2
Renamed select XILINX_INTC to select XILINX_AXI_INTC
---
 arch/mips/Kconfig                        |  1 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index b3c5bde..3d681c6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -478,6 +478,7 @@ config MACH_XILFPGA
 	select SYS_SUPPORTS_ZBOOT_UART16550
 	select USE_OF
 	select USE_GENERIC_EARLY_PRINTK_8250
+	select XILINX_INTC
 	help
 	  This enables support for the IMG University Program MIPSfpga platform.
 
diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 48d2112..8db660b 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -17,6 +17,18 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	axi_intc: interrupt-controller@10200000 {
+		#interrupt-cells = <1>;
+		compatible = "xlnx,xps-intc-1.00.a";
+		interrupt-controller;
+		reg = <0x10200000 0x10000>;
+		xlnx,kind-of-intr = <0x0>;
+		xlnx,num-intr-inputs = <0x6>;
+
+		interrupt-parent = <&cpuintc>;
+		interrupts = <6>;
+	};
+
 	axi_gpio: gpio@10600000 {
 		#gpio-cells = <1>;
 		compatible = "xlnx,xps-gpio-1.00.a";
-- 
1.9.1
