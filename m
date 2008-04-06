Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id 79330DDDF5
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Apr 2008 22:42:03 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so999583pyg.27
	for <linuxppc-dev@ozlabs.org>; Sun, 06 Apr 2008 05:42:02 -0700 (PDT)
Subject: Please pull 'for-2.6.26' branch of 4xx tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Sun, 06 Apr 2008 07:41:59 -0500
Message-Id: <1207485719.6809.16.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.26

to pick up a handful of additional commits for 2.6.26.  Most of these
are bug fixes.  Grant adds a helpful make target for building dtb files,
which is quite useful for some newer 4xx boards as well as other
platforms in general.

josh

Grant Likely (2):
      [POWERPC] add target for building .dtb files
      [POWERPC] bootwrapper: Add a firmware-independent simpleboot target.

Josh Boyer (1):
      [POWERPC] 4xx: Add Canyonlands and Yosemite to multi-board defconfig

Stefan Roese (5):
      [POWERPC] 4xx: Only reset PCIe PHY on 405EX systems when no link is detect
      [POWERPC] 4xx: Fix PESDRn_UTLSET1 register setup on 460EX/GT
      [POWERPC] 4xx: Create common ppc4xx_reset_system() in ppc4xx_soc.c
      [POWERPC] 4xx: Some EMAC related changes in Canyonlands & Glacier dts file
      [POWERPC] 4xx: Change dts files to support jumbo frames

Stephen Neuendorffer (1):
      [POWERPC] of_serial: Fix possible null dereference.

Valentine Barshak (1):
      [POWERPC] 4xx: Use machine_device_initcall() for warp_nand

 arch/powerpc/Makefile                    |    2 +-
 arch/powerpc/boot/Makefile               |   36 +++++++++----
 arch/powerpc/boot/dts/canyonlands.dts    |   19 +++++--
 arch/powerpc/boot/dts/glacier.dts        |    5 ++-
 arch/powerpc/boot/dts/haleakala.dts      |    2 +-
 arch/powerpc/boot/dts/katmai.dts         |    2 +-
 arch/powerpc/boot/dts/kilauea.dts        |    4 +-
 arch/powerpc/boot/dts/makalu.dts         |    4 +-
 arch/powerpc/boot/dts/rainier.dts        |    4 +-
 arch/powerpc/boot/dts/sequoia.dts        |    4 +-
 arch/powerpc/boot/dts/taishan.dts        |    4 +-
 arch/powerpc/boot/simpleboot.c           |   84 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/virtex405-head.S       |   30 +++++++++++
 arch/powerpc/boot/wrapper                |    4 ++
 arch/powerpc/configs/ppc44x_defconfig    |   14 ++++--
 arch/powerpc/platforms/40x/ep405.c       |    2 +
 arch/powerpc/platforms/40x/kilauea.c     |    4 +-
 arch/powerpc/platforms/40x/makalu.c      |    2 +
 arch/powerpc/platforms/40x/virtex.c      |    2 +
 arch/powerpc/platforms/40x/walnut.c      |    4 +-
 arch/powerpc/platforms/44x/44x.h         |    1 -
 arch/powerpc/platforms/44x/Kconfig       |    1 -
 arch/powerpc/platforms/44x/bamboo.c      |   15 +++---
 arch/powerpc/platforms/44x/canyonlands.c |    5 +-
 arch/powerpc/platforms/44x/ebony.c       |    5 +-
 arch/powerpc/platforms/44x/katmai.c      |    5 +-
 arch/powerpc/platforms/44x/misc_44x.S    |   11 ----
 arch/powerpc/platforms/44x/rainier.c     |    4 +-
 arch/powerpc/platforms/44x/sequoia.c     |    4 +-
 arch/powerpc/platforms/44x/taishan.c     |    5 +-
 arch/powerpc/platforms/44x/warp-nand.c   |    3 +-
 arch/powerpc/platforms/44x/warp.c        |    6 +--
 arch/powerpc/platforms/Kconfig.cputype   |    2 +
 arch/powerpc/sysdev/ppc4xx_pci.c         |   18 ++-----
 arch/powerpc/sysdev/ppc4xx_soc.c         |   11 ++++
 drivers/serial/of_serial.c               |    4 +-
 include/asm-powerpc/ppc4xx.h             |   18 ++++++
 37 files changed, 257 insertions(+), 93 deletions(-)
