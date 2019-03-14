Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B48C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2073C217F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 11:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2073C217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KnKh0NckzDq61
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 22:58:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=ghiti.fr
 (client-ip=217.70.178.242; helo=mslow2.mail.gandi.net;
 envelope-from=alex@ghiti.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ghiti.fr
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KnDc4kTqzDq61
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 22:54:07 +1100 (AEDT)
Received: from relay11.mail.gandi.net (unknown [217.70.178.231])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 250C63A2674
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 11:44:33 +0000 (UTC)
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr
 [81.250.144.103]) (Authenticated sender: alex@ghiti.fr)
 by relay11.mail.gandi.net (Postfix) with ESMTPSA id A44A6100009;
 Thu, 14 Mar 2019 11:43:51 +0000 (UTC)
Subject: Re: [PATCH v6 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 "David S . Miller" <davem@davemloft.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org
References: <20190307132015.26970-1-alex@ghiti.fr>
 <20190307132015.26970-5-alex@ghiti.fr> <87va0movdh.fsf@linux.ibm.com>
From: Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <e39f5b5b-efa1-c7b1-c1d8-89155b926027@ghiti.fr>
Date: Thu, 14 Mar 2019 12:43:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <87va0movdh.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 03/14/2019 06:52 AM, Aneesh Kumar K.V wrote:
> Alexandre Ghiti <alex@ghiti.fr> writes:
>
>> On systems without CONTIG_ALLOC activated but that support gigantic pages,
>> boottime reserved gigantic pages can not be freed at all. This patch
>> simply enables the possibility to hand back those pages to memory
>> allocator.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> Acked-by: David S. Miller <davem@davemloft.net> [sparc]
>> ---
>>   arch/arm64/Kconfig                           |  2 +-
>>   arch/arm64/include/asm/hugetlb.h             |  4 --
>>   arch/powerpc/include/asm/book3s/64/hugetlb.h |  7 ---
>>   arch/powerpc/platforms/Kconfig.cputype       |  2 +-
>>   arch/s390/Kconfig                            |  2 +-
>>   arch/s390/include/asm/hugetlb.h              |  3 --
>>   arch/sh/Kconfig                              |  2 +-
>>   arch/sparc/Kconfig                           |  2 +-
>>   arch/x86/Kconfig                             |  2 +-
>>   arch/x86/include/asm/hugetlb.h               |  4 --
>>   include/linux/gfp.h                          |  2 +-
>>   mm/hugetlb.c                                 | 57 ++++++++++++--------
>>   mm/page_alloc.c                              |  4 +-
>>   13 files changed, 44 insertions(+), 49 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 091a513b93e9..af687eff884a 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -18,7 +18,7 @@ config ARM64
>>   	select ARCH_HAS_FAST_MULTIPLIER
>>   	select ARCH_HAS_FORTIFY_SOURCE
>>   	select ARCH_HAS_GCOV_PROFILE_ALL
>> -	select ARCH_HAS_GIGANTIC_PAGE if CONTIG_ALLOC
>> +	select ARCH_HAS_GIGANTIC_PAGE
>>   	select ARCH_HAS_KCOV
>>   	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>   	select ARCH_HAS_PTE_SPECIAL
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index fb6609875455..59893e766824 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
>> @@ -65,8 +65,4 @@ extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>   
>>   #include <asm-generic/hugetlb.h>
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void) { return true; }
>> -#endif
>> -
>>   #endif /* __ASM_HUGETLB_H */
>> diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> index 5b0177733994..d04a0bcc2f1c 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
>> @@ -32,13 +32,6 @@ static inline int hstate_get_psize(struct hstate *hstate)
>>   	}
>>   }
>>   
>> -#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -static inline bool gigantic_page_supported(void)
>> -{
>> -	return true;
>> -}
>> -#endif
>> -
>>   /* hugepd entry valid bit */
>>   #define HUGEPD_VAL_BITS		(0x8000000000000000UL)
>>   
> As explained in https://patchwork.ozlabs.org/patch/1047003/
> architectures like ppc64 have a hypervisor assisted mechanism to indicate
> where to find gigantic huge pages(16G pages). At this point, we don't use this
> reserved pages for anything other than hugetlb backing and hence there
> is no runtime free of this pages needed ( Also we don't do
> runtime allocation of them).
>
> I guess you can still achieve what you want to do in this patch by
> keeping gigantic_page_supported()?
>
> NOTE: We should rename gigantic_page_supported to be more specific to
> support for runtime_alloc/free of gigantic pages
>
> -aneesh
>
Thanks for noticing Aneesh.

I can't find a better solution than bringing back 
gigantic_page_supported check,
since it is must be done at runtime in your case.
I'm not sure of one thing though: you say that freeing boottime gigantic 
pages
is not needed, but is it forbidden ? Just to know where the check and 
what its
new name should be.
Is something like that (on top of this series) ok for you (and everyone 
else) before
I send a v7:

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h 
b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index d04a0bc..d121559 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -35,4 +35,20 @@ static inline int hstate_get_psize(struct hstate *hstate)
  /* hugepd entry valid bit */
  #define HUGEPD_VAL_BITS                (0x8000000000000000UL)

+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+#define __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED
+static inline bool gigantic_page_supported(void)
+{
+       /*
+        * We used gigantic page reservation with hypervisor assist in 
some case.
+        * We cannot use runtime allocation of gigantic pages in those 
platforms
+        * This is hash translation mode LPARs.
+        */
+       if (firmware_has_feature(FW_FEATURE_LPAR) && !radix_enabled())
+               return false;
+
+       return true;
+}
+#endif
+
  #endif
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 71d7b77..7d12e73 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -126,4 +126,18 @@ static inline pte_t huge_ptep_get(pte_t *ptep)
  }
  #endif

+#ifndef __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED
+#ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
+static inline bool gigantic_page_supported(void)
+{
+        return true;
+}
+#else
+static inline bool gigantic_page_supported(void)
+{
+        return false;
+}
+#endif /* CONFIG_ARCH_HAS_GIGANTIC_PAGE */
+#endif /* __HAVE_ARCH_GIGANTIC_PAGE_SUPPORTED */
+
  #endif /* _ASM_GENERIC_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9fc96ef..cfbbafe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2425,6 +2425,11 @@ static ssize_t __nr_hugepages_store_common(bool 
obey_mempolicy,
         int err;
         NODEMASK_ALLOC(nodemask_t, nodes_allowed, GFP_KERNEL | 
__GFP_NORETRY);

+       if (hstate_is_gigantic(h) && !gigantic_page_supported()) {
+               err = -EINVAL;
+               goto out;
+       }
+
         if (nid == NUMA_NO_NODE) {
                 /*
                  * global hstate attribute
@@ -2446,6 +2451,7 @@ static ssize_t __nr_hugepages_store_common(bool 
obey_mempolicy,

         err = set_max_huge_pages(h, count, nodes_allowed);

+out:
         if (nodes_allowed != &node_states[N_MEMORY])
                 NODEMASK_FREE(nodes_allowed);









