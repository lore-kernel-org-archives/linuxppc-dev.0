Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id D3ED92C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2012 16:51:27 +1100 (EST)
Message-ID: <50DFD7F7.5090408@cn.fujitsu.com>
Date: Sun, 30 Dec 2012 13:58:15 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Glauber Costa <glommer@parallels.com>
Subject: Re: [PATCH v5 01/14] memory-hotplug: try to offline the memory twice
 to avoid dependence
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
 <50D96543.6010903@parallels.com>
In-Reply-To: <50D96543.6010903@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 12/25/2012 04:35 PM, Glauber Costa Wrote:
> On 12/24/2012 04:09 PM, Tang Chen wrote:
>> From: Wen Congyang <wency@cn.fujitsu.com>
>>
>> memory can't be offlined when CONFIG_MEMCG is selected.
>> For example: there is a memory device on node 1. The address range
>> is [1G, 1.5G). You will find 4 new directories memory8, memory9, memory10,
>> and memory11 under the directory /sys/devices/system/memory/.
>>
>> If CONFIG_MEMCG is selected, we will allocate memory to store page cgroup
>> when we online pages. When we online memory8, the memory stored page cgroup
>> is not provided by this memory device. But when we online memory9, the memory
>> stored page cgroup may be provided by memory8. So we can't offline memory8
>> now. We should offline the memory in the reversed order.
>>
>> When the memory device is hotremoved, we will auto offline memory provided
>> by this memory device. But we don't know which memory is onlined first, so
>> offlining memory may fail. In such case, iterate twice to offline the memory.
>> 1st iterate: offline every non primary memory block.
>> 2nd iterate: offline primary (i.e. first added) memory block.
>>
>> This idea is suggested by KOSAKI Motohiro.
>>
>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> 
> Maybe there is something here that I am missing - I admit that I came
> late to this one, but this really sounds like a very ugly hack, that
> really has no place in here.
> 
> Retrying, of course, may make sense, if we have reasonable belief that
> we may now succeed. If this is the case, you need to document - in the
> code - while is that.
> 
> The memcg argument, however, doesn't really cut it. Why can't we make
> all page_cgroup allocations local to the node they are describing? If
> memcg is the culprit here, we should fix it, and not retry. If there is
> still any benefit in retrying, then we retry being very specific about why.

We try to make all page_cgroup allocations local to the node they are describing
now. If the memory is the first memory onlined in this node, we will allocate
it from the other node.

For example, node1 has 4 memory blocks: 8-11, and we online it from 8 to 11
1. memory block 8, page_cgroup allocations are in the other nodes
2. memory block 9, page_cgroup allocations are in memory block 8

So we should offline memory block 9 first. But we don't know in which order
the user online the memory block.

I think we can modify memcg like this:
allocate the memory from the memory block they are describing

I am not sure it is OK to do so.

Thanks
Wen Congyang

> 
> 
> 
