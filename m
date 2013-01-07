Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA0502C007A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 16:31:34 +1100 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id BB9FE3EE081
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 14:31:30 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F22145DE5D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 14:31:30 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8163745DE58
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 14:31:30 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6508EE08007
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 14:31:30 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C3DCE08003
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Jan 2013 14:31:30 +0900 (JST)
Message-ID: <50EA5D7D.7000703@jp.fujitsu.com>
Date: Mon, 07 Jan 2013 14:30:37 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH v5 14/14] memory-hotplug: free node_data when a node is
 offlined
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-15-git-send-email-tangchen@cn.fujitsu.com>
 <50DA7533.6060407@jp.fujitsu.com> <50DC3C26.6060308@cn.fujitsu.com>
 <50DCE7C0.8070407@jp.fujitsu.com> <50DFD8F4.7040301@cn.fujitsu.com>
In-Reply-To: <50DFD8F4.7040301@cn.fujitsu.com>
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

(2012/12/30 15:02), Wen Congyang wrote:
> At 12/28/2012 08:28 AM, Kamezawa Hiroyuki Wrote:
>> (2012/12/27 21:16), Wen Congyang wrote:
>>> At 12/26/2012 11:55 AM, Kamezawa Hiroyuki Wrote:
>>>> (2012/12/24 21:09), Tang Chen wrote:
>>>>> From: Wen Congyang <wency@cn.fujitsu.com>
>>>>>
>>>>> We call hotadd_new_pgdat() to allocate memory to store node_data. So we
>>>>> should free it when removing a node.
>>>>>
>>>>> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
>>>>
>>>> I'm sorry but is it safe to remove pgdat ? All zone cache and zonelists are
>>>> properly cleared/rebuilded in synchronous way ? and No threads are visinting
>>>> zone in vmscan.c ?
>>>
>>> We have rebuilt zonelists when a zone has no memory after offlining some pages.
>>>
>>
>> How do you guarantee that the address of pgdat/zone is not on stack of any kernel
>> threads or other kernel objects without reference counting or other syncing method ?
> 
> No way to guarentee this. But, the kernel should not use the address of pgdat/zone when
> it is offlined.
> 
> Hmm, what about this: reuse the memory when the node is onlined again?
> 

That's the only way which we can go now. Please don't free it.

Thanks,
-Kame
