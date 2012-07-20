Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1694A2C032B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 17:31:47 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C29AA3EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:31:44 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id A09D245DEB7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:31:44 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8672A45DE7E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:31:44 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E3B41DB8042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:31:44 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1A6081DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 16:31:44 +0900 (JST)
Message-ID: <5009094B.3090506@jp.fujitsu.com>
Date: Fri, 20 Jul 2012 16:31:23 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH 0/8] memory-hotplug : hot-remove physical memory(clear
 page table)
References: <5009038A.4090001@cn.fujitsu.com>
In-Reply-To: <5009038A.4090001@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Hi Wen,

Good news!! I was waiting for this patch to come.
Applying the patches, can we hot-remove physical memory completely?

Thanks,
Yasuaki Ishimatsu

2012/07/20 16:06, Wen Congyang wrote:
> This patch series aims to support physical memory hot-remove(clear page table).
>
> This patch series base on ishimatsu's patch series. You can get it here:
> http://www.spinics.net/lists/linux-acpi/msg36804.html
>
> The patches can remove following things:
>    - page table of removed memory
>
> If you find lack of function for physical memory hot-remove, please let me
> know.
>
> Note:
> * The patch "remove memory info from list before freeing it" is being disccussed
>    in other thread. But for testing the patch series, the patch is needed.
>    So I added the patch as [PATCH 0/8].
> * You need to apply ishimatsu's patch series first before applying this patch
>    series.
>
> Wen Congyang (8):
>    memory-hotplug: store the node id in acpi_memory_device
>    memory-hotplug: offline memory only when it is onlined
>    memory-hotplug: call remove_memory() to cleanup when removing memory
>      device
>    memory-hotplug: export the function acpi_bus_remove()
>    memory-hotplug: call acpi_bus_remove() to remove memory device
>    memory-hotplug: introduce new function arch_remove_memory()
>    x86: make __split_large_page() generally avialable
>    memory-hotplug: implement arch_remove_memory()
>
>   arch/ia64/mm/init.c                  |   16 ++++
>   arch/powerpc/mm/mem.c                |   14 +++
>   arch/s390/mm/init.c                  |    8 ++
>   arch/sh/mm/init.c                    |   15 +++
>   arch/tile/mm/init.c                  |    8 ++
>   arch/x86/include/asm/pgtable_types.h |    1 +
>   arch/x86/mm/init_32.c                |   10 ++
>   arch/x86/mm/init_64.c                |  160 ++++++++++++++++++++++++++++++++++
>   arch/x86/mm/pageattr.c               |   47 +++++-----
>   drivers/acpi/acpi_memhotplug.c       |   24 ++++--
>   drivers/acpi/scan.c                  |    3 +-
>   include/acpi/acpi_bus.h              |    1 +
>   include/linux/memory_hotplug.h       |    1 +
>   mm/memory_hotplug.c                  |    2 +-
>   14 files changed, 280 insertions(+), 30 deletions(-)
>
