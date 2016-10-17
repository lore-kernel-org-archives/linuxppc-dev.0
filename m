Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syPmR4WNNzDvJF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:08:23 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>
CC: <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <benh@kernel.crashing.org>
Subject: [Patch v5 00/12] microblaze/MIPS/PowerPC: Xilinx intc
Date: Mon, 17 Oct 2016 17:52:44 +0100
Message-ID: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
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

Hi,

The MIPS based Xilfpga platform uses the axi interrupt controller
daisy chained to the MIPS microAptiv cpu interrupt controller.
This patch series moves the axi interrupt controller driver out
of arch/microblaze to drivers/irqchip and then cleans it up a bit.
And then remove another implementation of the driver in arch/powerpc.
This makes one common driver usable by mips,microblaze and powerpc.
The rest of the series basically enables drivers and adds dt nodes.

Would make sense for this to go via the MIPS tree.
Hence, ACKs from microblaze, powerpc and irqchip welcome.

Compile tested on microblaze-el.
Tested using qemu-system-ppc using virtix440-ml507

Based on v4.9-rc1

Regards,
ZubairLK

V4 -> V5
Added a new patch that removes the PPC driver
Rebase to v4.9-rc1
Better error handling

V3 -> V4
Better error handling
Some minor fixups

V2 -> V3
Cleanup the interrupt controller driver a bit based on feedback
Rebase to v4.8-rc4

V1 -> V2
Resubmitting without truncating the diff output for file moves
Removed accidental local mac address entry
Individual logs have more detail


Zubair Lutfullah Kakakhel (12):
  microblaze: irqchip: Move intc driver to irqchip
  irqchip: xilinx: Clean up irqdomain argument and read/write
  irqchip: xilinx: Rename get_irq to xintc_get_irq
  irqchip: xilinx: Add support for parent intc
  irqchip: xilinx: Try to fall back if xlnx,kind-of-intr not provided
  powerpc/virtex: Use generic xilinx irqchip driver
  MIPS: xilfpga: Use irqchip instead of the legacy way
  MIPS: xilfpga: Use Xilinx Interrupt Controller
  MIPS: xilfpga: Update DT node and specify uart irq
  MIPS: xilfpga: Add DT node for AXI I2C
  MIPS: xilfpga: Add DT node for AXI emaclite
  MIPS: xilfpga: Update defconfig

 arch/microblaze/Kconfig                  |   1 +
 arch/microblaze/include/asm/irq.h        |   2 +-
 arch/microblaze/kernel/Makefile          |   2 +-
 arch/microblaze/kernel/intc.c            | 196 -----------------------
 arch/microblaze/kernel/irq.c             |   4 +-
 arch/mips/Kconfig                        |   1 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts |  63 ++++++++
 arch/mips/configs/xilfpga_defconfig      |  37 ++++-
 arch/mips/xilfpga/intc.c                 |   7 +-
 arch/powerpc/include/asm/xilinx_intc.h   |   2 +-
 arch/powerpc/platforms/40x/Kconfig       |   1 +
 arch/powerpc/platforms/40x/virtex.c      |   2 +-
 arch/powerpc/platforms/44x/Kconfig       |   1 +
 arch/powerpc/platforms/44x/virtex.c      |   2 +-
 arch/powerpc/sysdev/xilinx_intc.c        | 211 +------------------------
 drivers/irqchip/Kconfig                  |   4 +
 drivers/irqchip/Makefile                 |   1 +
 drivers/irqchip/irq-xilinx-intc.c        | 258 +++++++++++++++++++++++++++++++
 18 files changed, 377 insertions(+), 418 deletions(-)
 delete mode 100644 arch/microblaze/kernel/intc.c
 create mode 100644 drivers/irqchip/irq-xilinx-intc.c

-- 
1.9.1
