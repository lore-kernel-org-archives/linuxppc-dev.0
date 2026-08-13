Return-Path: <linuxppc-dev+bounces-25784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C8BC5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 04:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLCFX6GPVz2yNj;
	Thu, 13 Aug 2026 14:34:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786595696;
	cv=none; b=GvBfux/Mz4IhnZOa0kktwCM1C6BGpFnK8MTYYEsaZr1WESlliUNGUfoR1t7Jwfg9Bs2qrl9R7p6K3nDJmKtoniF+etuEVQNifDEZKMWDqrhMcsjFYWRSd8b9DeK7y7YNq+AsbBobKoCFpyJu8nuR0y6tAC0l3/ZXi+4gKlx7qp/EfMl2XrO9r8mC9nGXQaQRiAGmHlvIdVDQAKmSb8VetPFAl4of421lEdsFS2aHPuIF9OmUGaA3QL8dgEcEPk7huT7X/78lGHvYAY8YW/1Qg0Pi7foKgVcT47l40HYrQm4EeoSOLEDdPoUVjBwP1v5tlRSMYmWMNIgWy0g5aGws0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786595696; c=relaxed/relaxed;
	bh=Kny2Ta5Q0Z/mhUSVYxPhv0RFXJl0+qly565KZ2ki+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYZn8WYYO8yFKgVyVvxNqur0z0vmVHl+IONG/8sXa/Pts0WEKBZEDU4u6t7dgqYvSYSLtUm/KelYme8dazYxoikESAPHKX9Q3dFkpJWp1aow64EaJ2JBd8SAgqsLd+8JxlwNLROSXClk712rhT49vT/XyMhpH5msZnigbT/e16fXsqAIaVj8kGezumU4ZFAmRPTg53+Z5KS1LKhcBEueXIhk4cdLSdVVvRVDUrDoSEURDWq8oTuY7Sef7cjKlro6OHulqdQfsS1LOTyd+a9ztiktBA1VL+Z94ftPtE5gP15TsLmpnMh62yvbXT49eVIJYjxFtmzdGD4EV/MZMhwa8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ucFab0TP; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ucFab0TP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLCFT4dWGz2yKD
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 14:34:51 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8A551596;
	Wed, 12 Aug 2026 21:34:14 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E593D3F632;
	Wed, 12 Aug 2026 21:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786595658; bh=mO6mrRKNqP+ykHI/mGROppdDnXxIwgWT7LgXJj+JezI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ucFab0TPnxvbqz3KEVyBy+XPNcRzGlpGCroO3Eciy3LZ0+X/OxqSrfgUvooo+EVnM
	 CkkbCWk5eaKn4RSc34lEp7tZQ4pnzvhzXI1BWphp8/e5uuWc6hv5uSnA/KhXLfZVFZ
	 sIXAXG2CvPJZ7I27QA35Hy/JfVFzGZIK3afmsQfQ=
Date: Thu, 13 Aug 2026 10:04:15 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/6] loongarch/mm: Stop using pte_ERROR()
Message-ID: <qymuy4grl654s6jwwyhlwwo6kfr3ongxpfnxifojkvism2ddwg@5lyq7iooel6b>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-2-anshuman.khandual@arm.com>
 <e0ada89f-26b2-4e82-8273-8ea7b391c147@kernel.org>
 <9a66d741-536e-44ac-b02f-395b5fc8ab6d@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a66d741-536e-44ac-b02f-395b5fc8ab6d@kernel.org>

On Wed, Aug 12, 2026 at 01:27:54PM +0200, David Hildenbrand (Arm) wrote:
> On 8/12/26 13:19, David Hildenbrand (Arm) wrote:
> > On 8/11/26 06:21, Anshuman Khandual wrote:
> >> Directly use pr_err() in __set_fixmap() and drop pte_ERROR() which helps in
> >> eventually dropping pte_ERROR() macro across the tree. In this new printing
> >> __FILE__ and __LINE__ has been dropped because they are always the same and
> >> don't really add any value.
> >>
> >> Cc: Huacai Chen <chenhuacai@kernel.org>
> >> Cc: WANG Xuerui <kernel@xen0n.name>
> >> Cc: loongarch@lists.linux.dev
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/loongarch/include/asm/pgtable.h | 2 --
> >>  arch/loongarch/mm/init.c             | 2 +-
> >>  2 files changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> >> index 223528c04d73..a32a8fff70c1 100644
> >> --- a/arch/loongarch/include/asm/pgtable.h
> >> +++ b/arch/loongarch/include/asm/pgtable.h
> >> @@ -128,8 +128,6 @@ struct vm_area_struct;
> >>  #define ptep_get(ptep) READ_ONCE(*(ptep))
> >>  #define pmdp_get(pmdp) READ_ONCE(*(pmdp))
> >>  
> >> -#define pte_ERROR(e) \
> >> -	pr_err("%s:%d: bad pte %016lx.\n", __FILE__, __LINE__, pte_val(e))
> >>  #ifndef __PAGETABLE_PMD_FOLDED
> >>  #define pmd_ERROR(e) \
> >>  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
> >> diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
> >> index 3407030f3e7a..be9b127daef2 100644
> >> --- a/arch/loongarch/mm/init.c
> >> +++ b/arch/loongarch/mm/init.c
> >> @@ -203,7 +203,7 @@ void __init __set_fixmap(enum fixed_addresses idx,
> >>  
> >>  	ptep = populate_kernel_pte(addr);
> >>  	if (!pte_none(ptep_get(ptep))) {
> >> -		pte_ERROR(*ptep);
> >> +		pr_err("bad pte %016lx\n", pte_val(*ptep));
> >>  		return;
> >>  	}
> >>  
> > 
> > Ah, I missed that we want to print actual values, I somehow thought that we
> > would be printing pte_none() ...
> > 
> > Maybe we should just be more verbose while at it?

Initially thought that these new prints should be right close to the
original via pxd_ERROR() but I guess making them verbose while doing
the replacements should be indeed acceptable.

> > 
> > pr_err("unexpected set PTE at %ul in __set_fixmap: %016lx\n",
> >        addr, pte_val(*ptep));
> > 
> 
> On second thought, why not simply use ptval_to_str() here as well?

Sure will do the required changes - the following builds successfully.

--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -197,13 +197,15 @@ void __init __set_fixmap(enum fixed_addresses idx,
                               phys_addr_t phys, pgprot_t flags)
 {
        unsigned long addr = __fix_to_virt(idx);
+       char str[PTVAL_STR_MAX];
        pte_t *ptep;

        BUG_ON(idx <= FIX_HOLE || idx >= __end_of_fixed_addresses);

        ptep = populate_kernel_pte(addr);
        if (!pte_none(ptep_get(ptep))) {
-               pr_err("bad pte %016lx\n", pte_val(*ptep));
+               ptval_to_str(str, pte_val(*ptep));
+               pr_err("unexpected set PTE at %lx in __set_fixmap: %s\n", addr, str);
                return;
        }

> 
> -- 
> Cheers,
> 
> David

