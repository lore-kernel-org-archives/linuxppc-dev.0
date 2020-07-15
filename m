Return-Path: <SRS0=XJaO=A2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F0C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:57:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC5C206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 03:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qxx8+YhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC5C206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B63WR6BCmzDqfs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2020 13:57:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B63Rk5P8DzDqQS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2020 13:54:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=qxx8+YhV; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4B63Rj1pl9z9sRK;
 Wed, 15 Jul 2020 13:54:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1594785282;
 bh=MIi6RwKszLbhlnij4bd7Rn0o2tKvQExnOupg3X0TUWk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=qxx8+YhVP7/J+7Gyyj12czQdZNim5ZtAPbniTDX67VdB2/0ueMc0QF8AkQS9Mmi07
 iEM+2AxYU32SIlRhkTlla76eeXXAJpRnasF8pwEdpgoGsjsk73qpgmgKhepIqspSPW
 sjrk8geX3LoIDI+fGwB4yg2lx8jq1OR48vca8PX5W4OJd/SWoCBOVtLvPALSaMOIsU
 91hgfnEdhY9IQ+uI4eEznGlRJkk3XkxF3/k3V1NU9rpfJ4pZUtBv3WXoRqBoh/SLtv
 +8IkPM3Ub2brasTlPAsoXRzkcNo3lV9HBuKb696ng5mNh8xm7GCdGarGarezOLbMds
 84OIDw67vqt1A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: YueHaibing <yuehaibing@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, haren@linux.ibm.com, dave.hansen@linux.intel.com,
 npiggin@gmail.com
Subject: Re: [PATCH] powerpc: Fix inconsistent function names
In-Reply-To: <20200715031939.31968-1-yuehaibing@huawei.com>
References: <20200715031939.31968-1-yuehaibing@huawei.com>
Date: Wed, 15 Jul 2020 13:54:39 +1000
Message-ID: <875zapv3eo.fsf@mpe.ellerman.id.au>
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
Cc: YueHaibing <yuehaibing@huawei.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YueHaibing <yuehaibing@huawei.com> writes:

> The stub helpers name should be consistent with prototypes.
>
> mm_context_add_vas_windows() --> mm_context_add_vas_window()
> mm_context_remove_vas_windows() --> mm_context_remove_vas_window()
>
> Fixes: c420644c0a8f ("powerpc: Use mm_context vas_windows counter to issue CP_ABORT")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 1a474f6b1992..00fd1d44731a 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -218,8 +218,8 @@ static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
>  static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
>  static inline void mm_context_add_copro(struct mm_struct *mm) { }
>  static inline void mm_context_remove_copro(struct mm_struct *mm) { }
> -static inline void mm_context_add_vas_windows(struct mm_struct *mm) { }
> -static inline void mm_context_remove_vas_windows(struct mm_struct *mm) { }
> +static inline void mm_context_add_vas_window(struct mm_struct *mm) { }
> +static inline void mm_context_remove_vas_window(struct mm_struct *mm) { }
>  #endif

Both of those functions are only called from 64-bit only code, so the
stubs should not be needed at all. Which explains why we haven't seen a
build break.

So just dropping them would be better IMO.

cheers
