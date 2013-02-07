Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id CD0142C0294
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 18:57:26 +1100 (EST)
Message-ID: <51135E33.4060508@cn.fujitsu.com>
Date: Thu, 07 Feb 2013 15:56:35 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Glauber Costa <glommer@parallels.com>
Subject: Re: [PATCH v5 01/14] memory-hotplug: try to offline the memory twice
 to avoid dependence
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-2-git-send-email-tangchen@cn.fujitsu.com>
 <50D96543.6010903@parallels.com> <50DFD7F7.5090408@cn.fujitsu.com>
 <50ED8834.1090804@parallels.com> <5111C8EB.6090805@cn.fujitsu.com>
 <51121FB7.1070205@cn.fujitsu.com> <51122C1D.5020002@cn.fujitsu.com>
 <5112679A.7080600@parallels.com>
In-Reply-To: <5112679A.7080600@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, Miao Xie <miaox@cn.fujitsu.com>,
 Wen Congyang <wency@cn.fujitsu.com>, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/06/2013 10:24 PM, Glauber Costa wrote:
>>>> And one more question, a memory section is 128MB in Linux. If we reserve
>>>> part of the them for page_cgroup,
>>>> then anyone who wants to allocate a contiguous memory larger than 128MB,
>>>> it will fail, right ?
>>>> Is it OK ?
> No, it is not.
>
> Another take on this: Can't we free all the page_cgroup structure before
> we actually start removing the sections ? If we do this, we would be
> basically left with no problem at all, since when your code starts
> running we would no longer have any page_cgroup allocated.
>
> All you have to guarantee is that it happens after the memory block is
> already isolated and allocations no longer can reach it.
>
> What do you think ?

Hi Glauber,

I don't think so. We can offline some of the sections and leave the 
reset online.

For example, we store page_cgroups of memory9~11 in memory8. So when we 
offline memory8,
we free memory8's page_cgroup storing on other section, but we cannot 
free the page_cgroups
being stored in memory8 if memory9~11 are left online.

So we still need to offline memory9~11, and then offline memory8, right ?
I think it makes no difference.

Thanks. :)
