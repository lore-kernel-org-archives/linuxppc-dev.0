Return-Path: <SRS0=0JSR=4Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3F7C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2020 00:58:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245E2206D7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2020 00:58:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245E2206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Z5hL53FxzF0QW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Mar 2020 11:58:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=anshuman.khandual@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 48Z5fX1tt3zDr7W
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2020 11:56:50 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7192C30E;
 Fri,  6 Mar 2020 16:56:49 -0800 (PST)
Received: from [10.163.1.59] (unknown [10.163.1.59])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25853F237;
 Fri,  6 Mar 2020 16:56:41 -0800 (PST)
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
To: Qian Cai <cai@lca.pw>
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
 <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
Date: Sat, 7 Mar 2020 06:26:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
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
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-snps-arc@lists.infradead.org,
 Vasily Gorbik <gor@linux.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/07/2020 06:04 AM, Qian Cai wrote:
> 
> 
>> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> Hmm, set_pte_at() function is not preferred here for these tests. The idea
>> is to avoid or atleast minimize TLB/cache flushes triggered from these sort
>> of 'static' tests. set_pte_at() is platform provided and could/might trigger
>> these flushes or some other platform specific synchronization stuff. Just
> 
> Why is that important for this debugging option?

Primarily reason is to avoid TLB/cache flush instructions on the system
during these tests that only involve transforming different page table
level entries through helpers. Unless really necessary, why should it
emit any TLB/cache flush instructions ?

> 
>> wondering is there specific reason with respect to the soft lock up problem
>> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?
> 
> Looks at the s390 version of set_pte_at(), it has this comment,
> vmaddr);
> 
> /*
>  * Certain architectures need to do special things when PTEs
>  * within a page table are directly modified.  Thus, the following
>  * hook is made available.
>  */
> 
> I can only guess that powerpc  could be the same here.

This comment is present in multiple platforms while defining set_pte_at().
Is not 'barrier()' here alone good enough ? Else what exactly set_pte_at()
does as compared to WRITE_ONCE() that avoids the soft lock up, just trying
to understand.
