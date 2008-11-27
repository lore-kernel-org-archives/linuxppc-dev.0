Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 155F0DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 11:30:16 +1100 (EST)
Date: Thu, 27 Nov 2008 03:30:01 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <364074843.20081127033001@emcraft.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re[4]: [2/2] powerpc: support for 256K pages on PPC 44x
In-Reply-To: <983a8cd0a573e97059371081e61663cc@bga.com>
References: <d02415a31b89736f070f290be89013d4@bga.com>
	<49186028.8010505@emcraft.com>
	<f6812adbe26a68b0545f5fd25b6d9d6a@bga.com>
	<828133638.20081114073249@emcraft.com>
	<983a8cd0a573e97059371081e61663cc@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
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

=0D=0A Hello Milton,

On Friday, November 14, 2008 you wrote:

> On Nov 13, 2008, at 10:32 PM, Yuri Tikhonov wrote:
>> On Tuesday, November 11, 2008 Milton Miller wrote:
>>>>>>  #ifdef CONFIG_PTE_64BIT
>>>>>>  typedef unsigned long long pte_basic_t;
>>>>>> +#ifdef CONFIG_PPC_256K_PAGES
>>>>>> +#define PTE_SHIFT       (PAGE_SHIFT - 7)
>>>>>
>>>>> This seems to be missing the comment on how many ptes are actually=20
>>>>> in
>>>>> the page that are in the other if and else cases.
>>>>
>>>> Ok. I'll fix this. Actually it's another hack: we don't use full page
>>>> for PTE table because we need to reserve something for PGD
>>
>>> I don't understand "we need to reserve something for PGD".   Do you
>>> mean that you would not require a second page for the PGD because the
>>> full pagetable could fit in one page?
> ...
>>> That does imply you want to allocate the pte page from a slab instead
>>> of pgalloc.  Is that covered?
>>
>>  Well, in case of 256K PAGE_SIZE we do not need the PGD level indeed
>> (18 bits are used for offset, and remaining 14 bits are for PTE index
>> inside the PTE table). Even the full 256K PTE page isn't necessary to
>> cover the full range: only half of it would be enough (with 14 bits we
>> can address only 16K PTEs).
>>
>>  But the head_44x.S code is essentially based on the assumption of
>> 2-level page addressing. Also, I may guess that eliminating of the
>> PGD level won't be as easy as just a re-implementation of the TLB-miss
>> handlers in head_44x.S. So, the current approach for 256K-pages
>> support was just a compromise between the required for the project
>> functionality, and the effort necessary to achieve it.

> So are you allocating the < PAGE_SIZE levels from slabs (either kmalloc
> or dedicated) instead of allocating pages?   Or are you wasting the=20
> extra space?

 Wasting the extra space has a place here.

> At a very minimum you need to comment this in the code.  If I were=20
> maintiner I would say not wasting large fractions of pages when the=20
> page size is 256k would be my merge requirement.  As I said, I'm fine=20
> with keeping the page table two levels, but the tradeoff needs to be=20
> documented.

 Agree, we'll document this fact, and re-submit the patch.

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
