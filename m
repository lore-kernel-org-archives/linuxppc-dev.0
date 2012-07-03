Return-Path: <jiang.liu@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 by ozlabs.org (Postfix) with ESMTP id E4C8B2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 13:33:50 +1000 (EST)
Message-ID: <4FF26726.8010904@huawei.com>
Date: Tue, 3 Jul 2012 11:29:42 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] mm: setup pageblock_order before it's used by sparse
References: <1341047274-5616-1-git-send-email-jiang.liu@huawei.com>
 <CAE9FiQWzfLkeQs8O22MUEmuGUx=jPi5s=wZt2fcpFMcwrzt3uA@mail.gmail.com>
 <4FF100F0.9050501@huawei.com>
 <CAE9FiQXpeGFfWvUHHW_GjgTg+4Op7agsht5coZbcmn2W=f9bqw@mail.gmail.com>
 <4FF25EFA.1080004@huawei.com>
 <CAE9FiQVxY9E3L_xmRj10+9D6NVbKaxaAd2oJ6EFe1D+Gy2971w@mail.gmail.com>
In-Reply-To: <CAE9FiQVxY9E3L_xmRj10+9D6NVbKaxaAd2oJ6EFe1D+Gy2971w@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"
Cc: Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Minchan Kim <minchan@kernel.org>, Keping Chen <chenkeping@huawei.com>,
 Mel Gorman <mgorman@suse.de>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, Xishi Qiu <qiuxishi@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Gibson <david@gibson.dropbear.id.au>, linuxppc-dev@lists.ozlabs.org,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
 Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Hi Yinghai,
>>
>> I'm afraid the v2 will break powerpc. Currently only IA64 and PowerPC
>> supports variable hugetlb size.
>>
>> HPAGE_SHIFT is a variable default to 0 on powerpc. But seems PowerPC
>> is doing something wrong here, according to it's mm initialization
>> sequence as below:
>> start_kernel()
>>         setup_arch()
>>                 paging_init()
>>                         free_area_init_node()
>>                                 set_pageblock_order()
>>                                         refer to HPAGE_SHIFT (still 0)
>>         init_rest()
>>                 do_initcalls()
>>                         hugetlbpage_init()
>>                                 setup HPAGE_SHIFT
>> That means pageblock_order is always set to "MAX_ORDER - 1", not sure
>> whether this is intended. And it has the same issue as IA64 of wasting
>> memory if CONFIG_SPARSE is enabled.
> 
> adding BenH, need to know if it is powerpc intended.
> 
>>
>> So it would be better to keep function set_pageblock_order(), it will
>> fix the memory wasting on both IA64 and PowerPC.
> 
> Should setup pageblock_order as early as possible to avoid confusing.
OK, waiting response from PPC. If we could find some ways to set HPAGE_SIZE
early on PPC too, we can setup pageblock_order in arch instead of page_alloc.c
as early as possible.

Thanks!
Gerry
