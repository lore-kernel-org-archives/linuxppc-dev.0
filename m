Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 2696F2C02BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:08:32 +1100 (EST)
Message-ID: <50EE5AA9.3090401@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 14:07:37 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 04/15] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-5-git-send-email-tangchen@cn.fujitsu.com>
 <20130109144905.8993886a.akpm@linux-foundation.org>
In-Reply-To: <20130109144905.8993886a.akpm@linux-foundation.org>
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

On 01/10/2013 06:49 AM, Andrew Morton wrote:
> On Wed, 9 Jan 2013 17:32:28 +0800
> Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>
>> When (hot)adding memory into system, /sys/firmware/memmap/X/{end, start, type}
>> sysfs files are created. But there is no code to remove these files. The patch
>> implements the function to remove them.
>>
>> Note: The code does not free firmware_map_entry which is allocated by bootmem.
>>        So the patch makes memory leak. But I think the memory leak size is
>>        very samll. And it does not affect the system.
>
> Well that's bad.  Can we remember the address of that memory and then
> reuse the storage if/when the memory is re-added?  That at least puts an upper
> bound on the leak.

I think we can do this. I'll post a new patch to do so.

Thanks. :)

>
>
