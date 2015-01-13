Return-Path: <geoff@infradead.org>
Message-Id: <cover.1421109719.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 0/6] *** SUBJECT HERE ***
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 13 Jan 2015 01:00:20 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 Nathan Whitehorn <nwhitehorn@freebsd.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,
    
Here is a short series of updates for PS3, none are critical.  Please queue.
These are based on v3.18.  I can rebase to something else if you like.

The first three patches are to have the kernel write the PS3 highmem info to
the LV1 hypervisor registry so that the info will be available to second stage
OS's loaded by petitboot/kexec.  FreeBSD and some Linux derivatives use this
feature.

The next two patches fix some warnings emitted by sparse.

The final patch refreshes ps3_defconfig and enables the highmem info write
feature (CONFIG_PS3_REPOSITORY_WRITE=y) introduced in the first three patches.

-Geoff

The following changes since commit b2776bf7149bddd1f4161f14f79520f17fc1d71d:

  Linux 3.18 (2014-12-07 14:21:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc

for you to fetch changes up to c9fc20b63c625d8d5c136f1e72d9930a6b0070df:

  powerpc/ps3: Update ps3_defconfig (2014-12-23 14:56:29 -0800)

----------------------------------------------------------------
Geoff Levand (6):
  powerpc/ps3: Add empty repository highmem routines
  powerpc/ps3: Add ps3_mm_set_repository_highmem
  powerpc/ps3: Write highmem info to repository
  powerpc/ps3: Fix vuart sparse warnings
  powerpc/ps3: Fix sys-manager-core sparse warnings
  powerpc/ps3: Update ps3_defconfig

 arch/powerpc/configs/ps3_defconfig    | 17 +++-----
 arch/powerpc/platforms/ps3/mm.c       | 77 ++++++++++++++++++++---------------
 arch/powerpc/platforms/ps3/platform.h | 13 ++++++
 drivers/ps3/ps3-vuart.c               |  5 ---
 drivers/ps3/sys-manager-core.c        |  6 +--
 drivers/ps3/vuart.h                   | 16 ++++++++
 6 files changed, 83 insertions(+), 51 deletions(-)

-- 
1.9.1
