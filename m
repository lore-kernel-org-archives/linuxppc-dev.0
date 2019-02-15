Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FAEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 04:00:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E08E021A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 04:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08E021A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440zzz5nrTzDqcg
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 14:59:59 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440zyD2NvhzDqc5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 14:58:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 440zyC4WM0z9sPT;
 Fri, 15 Feb 2019 14:58:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Corallo <kernel@bluematt.me>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [Bug 202149] New: NULL Pointer Dereference in __split_huge_pmd on
 PPC64LE
In-Reply-To: <CCDBD6B9-31CD-4B94-AA8F-9BEF1C133AED@bluematt.me>
References: <bug-202149-27@https.bugzilla.kernel.org/>
 <20190104170459.c8c7fa57ba9bc8a69dee5666@linux-foundation.org>
 <87ef9nk4cj.fsf@linux.ibm.com>
 <ed4bea40-cf9e-89a1-f99a-3dbd6249847f@bluematt.me>
 <8736q2jbhr.fsf@linux.ibm.com>
 <A61367CF-277E-4E74-8A9D-C94C5E53817B@bluematt.me>
 <87bm4achnu.fsf@linux.ibm.com>
 <CCDBD6B9-31CD-4B94-AA8F-9BEF1C133AED@bluematt.me>
Date: Fri, 15 Feb 2019 14:58:25 +1100
Message-ID: <87va1ld7oe.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 bugzilla-daemon@bugzilla.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Matt Corallo <kernel@bluematt.me> writes:
> Hey, sorry for the delay on this. I had some apparently-unrelated
> hangs that I believe were due to mpt3sas instability, and at the risk
> of speaking too soon for a bug I couldn't reliably reproduce, this
> patch appears to have resolved it, thanks!

Thanks.

For the archives it went upstream in a slightly different form as:

  579b9239c1f3 ("powerpc/radix: Fix kernel crash with mremap()")

  https://git.kernel.org/torvalds/c/579b9239c1f3


cheers

>> On Jan 21, 2019, at 07:35, Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> wrote:
>> 
>> 
>> Can you test this patch?
>> 
>> From e511e79af9a314854848ea8fda9dfa6d7e07c5e4 Mon Sep 17 00:00:00 2001
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
>> Date: Mon, 21 Jan 2019 16:43:17 +0530
>> Subject: [PATCH] arch/powerpc/radix: Fix kernel crash with mremap
>> 
>> With support for split pmd lock, we use pmd page pmd_huge_pte pointer to store
>> the deposited page table. In those config when we move page tables we need to
>> make sure we move the depoisted page table to the right pmd page. Otherwise this
>> can result in crash when we withdraw of deposited page table because we can find
>> the pmd_huge_pte NULL.
>> 
>> c0000000004a1230 __split_huge_pmd+0x1070/0x1940
>> c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
>> c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
>> c00000000042fe04 __vma_adjust+0x2b4/0x9b0
>> c0000000004316e8 __split_vma+0x1b8/0x280
>> c00000000043192c __do_munmap+0x13c/0x550
>> c000000000439390 sys_mremap+0x220/0x7e0
>> c00000000000b488 system_call+0x5c/0x70
>> 
>> Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>> arch/powerpc/include/asm/book3s/64/pgtable.h | 2 --
>> 1 file changed, 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index 92eaea164700..86e62384256d 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -1262,8 +1262,6 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>>                     struct spinlock *old_pmd_ptl,
>>                     struct vm_area_struct *vma)
>> {
>> -    if (radix_enabled())
>> -        return false;
>>    /*
>>     * Archs like ppc64 use pgtable to store per pmd
>>     * specific information. So when we switch the pmd,
>> -- 
>> 2.20.1
>> 
