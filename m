Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C1754DE088
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 23:26:57 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2RCQsFM008600
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 08:26:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2RCQr3W145006
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 06:26:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2RCQrK3012549
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 06:26:53 -0600
Date: Thu, 27 Mar 2008 07:24:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: Please pull 'for-2.6.26' branch of 4xx tree
Message-ID: <20080327072408.6869eb69@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.26

to pick up the first round of 4xx patches for 2.6.26.  There are a few
new board ports, some Xilinx driver updates, and some DCR helper
macros.

Grant has two bootwrapper patches that I would like to see go in as
well, but I need to test them a bit more first.

josh

David Gibson (1):
      [POWERPC] Start removing linux,network-index in favour of aliases

Josh Boyer (3):
      [POWERPC] 4xx: Add AMCC 440EP Yosemite DTS
      [POWERPC] 4xx: Add platform support for the AMCC Yosemite board
      [POWERPC] 4xx: Add bootwrapper for AMCC Yosemite board

Stefan Roese (10):
      [POWERPC] 4xx: Add AMCC 460EX/460GT support to cputable.c & cpu_setup_44x.S
      [POWERPC] 4xx: Add AMCC Canyonlands 460EX eval board support to platforms/44x
      [POWERPC] 4xx: Add Canyonlands DTS
      [POWERPC] 4xx: Add 460EX PCIe support to 4xx pci driver
      [POWERPC] 4xx: Add Canyonlands defconfig file
      [POWERPC] 4xx: Add TAH support to taishan dts
      [POWERPC] 4xx: Add AMCC Glacier 460GT eval board dts
      [POWERPC] 4xx: Add "amcc, haleakala" to the toplevel compatible property
      [POWERPC] 4xx: Add PPC4xx L2-cache support (440GX)
      [POWERPC] 4xx: Add L2 cache node to AMCC Taishan dts file

Stephen Neuendorffer (3):
      [POWERPC] Xilinx: hwicap: Refactor status handling code.
      [POWERPC] Xilinx: hwicap: Verify sync before reading idcode.
      [POWERPC] Xilinx: hwicap: Use fixed device major.

Valentine Barshak (2):
      [POWERPC] 4xx: Add dcri_clrset() for locked read/modify/write functionality
      [POWERPC] 4xx: Use dcri_clrset() for PCIe indirect dcr read/modify/write access

 Documentation/powerpc/booting-without-of.txt |   16 -
 arch/powerpc/Kconfig                         |    3 +
 arch/powerpc/boot/Makefile                   |    3 +-
 arch/powerpc/boot/bamboo.c                   |    3 +-
 arch/powerpc/boot/cuboot-rainier.c           |    3 +-
 arch/powerpc/boot/cuboot-sequoia.c           |    3 +-
 arch/powerpc/boot/cuboot-taishan.c           |    3 +-
 arch/powerpc/boot/cuboot-warp.c              |    2 +-
 arch/powerpc/boot/cuboot-yosemite.c          |   44 ++
 arch/powerpc/boot/dts/bamboo.dts             |    2 -
 arch/powerpc/boot/dts/canyonlands.dts        |  391 ++++++++++++++
 arch/powerpc/boot/dts/ebony.dts              |    2 -
 arch/powerpc/boot/dts/glacier.dts            |  464 +++++++++++++++++
 arch/powerpc/boot/dts/haleakala.dts          |    2 +-
 arch/powerpc/boot/dts/rainier.dts            |    2 -
 arch/powerpc/boot/dts/sequoia.dts            |    2 -
 arch/powerpc/boot/dts/taishan.dts            |   27 +-
 arch/powerpc/boot/dts/walnut.dts             |    1 -
 arch/powerpc/boot/dts/warp.dts               |    1 -
 arch/powerpc/boot/dts/yosemite.dts           |  304 +++++++++++
 arch/powerpc/boot/ebony.c                    |    3 +-
 arch/powerpc/boot/treeboot-walnut.c          |    2 +-
 arch/powerpc/configs/canyonlands_defconfig   |  721 ++++++++++++++++++++++++++
 arch/powerpc/kernel/cpu_setup_44x.S          |    5 +-
 arch/powerpc/kernel/cputable.c               |   28 +-
 arch/powerpc/platforms/44x/Kconfig           |   28 +
 arch/powerpc/platforms/44x/Makefile          |    2 +
 arch/powerpc/platforms/44x/canyonlands.c     |   64 +++
 arch/powerpc/sysdev/Makefile                 |    1 +
 arch/powerpc/sysdev/ppc4xx_pci.c             |  127 +++++-
 arch/powerpc/sysdev/ppc4xx_pci.h             |   59 +++
 arch/powerpc/sysdev/ppc4xx_soc.c             |  189 +++++++
 drivers/char/xilinx_hwicap/buffer_icap.c     |   22 +-
 drivers/char/xilinx_hwicap/buffer_icap.h     |    5 +-
 drivers/char/xilinx_hwicap/fifo_icap.c       |   31 +-
 drivers/char/xilinx_hwicap/fifo_icap.h       |    1 +
 drivers/char/xilinx_hwicap/xilinx_hwicap.c   |   63 ++-
 drivers/char/xilinx_hwicap/xilinx_hwicap.h   |   24 +
 include/asm-powerpc/dcr-native.h             |   17 +
 include/asm-powerpc/dcr-regs.h               |   78 +++
 40 files changed, 2643 insertions(+), 105 deletions(-)
