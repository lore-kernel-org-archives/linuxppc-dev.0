Return-Path: <linfeng@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id E7A8E2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2013 19:15:29 +1100 (EST)
From: Lin Feng <linfeng@cn.fujitsu.com>
To: akpm@linux-foundation.org, mhocko@suse.cz, linux-mm@kvack.org,
 tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, jbeulich@suse.com,
 dhowells@redhat.com, wency@cn.fujitsu.com,
 isimatu.yasuaki@jp.fujitsu.com, paul.gortmaker@windriver.com,
 laijs@cn.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, mel@csn.ul.ie,
 minchan@kernel.org, aquini@redhat.com, jiang.liu@huawei.com,
 tony.luck@intel.com, fenghua.yu@intel.com, benh@kernel.crashing.org,
 paulus@samba.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
 davem@davemloft.net, michael@ellerman.id.au,
 gerald.schaefer@de.ibm.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 0/2] memory-hotplug: introduce
 CONFIG_HAVE_BOOTMEM_INFO_NODE and revert register_page_bootmem_info_node()
 when platform not support
Date: Wed, 16 Jan 2013 16:14:17 +0800
Message-Id: <1358324059-9608-1-git-send-email-linfeng@cn.fujitsu.com>
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, tangchen@cn.fujitsu.com, linfeng@cn.fujitsu.com,
 sparclinux@vger.kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory-hotplug codes for x86_64 have been implemented by patchset:
https://lkml.org/lkml/2013/1/9/124
While other platforms haven't been completely implemented yet.

If we enable both CONFIG_MEMORY_HOTPLUG_SPARSE and CONFIG_SPARSEMEM_VMEMMAP,
register_page_bootmem_info_node() may be buggy, which is a hotplug generic
function but falling back to call platform related function
register_page_bootmem_memmap().

Other platforms such as powerpc it's not implemented, so on such platforms,
revert them to empty as they were before.

It's implemented by adding a new Kconfig option named
CONFIG_HAVE_BOOTMEM_INFO_NODE, which will be automatically selected by
memory-hotplug supported archs(currently only on x86_64).

changeLog v2->v3:
1) patch 1/2:
- Rename the patch title to conform it's content.
- Update memory_hotplug.h and remove the misleading TODO pointed out by Michal.
2) patch 2/2:
- New added, remove unimplemented functions suggested by Michal.

ChangeLog v1->v2:
1) patch 1/2:
- Add a Kconfig option named HAVE_BOOTMEM_INFO_NODE suggested by Michal, which
  will be automatically selected by supported archs(currently only on x86_64).

Lin Feng (1):
  memory-hotplug: revert register_page_bootmem_info_node() to empty
    when platform related code is not implemented

Michal Hocko (1):
  memory-hotplug: cleanup: removing the arch specific functions without
    any implementation

 arch/ia64/mm/discontig.c       |    5 -----
 arch/powerpc/mm/init_64.c      |    5 -----
 arch/s390/mm/vmem.c            |    6 ------
 arch/sparc/mm/init_64.c        |    5 -----
 arch/x86/mm/init_64.c          |    2 +-
 include/linux/memory_hotplug.h |    6 ++++++
 mm/Kconfig                     |    8 ++++++++
 mm/memory_hotplug.c            |    2 ++
 8 files changed, 17 insertions(+), 22 deletions(-)
