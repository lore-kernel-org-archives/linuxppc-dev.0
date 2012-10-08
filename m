Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 715042C01E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2012 16:20:43 +1100 (EST)
Message-ID: <507263F8.9040200@cn.fujitsu.com>
Date: Mon, 08 Oct 2012 13:26:16 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH 0/10] memory-hotplug: hot-remove physical memory
References: <506E43E0.70507@jp.fujitsu.com>
 <CAHGf_=qCZvL7xcOkea80Y995sZWkOMQLLVnuvLUto4W+qpUbWA@mail.gmail.com>
In-Reply-To: <CAHGf_=qCZvL7xcOkea80Y995sZWkOMQLLVnuvLUto4W+qpUbWA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, minchan.kim@gmail.com,
 rientjes@google.com, sparclinux@vger.kernel.org, cl@linux.com,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 10/06/2012 03:06 AM, KOSAKI Motohiro Wrote:
>> Known problems:
>> 1. memory can't be offlined when CONFIG_MEMCG is selected.
>>    For example: there is a memory device on node 1. The address range
>>    is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
>>    and memory11 under the directory /sys/devices/system/memory/.
>>    If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
>>    when we online pages. When we online memory8, the memory stored page cgroup
>>    is not provided by this memory device. But when we online memory9, the memory
>>    stored page cgroup may be provided by memory8. So we can't offline memory8
>>    now. We should offline the memory in the reversed order.
>>    When the memory device is hotremoved, we will auto offline memory provided
>>    by this memory device. But we don't know which memory is onlined first, so
>>    offlining memory may fail. In such case, you should offline the memory by
>>    hand before hotremoving the memory device.
> 
> Just iterate twice. 1st iterate: offline every non primary memory
> block. 2nd iterate:
> offline primary (i.e. first added) memory block. It may work.
> 

OK, I will try it.

Thanks
Wen Congyang
