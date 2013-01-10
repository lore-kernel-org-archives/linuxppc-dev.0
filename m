Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 44B502C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 18:32:48 +1100 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E548B3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 16:32:43 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CC0D345DE54
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 16:32:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AC00D45DE53
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 16:32:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 99EFC1DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 16:32:43 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 39E321DB802C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 16:32:43 +0900 (JST)
Message-ID: <50EE6E50.3040609@jp.fujitsu.com>
Date: Thu, 10 Jan 2013 16:31:28 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Glauber Costa <glommer@parallels.com>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130109142314.1ce04a96.akpm@linux-foundation.org>
 <50EE24A4.8020601@cn.fujitsu.com> <50EE6A48.7060307@parallels.com>
In-Reply-To: <50EE6A48.7060307@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2013/01/10 16:14), Glauber Costa wrote:
> On 01/10/2013 06:17 AM, Tang Chen wrote:
>>>> Note: if the memory provided by the memory device is used by the
>>>> kernel, it
>>>> can't be offlined. It is not a bug.
>>>
>>> Right.  But how often does this happen in testing?  In other words,
>>> please provide an overall description of how well memory hot-remove is
>>> presently operating.  Is it reliable?  What is the success rate in
>>> real-world situations?
>>
>> We test the hot-remove functionality mostly with movable_online used.
>> And the memory used by kernel is not allowed to be removed.
>
> Can you try doing this using cpusets configured to hardwall ?
> It is my understanding that the object allocators will try hard not to
> allocate anything outside the walls defined by cpuset. Which means that
> if you have one process per node, and they are hardwalled, your kernel
> memory will be spread evenly among the machine. With a big enough load,
> they should eventually be present in all blocks.
>

I'm sorry I couldn't catch your point.
Do you want to confirm whether cpuset can work enough instead of ZONE_MOVABLE ?
Or Do you want to confirm whether ZONE_MOVABLE will not work if it's used with cpuset ?


> Another question I have for you: Have you considering calling
> shrink_slab to try to deplete the caches and therefore free at least
> slab memory in the nodes that can't be offlined? Is it relevant?
>

At this stage, we don't consider to call shrink_slab(). We require
nearly 100% success at offlining memory for removing DIMM.
It's my understanding.

IMHO, I don't think shrink_slab() can kill all objects in a node even
if they are some caches. We need more study for doing that.

Thanks,
-Kame
