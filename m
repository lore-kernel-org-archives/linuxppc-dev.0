Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BA76FDDF85
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 17:49:57 +1000 (EST)
Date: Thu, 26 Jun 2008 02:49:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0806260249300.14932@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt    |   59 +
 arch/powerpc/Kconfig                            |    6
 arch/powerpc/boot/Makefile                      |    1
 arch/powerpc/boot/dts/mpc836x_rdk.dts           |  397 ++++++++
 arch/powerpc/boot/dts/tqm8540.dts               |    4
 arch/powerpc/boot/dts/tqm8541.dts               |    4
 arch/powerpc/boot/dts/tqm8548-bigflash.dts      |  365 +++++++
 arch/powerpc/boot/dts/tqm8548.dts               |  365 +++++++
 arch/powerpc/boot/dts/tqm8555.dts               |    4
 arch/powerpc/boot/dts/tqm8560.dts               |   69 +
 arch/powerpc/boot/wrapper                       |    2
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig | 1128 ++++++++++++++++++++++++
 arch/powerpc/configs/85xx/tqm8548_defconfig     | 1094 +++++++++++++++++++++++
 arch/powerpc/kernel/Makefile                    |    1
 arch/powerpc/kernel/cputable.c                  |   16
 arch/powerpc/kernel/entry_32.S                  |    8
 arch/powerpc/kernel/head_booke.h                |   10
 arch/powerpc/kernel/head_fsl_booke.S            |   57 +
 arch/powerpc/kernel/idle_6xx.S                  |    2
 arch/powerpc/kernel/idle_e500.S                 |   93 +
 arch/powerpc/kernel/setup_32.c                  |    5
 arch/powerpc/platforms/83xx/Kconfig             |   11
 arch/powerpc/platforms/83xx/Makefile            |    1
 arch/powerpc/platforms/83xx/mpc836x_rdk.c       |  102 ++
 arch/powerpc/platforms/85xx/Kconfig             |    8
 arch/powerpc/platforms/85xx/mpc85xx_ads.c       |    8
 arch/powerpc/platforms/85xx/tqm85xx.c           |   23
 arch/powerpc/platforms/Kconfig.cputype          |    7
 arch/powerpc/sysdev/Makefile                    |    2
 arch/powerpc/sysdev/cpm_common.c                |   16
 arch/powerpc/sysdev/fsl_gtm.c                   |  434 +++++++++
 arch/powerpc/sysdev/qe_lib/Kconfig              |   13
 arch/powerpc/sysdev/qe_lib/Makefile             |    2
 arch/powerpc/sysdev/qe_lib/gpio.c               |  149 +++
 arch/powerpc/sysdev/qe_lib/qe.c                 |   94 --
 arch/powerpc/sysdev/qe_lib/qe_io.c              |   94 --
 arch/powerpc/sysdev/qe_lib/ucc.c                |    7
 arch/powerpc/sysdev/qe_lib/usb.c                |   55 +
 drivers/serial/cpm_uart/cpm_uart.h              |   11
 drivers/serial/cpm_uart/cpm_uart_core.c         |  373 -------
 drivers/serial/cpm_uart/cpm_uart_cpm1.c         |  170 ---
 drivers/serial/cpm_uart/cpm_uart_cpm1.h         |   12
 drivers/serial/cpm_uart/cpm_uart_cpm2.c         |  283 ------
 drivers/serial/cpm_uart/cpm_uart_cpm2.h         |   12
 include/asm-powerpc/cache.h                     |    3
 include/asm-powerpc/cpm.h                       |    1
 include/asm-powerpc/cpm1.h                      |   20
 include/asm-powerpc/cpm2.h                      |   26
 include/asm-powerpc/cputable.h                  |   19
 include/asm-powerpc/fsl_gtm.h                   |   47 +
 include/asm-powerpc/machdep.h                   |    1
 include/asm-powerpc/qe.h                        |   82 +
 include/asm-powerpc/reg.h                       |    2
 include/asm-powerpc/reg_booke.h                 |   74 +
 include/asm-powerpc/synch.h                     |    2
 55 files changed, 4740 insertions(+), 1114 deletions(-)

Anton Vorontsov (8):
      powerpc/sysdev: implement FSL GTM support
      powerpc/QE: add support for QE USB clocks routing
      powerpc/QE: prepare QE PIO code for GPIO LIB support
      powerpc/QE: implement support for the GPIO LIB API
      powerpc/83xx: new board support: MPC8360E-RDK
      powerpc/QE: switch to the cpm_muram implementation
      powerpc/QE: qe_reset should be __init
      powerpc/QE: use arch_initcall to probe QUICC Engine GPIOs

Jerone Young (1):
      powerpc/booke: Fix definitions for dbcr[1-2] and dbsr registers

Kumar Gala (7):
      powerpc/booke: Fix some comments related to debug level exceptions
      powerpc/booke: Add support for new e500mc core
      powerpc/85xx: add DOZE/NAP support for e500 core
      powerpc/e500mc: flush L2 on NAP for e500mc
      cpm_uart: fix whitespace issues
      cpm_uart: Remove !CONFIG_PPC_CPM_NEW_BINDING code
      powerpc/cpm: Remove !CONFIG_PPC_CPM_NEW_BINDING code

Vitaly Bordug (1):
      powerpc/85xx: Update pin setup for 8560ads

Wolfgang Grandegger (4):
      powerpc/85xx: correct vendor prefix in DTS files for TQM85xx modules
      powerpc/85xx: add board support for the TQM8548 modules
      powerpc/85xx: support for the TQM8548 module using the big Flash
      powerpc/85xx: add local bus nodes for Flash and CAN to tqm8560.dts
