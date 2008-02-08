Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18348.10091.120122.608010@cargo.ozlabs.ibm.com>
Date: Fri, 8 Feb 2008 20:56:59 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git for-2.6.25 branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git for-2.6.25

to get some bug-fixes for powerpc (1 for powermac and 8 for Cell),
plus 3 commits from Badari Pulavarty that implement memory hot-remove
for 64-bit powerpc.  These 3 commits have been signed-off by Andrew
Morton.  One of them touches generic code (kernel/resource.c), and it
has been acked by KAMEZAWA Hiroyuki.

Thanks,
Paul.

 arch/powerpc/Kconfig                            |    6 +++
 arch/powerpc/mm/mem.c                           |   33 +++++++++++++++
 arch/powerpc/platforms/cell/iommu.c             |   48 +++++++++++++----------
 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 +++
 arch/powerpc/platforms/cell/spufs/fault.c       |   12 ++----
 arch/powerpc/platforms/cell/spufs/file.c        |   49 ++++++++++++++---------
 arch/powerpc/platforms/cell/spufs/run.c         |   21 ++++++----
 arch/powerpc/platforms/cell/spufs/spufs.h       |    5 ++
 arch/powerpc/platforms/powermac/feature.c       |   11 +++++
 drivers/macintosh/smu.c                         |   25 +++++++++++-
 include/asm-powerpc/pmac_feature.h              |    8 ++++
 kernel/resource.c                               |    2 -
 12 files changed, 166 insertions(+), 60 deletions(-)

Badari Pulavarty (3):
      [POWERPC] Add remove_memory() for 64-bit powerpc
      [POWERPC] Enable hotplug memory remove for 64-bit powerpc
      [POWERPC] Add arch-specific walk_memory_remove() for 64-bit powerpc

Benjamin Herrenschmidt (1):
      [POWERPC] Disable G5 NAP mode during SMU commands on U3

Christoph Hellwig (1):
      [POWERPC] spufs: Fix state_mutex leaks

Luke Browning (2):
      [POWERPC] spufs: No need to have a runnable SPU for libassist update
      [POWERPC] spufs: Fix timing dependent false return from spufs_run_spu

Masato Noguchi (1):
      [POWERPC] spufs: Update SPU_Status[CISHP] in backing runcntl write

Michael Ellerman (4):
      [POWERPC] Fix cell IOMMU null pointer explosion on old firmwares
      [POWERPC] Don't enable cell IOMMU fixed mapping if there are no dma-ranges
      [POWERPC] Fix potential cell IOMMU bug when switching back to default DMA ops
      [POWERPC] Make cell IOMMU fixed mapping printk more useful
