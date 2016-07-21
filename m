Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwKxv3Wf0zDqX5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 03:09:07 +1000 (AEST)
Date: Thu, 21 Jul 2016 12:09:01 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160721170901.GA10486@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include more 8xx optimizations, device tree updates,
and MVME7100 support.

The following changes since commit 63a72284b159c569ec52f380c9a8dd9342d43bb8:

  powerpc/pci: Assign fixed PHB number based on device-tree properties (2016-07-07 22:06:55 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 9f595fd8b54809fed13fc30906ef1e90a3fcfbc9:

  powerpc/8xx: Force VIRT_IMMR_BASE to be a positive number (2016-07-09 03:26:53 -0500)

----------------------------------------------------------------
Alessio Igor Bogani (1):
      powerpc/86xx: Add support for Emerson/Artesyn MVME7100

Bartlomiej Zolnierkiewicz (1):
      powerpc: disable IDE subsystem in pq2fads_defconfig

Christophe Leroy (8):
      powerpc32: provide VIRT_CPU_ACCOUNTING
      powerpc/8xx: Fix vaddr for IMMR early remap
      powerpc/8xx: Map IMMR area with 512k page at a fixed address
      powerpc/8xx: CONFIG_PIN_TLB unneeded for CONFIG_PPC_EARLY_DEBUG_CPM
      powerpc/8xx: unpin all TLBs before flushing
      powerpc/8xx: Don't use page table for linear memory space
      powerpc/8xx: Rework CONFIG_PIN_TLB handling
      powerpc/8xx: add CONFIG_PIN_TLB_IMMR

Claudiu Manoil (1):
      powerpc/85xx: Don't report SRAM to L2 cache fallback as error

Scott Wood (1):
      powerpc/8xx: Force VIRT_IMMR_BASE to be a positive number

Sriram Dash (2):
      powerpc/85xx: Change T1040si USB controller version
      powerpc/85xx: add aliases for usb nodes on t4240, b4860, and b4420

Valentin Longchamp (1):
      powerpc: define the fman node for the kmcoge4 DTS

Zhao Qiang (7):
      QE: Add IC, SI and SIRAM document to device tree bindings.
      QE: Add ucc hdlc document to bindings
      QE: Add uqe_serial document to bindings
      bindings: move cpm_qe binding from powerpc/fsl to soc/fsl
      T104xD4RDB: Add qe node to t104xd4rdb
      T104xRDB: Add qe node to t104xrdb
      T104xQDS: Add qe node to t104xqds

 .../bindings/powerpc/fsl/cpm_qe/network.txt        |  43 ------
 .../bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt   |   0
 .../{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt        |   0
 .../{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt        |   0
 .../{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt        |   0
 .../{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt        |   0
 .../bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt  |   0
 .../devicetree/bindings/soc/fsl/cpm_qe/network.txt | 124 ++++++++++++++++
 .../bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt    |  52 +++++++
 .../{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt    |   0
 .../{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt      |   0
 .../{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt      |   0
 .../{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt         |   0
 .../{powerpc => soc}/fsl/cpm_qe/qe/usb.txt         |   0
 .../{powerpc => soc}/fsl/cpm_qe/serial.txt         |   0
 .../bindings/soc/fsl/cpm_qe/uqe_serial.txt         |  17 +++
 arch/powerpc/Kconfig                               |   6 +
 arch/powerpc/Kconfig.debug                         |   1 -
 arch/powerpc/boot/Makefile                         |   4 +
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   1 +
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   1 +
 arch/powerpc/boot/dts/fsl/kmcoge4.dts              |  37 +++++
 arch/powerpc/boot/dts/fsl/mvme7100.dts             | 153 ++++++++++++++++++++
 arch/powerpc/boot/dts/fsl/qonverge-usb2-dr-0.dtsi  |   2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  49 ++++++-
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi          |  38 +++++
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi            |  38 +++++
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi            |  38 +++++
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |   2 +
 arch/powerpc/boot/motload-head.S                   |  11 ++
 arch/powerpc/boot/mvme7100.c                       |  59 ++++++++
 arch/powerpc/boot/ppcboot.h                        |   2 +-
 arch/powerpc/boot/wrapper                          |   5 +
 arch/powerpc/configs/86xx-hw.config                |   4 +-
 arch/powerpc/configs/mpc86xx_basic_defconfig       |   1 +
 arch/powerpc/configs/pq2fads_defconfig             |   1 -
 arch/powerpc/include/asm/accounting.h              |  24 ++++
 arch/powerpc/include/asm/cputime.h                 |  14 +-
 arch/powerpc/include/asm/exception-64s.h           |   2 +-
 arch/powerpc/include/asm/fixmap.h                  |   7 +
 arch/powerpc/include/asm/mmu-8xx.h                 |   3 +
 arch/powerpc/include/asm/paca.h                    |   9 +-
 arch/powerpc/include/asm/ppc_asm.h                 |  24 ++--
 arch/powerpc/include/asm/reg.h                     |   1 +
 arch/powerpc/include/asm/thread_info.h             |   4 +
 arch/powerpc/kernel/asm-offsets.c                  |  31 +++-
 arch/powerpc/kernel/entry_32.S                     |  17 +++
 arch/powerpc/kernel/entry_64.S                     |   6 +-
 arch/powerpc/kernel/exceptions-64e.S               |   4 +-
 arch/powerpc/kernel/head_8xx.S                     | 159 +++++++++++----------
 arch/powerpc/kernel/time.c                         |  81 +++++++----
 arch/powerpc/mm/8xx_mmu.c                          | 131 +++++++++++------
 arch/powerpc/mm/mmu_decl.h                         |   3 +-
 arch/powerpc/platforms/86xx/Kconfig                |   8 +-
 arch/powerpc/platforms/86xx/Makefile               |   1 +
 arch/powerpc/platforms/86xx/mvme7100.c             | 121 ++++++++++++++++
 arch/powerpc/platforms/Kconfig.cputype             |   1 -
 arch/powerpc/sysdev/cpm_common.c                   |  22 ++-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c              |   8 +-
 arch/powerpc/xmon/xmon.c                           |  14 +-
 60 files changed, 1133 insertions(+), 251 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/network.txt
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/brg.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/i2c.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/pic.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/cpm/usb.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/gpio.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/network.txt
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe.txt (75%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/firmware.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/par_io.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/pincfg.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/ucc.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/qe/usb.txt (100%)
 rename Documentation/devicetree/bindings/{powerpc => soc}/fsl/cpm_qe/serial.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/soc/fsl/cpm_qe/uqe_serial.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/mvme7100.dts
 create mode 100644 arch/powerpc/boot/motload-head.S
 create mode 100644 arch/powerpc/boot/mvme7100.c
 create mode 100644 arch/powerpc/include/asm/accounting.h
 create mode 100644 arch/powerpc/platforms/86xx/mvme7100.c
