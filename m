Return-Path: <glommer@parallels.com>
Received: from mx2.parallels.com (mx2.parallels.com [64.131.90.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7FB9D2C030F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 19:36:15 +1100 (EST)
Message-ID: <50EE7D75.8080100@parallels.com>
Date: Thu, 10 Jan 2013 12:36:05 +0400
From: Glauber Costa <glommer@parallels.com>
MIME-Version: 1.0
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130109142314.1ce04a96.akpm@linux-foundation.org>
 <50EE24A4.8020601@cn.fujitsu.com> <50EE6A48.7060307@parallels.com>
 <50EE6E50.3040609@jp.fujitsu.com> <50EE73DE.30208@parallels.com>
 <50EE7A6B.7020005@jp.fujitsu.com>
In-Reply-To: <50EE7A6B.7020005@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
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


> If it's configure as ZONE_NORMAL, you need to pray for offlining memory.
> 
> AFAIK, IBM's ppc? has 16MB section size. So, some of sections can be
> offlined
> even if they are configured as ZONE_NORMAL. For them, placement of offlined
> memory is not important because it's virtualized by LPAR, they don't try
> to remove DIMM, they just want to increase/decrease amount of memory.
> It's an another approach.
> 
> But here, we(fujitsu) tries to remove a system board/DIMM.
> So, configuring the whole memory of a node as ZONE_MOVABLE and tries to
> guarantee
> DIMM as removable.
> 
>>> IMHO, I don't think shrink_slab() can kill all objects in a node even
>>> if they are some caches. We need more study for doing that.
>>>
>>
>> Indeed, shrink_slab can only kill cached objects. They, however, are
>> usually a very big part of kernel memory. I wonder though if in case of
>> failure, it is worth it to try at least one shrink pass before you
>> give up.
>>
> 
> Yeah, now, his (our) approach is never allowing kernel memory on a node
> to be
> hot-removed by ZONE_MOVABLE. So, shrink_slab()'s effect will not be seen.

Ok, that clarifies it to me.
> 
> If other brave guys tries to use ZONE_NORMAL for hot-pluggable DIMM, I see,
> it's worth triying.
> 
I was under the impression that this was being done in here.

> How about checking the target memsection is in NORMAL or in MOVABLE at
> hot-removing ? If NORMAL, shrink_slab() will be worth to be called.
> 
Yes, this is what I meant. I think there is value investigating this,
since for a lot of workloads, a lot of the kernel memory will consist of
shrinkable cached memory. It would provide you with the same level of
guarantees (zero), but can improve the success  rate (this is, of
course, a guess)


> BTW, shrink_slab() is now node/zone aware ? If not, fixing that first will
> be better direction I guess.
> 
It is not upstream, but there are patches for this that I am already
using in my private tree.
