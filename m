Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59E112C0204
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 10:10:06 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id CFCB93EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 09:10:02 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id AE9A745DEB9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 09:10:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7B00845DEA6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 09:10:02 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6C74D1DB8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 09:10:02 +0900 (JST)
Received: from g01jpexchyt03.g01.fujitsu.local
 (g01jpexchyt03.g01.fujitsu.local [10.128.194.42])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 167A41DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 09:10:02 +0900 (JST)
Message-ID: <4FFCC438.4080004@jp.fujitsu.com>
Date: Wed, 11 Jul 2012 09:09:28 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC PATCH v3 0/13] memory-hotplug : hot-remove physical memory
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <alpine.DEB.2.00.1207091015570.30060@router.home>
 <4FFBFCAC.4010007@jp.fujitsu.com> <4FFC5D43.7040206@gmail.com>
In-Reply-To: <4FFC5D43.7040206@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jiang,

2012/07/11 1:50, Jiang Liu wrote:
> On 07/10/2012 05:58 PM, Yasuaki Ishimatsu wrote:
>> Hi Christoph,
>>
>> 2012/07/10 0:18, Christoph Lameter wrote:
>>>
>>> On Mon, 9 Jul 2012, Yasuaki Ishimatsu wrote:
>>>
>>>> Even if you apply these patches, you cannot remove the physical memory
>>>> completely since these patches are still under development. I want you to
>>>> cooperate to improve the physical memory hot-remove. So please review these
>>>> patches and give your comment/idea.
>>>
>>> Could you at least give a method on how you want to do physical memory
>>> removal?
>>
>> We plan to release a dynamic hardware partitionable system. It will be
>> able to hot remove/add a system board which included memory and cpu.
>> But as you know, Linux does not support memory hot-remove on x86 box.
>> So I try to develop it.
>>
>> Current plan to hot remove system board is to use container driver.
>> Thus I define the system board in ACPI DSDT table as a container device.
>> It have supported hot-add a container device. And if container device
>> has _EJ0 ACPI method, "eject" file to remove the container device is
>> prepared as follow:
>>
>> # ls -l /sys/bus/acpi/devices/ACPI0004\:01/eject
>> --w-------. 1 root root 4096 Jul 10 18:19 /sys/bus/acpi/devices/ACPI0004:01/eject
>>
>> When I hot-remove the container device, I echo 1 to the file as follow:
>>
>> #echo 1 > /sys/bus/acpi/devices/ACPI0004\:02/eject
>>
>> Then acpi_bus_trim() is called. And it calls acpi_memory_device_remove()
>> for removing memory device. But the code does not do nothing.
>> So I developed the continuation of the function.
>>
>>> You would have to remove all objects from the range you want to
>>> physically remove. That is only possible under special circumstances and
>>> with a limited set of objects. Even if you exclusively use ZONE_MOVEABLE
>>> you still may get cases where pages are pinned for a long time.
>>
>> I know it. So my memory hot-remove plan is as follows:
>>
>> 1. hot-added a system board
>>     All memory which included the system board is offline.
>>
>> 2. online the memory as removable page
>>     The function has not supported yet. It is being developed by Lai as follow:
>>     http://lkml.indiana.edu/hypermail/linux/kernel/1207.0/01478.html
>>     If it is supported, I will be able to create movable memory.
>>
>> 3. hot-remove the memory by container device's eject file
> We have implemented a prototype to do physical node (mem + CPU + IOH) hotplug
> for Itanium and is now porting it to x86. But with currently solution, memory
> hotplug functionality may cause 10-20% performance decrease because we concentrate
> all DMA/Normal memory to the first NUMA node, and all other NUMA nodes only
> hosts ZONE_MOVABLE. We are working on solution to minimize the performance
> drop now.

Thank you for your interesting response.

I have a question. How do you move all other NUMA nodes to ZONE_MOVABLE?
To use ZONE_MOVABLE, we need to use boot options like kernelcore or movablecore.
But it is not enough, since the requested amount is spread evenly throughout
all nodes in the system. So I think we do not have way to move all other NUMA
node to ZONE_MOVABLE.

Thanks,
Yasuaki Ishimatsu

>
>>
>> Thanks,
>> Yasuaki Ishimatsu
>>
>>>
>>> I am not sure that these patches are useful unless we know where you are
>>> going with this. If we end up with a situation where we still cannot
>>> remove physical memory then this patchset is not helpful.
>>
>>
>>
>
>
