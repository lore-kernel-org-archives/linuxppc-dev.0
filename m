Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48F631A0325
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 01:45:10 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B382140BDE
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 01:45:10 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Jan 2016 00:45:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3EB193578052
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 01:45:07 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0SEiZMT48431222
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 01:44:43 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0SEiYXO027243
 for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2016 01:44:34 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/mm: Enable HugeTLB page migration
In-Reply-To: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 28 Jan 2016 20:14:15 +0530
Message-ID: <87io2dyda8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> This enables HugeTLB page migration for PPC64_BOOK3S systems which implement
> HugeTLB page at the PMD level. It enables the kernel configuration option
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION by default which turns on the function
> hugepage_migration_supported() during migration. After the recent changes
> to the PTE format, HugeTLB page migration happens successfully.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index e4824fd..65d52a0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -82,6 +82,10 @@ config GENERIC_HWEIGHT
>  config ARCH_HAS_DMA_SET_COHERENT_MASK
>          bool
>
> +config ARCH_ENABLE_HUGEPAGE_MIGRATION
> +	def_bool y
> +	depends on PPC_BOOK3S_64 && HUGETLB_PAGE && MIGRATION
> +
>  config PPC
>  	bool
>  	default y


Are you sure this is all that is needed ? We will get a FOLL_GET with hugetlb
migration and our follow_huge_addr will BUG_ON on that. Look at
e66f17ff71772b209eed39de35aaa99ba819c93d (" mm/hugetlb: take page table
lock in follow_huge_pmd()").

Again this doesn't work with 4K page size. So if you are taking this
route, we will need that restriction here.

I would suggest we switch 64K page size hugetlb to generic
hugetlb and then do hugetlb migration on top of that.

Till you help me understnd why that FOLL_GET issue is not valid for
powerpc,

NAK.

-aneesh
