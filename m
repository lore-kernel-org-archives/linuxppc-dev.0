Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF62C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:56:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B401C20675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B401C20675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fnJr3MgpzDqQT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 23:56:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43fnFv4S9lzDqQT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 23:53:54 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D548780D;
 Wed, 16 Jan 2019 04:53:52 -0800 (PST)
Received: from [10.162.42.129] (p8cg001049571a15.blr.arm.com [10.162.42.129])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 DD8B93F5AF; Wed, 16 Jan 2019 04:53:42 -0800 (PST)
Subject: Re: [PATCH V2] mm: Introduce GFP_PGTABLE
To: Mike Rapoport <rppt@linux.ibm.com>
References: <1547619692-7946-1-git-send-email-anshuman.khandual@arm.com>
 <20190116065521.GC6643@rapoport-lnx>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <ddac2cef-43af-cda3-fe03-3fc070084731@arm.com>
Date: Wed, 16 Jan 2019 18:23:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190116065521.GC6643@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: mark.rutland@arm.com, mhocko@suse.com, linux-sh@vger.kernel.org,
 peterz@infradead.org, catalin.marinas@arm.com, dave.hansen@linux.intel.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
 linux@armlinux.org.uk, mingo@redhat.com, vbabka@suse.cz, rientjes@google.com,
 palmer@sifive.com, greentime@andestech.com, marc.zyngier@arm.com,
 rppt@linux.vnet.ibm.com, shakeelb@google.com, kirill@shutemov.name,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 ard.biesheuvel@linaro.org, robin.murphy@arm.com, steve.capper@arm.com,
 christoffer.dall@arm.com, james.morse@arm.com, aneesh.kumar@linux.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 01/16/2019 12:25 PM, Mike Rapoport wrote:
> On Wed, Jan 16, 2019 at 11:51:32AM +0530, Anshuman Khandual wrote:
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
>>
>> Original V1: https://lkml.org/lkml/2019/1/12/54 
>>
>>  arch/arm/include/asm/pgalloc.h               |  8 +++-----
>>  arch/arm/mm/mmu.c                            |  2 +-
>>  arch/arm64/include/asm/pgalloc.h             |  9 ++++-----
>>  arch/arm64/mm/mmu.c                          |  2 +-
>>  arch/arm64/mm/pgd.c                          |  4 ++--
>>  arch/nds32/include/asm/pgalloc.h             |  3 +--
>>  arch/powerpc/include/asm/book3s/64/pgalloc.h |  6 +++---
>>  arch/powerpc/include/asm/pgalloc.h           |  2 --
>>  arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +-
>>  arch/powerpc/mm/pgtable-frag.c               |  4 ++--
>>  arch/riscv/include/asm/pgalloc.h             |  8 +++-----
>>  arch/sh/mm/pgtable.c                         |  6 ++----
>>  arch/unicore32/include/asm/pgalloc.h         |  6 ++----
>>  arch/x86/kernel/espfix_64.c                  |  6 ++----
>>  arch/x86/mm/pgtable.c                        | 15 +++++++--------
>>  include/asm-generic/pgtable.h                |  2 ++
>>  virt/kvm/arm/mmu.c                           |  2 +-
>>  17 files changed, 37 insertions(+), 50 deletions(-)
> I wonder, what about the other arches? Do they use different GFP flags?
>  

Some of them as listed below use (GFP_KERNEL | __GFP_ZERO) which I will fix
next time around. Some how was focused on removing PGALLOC_GFP that missed
the other ones.

arch/powerpc/include/asm/nohash/64/pgalloc.h
arch/alpha/include/asm/pgalloc.h
arch/alpha/mm/init.c
arch/csky/include/asm/pgalloc.h
arch/arc/include/asm/pgalloc.h
........
........

But then there are those which use GFP_KERNEL alone without __GFP_ZERO like
pmd_alloc_one() in arch/sparc/include/asm/pgalloc_64.h cannot be replaced
with this patch as it does not intend to change functionality.
