Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 031C22C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 12:23:07 +1100 (EST)
Message-ID: <5105D2C8.1000807@cn.fujitsu.com>
Date: Mon, 28 Jan 2013 09:22:16 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
References: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
 <1359137977.14145.417.camel@misato.fc.hp.com>
In-Reply-To: <1359137977.14145.417.camel@misato.fc.hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, cl@linux.com,
 sfr@canb.auug.org.au, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, julian.calaby@gmail.com,
 glommer@parallels.com, wujianguo@huawei.com, yinghai@kernel.org,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/26/2013 02:19 AM, Toshi Kani wrote:
> On Tue, 2013-01-22 at 19:42 +0800, Tang Chen wrote:
>> Here are some bug fix patches for physical memory hot-remove. All these
>> patches are based on the latest -mm tree.
>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
>>
>> And patch1 and patch3 are very important.
>> patch1: free compound pages when freeing memmap, otherwise the kernel
>>          will panic the next time memory is hot-added.
>> patch3: the old way of freeing pagetable pages was wrong. We should never
>>          split larger pages into small ones.
>>
>>
>> Lai Jiangshan (1):
>>    Bug-fix: mempolicy: fix is_valid_nodemask()
>>
>> Tang Chen (3):
>>    Bug fix: Do not split pages when freeing pagetable pages.
>>    Bug fix: Fix section mismatch problem of
>>      release_firmware_map_entry().
>>    Bug fix: Fix the doc format in drivers/firmware/memmap.c
>>
>> Wen Congyang (1):
>>    Bug fix: consider compound pages when free memmap
>>
>>   arch/x86/mm/init_64.c     |  148 ++++++++++++++-------------------------------
>>   drivers/firmware/memmap.c |   16 +++---
>>   mm/mempolicy.c            |   36 +++++++----
>>   mm/sparse.c               |    2 +-
>>   4 files changed, 77 insertions(+), 125 deletions(-)
>
> This patchset fixed a blocker panic I was hitting in my memory hot-plug
> testing.  Memory hotplug works fine with this patchset (for testing my
> hotplug framework patchset :).  For the series:

Hi Toshi-san,

Thank you for testing. :)

>
> Tested-by: Toshi Kani<toshi.kani@hp.com>
>
> Thanks,
> -Toshi
>
>
>
>
