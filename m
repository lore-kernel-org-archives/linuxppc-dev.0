Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id DCD9F2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 10:19:22 +1100 (EST)
Date: Wed, 9 Jan 2013 15:19:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v6 04/15] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
Message-Id: <20130109151920.fb9b4029.akpm@linux-foundation.org>
In-Reply-To: <1357723959-5416-5-git-send-email-tangchen@cn.fujitsu.com>
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-5-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Wed, 9 Jan 2013 17:32:28 +0800
Tang Chen <tangchen@cn.fujitsu.com> wrote:

> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> When (hot)adding memory into system, /sys/firmware/memmap/X/{end, start, type}
> sysfs files are created. But there is no code to remove these files. The patch
> implements the function to remove them.
> 
> Note: The code does not free firmware_map_entry which is allocated by bootmem.
>       So the patch makes memory leak. But I think the memory leak size is
>       very samll. And it does not affect the system.
> 
> ...
>
> +static struct firmware_map_entry * __meminit
> +firmware_map_find_entry(u64 start, u64 end, const char *type)
> +{
> +	struct firmware_map_entry *entry;
> +
> +	spin_lock(&map_entries_lock);
> +	list_for_each_entry(entry, &map_entries, list)
> +		if ((entry->start == start) && (entry->end == end) &&
> +		    (!strcmp(entry->type, type))) {
> +			spin_unlock(&map_entries_lock);
> +			return entry;
> +		}
> +
> +	spin_unlock(&map_entries_lock);
> +	return NULL;
> +}
>
> ...
>
> +	entry = firmware_map_find_entry(start, end - 1, type);
> +	if (!entry)
> +		return -EINVAL;
> +
> +	firmware_map_remove_entry(entry);
>
> ...
>

The above code looks racy.  After firmware_map_find_entry() does the
spin_unlock() there is nothing to prevent a concurrent
firmware_map_remove_entry() from removing the entry, so the kernel ends
up calling firmware_map_remove_entry() twice against the same entry.

An easy fix for this is to hold the spinlock across the entire
lookup/remove operation.


This problem is inherent to firmware_map_find_entry() as you have
implemented it, so this function simply should not exist in the current
form - no caller can use it without being buggy!  A simple fix for this
is to remove the spin_lock()/spin_unlock() from
firmware_map_find_entry() and add locking documentation to
firmware_map_find_entry(), explaining that the caller must hold
map_entries_lock and must not release that lock until processing of
firmware_map_find_entry()'s return value has completed.
