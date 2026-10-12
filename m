Return-Path: <linuxppc-dev+bounces-29266-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD37CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 14:30:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3KdY67KMz3bV5;
	Tue, 13 Oct 2026 01:30:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791815457;
	cv=none; b=WGDKhkTNEuTBPAHNDA0iI9AfLkJI7D3BZV8XMZ9+leP3u2pzL8DzOdEjVU4JShb1BCCL3t5fPoZqEccsqEFHpgWzFlzIfshiWqXg3JXzo+2bAvjuNfLu3IXMFEYZgQTiYCE4fD+Vo1PbsSHxPZURgTPGgcgEyEsfBc3z/XdRg11M7TTe4w1gHl8o+V8NqwyR7P8U4Zg4/Vpcj0BpJbOTTXwZegmocXLtIp4phw7a8JNve0KJF9KsfXKMeZevEtNJszcZYxLdXLWVhAiLfBMFOMUNInenJJ3jyJlQoP4K+0gCBqPkkoKlYWljHh5Eet7FH9dS0KJJBfPM4LEJ5anpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791815457; c=relaxed/relaxed;
	bh=MKq0YlVZaN6uo7U9gHQW5guRnA4CvVhwp5Xx9G/tslo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l6cLdigUt0Vm9ZzKPp95QxJo5DwxzrWzXbSZ+ldxlrpAFN1jb0HoBjkPieUYm/OjFCwFdPYPQWxt6es4rzHq+rIY6jCLQsRer0j7WQEdiwZ1EP774rWkyOhUZ+JGLlWQy0bLnUcc6Y9vtrMdSAv3ic/7NcyENFdr0EnfXntyEe6KaKEdb4p3tG+Jh6XDdX3m1VbA1ja/XTIxbf0p7BiI1heDwPwymjEhvPZo4lisbZykwINnBpurdwDuxIokp1f9J831bRqYhUUlUz9+eCZmOxxhrEVihR/aatRhGji5EmUqEy7cMg/IbwnWR7Fnc8944u7Nabaq1VFKBOPstrJBbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N30nkZhn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N30nkZhn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3KdY0fTvz3bNr
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 01:30:57 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7183B40961;
	Mon, 12 Oct 2026 14:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099FB1F0089B;
	Mon, 12 Oct 2026 14:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815455;
	bh=MKq0YlVZaN6uo7U9gHQW5guRnA4CvVhwp5Xx9G/tslo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=N30nkZhnpfbN4mIx8WKiJZKQiRFP16MssSxvaATKX0mDhkhKjIzcKKzDvSc5/oXc9
	 EUvwV/7n6vhh4B78f1V3hQsonrFuoQZdfBOtMDLu7dXB/niEi73HqT1dg8EQVhQShR
	 B/OtCod86sIO7cjPyJG2b96TFgKiJpWPKq2tGEeeoD+yy3x50+FT3xWSNN3j3kbb3y
	 rf1b212b4LIU2yx08qfhd3V6vxJ/+fSnRNeJnaRaauRVPU6tTTApi9SlrcqP9LRa5v
	 il/SASQSEIC1fp6lr4u8wrZQpzxRv6Z6uR8stnuofQqohtx7IoYHASiQ0HjgwF7nkG
	 CqBY7xfaar5tw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kexec@lists.infradead.org,  Aditya Gupta <adityag@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Mahesh Salgaonkar <mahesh@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Mike Rapoport <rppt@kernel.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v1 1/2] kho: check scratch vs CMA alignment at runtime
In-Reply-To: <20260928083226.107807-2-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Mon, 28 Sep 2026 14:02:25 +0530")
References: <20260928083226.107807-1-sourabhjain@linux.ibm.com>
	<20260928083226.107807-2-sourabhjain@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:30:50 +0200
Message-ID: <2vxzfqybj8it.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain

On Mon, Sep 28 2026, Sourabh Jain wrote:

> KHO requires the scratch alignment to be at least CMA_MIN_ALIGNMENT_BYTES,
> and this is currently enforced with a static_assert().
>
> That assertion breaks the build on powerpc once CONFIG_KEXEC_HANDOVER is
> enabled together with CONFIG_TRANSPARENT_HUGEPAGE or CONFIG_HUGETLB_PAGE:
>
>     kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>     ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>        80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>
> CMA_MIN_ALIGNMENT_BYTES depends on pageblock_order, which is not a
> compile-time constant with certain configs, such as
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE on powerpc. The next patch in this
> series enables KHO on powerpc, so the alignment must be checked at
> runtime instead.
>
> Replace the static_assert() with a runtime check at the start of
> kho_reserve_scratch(), before any scratch memory is reserved. If the
> scratch alignment is smaller than the CMA minimum alignment, warn once
> and disable KHO rather than continue with a misaligned reservation.
>
> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 7c4d86daf86d..dc76dd6b74da 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -39,15 +39,7 @@
>  #include "../kexec_internal.h"
>  #include "kexec_handover_internal.h"
>  
> -/*
> - * This is the minimal alignment required by deferred struct page init.
> - * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> - * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> - * If KHO scratch is not aligned to that value, buddy can access uninitialized
> - * struct pages, which can cause a crash.
> - */
>  #define SCRATCH_ALIGNMENT_BYTES (PAGE_SIZE * MAX_ORDER_NR_PAGES)
> -static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>  
>  /* The magic token for preserved pages */
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> @@ -836,6 +828,21 @@ static void __init kho_reserve_scratch(void)
>  	if (!kho_enable)
>  		return;
>  
> +	/*
> +	 * This is the minimal alignment required by deferred struct page init.
> +	 * deferred_init_memmap_chunk frees memory to the buddy allocator, which looks
> +	 * at the neighboring pages (up to MAX_PAGE_ORDER) to merge them.
> +	 * If KHO scratch is not aligned to that value, buddy can access uninitialized
> +	 * struct pages, which can cause a crash.
> +	 */
> +	if (WARN_ON_ONCE(SCRATCH_ALIGNMENT_BYTES < CMA_MIN_ALIGNMENT_BYTES)) {

Nit: do we need both the WARN_ON_ONCE() and the pr_err()? Can't we drop
the WARN and keep the pr_err only?

LGTM otherwise.

> +		pr_err("scratch alignment %lu < CMA minimum %lu, disabling\n",
> +		       (unsigned long)SCRATCH_ALIGNMENT_BYTES,
> +		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
> +		kho_enable = false;
> +		return;
> +	}
> +
>  	scratch_size_update();
>  
>  	/* FIXME: deal with node hot-plug/remove */

-- 
Regards,
Pratyush Yadav

