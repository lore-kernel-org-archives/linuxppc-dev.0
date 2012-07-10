Return-Path: <liuj97@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
 [209.85.213.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3C55C2C01FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 02:50:29 +1000 (EST)
Received: by yenr13 with SMTP id r13so195118yen.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 09:50:27 -0700 (PDT)
Message-ID: <4FFC5D43.7040206@gmail.com>
Date: Wed, 11 Jul 2012 00:50:11 +0800
From: Jiang Liu <liuj97@gmail.com>
MIME-Version: 1.0
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [RFC PATCH v3 0/13] memory-hotplug : hot-remove physical memory
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <alpine.DEB.2.00.1207091015570.30060@router.home>
 <4FFBFCAC.4010007@jp.fujitsu.com>
In-Reply-To: <4FFBFCAC.4010007@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On 07/10/2012 05:58 PM, Yasuaki Ishimatsu wrote:
> Hi Christoph,
> 
> 2012/07/10 0:18, Christoph Lameter wrote:
>>
>> On Mon, 9 Jul 2012, Yasuaki Ishimatsu wrote:
>>
>>> Even if you apply these patches, you cannot remove the physical memory
>>> completely since these patches are still under development. I want you to
>>> cooperate to improve the physical memory hot-remove. So please review these
>>> patches and give your comment/idea.
>>
>> Could you at least give a method on how you want to do physical memory
>> removal?
> 
> We plan to release a dynamic hardware partitionable system. It will be
> able to hot remove/add a system board which included memory and cpu.
> But as you know, Linux does not support memory hot-remove on x86 box.
> So I try to develop it.
> 
> Current plan to hot remove system board is to use container driver.
> Thus I define the system board in ACPI DSDT table as a container device.
> It have supported hot-add a container device. And if container device
> has _EJ0 ACPI method, "eject" file to remove the container device is
> prepared as follow:
> 
> # ls -l /sys/bus/acpi/devices/ACPI0004\:01/eject
> --w-------. 1 root root 4096 Jul 10 18:19 /sys/bus/acpi/devices/ACPI0004:01/eject
> 
> When I hot-remove the container device, I echo 1 to the file as follow:
> 
> #echo 1 > /sys/bus/acpi/devices/ACPI0004\:02/eject
> 
> Then acpi_bus_trim() is called. And it calls acpi_memory_device_remove()
> for removing memory device. But the code does not do nothing.
> So I developed the continuation of the function.
> 
>> You would have to remove all objects from the range you want to
>> physically remove. That is only possible under special circumstances and
>> with a limited set of objects. Even if you exclusively use ZONE_MOVEABLE
>> you still may get cases where pages are pinned for a long time.
> 
> I know it. So my memory hot-remove plan is as follows:
> 
> 1. hot-added a system board
>    All memory which included the system board is offline.
> 
> 2. online the memory as removable page
>    The function has not supported yet. It is being developed by Lai as follow:
>    http://lkml.indiana.edu/hypermail/linux/kernel/1207.0/01478.html
>    If it is supported, I will be able to create movable memory.
> 
> 3. hot-remove the memory by container device's eject file
We have implemented a prototype to do physical node (mem + CPU + IOH) hotplug
for Itanium and is now porting it to x86. But with currently solution, memory
hotplug functionality may cause 10-20% performance decrease because we concentrate
all DMA/Normal memory to the first NUMA node, and all other NUMA nodes only
hosts ZONE_MOVABLE. We are working on solution to minimize the performance
drop now.

> 
> Thanks,
> Yasuaki Ishimatsu
> 
>>
>> I am not sure that these patches are useful unless we know where you are
>> going with this. If we end up with a situation where we still cannot
>> remove physical memory then this patchset is not helpful.
> 
> 
> 
