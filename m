Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id B02B62C0315
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:15:52 +1100 (EST)
Message-ID: <50EE5C68.4030402@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 14:15:04 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 04/15] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-5-git-send-email-tangchen@cn.fujitsu.com>
 <20130109151920.fb9b4029.akpm@linux-foundation.org>
In-Reply-To: <20130109151920.fb9b4029.akpm@linux-foundation.org>
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

On 01/10/2013 07:19 AM, Andrew Morton wrote:
>> ...
>>
>> +	entry = firmware_map_find_entry(start, end - 1, type);
>> +	if (!entry)
>> +		return -EINVAL;
>> +
>> +	firmware_map_remove_entry(entry);
>>
>> ...
>>
>
> The above code looks racy.  After firmware_map_find_entry() does the
> spin_unlock() there is nothing to prevent a concurrent
> firmware_map_remove_entry() from removing the entry, so the kernel ends
> up calling firmware_map_remove_entry() twice against the same entry.
>
> An easy fix for this is to hold the spinlock across the entire
> lookup/remove operation.
>
>
> This problem is inherent to firmware_map_find_entry() as you have
> implemented it, so this function simply should not exist in the current
> form - no caller can use it without being buggy!  A simple fix for this
> is to remove the spin_lock()/spin_unlock() from
> firmware_map_find_entry() and add locking documentation to
> firmware_map_find_entry(), explaining that the caller must hold
> map_entries_lock and must not release that lock until processing of
> firmware_map_find_entry()'s return value has completed.

Thank you for your advice, I'll fix it soon.

Since you have merged the patch-set, do I need to resend all these
patches again, or just send a patch to fix it based on the current
one ?

Thanks. :)

>
