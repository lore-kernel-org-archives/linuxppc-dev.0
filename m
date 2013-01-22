Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 609D02C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 22:44:01 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, cl@linux.com,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com,
 laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org,
 glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com,
 sfr@canb.auug.org.au
Subject: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
Date: Tue, 22 Jan 2013 19:42:59 +0800
Message-Id: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-mm@kvack.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Here are some bug fix patches for physical memory hot-remove. All these
patches are based on the latest -mm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm

And patch1 and patch3 are very important.
patch1: free compound pages when freeing memmap, otherwise the kernel
        will panic the next time memory is hot-added.
patch3: the old way of freeing pagetable pages was wrong. We should never
        split larger pages into small ones.


Lai Jiangshan (1):
  Bug-fix: mempolicy: fix is_valid_nodemask()

Tang Chen (3):
  Bug fix: Do not split pages when freeing pagetable pages.
  Bug fix: Fix section mismatch problem of
    release_firmware_map_entry().
  Bug fix: Fix the doc format in drivers/firmware/memmap.c

Wen Congyang (1):
  Bug fix: consider compound pages when free memmap

 arch/x86/mm/init_64.c     |  148 ++++++++++++++-------------------------------
 drivers/firmware/memmap.c |   16 +++---
 mm/mempolicy.c            |   36 +++++++----
 mm/sparse.c               |    2 +-
 4 files changed, 77 insertions(+), 125 deletions(-)
