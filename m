Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 69598DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 16:24:29 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 30 Jul 2008 16:24:18 +1000
Message-Id: <1217399058.11188.309.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

Hopefully this one won't be busted... I'll hand back the hat
to paulus for the rest of 2.6.27, but before that, here's a last
pull request.

It brings the powerpc variant of the lockless get_user_pages_fast()
which took some time because I took it out of -mm and had to adjust a
few things, mostly conflicts with other hugetlb stuff that went in.

The diffstat will show a change to drivers/ipmi from Stephen. This
fixes a powerpc specific bit in there and the maintainer hasn't
responded to Stephen so far so we decided to merge it ourselves.

The drivers/serial changes are freescale specific drivers and the
drivers/ide change is a powermac specific driver and has Bart's ack.

Some of the freescale changes look like they aren't purely fixes,
Kumar asked me to pull them as this delay is to blame apparently
on the relevant people doing whatever people do at OLS which doesn't
involve merging patches :-)

So please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

 Documentation/powerpc/00-INDEX                     |    2 
 Documentation/powerpc/SBC8260_memory_mapping.txt   |  197 --------------
 .../powerpc/dts-bindings/fsl/cpm_qe/serial.txt     |   11 +
 arch/powerpc/Kconfig                               |    3 
 arch/powerpc/boot/dts/mpc832x_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |    1 
 arch/powerpc/boot/dts/mpc8349emitx.dts             |    1 
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |    1 
 arch/powerpc/boot/dts/mpc834x_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc836x_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc836x_rdk.dts              |   16 -
 arch/powerpc/boot/dts/mpc8377_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc8378_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc8379_mds.dts              |    1 
 arch/powerpc/boot/dts/mpc8536ds.dts                |    1 
 arch/powerpc/boot/dts/mpc8540ads.dts               |    1 
 arch/powerpc/boot/dts/mpc8541cds.dts               |    1 
 arch/powerpc/boot/dts/mpc8544ds.dts                |    1 
 arch/powerpc/boot/dts/mpc8548cds.dts               |    1 
 arch/powerpc/boot/dts/mpc8555cds.dts               |    1 
 arch/powerpc/boot/dts/mpc8560ads.dts               |    1 
 arch/powerpc/boot/dts/mpc8568mds.dts               |    1 
 arch/powerpc/boot/dts/mpc8572ds.dts                |    1 
 arch/powerpc/kernel/lparcfg.c                      |    4 
 arch/powerpc/kernel/ptrace.c                       |   10 -
 arch/powerpc/kernel/ptrace32.c                     |    2 
 arch/powerpc/mm/Makefile                           |    3 
 arch/powerpc/mm/gup.c                              |  280 ++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    1 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    1 
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |    1 
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |    1 
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |    1 
 arch/powerpc/platforms/83xx/sbc834x.c              |    1 
 arch/powerpc/platforms/85xx/ksi8560.c              |    1 
 arch/powerpc/platforms/85xx/mpc8536_ds.c           |    1 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |    1 
 arch/powerpc/platforms/85xx/mpc85xx_ds.c           |    1 
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    1 
 arch/powerpc/platforms/85xx/sbc8560.c              |    1 
 arch/powerpc/platforms/8xx/Kconfig                 |   10 +
 arch/powerpc/platforms/Kconfig                     |    3 
 arch/powerpc/sysdev/cpm1.c                         |  267 +++++++++++++++++++
 arch/powerpc/sysdev/cpm2.c                         |   45 +--
 arch/powerpc/sysdev/cpm_common.c                   |  123 +++++++++
 arch/powerpc/sysdev/rtc_cmos_setup.c               |   23 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |    4 
 drivers/ide/ppc/pmac.c                             |   13 +
 drivers/serial/cpm_uart/cpm_uart.h                 |   11 +
 drivers/serial/cpm_uart/cpm_uart_core.c            |   66 ++++-
 include/asm-powerpc/cpm.h                          |    3 
 include/asm-powerpc/cpm2.h                         |   46 ++-
 include/asm-powerpc/pgtable-ppc64.h                |    2 
 include/linux/pagemap.h                            |   23 ++
 54 files changed, 907 insertions(+), 290 deletions(-)
 delete mode 100644 Documentation/powerpc/SBC8260_memory_mapping.txt
 create mode 100644 arch/powerpc/mm/gup.c

Anton Vorontsov (1):
      powerpc: rtc_cmos_setup: assign interrupts only if there is i8259 PIC

Benjamin Herrenschmidt (1):
      ide/powermac: Fix use of uninitialized pointer on media-bay

Jochen Friedrich (1):
      powerpc: implement GPIO LIB API on CPM1 Freescale SoC.

Kim Phillips (1):
      powerpc/fsl: proliferate simple-bus compatibility to soc nodes

Kumar Gala (2):
      powerpc: clean up the Book-E HW watchpoint support
      powerpc: Fix 8xx build failure

Laurent Pinchart (4):
      cpm2: Implement GPIO LIB API on CPM2 Freescale SoC.
      cpm_uart: Modem control lines support
      cpm_uart: Add generic clock API support to set baudrates
      cpm2: Rework baud rate generators configuration to support external clocks.

Michael Neuling (3):
      powerpc: Correctly hookup PTRACE_GET/SETVSRREGS for 32 bit processes
      powerpc: Fix ptrace buffer size for VSX
      powerpc: Don't use the wrong thread_struct for ptrace get/set VSX regs

Nathan Fontenot (1):
      powerpc: Allow non-hcall return values for lparcfg writes

Nick Piggin (1):
      powerpc/mm: Lockless get_user_pages_fast() for 64-bit (v3)

Paul Gortmaker (1):
      Documentation: remove old sbc8260 board specific information

Stephen Rothwell (1):
      ipmi/powerpc: Use linux/of_{device,platform}.h instead of asm
