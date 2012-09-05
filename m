Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id EAC6F2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 11:46:23 +1000 (EST)
Message-ID: <5046ADB2.9020703@cn.fujitsu.com>
Date: Wed, 05 Sep 2012 09:41:06 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC v8 PATCH 08/20] memory-hotplug: remove /sys/firmware/memmap/X
 sysfs
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>	<1346148027-24468-9-git-send-email-wency@cn.fujitsu.com>	<20120831140623.8d13bd2c.akpm@linux-foundation.org>	<5044454E.7070909@cn.fujitsu.com>
 <20120904161634.f1f9f693.akpm@linux-foundation.org>
In-Reply-To: <20120904161634.f1f9f693.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 09/05/2012 07:16 AM, Andrew Morton Wrote:
> On Mon, 03 Sep 2012 13:51:10 +0800
> Wen Congyang <wency@cn.fujitsu.com> wrote:
> 
>>>> +static void release_firmware_map_entry(struct kobject *kobj)
>>>> +{
>>>> +	struct firmware_map_entry *entry = to_memmap_entry(kobj);
>>>> +	struct page *page;
>>>> +
>>>> +	page = virt_to_page(entry);
>>>> +	if (PageSlab(page) || PageCompound(page))
>>>
>>> That PageCompound() test looks rather odd.  Why is this done?
>>
>> Liu Jiang and Christoph Lameter discussed how to find slab page
>> in this mail:
>> https://lkml.org/lkml/2012/7/6/333.
> 
> Well, please add a code comment to release_firmware_map_entry() which
> fully explains these things.
> 
> I see that Christoph and I agree: "It would be cleaner if memory
> hotplug had an indicator which allocation mechanism was used and would
> use the corresponding free action".  You didn't respond to this
> suggestion when he made it, nor when I made it.  What are your thoughts
> on this?

Hmm, I think it is better to use an indicator which allocation mechanism was
used. I will do it in the next version.

Thanks
Wen Congyang
