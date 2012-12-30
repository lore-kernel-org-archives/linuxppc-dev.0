Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id D4BCD2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Dec 2012 16:55:40 +1100 (EST)
Message-ID: <50DFD8F4.7040301@cn.fujitsu.com>
Date: Sun, 30 Dec 2012 14:02:28 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v5 14/14] memory-hotplug: free node_data when a node is
 offlined
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
 <50DA7533.6060407@jp.fujitsu.com> <50DC3C26.6060308@cn.fujitsu.com>
 <50DCE7C0.8070407@jp.fujitsu.com>
In-Reply-To: <50DCE7C0.8070407@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
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

At 12/28/2012 08:28 AM, Kamezawa Hiroyuki Wrote:
> (2012/12/27 21:16), Wen Congyang wrote:
>> At 12/26/2012 11:55 AM, Kamezawa Hiroyuki Wrote:
>>> (2012/12/24 21:09), Tang Chen wrote:
>>>> From: Wen Congyang <wency@cn.fujitsu.com>
>>>>
>>>> We call hotadd_new_pgdat() to allocate memory to store node_data. So we
>>>> should free it when removing a node.
>>>>
>>>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>>>
>>> I'm sorry but is it safe to remove pgdat ? All zone cache and zonelists are
>>> properly cleared/rebuilded in synchronous way ? and No threads are visinting
>>> zone in vmscan.c ?
>>
>> We have rebuilt zonelists when a zone has no memory after offlining some pages.
>>
> 
> How do you guarantee that the address of pgdat/zone is not on stack of any kernel
> threads or other kernel objects without reference counting or other syncing method ?

No way to guarentee this. But, the kernel should not use the address of pgdat/zone when
it is offlined.

Hmm, what about this: reuse the memory when the node is onlined again?

Thanks
Wen Congyang

> 
> 
> Thanks,
> -Kame
> 
> 
> 
