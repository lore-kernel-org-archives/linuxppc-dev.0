Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 76DF5DDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 15:24:52 +1000 (EST)
Date: Fri, 29 Jun 2007 00:24:50 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

to receive the following updates:

 arch/powerpc/Kconfig                              |    6
 arch/powerpc/Makefile                             |   19
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |   99 +++-
 arch/powerpc/kernel/Makefile                      |    2
 arch/powerpc/kernel/pci-common.c                  |  454 ++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c                      |  476 ----------------------
 arch/powerpc/kernel/pci_64.c                      |  391 ------------------
 arch/powerpc/kernel/ppc_ksyms.c                   |    4
 arch/powerpc/platforms/4xx/Kconfig                |   11
 arch/powerpc/platforms/52xx/Kconfig               |    2
 arch/powerpc/platforms/52xx/efika.c               |    9
 arch/powerpc/platforms/52xx/mpc52xx_pci.c         |   18
 arch/powerpc/platforms/82xx/Kconfig               |    3
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   17
 arch/powerpc/platforms/83xx/Kconfig               |    8
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |    7
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    7
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    7
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    7
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    7
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    7
 arch/powerpc/platforms/83xx/mpc83xx.h             |    6
 arch/powerpc/platforms/83xx/pci.c                 |   18
 arch/powerpc/platforms/85xx/Kconfig               |    5
 arch/powerpc/platforms/85xx/mpc85xx.h             |    2
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   10
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   17
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    7
 arch/powerpc/platforms/85xx/pci.c                 |   11
 arch/powerpc/platforms/86xx/Kconfig               |    3
 arch/powerpc/platforms/86xx/mpc86xx.h             |   11
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   12
 arch/powerpc/platforms/86xx/pci.c                 |   67 ++-
 arch/powerpc/platforms/Kconfig                    |   24 +
 arch/powerpc/platforms/Kconfig.cputype            |  306 ++++++++++++--
 arch/powerpc/platforms/cell/Kconfig               |    1
 arch/powerpc/platforms/celleb/Kconfig             |    1
 arch/powerpc/platforms/chrp/Kconfig               |    1
 arch/powerpc/platforms/chrp/Makefile              |    3
 arch/powerpc/platforms/chrp/pci.c                 |    7
 arch/powerpc/platforms/embedded6xx/Kconfig        |    5
 arch/powerpc/platforms/embedded6xx/holly.c        |    2
 arch/powerpc/platforms/embedded6xx/linkstation.c  |   10
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    9
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |    5
 arch/powerpc/platforms/iseries/pci.c              |    2
 arch/powerpc/platforms/maple/Kconfig              |    1
 arch/powerpc/platforms/maple/pci.c                |    6
 arch/powerpc/platforms/pasemi/Kconfig             |    1
 arch/powerpc/platforms/pasemi/pci.c               |    4
 arch/powerpc/platforms/powermac/Kconfig           |    2
 arch/powerpc/platforms/powermac/pci.c             |   14
 arch/powerpc/platforms/ps3/Kconfig                |    1
 arch/powerpc/sysdev/Makefile                      |    3
 arch/powerpc/sysdev/fsl_pcie.c                    |  171 -------
 arch/powerpc/sysdev/indirect_pci.c                |   44 +-
 arch/powerpc/sysdev/mv64x60_pci.c                 |    7
 arch/powerpc/sysdev/tsi108_pci.c                  |   10
 arch/ppc/syslib/Makefile                          |    1
 arch/ppc/syslib/indirect_pci.c                    |  134 ++++++
 include/asm-powerpc/machdep.h                     |    2
 include/asm-powerpc/mpc86xx.h                     |    6
 include/asm-powerpc/pci-bridge.h                  |  129 ++++-
 include/asm-powerpc/pci.h                         |    7
 64 files changed, 1299 insertions(+), 1350 deletions(-)

Arnd Bergmann (7):
      [POWERPC] move 82xx/83xx/86xx Kconfig options to platform selection
      [POWERPC] autoselect optimal -mcpu= flag by platform
      [POWERPC] rename add_bridge to avoid namespace clashes
      [POWERPC] mpc82xx_ads build fix
      [POWERPC] kill isa_{io,mem}_base definitions for !PCI
      [POWERPC] fix building without PCI
      [POWERPC] disallow building powermac and tsi108 without PCI

Kumar Gala (18):
      [POWERPC] Remove set_cfg_type for PCI indirect users that don't need it
      [POWERPC] 52xx: Remove support for PCI bus_offset
      [POWERPC] Pass the pci_controller into pci_exclude_device
      [POWERPC] Remove hack to determine the 2nd PHBs bus number
      [POWERPC] Remove bus_offset in places its not really used
      [POWERPC] Added self_busno to indicate which bus number the PHB is
      [POWERPC] Removed remnants of bus_offset
      [POWERPC] Added indirect_type to handle variants of PCI ops
      [POWERPC] 86xx: Workaround PCI_PRIMARY_BUS usage
      [POWERPC] Merge asm-ppc/pci-bridge.h into asm-power/pci-bridge.h
      [POWERPC] Remove local_number from pci_controller
      [POWERPC] Removed dead code related to PCI on ppc32
      [POWERPC] Use global_number in ppc32 pci_controller
      [POWERPC] Merge ppc32 and ppc64 pcibios_alloc_controller() prototypes
      [POWERPC] Move pci_bus_to_hose users to pci_bus_to_host
      [POWERPC] Move common PCI code out of pci_32/pci_64
      [POWERPC] Use ppc64 style list management for pci_controller on ppc32
      [POWERPC] Add copyright header to pci-common.c based on pci_{32,64}.c

Wade Farnsworth (1):
      [POWERPC] 86xx: Add uli1575 pci-bridge sector to MPC8641HPCN dts file.

York Sun (1):
      [POWERPC] Let subordinate transparent bridges be transparent.

Zhang Wei (4):
      [POWERPC] Remove PCI-e errata for MPC8641 silicon ver 1.0
      [POWERPC] 86xx: Avoid system halt if link training isn't at least L0.
      [POWERPC] MPC8641HPCN: Set IDE in ULI1575 to not native mode.
      [POWERPC] 86xx: Created quirk_fsl_pcie_transparent() to initialize bridge resources.
