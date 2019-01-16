Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93FCC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7017020651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7017020651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fn023WKkzDqcD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 23:41:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43fmxd6hrKzDqPK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 23:39:48 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E68D80D;
 Wed, 16 Jan 2019 04:39:46 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B360B3F5AF; Wed, 16 Jan 2019 04:39:35 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-sh@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
 linux-riscv@lists.infradead.org
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <bc49c0d1-b46c-f03a-baf9-445c417fae8f@c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f71d23c6-57ee-1ceb-39a1-395a2f24a870@arm.com>
Date: Wed, 16 Jan 2019 18:09:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bc49c0d1-b46c-f03a-baf9-445c417fae8f@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: mark.rutland@arm.com, mhocko@suse.com, peterz@infradead.org,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, will.deacon@arm.com,
 aneesh.kumar@linux.ibm.com, linux@armlinux.org.uk, mingo@redhat.com,
 rientjes@google.com, palmer@sifive.com, greentime@andestech.com,
 marc.zyngier@arm.com, rppt@linux.vnet.ibm.com, shakeelb@google.com,
 kirill@shutemov.name, tglx@linutronix.de, vbabka@suse.cz,
 ard.biesheuvel@linaro.org, steve.capper@arm.com, christoffer.dall@arm.com,
 james.morse@arm.com, robin.murphy@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 01/16/2019 12:40 PM, Christophe Leroy wrote:
> 
> 
> Le 16/01/2019 à 07:21, Anshuman Khandual a écrit :
>> All architectures have been defining their own PGALLOC_GFP as (GFP_KERNEL |
>> __GFP_ZERO) and using it for allocating page table pages. This causes some
>> code duplication which can be easily avoided. GFP_KERNEL allocated and
>> cleared out pages (__GFP_ZERO) are required for page tables on any given
>> architecture. This creates a new generic GFP flag flag which can be used
>> for any page table page allocation. Does not cause any functional change.
>>
>> GFP_PGTABLE is being added into include/asm-generic/pgtable.h which is the
>> generic page tabe header just to prevent it's potential misuse as a general
>> allocation flag if included in include/linux/gfp.h.
>>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Build tested on arm, arm64, powerpc, powerpc64le and x86.
>> Boot tested on arm64 and x86.
>>
>> Changes in V2:
>>
>> - Moved GFP_PGTABLE into include/asm-generic/pgtable.h
>> - On X86 added __GFP_ACCOUNT into GFP_PGTABLE at various places
>> - Replaced possible flags on riscv and nds32 with GFP_PGTABLE
> 
> Could also replace the flags in arch/powerpc/include/asm/nohash/64/pgalloc.h with GFP_PGTABLE in pte_alloc_one_kernel() and pte_alloc_one()

Sure will do.
