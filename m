Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXzdL68B7zDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Mar 2017 13:18:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: andrew.donnellan@au1.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 arnd@arndb.de, bsingharora@gmail.com, christophe.leroy@c-s.fr,
 dougmill@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com, fweisbec@gmail.com,
 gwshan@linux.vnet.ibm.com, jason.jin@nxp.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
 mdroth@linux.vnet.ibm.com, mikey@neuling.org, naveen.n.rao@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com, npiggin@gmail.com, oss@buserror.net,
 rashmicy@gmail.com, ruscur@russell.cc, sahilmehta17@gmail.com,
 stewart@linux.vnet.ibm.com, valentin.longchamp@keymile.com,
 viro@ZenIV.linux.org.uk, Peter Bergner  <bergner@vnet.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.11-2 tag
Date: Wed, 01 Mar 2017 13:18:17 +1100
Message-ID: <87o9xlpwnq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull the second set of powerpc updates for 4.11.

This includes an update of the disassembly code in xmon, from binutils. We'=
ve
received permission from all the authors of the relevant binutils changes to
relicense their changes to the relevant files from GPLv3 to GPLv2. That was=
 the
reason I split the pull request in two, so I could make 100% sure we had all
those approvals.

The rest is fairly boring arch stuff, plus a few changes to the pnv-php PCI
hotplug driver, which Bjorn has said he's OK with us merging.

This does generate a fairly ugly conflict in asm-offsets.c, between changes=
 in
your tree and a big patch I merged to switch that file to use the OFFSET ma=
cro.
In hindsight I should have done the OFFSET change after rc1.

The resolution is to drop TSK_STACK_CANARY which was removed in your tree, =
and
then for both 32 & 64-bit accounting.user_time was renamed to accounting.ut=
ime,
and accounting.system_time was renamed to accounting.stime.

Stephen has the correct resolution in linux-next:
    http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/diff/ar=
ch/powerpc/kernel/asm-offsets.c?id=3D99b07077f0c2cae8d4ff7263bf45df49f79f4c=
0d&id2=3D9f3768e02335ddd6ebe1d85d5cb3a68ee6264004


cheers


The following changes since commit 438e69b52be776c035aa2a851ccc1709033d729b:

  powerpc/mm/radix: Skip ptesync in pte update helpers (2017-02-15 20:02:41=
 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.11-2

for you to fetch changes up to 9f3768e02335ddd6ebe1d85d5cb3a68ee6264004:

  powerpc: Remove leftover cputime_to_nsecs call causing build error (2017-=
02-23 08:33:20 +1100)

=2D---------------------------------------------------------------
powerpc updates for 4.11 part 2

Highlights include:

 - An update of the disassembly code used by xmon to the latest versions in
   binutils. We've received permission from all the authors of the relevant
   binutils changes to relicense their changes to the relevant files from G=
PLv3
   to GPLv2, for inclusion in Linux. Thanks to Peter Bergner for doing the =
leg
   work to get permission from everyone.

 - Addition of the "architected" Power9 CPU table entry, allowing us to boot
   in Power9 architected mode under a hypervisor.

 - Updates to the Power9 PMU code.

 - Implementation of clear_bit_unlock_is_negative_byte() to optimise
   unlock_page().

 - Freescale updates from Scott: "Highlights include 8xx breakpoints and pe=
rf,
   t1042rdb display support, and board updates."

Thanks to:
  Al Viro, Andrew Donnellan, Aneesh Kumar K.V, Balbir Singh, Douglas Miller,
  Fr=C3=A9d=C3=A9ric Weisbecker, Gavin Shan, Madhavan Srinivasan, Michael R=
oth, Nathan
  Fontenot, Naveen N. Rao, Nicholas Piggin, Peter Bergner, Paul E. McKenney,
  Rashmica Gupta, Russell Currey, Sahil Mehta, Stewart Smith.

=2D---------------------------------------------------------------
Al Viro (1):
      powerpc/spufs: Get rid of broken fasync stuff

Andrew Donnellan (1):
      cxl: fix nested locking hang during EEH hotplug

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Always clear UPRT and Host Radix bits when setting u=
p CPU

Balbir Singh (3):
      powerpc/xmon: Update ppc-dis/opc.c and ppc.h
      powerpc/xmon: Apply binutils changes to upgrade disassembly
      powerpc/xmon: Enable disassembly files (compilation changes)

Christophe Leroy (4):
      powerpc/32: Enable HW_BREAKPOINT on BOOK3S
      powerpc/8xx: Implement hw_breakpoint
      powerpc/32: Remove FIX_SRR1
      powerpc/8xx: Perf events on PPC 8xx

Douglas Miller (1):
      powerpc/xmon: Dump memory in CPU endian format

Fr=C3=A9d=C3=A9ric Weisbecker (1):
      powerpc: Remove leftover cputime_to_nsecs call causing build error

Gavin Shan (9):
      drivers/pci/hotplug: Handle presence detection change properly
      drivers/pci/hotplug: Fix initial state for empty slot
      drivers/pci/hotplug: Mask PDC interrupt if required
      pci/hotplug/pnv-php: Remove WARN_ON() in pnv_php_put_slot()
      pci/hotplug/pnv-php: Disable surprise hotplug capability on conflicts
      pci/hotplug/pnv-php: Disable MSI and PCI device properly
      powerpc/mm: Fix typo in set_pte_at()
      powerpc/kernel: Remove error message in pcibios_setup_phb_resources()
      powerpc/powernv: Remove unused variable in pnv_pci_sriov_disable()

Jason Jin (1):
      powerpc/85xx: Enable display support for t1042rdb

Madhavan Srinivasan (8):
      powerpc/perf: Factor out event_alternative function
      powerpc/perf: Add PM_INST_DISP event to Power9 event list
      powerpc/perf: Add alternative event table and function for power9
      powerpc/perf: Use PM_INST_DISP for generic instructions sample
      powerpc/perf: Use Instruction Counter value
      powerpc/perf: Add restrictions to PMC5 in power9 DD1
      powerpc/perf: Avoid FAB_*_MATCH checks for power9
      powerpc/perf: use is_kernel_addr macro in perf_get_misc_flags()

Michael Ellerman (6):
      powerpc/64e: Fix bogus usage of WARN_ONCE()
      powerpc/pseries: Fix build break when MEMORY_HOTREMOVE=3Dn
      powerpc/mm: Convert slb_finish_load[_1T] to local symbols
      powerpc/mm: Blacklist SLB symbols from kprobe
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next
      powerpc/powernv: Make PCI non-optional

Michael Roth (1):
      powerpc/pseries: Advertise Hot Plug Event support to firmware

Nathan Fontenot (1):
      powerpc/pseries: Revert 'Auto-online hotplugged memory'

Naveen N. Rao (1):
      powerpc/optprobes: Fix TOC handling in optprobes trampoline

Nicholas Piggin (1):
      powerpc/64: Implement clear_bit_unlock_is_negative_byte()

Rashmica Gupta (2):
      powerpc/asm: Use OFFSET macro in asm-offsets.c
      powerpc/asm: Define STACK_PT_REGS_OFFSET macro in asm-offsets.c

Russell Currey (1):
      powerpc: Add POWER9 architected mode to cputable

Sahil Mehta (2):
      powerpc/pseries: Implement indexed-count hotplug memory add
      powerpc/pseries: Implement indexed-count hotplug memory remove

Stewart Smith (1):
      MAINTAINERS: Remove powerpc's "opal" pattern match

Valentin Longchamp (3):
      powerpc/corenet: explicitly disable the SDHC controller on kmcoge4
      powerpc/85xx: remove the kmp204x_defconfig
      powerpc/corenet: add support for the kmcent2 board

 MAINTAINERS                                     |    8 +-
 arch/powerpc/Kconfig                            |    2 +-
 arch/powerpc/boot/dts/fsl/kmcent2.dts           |  303 +
 arch/powerpc/boot/dts/fsl/kmcoge4.dts           |    4 +
 arch/powerpc/configs/85xx/kmp204x_defconfig     |  220 -
 arch/powerpc/configs/pseries_defconfig          |    1 -
 arch/powerpc/include/asm/bitops.h               |   28 +
 arch/powerpc/include/asm/pnv-pci.h              |    2 +
 arch/powerpc/include/asm/ppc_asm.h              |    1 -
 arch/powerpc/include/asm/processor.h            |    2 +-
 arch/powerpc/include/asm/prom.h                 |    1 +
 arch/powerpc/include/asm/reg.h                  |    2 +
 arch/powerpc/include/asm/reg_8xx.h              |   11 +
 arch/powerpc/include/asm/rtas.h                 |    2 +
 arch/powerpc/kernel/asm-offsets.c               |  772 +-
 arch/powerpc/kernel/cpu_setup_power.S           |    4 +
 arch/powerpc/kernel/cputable.c                  |   17 +
 arch/powerpc/kernel/entry_32.S                  |   19 +-
 arch/powerpc/kernel/head_32.S                   |    3 -
 arch/powerpc/kernel/head_8xx.S                  |   72 +-
 arch/powerpc/kernel/hw_breakpoint.c             |    6 +-
 arch/powerpc/kernel/optprobes_head.S            |    7 +
 arch/powerpc/kernel/pci-common.c                |   10 +-
 arch/powerpc/kernel/process.c                   |   22 +
 arch/powerpc/kernel/prom_init.c                 |    2 +-
 arch/powerpc/kernel/setup_64.c                  |   12 +-
 arch/powerpc/kernel/time.c                      |    2 +-
 arch/powerpc/mm/pgtable.c                       |    4 +-
 arch/powerpc/mm/slb_low.S                       |   24 +-
 arch/powerpc/perf/8xx-pmu.c                     |  173 +
 arch/powerpc/perf/Makefile                      |    2 +
 arch/powerpc/perf/core-book3s.c                 |   38 +-
 arch/powerpc/perf/isa207-common.c               |   94 +-
 arch/powerpc/perf/isa207-common.h               |    7 +
 arch/powerpc/perf/power8-pmu.c                  |   35 +-
 arch/powerpc/perf/power9-events-list.h          |    3 +
 arch/powerpc/perf/power9-pmu.c                  |   47 +-
 arch/powerpc/platforms/85xx/Makefile            |    1 +
 arch/powerpc/platforms/85xx/corenet_generic.c   |    1 +
 arch/powerpc/platforms/85xx/t1042rdb_diu.c      |  152 +
 arch/powerpc/platforms/Kconfig.cputype          |    7 +
 arch/powerpc/platforms/cell/spufs/file.c        |   65 +-
 arch/powerpc/platforms/cell/spufs/spufs.h       |    3 -
 arch/powerpc/platforms/powernv/Kconfig          |    3 +-
 arch/powerpc/platforms/powernv/pci-ioda.c       |    2 -
 arch/powerpc/platforms/pseries/dlpar.c          |   38 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  272 +-
 arch/powerpc/xmon/ppc-dis.c                     |  260 +-
 arch/powerpc/xmon/ppc-opc.c                     | 8999 ++++++++++++++-----=
----
 arch/powerpc/xmon/ppc.h                         |  268 +-
 arch/powerpc/xmon/xmon.c                        |   58 +-
 drivers/misc/cxl/cxl.h                          |    5 +-
 drivers/misc/cxl/main.c                         |    3 +-
 drivers/misc/cxl/pci.c                          |   11 +-
 drivers/misc/cxl/vphb.c                         |   18 +-
 drivers/pci/hotplug/pnv_php.c                   |   81 +-
 56 files changed, 7867 insertions(+), 4342 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/kmcent2.dts
 delete mode 100644 arch/powerpc/configs/85xx/kmp204x_defconfig
 create mode 100644 arch/powerpc/perf/8xx-pmu.c
 create mode 100644 arch/powerpc/platforms/85xx/t1042rdb_diu.c

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYti9rAAoJEFHr6jzI4aWA4RkP/i3Y31TTL9eV+u8m7TC/39aj
Biwo7tFFpIDUTqCrG5eD2u/+ybbtHqEdiZfLbJ9JPah15PaI72/vqfPpkFxZsW4M
qQFLBa4TnbUkfae5fNy/nSH9M5NJW10FRe5nR3k/TqAcE7Yvf+xKItGeLmlm50n0
oelXOmCeHD6HvA/9kj3Z8LUPNP8/nyZmbfTSGiI3Wj+h8/ASP2+mJFp73ZrkhK9t
VuRZYpRlsF/h0PMzqju3swqnnaXTIrofEL3jb7NE0GEvCQ+hR287I6902dllBhcH
O1sAo/1ItK+h9qPD4gMD+QFv+k7Cu6aZVKFAdG3fS0fWpZVK5qtg8kQ5iek32hZ5
Na5hjewriuUJiMdqozcgibFoYinsF/hcvwgDsJfvNTJ75XcY4aa0c/N+KJN9fmwa
uowgUk7ZeD3AcyoM4c0bPrTyX8uvMqAjco6eLVlDXpO1QY+xBY4zwMTkL8JQsH6R
KCpBmPk66sZEa5SZJxC+zWWp6xce/Yj0yMZj5xTLHWSKoKqGdGKA5rrx5brsTytE
AkFvboUcTLaanV+S9X7w4Tb2DxMLU+3NAop8dF4Tx4DH1AAT/pPzUID0ygG9H0HG
ncQYq1W2A0YUQB766g0GMlnA49P6aIkgMaFpttXICWTil49qGqDrQEmnU3LeMO8q
x+mn4bq/0TbrIm42pMgR
=e9Hq
-----END PGP SIGNATURE-----
--=-=-=--
