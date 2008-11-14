Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09254DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 15:33:25 +1100 (EST)
Date: Fri, 14 Nov 2008 07:32:49 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <828133638.20081114073249@emcraft.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re[2]: [2/2] powerpc: support for 256K pages on PPC 44x
In-Reply-To: <f6812adbe26a68b0545f5fd25b6d9d6a@bga.com>
References: <d02415a31b89736f070f290be89013d4@bga.com>
	<49186028.8010505@emcraft.com>
	<f6812adbe26a68b0545f5fd25b6d9d6a@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, dzu@denx.de,
	Vladimir Panfilov <pvr@emcraft.com>,
	Ilya Yanok <yanok@emcraft.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Milton,

On Tuesday, November 11, 2008 Milton Miller wrote:

[snip]

>>>>
>>>>  #ifdef CONFIG_PTE_64BIT
>>>>  typedef unsigned long long pte_basic_t;
>>>> +#ifdef CONFIG_PPC_256K_PAGES
>>>> +#define PTE_SHIFT       (PAGE_SHIFT - 7)
>>>
>>> This seems to be missing the comment on how many ptes are actually in
>>> the page that are in the other if and else cases.
>>
>> Ok. I'll fix this. Actually it's another hack: we don't use full page
>> for PTE table because we need to reserve something for PGD

> I don't understand "we need to reserve something for PGD".   Do you=20
> mean that you would not require a second page for the PGD because the=20
> full pagetable could fit in one page?   My first reaction was to say=20
> then create pgtable-nopgd.h like the other two.  The page walkers=20
> support this with the advent of gigantic pages.  Then I realized that=20
> might not be optimal:  while the page table might fit in one page, it=20
> would mean you always allocate the pte space to cover the full address
> space.   Even if your processes spread out over the 3G of address space
> allocated to them (32 bit kernel), you will allocate space for 4G,=20
> wasting 1/4 of the pte space.
> That does imply you want to allocate the pte page from a slab instead=20
> of pgalloc.  Is that covered?

 Well, in case of 256K PAGE_SIZE we do not need the PGD level indeed
(18 bits are used for offset, and remaining 14 bits are for PTE index=20
inside the PTE table). Even the full 256K PTE page isn't necessary to=20
cover the full range: only half of it would be enough (with 14 bits we=20
can address only 16K PTEs).

 But the head_44x.S code is essentially based on the assumption of=20
2-level page addressing. Also, I may guess that eliminating of the
PGD level won't be as easy as just a re-implementation of the TLB-miss=20
handlers in head_44x.S. So, the current approach for 256K-pages=20
support was just a compromise between the required for the project=20
functionality, and the effort necessary to achieve it.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
