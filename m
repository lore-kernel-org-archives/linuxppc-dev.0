Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 00/15] ps3: Support more than the OtherOS lpar
Date: Mon,  1 Aug 2011 22:02:51 +0200
Message-Id: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
Cc: cbe-oss-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series addresses various issues and extends support when running
in lpars like GameOS. Included are some patches from Hector Martin, which
I found useful.

The ps3disk driver now creates multiple block devices instead of just one.
On the GameOS lpar we have access to all regions, and - depending on the
customizable layout - the linux partitions are likely not on the first.
The device names look similar the bsd slices, a bit unusual, but the best
I could think of. Better suggestions?

There're 2 new drivers: ps3vflash and ps3nflash. These are just modified
copies of the ps3disk driver:
  diff -u drivers/block/ps3disk.c drivers/block/ps3vflash.c
and "worse":
  diff -u drivers/block/ps3vflash.c drivers/block/ps3nflash.c
I'm not sure what the desired way to handle these similarities are. Should
that be merged to avoid code duplication? If so, how?

Patches are based on 2.6.39 since master doesn't boot with smp on my
console.  I wasn't able to pinpoint the cause so far (not that I tried
too hard). If anything get accepted I'll rebase :)

All patches were tested with the AsbestOS bootloader from Hector
Martin (http://git.marcansoft.com/?p=asbestos.git) on a PS3 slim.

Note: There are various patches floating around from anonymous
developers. None of those are signed-off and had various issues.
While some of those do contain simliar changes, I redid everything
in this series from scratch (except the patches from Hector).

Please let me know If there're any issues!

Thanks,
Andre

Andre Heider (12):
  ps3: MEMORY_HOTPLUG is not a requirement anymore
  ps3: Detect the current lpar environment
  ps3flash: Fix region align checks
  ps3flash: Refuse to work in lpars other than OtherOS
  ps3: Only prealloc the flash bounce buffer for the OtherOS lpar
  ps3: Limit the number of regions per storage device
  ps3stor_lib: Add support for multiple regions
  ps3disk: Provide a gendisk per accessible region
  ps3stor_lib: Add support for storage access flags
  ps3disk: Use region flags
  ps3: Add a vflash driver for lpars other than OtherOS
  ps3: Add a NOR FLASH driver for PS3s without NAND

Hector Martin (3):
  [PS3] Add udbg driver using the PS3 gelic Ethernet device
  [PS3] Get lv1 high memory region from devtree
  [PS3] Add region 1 memory early

 arch/powerpc/Kconfig.debug               |    8 +
 arch/powerpc/include/asm/ps3.h           |    9 +
 arch/powerpc/include/asm/ps3stor.h       |   11 +-
 arch/powerpc/include/asm/udbg.h          |    1 +
 arch/powerpc/kernel/udbg.c               |    2 +
 arch/powerpc/platforms/ps3/Kconfig       |   43 +++-
 arch/powerpc/platforms/ps3/Makefile      |    1 +
 arch/powerpc/platforms/ps3/device-init.c |   16 +
 arch/powerpc/platforms/ps3/gelic_udbg.c  |  272 ++++++++++++++++
 arch/powerpc/platforms/ps3/mm.c          |   91 ++++---
 arch/powerpc/platforms/ps3/platform.h    |    5 +
 arch/powerpc/platforms/ps3/repository.c  |   19 ++
 arch/powerpc/platforms/ps3/setup.c       |   27 ++-
 arch/powerpc/platforms/ps3/system-bus.c  |    2 +
 drivers/block/Makefile                   |    2 +
 drivers/block/ps3disk.c                  |  136 ++++++---
 drivers/block/ps3nflash.c                |  473 +++++++++++++++++++++++++++
 drivers/block/ps3vflash.c                |  508 ++++++++++++++++++++++++++++++
 drivers/char/ps3flash.c                  |   56 +++--
 drivers/net/ps3_gelic_net.c              |    3 +
 drivers/net/ps3_gelic_net.h              |    6 +
 drivers/ps3/ps3stor_lib.c                |   30 +-
 drivers/scsi/ps3rom.c                    |   11 +-
 23 files changed, 1617 insertions(+), 115 deletions(-)
 create mode 100644 arch/powerpc/platforms/ps3/gelic_udbg.c
 create mode 100644 drivers/block/ps3nflash.c
 create mode 100644 drivers/block/ps3vflash.c

-- 
1.7.5.4
