Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 57CD0DDDF9
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 02:36:57 +1100 (EST)
In-Reply-To: <828133638.20081114073249@emcraft.com>
References: <d02415a31b89736f070f290be89013d4@bga.com>
	<49186028.8010505@emcraft.com>
	<f6812adbe26a68b0545f5fd25b6d9d6a@bga.com>
	<828133638.20081114073249@emcraft.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <983a8cd0a573e97059371081e61663cc@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Re[2]: [2/2] powerpc: support for 256K pages on PPC 44x
Date: Fri, 14 Nov 2008 09:41:24 -0600
To: Yuri Tikhonov <yur@emcraft.com>
Cc: dzu@denx.de, Ilya Yanok <yanok@emcraft.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>,
	Vladimir Panfilov <pvr@emcraft.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Nov 13, 2008, at 10:32 PM, Yuri Tikhonov wrote:
> On Tuesday, November 11, 2008 Milton Miller wrote:
>>>>>  #ifdef CONFIG_PTE_64BIT
>>>>>  typedef unsigned long long pte_basic_t;
>>>>> +#ifdef CONFIG_PPC_256K_PAGES
>>>>> +#define PTE_SHIFT       (PAGE_SHIFT - 7)
>>>>
>>>> This seems to be missing the comment on how many ptes are actually 
>>>> in
>>>> the page that are in the other if and else cases.
>>>
>>> Ok. I'll fix this. Actually it's another hack: we don't use full page
>>> for PTE table because we need to reserve something for PGD
>
>> I don't understand "we need to reserve something for PGD".   Do you
>> mean that you would not require a second page for the PGD because the
>> full pagetable could fit in one page?
...
>> That does imply you want to allocate the pte page from a slab instead
>> of pgalloc.  Is that covered?
>
>  Well, in case of 256K PAGE_SIZE we do not need the PGD level indeed
> (18 bits are used for offset, and remaining 14 bits are for PTE index
> inside the PTE table). Even the full 256K PTE page isn't necessary to
> cover the full range: only half of it would be enough (with 14 bits we
> can address only 16K PTEs).
>
>  But the head_44x.S code is essentially based on the assumption of
> 2-level page addressing. Also, I may guess that eliminating of the
> PGD level won't be as easy as just a re-implementation of the TLB-miss
> handlers in head_44x.S. So, the current approach for 256K-pages
> support was just a compromise between the required for the project
> functionality, and the effort necessary to achieve it.

So are you allocating the < PAGE_SIZE levels from slabs (either kmalloc 
or dedicated) instead of allocating pages?   Or are you wasting the 
extra space?

At a very minimum you need to comment this in the code.  If I were 
maintiner I would say not wasting large fractions of pages when the 
page size is 256k would be my merge requirement.  As I said, I'm fine 
with keeping the page table two levels, but the tradeoff needs to be 
documented.

milton
