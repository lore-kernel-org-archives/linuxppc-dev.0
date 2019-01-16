Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80F4C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515F520675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="unknown key hash" (0-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="h6bDEpcf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515F520675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fqMC2BtpzDqNb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:28:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="unknown key hash" (0-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="h6bDEpcf"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fpRb5gM1zDqfN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:47:23 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43fpRW16Rdz9vBL9;
 Wed, 16 Jan 2019 14:47:19 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=h6bDEpcf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id vTxn3aznp6JG; Wed, 16 Jan 2019 14:47:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43fpRV6xvbz9vBL5;
 Wed, 16 Jan 2019 14:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1547646439; bh=lH8phfL2dc2xvrucZHWB7D4b5ZzaHKfGAG4MvWdpo94=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=h6bDEpcfHoPi7+K8iDB5P2D8Msf7Cxay7+XiKbclC3/MBH8MSFbPurZAHmoagmvkW
 Ef/q/jgPKVOgfJwRlPktA6kj61l8TiftNxvgf/CRtWQBZcf2d0rDXPE2LDLtrhQ72n
 qx3IFMrMR7vXjtN8R9DD2KfjwhDzpyEy2mqQ6kN8=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DB7F8B84D;
 Wed, 16 Jan 2019 14:47:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QK8m5vIbXNH2; Wed, 16 Jan 2019 14:47:20 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4435E8B830;
 Wed, 16 Jan 2019 14:47:17 +0100 (CET)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Matthew Wilcox <willy@infradead.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065703.GE24149@dhcp22.suse.cz>
 <20190116123018.GF6310@bombadil.infradead.org>
 <07d6a264-dccd-78ab-e8a9-2410bbef7b97@arm.com>
 <20190116131827.GH6310@bombadil.infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <521d8511-4c87-49c6-de03-67a71d5bacca@c-s.fr>
Date: Wed, 16 Jan 2019 14:47:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116131827.GH6310@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, christoffer.dall@arm.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, palmer@sifive.com,
 will.deacon@arm.com, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com,
 linux-arm-kernel@lists.infradead.org, rientjes@google.com,
 dave.hansen@linux.intel.com, greentime@andestech.com, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, vbabka@suse.cz, ard.biesheuvel@linaro.org,
 linuxppc-dev@lists.ozlabs.org, steve.capper@arm.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com, akpm@linux-foundation.org,
 robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/01/2019 à 14:18, Matthew Wilcox a écrit :
> On Wed, Jan 16, 2019 at 06:42:22PM +0530, Anshuman Khandual wrote:
>> On 01/16/2019 06:00 PM, Matthew Wilcox wrote:
>>> On Wed, Jan 16, 2019 at 07:57:03AM +0100, Michal Hocko wrote:
>>>> On Wed 16-01-19 11:51:32, Anshuman Khandual wrote:
>>>>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>>>>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>>>>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>>>>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>>>>> architecture. This creates a new generic GFP flag flag which can be used
>>>>> for any page table page allocation. Does not cause any functional change.
>>>>>
>>>>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>>>>> generic page tabe header just to prevent it's potential misuse as a general
>>>>> allocation flag if included in include/linux/gfp.h.
>>>>
>>>> I haven't reviewed the patch yet but I am wondering whether this is
>>>> really worth it without going all the way down to unify the common code
>>>> and remove much more code duplication. Or is this not possible for some
>>>> reason?
>>>
>>> Exactly what I suggested doing in response to v1.
>>>
>>> Also, the approach taken here is crazy.  x86 has a feature that no other
>>> architecture has bothered to implement yet -- accounting page tables
>>> to the process.  Yet instead of spreading that goodness to all other
>>> architectures, Anshuman has gone to more effort to avoid doing that.
>>
>> The basic objective for this patch is to create a common minimum allocation
>> flag that can be used by architectures but that still allows archs to add
>> on additional constraints if they see fit. This patch does not intend to
>> change functionality for any arch.
> 
> I disagree with your objective.  Making more code common is a great idea,
> but this patch is too unambitious.  We should be heading towards one or
> two page table allocation functions instead of having every architecture do
> its own thing.
> 
> So start there.  Move the x86 function into common code and convert one
> other architecture to use it too.

Are we talking about pte_alloc_one_kernel() and pte_alloc_one() ?

I'm not sure x86 function is the best common one, as it seems to 
allocate a multiple of PAGE_SIZE only.

Some arches like powerpc use pagetables which are smaller than a page, 
for instance powerpc 8xx uses 4k pagetables even with 16k pages, which 
means a single page can be used by 4 pagetables.

Therefore, I would suggest to start with powerpc functions.

Christophe
