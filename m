Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 57FBC2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 13:00:13 +1100 (EST)
Message-ID: <50EE1B82.4090601@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 09:38:10 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Glauber Costa <glommer@parallels.com>
Subject: Re: [PATCH v5 01/14] memory-hotplug: try to offline the memory twice
 to avoid dependence
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
 <50D96543.6010903@parallels.com> <50DFD7F7.5090408@cn.fujitsu.com>
 <50ED8834.1090804@parallels.com>
In-Reply-To: <50ED8834.1090804@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, Wen Congyang <wency@cn.fujitsu.com>, cmetcalf@tilera.com,
 wujianguo@huawei.com, yinghai@kernel.org,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Glauber,

On 01/09/2013 11:09 PM, Glauber Costa wrote:
>>
>> We try to make all page_cgroup allocations local to the node they are describing
>> now. If the memory is the first memory onlined in this node, we will allocate
>> it from the other node.
>>
>> For example, node1 has 4 memory blocks: 8-11, and we online it from 8 to 11
>> 1. memory block 8, page_cgroup allocations are in the other nodes
>> 2. memory block 9, page_cgroup allocations are in memory block 8
>>
>> So we should offline memory block 9 first. But we don't know in which order
>> the user online the memory block.
>>
>> I think we can modify memcg like this:
>> allocate the memory from the memory block they are describing
>>
>> I am not sure it is OK to do so.
>
> I don't see a reason why not.

I'm not sure, but if we do this, we could bring in a fragment for each
memory block (a memory section, 128MB, right?). Is this a problem when
we use large page (such as 1GB page) ?

Even if not, will these fragments make any bad effects ?

Thank. :)

>
> You would have to tweak a bit the lookup function for page_cgroup, but
> assuming you will always have the pfns and limits, it should be easy to do.
>
> I think the only tricky part is that today we have a single
> node_page_cgroup, and we would of course have to have one per memory
> block. My assumption is that the number of memory blocks is limited and
> likely not very big. So even a static array would do.
>
> Kamezawa, do you have any input in here?
>
