Return-Path: <a.heider@gmail.com>
From: Andre Heider <a.heider@gmail.com>
To: Geoff Levand <geoff@infradead.org>
Subject: [PATCH part1 v2 0/9] ps3: General improvements and preparation for
	support more than the OtherOS lpar
Date: Thu, 11 Aug 2011 21:31:04 +0200
Message-Id: <1313091073-4572-1-git-send-email-a.heider@gmail.com>
In-Reply-To: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
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

This is the first part of my previous series including the discussed fixups.

I dropped the old #2 ([PS3] Get lv1 high memory region from devtree)
and replaced it with 2 new patches, now #2 and #3. The latter contains
the fixups mentioned on the old #2 thread.

Patches are based on today's Linus' tree.

Andre Heider (7):
  ps3: Add helper functions to read highmem info from the repository
  ps3: Get lv1 high memory region from the repository
  ps3: MEMORY_HOTPLUG is not a requirement anymore
  ps3: Detect the current lpar
  ps3: Log the detected lpar on startup
  ps3flash: Refuse to work in lpars other than OtherOS
  ps3: Only prealloc the flash bounce buffer for the OtherOS lpar

Hector Martin (2):
  Add udbg driver using the PS3 gelic Ethernet device
  Add region 1 memory early

 arch/powerpc/Kconfig.debug              |    8 +
 arch/powerpc/include/asm/ps3.h          |    7 +
 arch/powerpc/include/asm/udbg.h         |    1 +
 arch/powerpc/kernel/udbg.c              |    2 +
 arch/powerpc/platforms/ps3/Kconfig      |   15 ++-
 arch/powerpc/platforms/ps3/Makefile     |    1 +
 arch/powerpc/platforms/ps3/gelic_udbg.c |  273 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/mm.c         |   85 +++++------
 arch/powerpc/platforms/ps3/platform.h   |    7 +
 arch/powerpc/platforms/ps3/repository.c |   55 ++++++
 arch/powerpc/platforms/ps3/setup.c      |   27 +++-
 drivers/char/ps3flash.c                 |    7 +
 drivers/net/ps3_gelic_net.c             |    3 +
 drivers/net/ps3_gelic_net.h             |    6 +
 14 files changed, 447 insertions(+), 50 deletions(-)
 create mode 100644 arch/powerpc/platforms/ps3/gelic_udbg.c

-- 
1.7.5.4
