Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18067.32217.791517.449235@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 22:38:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: more patches pushed to powerpc.git for-2.6.23 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just pushed the following patches to the for-2.6.23 branch on
powerpc.git.  I intend to ask Linus to pull everything on the
for-2.6.23 branch shortly, unless I hear loud screams to the
contrary. :)

Paul.

 Documentation/feature-removal-schedule.txt   |   12 +
 Documentation/powerpc/booting-without-of.txt |   32 ++
 arch/powerpc/boot/Makefile                   |   31 ++
 arch/powerpc/boot/dts/ebony.dts              |    4 
 arch/powerpc/boot/dts/mpc8272ads.dts         |   42 +--
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   16 +
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   16 +
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   10 +
 arch/powerpc/boot/dts/mpc834x_mds.dts        |   10 +
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   16 +
 arch/powerpc/boot/dts/mpc8540ads.dts         |  147 ++++++-----
 arch/powerpc/boot/dts/mpc8541cds.dts         |   90 +++----
 arch/powerpc/boot/dts/mpc8544ds.dts          |   18 +
 arch/powerpc/boot/dts/mpc8548cds.dts         |  108 ++++----
 arch/powerpc/boot/dts/mpc8555cds.dts         |   90 +++----
 arch/powerpc/boot/dts/mpc8560ads.dts         |  148 ++++++-----
 arch/powerpc/boot/dts/mpc8568mds.dts         |   66 +++--
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |   50 +++-
 arch/powerpc/boot/dts/mpc866ads.dts          |   31 +-
 arch/powerpc/boot/dts/mpc885ads.dts          |   54 ++--
 arch/powerpc/boot/ps3-head.S                 |   80 ++++++
 arch/powerpc/boot/ps3-hvcall.S               |  184 ++++++++++++++
 arch/powerpc/boot/ps3.c                      |  161 ++++++++++++
 arch/powerpc/boot/wrapper                    |   55 ++++
 arch/powerpc/boot/zImage.ps3.lds.S           |   50 ++++
 arch/powerpc/kernel/cputable.c               |   20 +
 arch/powerpc/kernel/io.c                     |   12 -
 arch/powerpc/kernel/irq.c                    |    3 
 arch/powerpc/kernel/pci_32.c                 |   34 ---
 arch/powerpc/kernel/pci_64.c                 |    9 -
 arch/powerpc/kernel/ppc_ksyms.c              |    1 
 arch/powerpc/kernel/prom.c                   |   27 +-
 arch/powerpc/kernel/setup-common.c           |   21 ++
 arch/powerpc/kernel/sysfs.c                  |    5 
 arch/powerpc/kernel/time.c                   |    9 -
 arch/powerpc/kernel/vmlinux.lds.S            |    6 
 arch/powerpc/mm/hash_native_64.c             |    2 
 arch/powerpc/mm/mem.c                        |    2 
 arch/powerpc/mm/stab.c                       |    4 
 arch/powerpc/oprofile/op_model_power4.c      |   14 +
 arch/powerpc/platforms/52xx/efika.c          |    4 
 arch/powerpc/platforms/52xx/lite5200.c       |    2 
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8 -
 arch/powerpc/platforms/83xx/Makefile         |    2 
 arch/powerpc/platforms/83xx/mpc8313_rdb.c    |    1 
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |    2 
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |   49 ----
 arch/powerpc/platforms/83xx/mpc83xx.h        |   28 ++
 arch/powerpc/platforms/83xx/usb.c            |  181 +++++++++++++
 arch/powerpc/platforms/85xx/misc.c           |   32 ++
 arch/powerpc/platforms/85xx/mpc8544_ds.c     |   15 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   22 --
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   99 +++----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   21 --
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c   |   15 -
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    5 
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |   71 +++++
 arch/powerpc/platforms/pasemi/Kconfig        |    1 
 arch/powerpc/platforms/pasemi/setup.c        |    2 
 arch/powerpc/platforms/powermac/low_i2c.c    |   23 +-
 arch/powerpc/platforms/ps3/mm.c              |    2 
 arch/powerpc/platforms/pseries/reconfig.c    |    2 
 arch/powerpc/sysdev/fsl_soc.c                |   13 +
 arch/powerpc/sysdev/mpc8xx_pic.h             |   11 +
 arch/powerpc/sysdev/qe_lib/ucc.c             |    2 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c        |    8 +
 arch/powerpc/xmon/xmon.c                     |    2 
 arch/ppc/kernel/ppc_ksyms.c                  |    1 
 arch/ppc/mm/tlb.c                            |    1 
 drivers/block/viodasd.c                      |    4 
 drivers/char/briq_panel.c                    |   10 -
 drivers/char/hvc_console.c                   |    2 
 drivers/char/viotape.c                       |   12 -
 drivers/pcmcia/Kconfig                       |   17 +
 drivers/pcmcia/m8xx_pcmcia.c                 |  351 ++++++++++++--------------
 drivers/rtc/Kconfig                          |    2 
 drivers/serial/cpm_uart/cpm_uart_core.c      |    2 
 drivers/serial/of_serial.c                   |   33 ++
 include/asm-powerpc/cache.h                  |    4 
 include/asm-powerpc/cputable.h               |   26 --
 include/asm-powerpc/mmu-8xx.h                |  147 +++++++++++
 include/asm-powerpc/mmu-fsl-booke.h          |   88 +++++++
 include/asm-powerpc/mmu.h                    |   10 -
 include/asm-powerpc/mmu_context.h            |  202 +++++++++++++++
 include/asm-powerpc/mpc8xx.h                 |    4 
 include/asm-powerpc/prom.h                   |   15 +
 include/asm-powerpc/reg.h                    |    2 
 include/asm-powerpc/system.h                 |    4 
 include/asm-powerpc/termbits.h               |    4 
 include/linux/fsl_devices.h                  |    5 
 90 files changed, 2322 insertions(+), 937 deletions(-)
 create mode 100644 arch/powerpc/boot/ps3-head.S
 create mode 100644 arch/powerpc/boot/ps3-hvcall.S
 create mode 100644 arch/powerpc/boot/ps3.c
 create mode 100644 arch/powerpc/boot/zImage.ps3.lds.S
 create mode 100644 arch/powerpc/platforms/83xx/usb.c
 create mode 100644 include/asm-powerpc/mmu-8xx.h
 create mode 100644 include/asm-powerpc/mmu-fsl-booke.h

Adrian Bunk (1):
      [POWERPC] Make drivers/char/hvc_console.c:khvcd() static

Christoph Hellwig (1):
      [POWERPC] Remove unused do_signal export

David Gibson (2):
      [POWERPC] Split out asm-ppc/mmu.h portions for Freescale Book-E
      [POWERPC] Split out asm-ppc/mmu.h portions for PowerPC 8xx

David Woodhouse (1):
      [POWERPC] Enable arbitary speed tty ioctls and split input/output speed

Domen Puncer (1):
      [POWERPC] 52xx: sparse fixes

Geoff Levand (1):
      [POWERPC] PS3: Bootwrapper support.

Grant Likely (1):
      [POWERPC] 83xx: Add USB support to mpc8349-mitx board port

Ishizaki Kou (2):
      [POWERPC] of_serial: Ignore unknown serial port
      [POWERPC] of_serial: add port type checking

Johannes Berg (2):
      [POWERPC] powermac i2c: Use mutex
      [POWERPC] arch/powerpc/kernel/sysfs.c: Move NUMA exports

Jon Loeliger (1):
      [POWERPC] Replace use of GET_64BIT(prop, i) with of_read_number().

Josh Boyer (2):
      [POWERPC] Consolidate PowerPC 750 cputable features
      [POWERPC] Schedule removal of arch/ppc

Kumar Gala (6):
      [POWERPC] Reworked interrupt numbers for OpenPIC based Freescale chips
      [POWERPC] Kill pcibios_enable_resources()
      [POWERPC] Fix up interrupt senses for MPC85xx boards
      [POWERPC] Merge asm-ppc/mmu_context.h into asm-power/mmu_context.h
      [POWERPC] Move inline asm eieio to using eieio inline function
      [POWERPC] CPM_UART: Use inline function form of eieio

Laurent Pinchart (1):
      [PPC] Add linux/pagemap.h to arch/ppc/mm/tlb.c

Li Yang (3):
      [POWERPC] qe_lib: export symbols for QE driver to compile as module
      [POWERPC] 83xx: USB platform code rework
      [POWERPC] Fix typo in Ebony default DTS

Manish Ahuja (1):
      [POWERPC] Remove extra return statement

Mathieu Desnoyers (1):
      [POWERPC] Remove unnecessary #undef printk from prom.c

Michael Ellerman (4):
      [POWERPC] Check for the root node in of_detach_node()
      [POWERPC] Generalise device_node flag interface
      [POWERPC] Add a warning to help trackdown device_node refcounting bugs
      [POWERPC] Make the debugfs "powerpc" dir globally accessible

Olaf Hering (1):
      [POWERPC] Make two xmon variables static

Olof Johansson (2):
      [POWERPC] pasemi: Rename platform
      [POWERPC] pasemi: Don't auto-select CONFIG_EMBEDDED

Robert P. J. Day (2):
      [POWERPC] VIOTAPE: Use designated initializers for fops member structures.
      [POWERPC] Remove dead code for preventing pread() and pwrite() calls

Roland Dreier (1):
      [POWERPC] Add cputable entry for PowerPC 440SPe Rev. B

Roy Zang (4):
      [POWERPC] Document the global utilities node define and example
      [POWERPC] Fix the node index confusion for SOC
      [POWERPC] 85xx: Fix 8548CDS reset bug
      [POWERPC] Remove redundant pci_read_irq_line() function for 85xx platform

Sonny Rao (1):
      [POWERPC] Check for NULL ppc_md.init_IRQ() before calling

Stephen Rothwell (1):
      [POWERPC] Fix viodasd geometry calculations

Timur Tabi (1):
      [POWERPC] Fix MAC address entries for 83xx, 85xx, and 86xx device trees

Tony Breeds (3):
      [POWERPC] Create a dummy zImage if no valid platform has been selected
      [POWERPC] Modify sched_clock() to make CONFIG_PRINTK_TIME more sane
      [POWERPC] Add __read_mostly support for powerpc

Vitaly Bordug (2):
      [POWERPC] 8xx: mpc885ads pcmcia support
      [POWERPC] dts: kill hardcoded phandles

Wade Farnsworth (2):
      [POWERPC] Fix drivers/rtc/Kconfig for powerpc
      [POWERPC] Add a check for keyboard/mouse device nodes in check_legacy_ioport()

will schmidt (1):
      [POWERPC] Oprofile enhanced instruction sampling support
