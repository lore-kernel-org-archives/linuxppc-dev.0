Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CFCC10F12
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 08:53:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7611E2073F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 08:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7611E2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kbcJ1f0RzDqMW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 18:53:20 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kbZY5nDZzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 18:51:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44kbZX3ThVz9s7T; Wed, 17 Apr 2019 18:51:48 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44kbZW65TJz9s71;
 Wed, 17 Apr 2019 18:51:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/mm/radix: Make Radix require HUGETLB_PAGE
In-Reply-To: <20190417074140.25130-1-mpe@ellerman.id.au>
References: <20190417074140.25130-1-mpe@ellerman.id.au>
Date: Wed, 17 Apr 2019 18:51:46 +1000
Message-ID: <87bm15ui8t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: stewart@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Joel reported weird crashes using skiroot_defconfig, in his case we
> jumped into an NX page:
>
>   kernel tried to execute exec-protected page (c000000002bff4f0) - exploit attempt? (uid: 0)
>   BUG: Unable to handle kernel instruction fetch
>   Faulting instruction address: 0xc000000002bff4f0
>
> Looking at the disassembly, we had simply branched to that address:
>
>   c000000000c001bc  49fff335    bl     c000000002bff4f0
>
> But that didn't match the original kernel image:
>
>   c000000000c001bc  4bfff335    bl     c000000000bff4f0 <kobject_get+0x8>
>
> When STRICT_KERNEL_RWX is enabled, and we're using the radix MMU, we
> call radix__change_memory_range() late in boot to change page
> protections. We do that both to mark rodata read only and also to mark
> init text no-execute. That involves walking the kernel page tables,
> and clearing _PAGE_WRITE or _PAGE_EXEC respectively.
>
> With radix we may use hugepages for the linear mapping, so the code in
> radix__change_memory_range() uses eg. pmd_huge() to test if it has
> found a huge mapping, and if so it stops the page table walk and
> changes the PMD permissions.
>
> However if the kernel is built without HUGETLBFS support, pmd_huge()
> is just a #define that always returns 0. That causes the code in
> radix__change_memory_range() to incorrectly interpret the PMD value as
> a pointer to a PTE page rather than as a PTE at the PMD level.
>
> Unfortunately the combination of _PAGE_PTE and _PAGE_PRESENT in the
> high bits of the PMD entry give us 0xc in the top nibble which means
> the PMD entry happens to look like a valid pointer into the linear
> mapping.

Aneesh points out this paragraph is confusing. Those bits only make the
pointer *look* valid, it doesn't actually make any difference to the
code, as we mask and re-add those bits anyway.

I'll drop this paragraph when committing.

cheers
