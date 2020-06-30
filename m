Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA42BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 03:55:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363C2206BE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 03:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363C2206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49wrB02kBwzDqd3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 13:55:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 49wr7t2PvczDqcn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 13:54:00 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2739030E;
 Mon, 29 Jun 2020 20:53:58 -0700 (PDT)
Received: from [10.163.84.101] (unknown [10.163.84.101])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EE3D3F73C;
 Mon, 29 Jun 2020 20:53:47 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] mm/debug_vm_pgtable: Add some more tests
To: linux-mm@kvack.org
References: <1592192277-8421-1-git-send-email-anshuman.khandual@arm.com>
 <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1ed72a76-9f20-0169-4c16-c1d8808690eb@arm.com>
Date: Tue, 30 Jun 2020 09:23:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <70ddc7dd-b688-b73e-642a-6363178c8cdd@arm.com>
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
Cc: linux-doc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org, ziy@nvidia.com,
 Catalin Marinas <catalin.marinas@arm.com>, linux-snps-arc@lists.infradead.org,
 Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>,
 Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, gerald.schaefer@de.ibm.com,
 christophe.leroy@c-s.fr, Vineet Gupta <vgupta@synopsys.com>,
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 06/24/2020 08:43 AM, Anshuman Khandual wrote:
> 
> 
> On 06/15/2020 09:07 AM, Anshuman Khandual wrote:
>> This series adds some more arch page table helper validation tests which
>> are related to core and advanced memory functions. This also creates a
>> documentation, enlisting expected semantics for all page table helpers as
>> suggested by Mike Rapoport previously (https://lkml.org/lkml/2020/1/30/40).
>>
>> There are many TRANSPARENT_HUGEPAGE and ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD
>> ifdefs scattered across the test. But consolidating all the fallback stubs
>> is not very straight forward because ARCH_HAS_TRANSPARENT_HUGEPAGE_PUD is
>> not explicitly dependent on ARCH_HAS_TRANSPARENT_HUGEPAGE.
>>
>> Tested on arm64, x86 platforms but only build tested on all other enabled
>> platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The
>> following failure on arm64 still exists which was mentioned previously. It
>> will be fixed with the upcoming THP migration on arm64 enablement series.
>>
>> WARNING .... mm/debug_vm_pgtable.c:860 debug_vm_pgtable+0x940/0xa54
>> WARN_ON(!pmd_present(pmd_mkinvalid(pmd_mkhuge(pmd))))
>>
>> This series is based on v5.8-rc1.
>>
>> Changes in V3:
>>
>> - Replaced HAVE_ARCH_SOFT_DIRTY with MEM_SOFT_DIRTY
>> - Added HAVE_ARCH_HUGE_VMAP checks in pxx_huge_tests() per Gerald
>> - Updated documentation for pmd_thp_tests() per Zi Yan
>> - Replaced READ_ONCE() with huge_ptep_get() per Gerald
>> - Added pte_mkhuge() and masking with PMD_MASK per Gerald
>> - Replaced pte_same() with holding pfn check in pxx_swap_tests()
>> - Added documentation for all (#ifdef #else #endif) per Gerald
>> - Updated pmd_protnone_tests() per Gerald
>> - Updated HugeTLB PTE creation in hugetlb_advanced_tests() per Gerald
>> - Replaced [pmd|pud]_mknotpresent() with [pmd|pud]_mkinvalid()
>> - Added has_transparent_hugepage() check for PMD and PUD tests
>> - Added a patch which debug prints all individual tests being executed
>> - Updated documentation for renamed [pmd|pud]_mkinvalid() helpers
> 
> Hello Gerald/Christophe/Vineet,
> 
> It would be really great if you could give this series a quick test
> on s390/ppc/arc platforms respectively. Thank you.

Thanks Alexander, Gerald and Christophe for testing this out on s390
and ppc32 platforms. Probably Vineet and Qian (any other volunteers)
could help us with arc and ppc64 platforms, which I would appreciate.
