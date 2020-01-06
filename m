Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F945C32767
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 03:34:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A767A2072C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 03:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A767A2072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47rh2328D0zDqDQ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 14:34:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47rgzQ03Q6zDq9W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2020 14:31:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="PseaXQkA"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47rgzM5PMRz9sNH;
 Mon,  6 Jan 2020 14:31:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1578281504;
 bh=XeP8e7qXes4HkHyMRiVW9bZkBg9wHSfCUbqH7aV7fWI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=PseaXQkADJFYGx4SaZsY8sR8oWICr+mRYyYr5fMd+fnxepINCrjznL1PLsh6Nvlcn
 C1u/dXFf4MPhZL0D3/iqEg9lgO6lddEzi7k8X0HlcU7EhFoWF8V4KqQ1Ld2vrgfOmF
 8xJRGQoZEGXrYoUV/poOaGavJ6HBQ2pGlgOVg5ya1DWljIM/GdntvZDnnQIq1d0vrn
 hTzu3/amT42926Hf0wiuK4vD84ztJ5fo4OrAw0rbPyiT9uWXu/81Da9MUXvFi6V7H1
 lLmTIKEcYguwgRIibijKxb9zOk2IpkUFVNbaOcqwzS7oP1rsO6pmo5ALTydI/FzVoh
 lt/4slorVh1DA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] powerpc: add support for folded p4d page tables
In-Reply-To: <20200102081059.GA12063@rapoport-lnx>
References: <20191209150908.6207-1-rppt@kernel.org>
 <20200102081059.GA12063@rapoport-lnx>
Date: Mon, 06 Jan 2020 14:31:41 +1100
Message-ID: <87v9ppi7ky.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mike Rapoport <rppt@kernel.org> writes:
> Any updates on this?

It's very ... big, and kind of intrusive.

It's not an improvement as far as the powerpc code's readability is
concerned. I assume the plan is that the 5-level hack can eventually be
removed and so this conversion is a prerequisite for that?

cheers

> On Mon, Dec 09, 2019 at 05:09:08PM +0200, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>> 
>> Implement primitives necessary for the 4th level folding, add walks of p4d
>> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
>> 
>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
>>  arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
>>  arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
>>  arch/powerpc/include/asm/book3s/64/pgtable.h  | 58 ++++++++++--------
>>  arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
>>  arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
>>  arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
>>  .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
>>  arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
>>  arch/powerpc/include/asm/pgtable.h            |  8 +++
>>  arch/powerpc/kvm/book3s_64_mmu_radix.c        | 59 ++++++++++++++++---
>>  arch/powerpc/lib/code-patching.c              |  7 ++-
>>  arch/powerpc/mm/book3s32/mmu.c                |  2 +-
>>  arch/powerpc/mm/book3s32/tlb.c                |  4 +-
>>  arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
>>  arch/powerpc/mm/book3s64/radix_pgtable.c      | 19 ++++--
>>  arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
>>  arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
>>  arch/powerpc/mm/kasan/kasan_init_32.c         |  8 +--
>>  arch/powerpc/mm/mem.c                         |  4 +-
>>  arch/powerpc/mm/nohash/40x.c                  |  4 +-
>>  arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 +++--
>>  arch/powerpc/mm/pgtable.c                     | 25 +++++++-
>>  arch/powerpc/mm/pgtable_32.c                  | 28 +++++----
>>  arch/powerpc/mm/pgtable_64.c                  | 10 ++--
>>  arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
>>  arch/powerpc/mm/ptdump/ptdump.c               | 22 ++++++-
>>  arch/powerpc/xmon/xmon.c                      | 17 +++++-
>>  28 files changed, 284 insertions(+), 120 deletions(-)
