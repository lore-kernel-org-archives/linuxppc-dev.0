Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56E35DDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 12:52:29 +1100 (EST)
Message-ID: <49407234.7070501@emcraft.com>
Date: Thu, 11 Dec 2008 04:51:48 +0300
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add 16K/64K pages support for the 44x PPC32
	architectures.
References: <1227829488-8260-1-git-send-email-yanok@emcraft.com>	
	<1228858740.22413.28.camel@pasglop>
	<1251410626.20081210142142@emcraft.com>
	<1228939101.22413.69.camel@pasglop>
In-Reply-To: <1228939101.22413.69.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org, Vladimir Panfilov <pvr@emcraft.com>, dzu@denx.de,
	wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Benjamin,
Benjamin Herrenschmidt wrote:
>>> I'm not sure about the above & PMD_MASK. Shouldn't we instead make it
>>> not build if (PKMAP_BASE & PMD_MASK) != 0 ? 
>>>       
>>  We separated the !4K_PAGES case here exactly because  (PKMAP_BASE & 
>> PMD_MASK) != 0 [see the comment to this chunk - why]. So, this'll turn 
>> out to be broken if we follow your suggestion. Are there any reasons 
>> why we should have PKMAP_BASE aligned on the PMD_SIZE boundary ?
>>     
>
> No, you are right, so why do we need the & PMD_MASK in the 4k case ?
>
> What I don't get is why do we need a different formula for 4k and 64k
> but I might just be stupid :-)
>   

Because we want full PTE table for PKMAP with 4K pages (it's pretty
small - only 512 pages so we really want to use all). And as current
code doesn't support PKMAP being in different PTE tables we want to
align to full PTE table not to lost part of it.

>>  These definitions seem to be related to the page table, so, as for me, 
>> then pgtable.h is the better place for them. Though, as you want; 
>> we'll move this to page_32.h.
>>     
>
> Well, I like having them next to the pte_t/pgd_t definitions since they
> relate directly to the size of those structures.
>   

Well. But pte_t/pgd_t are actually in page.h not page_32.h (along with
pmd/pud for 64bit)... So maybe we need to put definitions for
PMD_T_LOG2/PUD_T_LOG2 too...

Regards, Ilya.
