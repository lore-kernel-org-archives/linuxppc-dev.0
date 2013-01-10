Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 532FC2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:10:59 +1100 (EST)
Message-ID: <50EE57F7.1000304@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 13:56:07 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 02/15] memory-hotplug: check whether all memory blocks
 are offlined or not when removing memory
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-3-git-send-email-tangchen@cn.fujitsu.com>
 <20130109151140.76982b9e.akpm@linux-foundation.org>
In-Reply-To: <20130109151140.76982b9e.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, glommer@parallels.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On 01/10/2013 07:11 AM, Andrew Morton wrote:
> On Wed, 9 Jan 2013 17:32:26 +0800
> Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>
>> We remove the memory like this:
>> 1. lock memory hotplug
>> 2. offline a memory block
>> 3. unlock memory hotplug
>> 4. repeat 1-3 to offline all memory blocks
>> 5. lock memory hotplug
>> 6. remove memory(TODO)
>> 7. unlock memory hotplug
>>
>> All memory blocks must be offlined before removing memory. But we don't hold
>> the lock in the whole operation. So we should check whether all memory blocks
>> are offlined before step6. Otherwise, kernel maybe panicked.
>
> Well, the obvious question is: why don't we hold lock_memory_hotplug()
> for all of steps 1-4?  Please send the reasons for this in a form which
> I can paste into the changelog.

In the changelog form:

Offlining a memory block and removing a memory device can be two
different operations. Users can just offline some memory blocks
without removing the memory device. For this purpose, the kernel has
held lock_memory_hotplug() in __offline_pages(). To reuse the code
for memory hot-remove, we repeat step 1-3 to offline all the memory
blocks, repeatedly lock and unlock memory hotplug, but not hold the
memory hotplug lock in the whole operation.

>
>
> Actually, I wonder if doing this would fix a race in the current
> remove_memory() repeat: loop.  That code does a
> find_memory_block_hinted() followed by offline_memory_block(), but
> afaict find_memory_block_hinted() only does a get_device().  Is the
> get_device() sufficiently strong to prevent problems if another thread
> concurrently offlines or otherwise alters this memory_block's state?

I think we already have memory_block->state_mutex to protect the
concurrently changing of memory_block's state.

The find_memory_block_hinted() here is to find the memory_block
corresponding to the memory section we are dealing with.

Thanks. :)

>
