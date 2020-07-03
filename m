Return-Path: <SRS0=ZYlp=AO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B8C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 10:43:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A9620723
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 10:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="R6OndPXL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A9620723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ys4q28xCzDrGn
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2020 20:43:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49ys2V6lc3zDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2020 20:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=R6OndPXL; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49ys2R4MTvz9sQt;
 Fri,  3 Jul 2020 20:41:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1593772881;
 bh=ouQdbcbhXEsmtXFYa0vga5m4RkRqU+lSip6svPkAoWE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=R6OndPXLKtiDiQ1Yg6qZjpgHLC6/QS2AlJZYtOzMgFSeYNh6Sx3B0ltJCzh7sjte5
 WiiVS0RAL5X390ALRNp7CDkU1RVQeSH9Wca2ibJ08WXyPDBnyYO+Gxoy56H8T0H24A
 F6WMbq5RKm4waWWNoG6ZJkS8Z04QD4Qfen0kPPO+o9GKjqMlrQM4oL+Hip9uWVFMld
 UPez+VVedhg6+MIFlsUQ+LqzA6fjTMk4Lbg8v+KsyVDGxyvtiP2F5mRej5ntf0lZ9k
 3JqKlIL/mXbyppKeQNjGxRorukCOGXpRzvqKB7CGr+jE5Hsx4Z3fp9XtqzVesL+Bm3
 JD0xFqCJG+Szw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 (RESEND) 2/3] mm/sparsemem: Enable vmem_altmap support
 in vmemmap_alloc_block_buf()
In-Reply-To: <20200702140752.GF22241@gaia>
References: <1592442930-9380-1-git-send-email-anshuman.khandual@arm.com>
 <1592442930-9380-3-git-send-email-anshuman.khandual@arm.com>
 <20200702140752.GF22241@gaia>
Date: Fri, 03 Jul 2020 20:43:33 +1000
Message-ID: <87blkw7uay.fsf@mpe.ellerman.id.au>
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
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Catalin Marinas <catalin.marinas@arm.com> writes:
> On Thu, Jun 18, 2020 at 06:45:29AM +0530, Anshuman Khandual wrote:
>> There are many instances where vmemap allocation is often switched between
>> regular memory and device memory just based on whether altmap is available
>> or not. vmemmap_alloc_block_buf() is used in various platforms to allocate
>> vmemmap mappings. Lets also enable it to handle altmap based device memory
>> allocation along with existing regular memory allocations. This will help
>> in avoiding the altmap based allocation switch in many places.
>> 
>> While here also implement a regular memory allocation fallback mechanism
>> when the first preferred device memory allocation fails. This will ensure
>> preserving the existing semantics on powerpc platform. To summarize there
>> are three different methods to call vmemmap_alloc_block_buf().
>> 
>> (., NULL,   false) /* Allocate from system RAM */
>> (., altmap, false) /* Allocate from altmap without any fallback */
>> (., altmap, true)  /* Allocate from altmap with fallback (system RAM) */
> [...]
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index bc73abf0bc25..01e25b56eccb 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -225,12 +225,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>  		 * fall back to system memory if the altmap allocation fail.
>>  		 */
>>  		if (altmap && !altmap_cross_boundary(altmap, start, page_size)) {
>> -			p = altmap_alloc_block_buf(page_size, altmap);
>> -			if (!p)
>> -				pr_debug("altmap block allocation failed, falling back to system memory");
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    altmap, true);
>> +		} else {
>> +			p = vmemmap_alloc_block_buf(page_size, node,
>> +						    NULL, false);
>>  		}
>> -		if (!p)
>> -			p = vmemmap_alloc_block_buf(page_size, node);
>>  		if (!p)
>>  			return -ENOMEM;
>
> Is the fallback argument actually necessary. It may be cleaner to just
> leave the code as is with the choice between altmap and NULL. If an arch
> needs a fallback (only powerpc), they have the fallback in place
> already. I don't see the powerpc code any better after this change.

Yeah I agree.

cheers
