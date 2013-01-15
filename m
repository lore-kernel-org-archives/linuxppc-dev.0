Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 4F7702C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 21:55:39 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, cl@linux.com,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, tangchen@cn.fujitsu.com, hpa@zytor.com,
 linfeng@cn.fujitsu.com, laijs@cn.fujitsu.com, mgorman@suse.de,
 yinghai@kernel.org, glommer@parallels.com, jiang.liu@huawei.com
Subject: [BUG Fix Patch 0/6] Bug fix for physical memory hot-remove.
Date: Tue, 15 Jan 2013 18:54:21 +0800
Message-Id: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Here are some bug fix patches for physical hot-remove patches.
And there are some new ones reported by others, I'll fix them soon.

Thanks. :)


Tang Chen (6):
  Bug fix: Hold spinlock across find|remove /sys/firmware/memmap/X
    operation.
  Bug fix: Do not calculate direct mapping pages when freeing vmemmap
    pagetables.
  Bug fix: Do not free direct mapping pages twice.
  Bug fix: Do not free page split from hugepage one by one.
  Bug fix: Fix the wrong comments of map_entries.
  Bug fix: Reuse the storage of /sys/firmware/memmap/X/ allocated by
    bootmem.

 arch/x86/mm/init_64.c     |   92 ++++++++++++++++++++++++++++-----
 drivers/firmware/memmap.c |  124 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 179 insertions(+), 37 deletions(-)
