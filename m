Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id AA1562C0868
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2013 22:47:12 +1100 (EST)
From: Tang Chen <tangchen@cn.fujitsu.com>
To: akpm@linux-foundation.org, rientjes@google.com, len.brown@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, cl@linux.com,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, wujianguo@huawei.com,
 wency@cn.fujitsu.com, hpa@zytor.com, linfeng@cn.fujitsu.com,
 laijs@cn.fujitsu.com, mgorman@suse.de, yinghai@kernel.org,
 glommer@parallels.com, jiang.liu@huawei.com, julian.calaby@gmail.com,
 sfr@canb.auug.org.au
Subject: [PATCH Bug fix 0/4] Bug fix for movablecore_map boot option.
Date: Tue, 22 Jan 2013 19:46:17 +0800
Message-Id: <1358855181-6160-1-git-send-email-tangchen@cn.fujitsu.com>
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

Hi Andrew,

patch1 ~ patch3 fix some problems of movablecore_map boot option.
And since the name "core" could be confused, patch4 rename this option
to movablemem_map.

All these patches are based on the latest -mm tree.
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm

Tang Chen (4):
  Bug fix: Use CONFIG_HAVE_MEMBLOCK_NODE_MAP to protect movablecore_map
    in memblock_overlaps_region().
  Bug fix: Fix the doc format.
  Bug fix: Remove the unused sanitize_zone_movable_limit() definition.
  Rename movablecore_map to movablemem_map.

 Documentation/kernel-parameters.txt |    8 +-
 include/linux/memblock.h            |    3 +-
 include/linux/mm.h                  |    8 +-
 mm/memblock.c                       |   42 +++++++++++-
 mm/page_alloc.c                     |  116 +++++++++++++++++-----------------
 5 files changed, 106 insertions(+), 71 deletions(-)
