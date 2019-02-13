Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F250C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62E92073D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 11:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62E92073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zy3Z4xHGzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 22:29:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=vbabka@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zy1T3fW8zDqPg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 22:27:34 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2EF02ABAC;
 Wed, 13 Feb 2019 11:27:31 +0000 (UTC)
Subject: Re: [PATCH] hugetlb: allow to free gigantic pages regardless of the
 configuration
To: Alexandre Ghiti <aghiti@upmem.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190117183953.5990-1-aghiti@upmem.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <16a6209c-868b-8fd5-a70a-6e0e1ecb62d4@suse.cz>
Date: Wed, 13 Feb 2019 12:27:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190117183953.5990-1-aghiti@upmem.com>
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
Cc: hch@infradead.org, linux-riscv@lists.infradead.org,
 Alexandre Ghiti <alex@ghiti.fr>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/17/19 7:39 PM, Alexandre Ghiti wrote:
> From: Alexandre Ghiti <alex@ghiti.fr>
> 
> On systems without CMA or (MEMORY_ISOLATION && COMPACTION) activated but
> that support gigantic pages, boottime reserved gigantic pages can not be
> freed at all. This patchs simply enables the possibility to hand back
> those pages to memory allocator.
> 
> This commit then renames gigantic_page_supported and
> ARCH_HAS_GIGANTIC_PAGE to make them more accurate. Indeed, those values
> being false does not mean that the system cannot use gigantic pages: it
> just means that runtime allocation of gigantic pages is not supported,
> one can still allocate boottime gigantic pages if the architecture supports
> it.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

I'm fine with the change, but wonder if this can be structured better in a way
which would remove the duplicated "if (MEMORY_ISOLATION && COMPACTION) || CMA"
from all arches, as well as the duplicated
gigantic_page_runtime_allocation_supported()

something like:

- "select ARCH_HAS_GIGANTIC_PAGE" has no conditions, it just says the arch can
support them either at boottime or runtime (but runtime is usable only if other
conditions are met)
- gigantic_page_runtime_allocation_supported() is a function that returns true
if ARCH_HAS_GIGANTIC_PAGE && ((MEMORY_ISOLATION && COMPACTION) || CMA) and
there's a single instance, not per-arch.
- code for freeing gigantic pages can probably still be conditional on
ARCH_HAS_GIGANTIC_PAGE

BTW I wanted also to do something about the "(MEMORY_ISOLATION && COMPACTION) ||
CMA" ugliness itself, i.e. put the common parts behind some new kconfig
(COMPACTION_CORE ?) and expose it better to users, but I can take a stab on that
once the above part is settled.

Vlastimil
