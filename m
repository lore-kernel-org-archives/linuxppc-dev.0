Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B0E63DDF7C
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:22:07 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n376LmZp030330
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Apr 2009 01:21:48 -0500
Date: Tue, 7 Apr 2009 01:21:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: Please pull from 'next' branch (for 2.6.30)(updated) (fwd)
Message-ID: <Pine.LNX.4.64.0904070121370.11169@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Forgot to CC linuxppc-dev

- k

---------- Forwarded message ----------
Date: Tue, 7 Apr 2009 01:21:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>,
    Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch (for 2.6.30)(updated)

* Added some patches for tqm85xx that I missed
* Added tlbilx opcode patches (support was added in .30 so this is fixing
issues with that code)

- k

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/Kconfig                        |    1
 arch/powerpc/boot/dts/ksi8560.dts           |    4
 arch/powerpc/boot/dts/pq2fads.dts           |   20 ++-
 arch/powerpc/boot/dts/sbc8548.dts           |    4
 arch/powerpc/boot/dts/sbc8560.dts           |    4
 arch/powerpc/boot/dts/socrates.dts          |    1
 arch/powerpc/boot/dts/stx_gp3_8560.dts      |    4
 arch/powerpc/boot/dts/tqm8540.dts           |    8 -
 arch/powerpc/boot/dts/tqm8541.dts           |    8 -
 arch/powerpc/boot/dts/tqm8548-bigflash.dts  |    8 -
 arch/powerpc/boot/dts/tqm8548.dts           |    8 -
 arch/powerpc/boot/dts/tqm8555.dts           |    8 -
 arch/powerpc/boot/dts/tqm8560.dts           |    8 -
 arch/powerpc/configs/85xx/tqm8548_defconfig |  164 ++++++++--------------------
 arch/powerpc/include/asm/mmu.h              |    6 +
 arch/powerpc/include/asm/mpic.h             |   12 ++
 arch/powerpc/include/asm/ppc-opcode.h       |   13 +-
 arch/powerpc/include/asm/reg.h              |   30 +++++
 arch/powerpc/include/asm/reg_booke.h        |   30 -----
 arch/powerpc/include/asm/sfp-machine.h      |    6 -
 arch/powerpc/kernel/cputable.c              |    2
 arch/powerpc/mm/tlb_nohash_low.S            |   14 ++
 arch/powerpc/sysdev/mpic.c                  |   34 +++++
 drivers/serial/cpm_uart/cpm_uart_core.c     |   14 +-
 drivers/video/fsl-diu-fb.c                  |   34 +++--
 include/linux/fsl_devices.h                 |   22 ---
 26 files changed, 234 insertions(+), 233 deletions(-)

Anton Vorontsov (1):
      fsl-diu-fb: Pass the proper device for dma mapping routines

Grant Likely (1):
      powerpc: Remove unused symbols from fsl_devices.h

Josh Boyer (1):
      powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE

Kumar Gala (6):
      powerpc/85xx: Use fsl,mpc85.. as prefix for memory ctrl & l2-cache nodes
      powerpc: Move SPEFSCR defines to common header
      powerpc/math-emu: Change types to work on ppc64
      powerpc: Add support for CoreInt delivery of interrupts on MPIC
      powerpc: Fix tlbilx opcode
      powerpc: Add support for early tlbilx opcode

Scott Wood (3):
      cpm_uart: Initialize port.dev before it's used.
      cpm_uart: Disable CPM udbg when re-initing CPM uart, even if not the console.
      powerpc/pq2fads: Update device tree for use with device-tree-aware u-boot.

Wolfgang Grandegger (4):
      powerpc/85xx: Re-add the device_type soc to socrates.dts
      powerpc/85xx: TQM85xx: correct address of LM75 I2C device nodes
      powerpc/85xx: TQM8548: use proper phy-handles for enet2 and enet3
      powerpc/85xx: TQM8548: update defconfig
