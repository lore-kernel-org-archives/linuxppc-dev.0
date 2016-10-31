Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t6tdg3XnkzDvJD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 23:16:55 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <Zubair.Kakakhel@imgtec.com>
Subject: [Patch V6 0/6] microblaze/PowerPC: Move irq-xilinx
Date: Mon, 31 Oct 2016 12:16:41 +0000
Message-ID: <1477916207-25157-1-git-send-email-Zubair.Kakakhel@imgtec.com>
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

The MIPS based Xilfpga platform uses the Xilinx interrupt controller
daisy chained to the MIPS microAptiv cpu interrupt controller.

This patch series moves the Xilinx interrupt controller driver out
of arch/microblaze to drivers/irqchip and then cleans it up a bit.
And then removes another implementation of the driver in arch/powerpc.

This effort results in one common driver usable by mips,microblaze
and powerpc.

Compile tested on microblaze-el.
Tested using qemu-system-ppc using virtix440-ml507
Tested on MIPSfpga platform.

Based on v4.9-rc3

Thanks,
ZubairLK

V5 -> V6
Split patch series. Patches for arch/mips can go separately
Rebase to v4.9-rc3
Added chained_irq_enter/exit
Removed __func__ used in pr_err

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

Zubair Lutfullah Kakakhel (6):
  microblaze: irqchip: Move intc driver to irqchip
  irqchip: xilinx: Clean up irqdomain argument and read/write
  irqchip: xilinx: Rename get_irq to xintc_get_irq
  irqchip: xilinx: Add support for parent intc
  irqchip: xilinx: Try to fall back if xlnx,kind-of-intr not provided
  powerpc/virtex: Use generic xilinx irqchip driver

 arch/microblaze/Kconfig                |   1 +
 arch/microblaze/include/asm/irq.h      |   2 +-
 arch/microblaze/kernel/Makefile        |   2 +-
 arch/microblaze/kernel/intc.c          | 196 ------------------------
 arch/microblaze/kernel/irq.c           |   4 +-
 arch/powerpc/include/asm/xilinx_intc.h |   2 +-
 arch/powerpc/platforms/40x/Kconfig     |   1 +
 arch/powerpc/platforms/40x/virtex.c    |   2 +-
 arch/powerpc/platforms/44x/Kconfig     |   1 +
 arch/powerpc/platforms/44x/virtex.c    |   2 +-
 arch/powerpc/sysdev/xilinx_intc.c      | 211 +-------------------------
 drivers/irqchip/Kconfig                |   4 +
 drivers/irqchip/Makefile               |   1 +
 drivers/irqchip/irq-xilinx-intc.c      | 267 +++++++++++++++++++++++++++++++++
 14 files changed, 284 insertions(+), 412 deletions(-)
 delete mode 100644 arch/microblaze/kernel/intc.c
 create mode 100644 drivers/irqchip/irq-xilinx-intc.c

-- 
1.9.1
