Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01D242C009F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 11:47:19 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 52FA03EE0BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:47:15 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 2F91145DE5C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:47:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 14C1645DE55
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:47:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 02B811DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:47:15 +0900 (JST)
Received: from g01jpexchkw06.g01.fujitsu.local
 (g01jpexchkw06.g01.fujitsu.local [10.0.194.45])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B33161DB8052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 10:47:14 +0900 (JST)
Message-ID: <504D467D.2080201@jp.fujitsu.com>
Date: Mon, 10 Sep 2012 10:46:37 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <wency@cn.fujitsu.com>
Subject: Re: [RFC v8 PATCH 00/20] memory-hotplug: hot-remove physical memory
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
 <20120831134956.fec0f681.akpm@linux-foundation.org>
In-Reply-To: <20120831134956.fec0f681.akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 paulus@samba.org, minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com,
 rientjes@google.com, sparclinux@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 cl@linux.com, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wen,

2012/09/01 5:49, Andrew Morton wrote:
> On Tue, 28 Aug 2012 18:00:07 +0800
> wency@cn.fujitsu.com wrote:
>
>> This patch series aims to support physical memory hot-remove.
>
> Have you had much review and testing feedback yet?
>
>> The patches can free/remove the following things:
>>
>>    - acpi_memory_info                          : [RFC PATCH 4/19]
>>    - /sys/firmware/memmap/X/{end, start, type} : [RFC PATCH 8/19]
>>    - iomem_resource                            : [RFC PATCH 9/19]
>>    - mem_section and related sysfs files       : [RFC PATCH 10-11, 13-16/19]
>>    - page table of removed memory              : [RFC PATCH 12/19]
>>    - node and related sysfs files              : [RFC PATCH 18-19/19]
>>
>> If you find lack of function for physical memory hot-remove, please let me
>> know.
>

> I doubt if many people have hardware which permits physical memory
> removal?  How would you suggest that people with regular hardware can
> test these chagnes?

How do you test the patch? As Andrew says, for hot-removing memory,
we need a particular hardware. I think so too. So many people may want
to know how to test the patch.
If we apply following patch to kvm guest, can we hot-remove memory on
kvm guest?

http://lists.gnu.org/archive/html/qemu-devel/2012-07/msg01389.html

Thanks,
Yasuaki Ishimatsu

>
>> Known problems:
>> 1. memory can't be offlined when CONFIG_MEMCG is selected.
>
> That's quite a problem!  Do you have a description of why this is the
> case, and a plan for fixing it?
>
