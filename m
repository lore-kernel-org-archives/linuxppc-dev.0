Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 35C282C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 12:20:55 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id EA8643EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 11:20:51 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id CFF6C45DE59
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 11:20:51 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id A3C9645DE54
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 11:20:51 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 925B91DB802F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 11:20:51 +0900 (JST)
Received: from g01jpexchkw01.g01.fujitsu.local
 (g01jpexchkw01.g01.fujitsu.local [10.0.194.40])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 4068A1DB8037
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 11:20:51 +0900 (JST)
Message-ID: <506E43E0.70507@jp.fujitsu.com>
Date: Fri, 5 Oct 2012 11:20:16 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <x86@kernel.org>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
 <linux-ia64@vger.kernel.org>, <cmetcalf@tilera.com>,
 <sparclinux@vger.kernel.org>
Subject: [PATCH 0/10] memory-hotplug: hot-remove physical memory
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch-set was divided from following thread's patch-set.

https://lkml.org/lkml/2012/9/5/201

If you want to know the reason, please read following thread.

https://lkml.org/lkml/2012/10/2/83

The patch-set has only the function of kernel core side for physical
memory hot remove. So if you use the patch, please apply following
patches.

- bug fix for memory hot remove
  https://lkml.org/lkml/2012/9/27/39
  https://lkml.org/lkml/2012/10/2/83
  http://www.spinics.net/lists/linux-mm/msg42982.html
  
- acpi framework
  https://lkml.org/lkml/2012/10/3/126
  https://lkml.org/lkml/2012/10/3/641

The patches can free/remove the following things:

  - /sys/firmware/memmap/X/{end, start, type} : [PATCH 2/10]
  - mem_section and related sysfs files       : [PATCH 3-4/10]
  - memmap of sparse-vmemmap                  : [PATCH 5-7/10]
  - page table of removed memory              : [RFC PATCH 8/10]
  - node and related sysfs files              : [RFC PATCH 9-10/10]

* [PATCH 1/10] checks whether the memory can be removed or not.

If you find lack of function for physical memory hot-remove, please let me
know.

How to test this patchset?
1. apply this patchset and build the kernel. MEMORY_HOTPLUG, MEMORY_HOTREMOVE,
   ACPI_HOTPLUG_MEMORY must be selected.
2. load the module acpi_memhotplug
3. hotplug the memory device(it depends on your hardware)
   You will see the memory device under the directory /sys/bus/acpi/devices/.
   Its name is PNP0C80:XX.
4. online/offline pages provided by this memory device
   You can write online/offline to /sys/devices/system/memory/memoryX/state to
   online/offline pages provided by this memory device
5. hotremove the memory device
   You can hotremove the memory device by the hardware, or writing 1 to
   /sys/bus/acpi/devices/PNP0C80:XX/eject.

Note: if the memory provided by the memory device is used by the kernel, it
can't be offlined. It is not a bug.

Known problems:
1. memory can't be offlined when CONFIG_MEMCG is selected.
   For example: there is a memory device on node 1. The address range
   is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
   and memory11 under the directory /sys/devices/system/memory/.
   If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
   when we online pages. When we online memory8, the memory stored page cgroup
   is not provided by this memory device. But when we online memory9, the memory
   stored page cgroup may be provided by memory8. So we can't offline memory8
   now. We should offline the memory in the reversed order.
   When the memory device is hotremoved, we will auto offline memory provided
   by this memory device. But we don't know which memory is onlined first, so
   offlining memory may fail. In such case, you should offline the memory by
   hand before hotremoving the memory device.
2. hotremoving memory device may cause kernel panicked
   This bug will be fixed by Liu Jiang's patch:
   https://lkml.org/lkml/2012/7/3/1
