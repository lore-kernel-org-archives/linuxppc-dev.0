Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 851442C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2013 13:12:57 +1100 (EST)
Message-ID: <50F60C77.9000201@cn.fujitsu.com>
Date: Wed, 16 Jan 2013 10:12:07 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [BUG Fix Patch 1/6] Bug fix: Hold spinlock across find|remove
 /sys/firmware/memmap/X operation.
References: <1358247267-18089-1-git-send-email-tangchen@cn.fujitsu.com>
 <1358247267-18089-2-git-send-email-tangchen@cn.fujitsu.com>
 <CAGRGNgWCdvWhp=9+PDRbC9bK100BdBv9kpcsqoM-J6ipq22Szw@mail.gmail.com>
In-Reply-To: <CAGRGNgWCdvWhp=9+PDRbC9bK100BdBv9kpcsqoM-J6ipq22Szw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
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

On 01/16/2013 06:26 AM, Julian Calaby wrote:
> Hi Tang,
>
> One minor point.
>
>>
>>   /*
>> - * Search memmap entry
>> + * firmware_map_find_entry: Search memmap entry.
>> + * @start: Start of the memory range.
>> + * @end:   End of the memory range (exclusive).
>> + * @type:  Type of the memory range.
>> + *
>> + * This function is to find the memmap entey of a given memory range.
>> + * The caller must hold map_entries_lock, and must not release the lock
>> + * until the processing of the returned entry has completed.
>> + *
>> + * Return pointer to the entry to be found on success, or NULL on failure.
>
> Why not make this completely kernel-doc compliant as you're already
> re-writing the comment?

Hi Julian,

Thank you for reminding me this. I think I may have some more problems
like this. I'll post a patch to fix as many of them as I can. :)

Thanks.
