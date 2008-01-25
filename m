Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4956FDDE04
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 20:06:48 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0P96hip015265
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 03:06:44 -0600
Date: Fri, 25 Jan 2008 03:04:20 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: what's in my tree for 2.6.25
Message-ID: <Pine.LNX.4.64.0801250259420.11701@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's what I've currently got in my tree.  I plan on looking at the
following:
* Anton V's device_type/compat cleanup
* Kim's 83xx board ports
* UCC TDM

So if there are some other patches for 2.6.25 linger let me know.  There
are a few on my radar.

- k

 Documentation/powerpc/booting-without-of.txt |  158 +++
 arch/powerpc/boot/Makefile                   |    6
 arch/powerpc/boot/cuboot-85xx-cpm2.c         |   66 +
 arch/powerpc/boot/dts/sbc8349.dts            |  243 +++++
 arch/powerpc/boot/dts/sbc8548.dts            |  244 +++++
 arch/powerpc/boot/dts/sbc8560.dts            |  330 +++++++
 arch/powerpc/boot/dts/stx_gp3_8560.dts       |  228 +++++
 arch/powerpc/boot/dts/tqm8540.dts            |  204 ++++
 arch/powerpc/boot/dts/tqm8541.dts            |  228 +++++
 arch/powerpc/boot/dts/tqm8555.dts            |  228 +++++
 arch/powerpc/boot/dts/tqm8560.dts            |  245 +++++
 arch/powerpc/boot/libfdt-wrapper.c           |    9
 arch/powerpc/boot/ops.h                      |   11
 arch/powerpc/configs/sbc834x_defconfig       |  800 ++++++++++++++++++
 arch/powerpc/configs/sbc8548_defconfig       |  741 ++++++++++++++++
 arch/powerpc/configs/sbc8560_defconfig       |  764 +++++++++++++++++
 arch/powerpc/configs/stx_gp3_defconfig       | 1183 +++++++++++++++++++++++++++
 arch/powerpc/configs/tqm8540_defconfig       | 1032 +++++++++++++++++++++++
 arch/powerpc/configs/tqm8541_defconfig       | 1044 +++++++++++++++++++++++
 arch/powerpc/configs/tqm8555_defconfig       | 1044 +++++++++++++++++++++++
 arch/powerpc/configs/tqm8560_defconfig       | 1044 +++++++++++++++++++++++
 arch/powerpc/kernel/legacy_serial.c          |   45 -
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5
 arch/powerpc/platforms/82xx/pq2fads.c        |    5
 arch/powerpc/platforms/83xx/Kconfig          |    9
 arch/powerpc/platforms/83xx/Makefile         |    1
 arch/powerpc/platforms/83xx/sbc834x.c        |  115 ++
 arch/powerpc/platforms/85xx/Kconfig          |   71 +
 arch/powerpc/platforms/85xx/Makefile         |    4
 arch/powerpc/platforms/85xx/sbc8548.c        |  169 +++
 arch/powerpc/platforms/85xx/sbc8560.c        |  285 ++++++
 arch/powerpc/platforms/85xx/stx_gp3.c        |  187 ++++
 arch/powerpc/platforms/85xx/tqm85xx.c        |  191 ++++
 arch/powerpc/platforms/8xx/ep88xc.c          |    4
 arch/powerpc/platforms/8xx/m8xx_setup.c      |   11
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    6
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5
 arch/powerpc/platforms/8xx/mpc8xx.h          |   21
 arch/powerpc/platforms/Kconfig               |    4
 arch/powerpc/platforms/embedded6xx/ls_uart.c |    5
 arch/powerpc/sysdev/commproc.c               |   38
 arch/powerpc/sysdev/commproc.h               |   12
 arch/powerpc/sysdev/mpc8xx_pic.c             |    1
 arch/ppc/8xx_io/commproc.c                   |   38
 arch/ppc/syslib/ppc8xx_pic.h                 |    1
 drivers/pci/Makefile                         |    2
 include/asm-powerpc/commproc.h               |    6
 include/asm-powerpc/mpc8xx.h                 |   20
 include/asm-ppc/commproc.h                   |    4
 49 files changed, 10933 insertions(+), 184 deletions(-)

Grant Likely (1):
      [POWERPC] 82xx and embedded6xx: Use machine_*_initcall() hooks in platform code

Jochen Friedrich (5):
      [POWERPC] 8xx: Remove unused m8xx_cpm_hostalloc/free/dump()
      [POWERPC] 8xx: Rename m8xx_pic_init to mpc8xx_pics_init
      [POWERPC] 8xx: Remove unneeded and misspelled prototype m8xx_calibrate_decr
      [POWERPC] 8xx: Remove sysdev/commproc.h
      [POWERPC] 8xx: Get rid of conditional includes of board specific setup

Kumar Gala (5):
      [POWERPC] Always build setup-bus.c on powerpc
      [POWERPC] bootwrapper: Add find_node_by_compatible
      [POWERPC] Add a cuboot wrapper for 85xx with CPM2
      [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
      [POWERPC] 85xx: Port TQM85xx boards over from arch/ppc

Li Yang (1):
      [POWERPC] Add docs for Freescale PowerQUICC SATA device tree nodes

Paul Gortmaker (11):
      [POWERPC] Reduce code duplication in legacy_serial, add UART parent types
      [POWERPC] 85xx: Add support for Wind River SBC8560 in arch/powerpc
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8560 board
      [POWERPC] CPM2: Make support for the CPM2 optional on 8560 based boards
      [POWERPC] 85xx: Add default .config file for Wind River SBC8560
      [POWERPC] 85xx: Add basic support for Wind River SBC8548 board
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8548 board
      [POWERPC] 85xx: Add default .config file for Wind River SBC8548
      [POWERPC] 83xx: Add support for Wind River SBC834x boards
      [POWERPC] 83xx: Add device tree source for Wind River SBC834x board.
      [POWERPC] 83xx: Add default config file for Wind River SBC8349 board

Zhang Wei (1):
      [POWERPC] Add docs for Freescale DMA & DMA channel device tree nodes
