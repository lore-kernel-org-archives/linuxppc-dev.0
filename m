Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 97637DDF93
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:26:49 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18906.61984.130724.486881@drongo.ozlabs.ibm.com>
Date: Tue, 7 Apr 2009 16:26:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a powerpc update.  (I'm sending this instead of Ben
Herrenschmidt because Ben has just gone off on a month's vacation.)

Most of the commits are bug fixes and cleanups.  There is also a
commit from Stephen Rothwell to wire up preadv/pwritev and one from
Anton Blanchard that exports some statistics from the hypervisor on
pSeries machines.

Thanks,
Paul.

 arch/powerpc/Kconfig                    |    3 ++-
 arch/powerpc/boot/dts/ksi8560.dts       |    4 ++--
 arch/powerpc/boot/dts/pq2fads.dts       |   20 +++++++++++++-----
 arch/powerpc/boot/dts/sbc8548.dts       |    4 ++--
 arch/powerpc/boot/dts/sbc8560.dts       |    4 ++--
 arch/powerpc/boot/dts/socrates.dts      |    1 +
 arch/powerpc/boot/dts/stx_gp3_8560.dts  |    4 ++--
 arch/powerpc/boot/dts/tqm8540.dts       |    4 ++--
 arch/powerpc/boot/dts/tqm8541.dts       |    4 ++--
 arch/powerpc/boot/dts/tqm8555.dts       |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts       |    4 ++--
 arch/powerpc/configs/pseries_defconfig  |    2 +-
 arch/powerpc/include/asm/lppaca.h       |    2 +-
 arch/powerpc/include/asm/mpic.h         |   12 +++++++++++
 arch/powerpc/include/asm/ps3fb.h        |    1 -
 arch/powerpc/include/asm/pte-common.h   |    6 ++++-
 arch/powerpc/include/asm/reg.h          |   30 +++++++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h    |   30 ---------------------------
 arch/powerpc/include/asm/rtas.h         |    3 ++-
 arch/powerpc/include/asm/sfp-machine.h  |    6 +++--
 arch/powerpc/include/asm/systbl.h       |    3 +++
 arch/powerpc/include/asm/unistd.h       |    4 +++-
 arch/powerpc/kernel/fpu.S               |    5 +++++
 arch/powerpc/kernel/ftrace.c            |    4 ++--
 arch/powerpc/kernel/irq.c               |    4 +++-
 arch/powerpc/kernel/lparcfg.c           |   16 +++++++++++++++
 arch/powerpc/kernel/misc_64.S           |    8 +++++++
 arch/powerpc/kernel/prom_init.c         |   18 +++++++++-------
 arch/powerpc/kernel/ptrace32.c          |   15 ++++++++++----
 arch/powerpc/kernel/setup-common.c      |    1 -
 arch/powerpc/sysdev/mpic.c              |   34 +++++++++++++++++++++++++++++++
 drivers/serial/cpm_uart/cpm_uart_core.c |   14 ++++++-------
 drivers/serial/pmac_zilog.c             |   15 ++++++++++++++
 drivers/video/fsl-diu-fb.c              |   34 +++++++++++++++++++------------
 drivers/watchdog/wdrtas.c               |   13 ++++++++++--
 include/linux/fsl_devices.h             |   22 --------------------
 36 files changed, 235 insertions(+), 123 deletions(-)

Anton Blanchard (6):
      powerpc: Print progress of ibm,client-architecture method
      powerpc: Clean up some prom printouts
      powerpc/pseries: Add dispatch dispersion statistics
      powerpc/pseries: Scan for all events in rtasd
      powerpc/pseries: Fix ibm,client-architecture comment
      powerpc/pseries: Enable relay in pseries_defconfig

Anton Vorontsov (1):
      fsl-diu-fb: Pass the proper device for dma mapping routines

Benjamin Herrenschmidt (1):
      powerpc/pmac: Fix internal modem IRQ on Wallstreet PowerBook

Geert Uytterhoeven (1):
      powerpc: Correct dependency of KEXEC

Grant Likely (1):
      powerpc: Remove unused symbols from fsl_devices.h

Huang Weiyi (1):
      powerpc: Remove duplicated #include's

Josh Boyer (1):
      powerpc: Make LOWMEM_CAM_NUM depend on FSL_BOOKE

Kumar Gala (4):
      powerpc/85xx: Use fsl,mpc85.. as prefix for memory ctrl & l2-cache nodes
      powerpc: Move SPEFSCR defines to common header
      powerpc/math-emu: Change types to work on ppc64
      powerpc: Add support for CoreInt delivery of interrupts on MPIC

Mark Nelson (1):
      powerpc/wdrtas: Update wdrtas_get_interval to use rtas_data_buf

Michael Ellerman (3):
      powerpc: Print information about mapping hw irqs to virtual irqs
      powerpc/ftrace: Fix #if that should be #ifdef
      powerpc/ftrace: Fix printf format warning

Michael Neuling (2):
      powerpc: Disable VSX or current process in giveup_fpu/altivec
      powerpc: Fix ptrace compat wrapper for FPU register access

Paul Mackerras (1):
      powerpc: Fix oops when loading modules

Scott Wood (3):
      cpm_uart: Initialize port.dev before it's used.
      cpm_uart: Disable CPM udbg when re-initing CPM uart, even if not the console.
      powerpc/pq2fads: Update device tree for use with device-tree-aware u-boot.

Stephen Rothwell (1):
      powerpc: Wire up preadv and pwritev

Wolfgang Grandegger (1):
      powerpc/85xx: Re-add the device_type soc to socrates.dts
