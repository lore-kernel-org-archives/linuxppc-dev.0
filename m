Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D9C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:26:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB7482086C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7482086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444C0b5GYTzDqDF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:26:39 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Bwl1ctbzDqDm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 444Bwk55nmz9s7h; Wed, 20 Feb 2019 20:23:18 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444Bwk3Hz5z9s70;
 Wed, 20 Feb 2019 20:23:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, Christophe Leroy <christophe.leroy@c-s.fr>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Make PPC_64K_PAGES depend on only 44x or
 PPC_BOOK3S_64
In-Reply-To: <5e552f3d0c69890d5beb88475c8f9ba7a76bf64b.camel@buserror.net>
References: <20190208123416.1051-1-mpe@ellerman.id.au>
 <2fc1837d-af23-751c-d9af-0d0888b26ab4@c-s.fr>
 <87h8czc1by.fsf@concordia.ellerman.id.au>
 <5e552f3d0c69890d5beb88475c8f9ba7a76bf64b.camel@buserror.net>
Date: Wed, 20 Feb 2019 20:23:18 +1100
Message-ID: <87y36a7r09.fsf@concordia.ellerman.id.au>
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
Cc: aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Scott Wood <oss@buserror.net> writes:
> On Wed, 2019-02-20 at 01:14 +1100, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>> > On 02/08/2019 12:34 PM, Michael Ellerman wrote:
>> > > In commit 7820856a4fcd ("powerpc/mm/book3e/64: Remove unsupported
>> > > 64Kpage size from 64bit booke") we dropped the 64K page size support
>> > > from the 64-bit nohash (Book3E) code.
>> > > 
>> > > But we didn't update the dependencies of the PPC_64K_PAGES option,
>> > > meaning a randconfig can still trigger this code and cause a build
>> > > breakage, eg:
>> > >    arch/powerpc/include/asm/nohash/64/pgtable.h:14:2: error: #error
>> > > "Page size not supported"
>> > >    arch/powerpc/include/asm/nohash/mmu-book3e.h:275:2: error: #error
>> > > Unsupported page size
>> > > 
>> > > So remove PPC_BOOK3E_64 from the dependencies. This also means we
>> > > don't need to worry about PPC_FSL_BOOK3E, because that was just trying
>> > > to prevent the PPC_BOOK3E_64=y && PPC_FSL_BOOK3E=y case.
>> > 
>> > Does it means some cleanup could be done, for instance:
>> > 
>> > arch/powerpc/include/asm/nohash/64/pgalloc.h:#ifndef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/include/asm/nohash/64/pgalloc.h:#endif /* 
>> > CONFIG_PPC_64K_PAGES */
>> > arch/powerpc/include/asm/nohash/64/pgtable.h:#ifdef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/include/asm/nohash/64/slice.h:#ifdef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/include/asm/nohash/64/slice.h:#else /* CONFIG_PPC_64K_PAGES
>> > */
>> > arch/powerpc/include/asm/nohash/64/slice.h:#endif /* 
>> > !CONFIG_PPC_64K_PAGES */
>> > arch/powerpc/include/asm/nohash/pte-book3e.h:#ifdef CONFIG_PPC_64K_PAGES
>> > 
>> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
>> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
>> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#endif /* CONFIG_PPC_64K_PAGES */
>> > arch/powerpc/mm/tlb_low_64e.S:#ifndef CONFIG_PPC_64K_PAGES
>> > arch/powerpc/mm/tlb_low_64e.S:#ifdef CONFIG_PPC_64K_PAGES
>> 
>> Probably.
>> 
>> Some of the FSL chips do support 64K pages at least according to some
>> datasheets. I don't know what would be required to get it working, or if
>> it even works in practice.
>> 
>> So it would be nice to get 64K working on those chips, but probably no
>> one has time or motivation to do it. In which case yeah all that code
>> should be removed.
>
> The primary TLB (TLB0) on these chips only supports 4K pages.  TLB1 supports
> many different sizes but is much smaller, hardware tablewalk only loads into
> TLB0, etc.

Aha thanks. I wondered if there was some reason for it.

So that makes it sound much less interesting, meaning all that 64K page
code should go.

cheers
