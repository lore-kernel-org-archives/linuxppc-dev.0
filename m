Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A17FDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 12:57:23 +1000 (EST)
Date: Mon, 23 Jul 2007 21:56:49 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull from 'for_paulus' branch
In-Reply-To: <Pine.LNX.4.64.0707231556210.4203@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0707232152200.12643@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0707231556210.4203@blarg.am.freescale.net>
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

Updated with Ben's request change to the indirect runtime patch and
dropped the i8259/mpic patch for now.

to receive the following updates:

 arch/powerpc/Kconfig                             |    9
 arch/powerpc/boot/dts/mpc8313erdb.dts            |    2
 arch/powerpc/boot/dts/mpc832x_mds.dts            |    2
 arch/powerpc/boot/dts/mpc832x_rdb.dts            |    2
 arch/powerpc/boot/dts/mpc8349emitx.dts           |    4
 arch/powerpc/boot/dts/mpc8349emitxgp.dts         |    2
 arch/powerpc/boot/dts/mpc834x_mds.dts            |    4
 arch/powerpc/boot/dts/mpc836x_mds.dts            |    2
 arch/powerpc/boot/dts/mpc8540ads.dts             |    2
 arch/powerpc/boot/dts/mpc8541cds.dts             |    4
 arch/powerpc/boot/dts/mpc8544ds.dts              |  211 ++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts             |  250 ++++++++++++-----
 arch/powerpc/boot/dts/mpc8555cds.dts             |    4
 arch/powerpc/boot/dts/mpc8560ads.dts             |    2
 arch/powerpc/boot/dts/mpc8568mds.dts             |   54 +++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts           |    8
 arch/powerpc/configs/mpc8544_ds_defconfig        |  333 ++++++++++++++---------
 arch/powerpc/configs/mpc8568mds_defconfig        |  292 ++++++++++++--------
 arch/powerpc/kernel/pci_32.c                     |   25 +
 arch/powerpc/platforms/82xx/mpc82xx_ads.c        |    3
 arch/powerpc/platforms/83xx/pci.c                |    4
 arch/powerpc/platforms/85xx/Kconfig              |    6
 arch/powerpc/platforms/85xx/Makefile             |    2
 arch/powerpc/platforms/85xx/mpc8544_ds.c         |  241 ++++++++++++++++
 arch/powerpc/platforms/85xx/mpc85xx.h            |    1
 arch/powerpc/platforms/85xx/mpc85xx_ads.c        |    3
 arch/powerpc/platforms/85xx/mpc85xx_cds.c        |   99 ++++++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        |    7
 arch/powerpc/platforms/85xx/pci.c                |   91 ------
 arch/powerpc/platforms/86xx/Kconfig              |    3
 arch/powerpc/platforms/86xx/Makefile             |    1
 arch/powerpc/platforms/86xx/mpc86xx.h            |    5
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c       |   13
 arch/powerpc/platforms/86xx/pci.c                |  238 ----------------
 arch/powerpc/platforms/chrp/pci.c                |    7
 arch/powerpc/platforms/embedded6xx/linkstation.c |    2
 arch/powerpc/sysdev/Makefile                     |    1
 arch/powerpc/sysdev/fsl_pci.c                    |  257 +++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h                    |   88 ++++++
 arch/powerpc/sysdev/fsl_pcie.h                   |   94 ------
 arch/powerpc/sysdev/grackle.c                    |    2
 arch/powerpc/sysdev/indirect_pci.c               |   59 ++--
 arch/powerpc/sysdev/mpic.c                       |    1
 arch/powerpc/sysdev/mv64x60_pci.c                |    2
 include/asm-powerpc/pci-bridge.h                 |   17 -
 include/linux/pci_ids.h                          |   17 +
 46 files changed, 1642 insertions(+), 834 deletions(-)

Jon Loeliger (1):
      [POWERPC] Add Freescale PCI VENDOR ID and 8641 device IDs

Kumar Gala (12):
      [POWERPC] Add the ability to find PCI capabilities early on
      [POWERPC] Added indirect quirk to handle PCIe PHB that have issue w/no link
      [POWERPC] FSL: Cleanup how we detect if we are a PCIe controller
      [POWERPC] Fixup resources on pci_bus for PCIe PHB when no device is connected
      [POWERPC] 85xx: Added 8568 PCIe support
      [POWERPC] 85xx: Add quirk to ignore bogus FPGA on CDS
      [POWERPC] Removed setup_indirect_pci_nomap
      [POWERPC] Make endianess of cfg_addr for indirect pci ops runtime
      [POWERPC] Provide ability to setup P2P bridge registers from struct resource
      [POWERPC] Make sure virtual P2P bridge registers are setup on PCIe PHB
      [POWERPC] FSL: Add support for PCI-X controllers
      [POWERPC] 85xx: Added needed MPC85xx PCI device IDs

Randy Vinson (4):
      [POWERPC] 85xxCDS: Allow 8259 cascade to share an MPIC interrupt line.
      [POWERPC] 85xxCDS: Make sure restart resets the PCI bus.
      [POWERPC] 85xxCDS: Misc 8548 PCI Corrections.
      [POWERPC] 85xxCDS: MPC8548 DTS cleanup.

Roy Zang (6):
      [POWERPC] Create common fsl pci/e files based on 86xx platforms
      [POWERPC] Add 8548 CDS PCI express controller node and PCI-X device node
      [POWERPC] Update PCI nodes in the 83xx/85xx boards device tree
      [POWERPC] Use Freescale pci/pcie common code for 85xx boards
      [POWERPC] Add basic PCI node for mpc8568mds board
      [POWERPC] Add basic PCI/PCI Express support for 8544DS board

Zang Roy-r61911 (1):
      [POWERPC] Rewrite Freescale PCI/PCIe support for 8{3,5,6}xx
