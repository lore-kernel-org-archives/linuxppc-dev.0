Return-Path: <linuxppc-dev+bounces-26032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1095C5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2026 11:34:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hRJBT1TWzz2xLd;
	Fri, 21 Aug 2026 21:34:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787312097;
	cv=none; b=E9L7SC1PCC6BILytNazanrh0uEPufTRpi1m4hHXhYtzWHsNBlnIQm0VDAXJAkH6PeaqY4NdpP9vs4pzwvdgzSfCv39Q6fNzggMQPPoOQU1c5dZBC67k15ipo94B++5Tj5ic0X/tAxmc1MBkW2d/PmPQb1EDZ1EHTEDQ4tQ14eWCi/KnHwF++yToX8SNJPo4qhzieY/hFH88tnTRYX1OW+sqZ3+tTbpqtMe6Wc5/3K2wzUuKol29hLmVby+Ey+4oVshZVZvesBtIquj3DajSdQj/RfeOmhBZDbV2O0LkNRUR3dGrumXJwLyOeNezrMOR+L8BkPVMhB02/N72+ZJBR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787312097; c=relaxed/relaxed;
	bh=kJK8zYVP422FvpgoMi2IYMM8fvVyRmiBglfOTp8DIAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8y+BNPH4bLE25GUMfbNhlGdx355BI5aw9jMCtb8a2UhH7DAcujwsiBXBEZUysWXo/OovlnL1wJY1lvpbEqjw1V7F2wftaJxDzYzeIuE98SL2HXfiO9ktc9oORjFbYenCFF1P1nKj9YRplwdECS4bYswVfwYeakiL/71I/vkVIcX2WVHZsyUOzM1G0NHznYgIiXhMQAYebxTVcOLJpk7f2teAQqdZsW4bBhRNbcfat1quCSYe0ttvDVIZNOg/zf1HZdDUVL1eWaAg1h/Eo18l95J8PfLK4qPynpzPJSIoJqVNNOUUoJ8D2nhX7nuyOGsdH28QMoPgh6tP446yHp9ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfHCO7b7; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfHCO7b7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hRJBS1yHhz2xKN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2026 21:34:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5177760008;
	Fri, 21 Aug 2026 11:34:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7001F000E9;
	Fri, 21 Aug 2026 11:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787312093;
	bh=kJK8zYVP422FvpgoMi2IYMM8fvVyRmiBglfOTp8DIAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GfHCO7b71pDpL2ixqylgh76wjhe8mKsSfm32uTm22AvSEp6o5YPls8px3oH8ooGM4
	 ngTloyRJaLnVJQ/9nGdGqz2UghBZGeOPjDazczTK5CUA+H+PNdsarsqtjo/cUwU7ap
	 s4VUY7LndqGeDBDFhAe/kqp9OixfyCzBB4W99W8xxGlWKvqiA5Byhf4QTjyHrpKxH2
	 EnmuMl5QbcFa3ltN0JdprQGnI2dw/QzsGufcidXUYZMypFNqg+U4J2HE2fQHirvUBf
	 DfnOwK++CLRQxIelsxzJ6uE3IIZWBmpBIA5HeEjVq2St1M06sYslODdSGiVs3N+h+q
	 o6qVoQAl+knHQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,  Aditya Gupta <adityag@linux.ibm.com>,
  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baoquan He <baoquan.he@linux.dev>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Hari Bathini
 <hbathini@linux.ibm.com>,  Madhavan Srinivasan <maddy@linux.ibm.com>,
  Mahesh Salgaonkar <mahesh@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Mike Rapoport <rppt@kernel.org>,  Nicholas Piggin
 <npiggin@gmail.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shivang Upadhyay <shivangu@linux.ibm.com>,
  Shrikanth Hegde <sshegde@linux.ibm.com>,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org, Michal Clapinski <mclapinski@google.com>
Subject: Re: [RFC PATCH 3/3] powerpc/kho: exclude THP and HUGETLB_PAGE
In-Reply-To: <20260821105609.983622-4-sourabhjain@linux.ibm.com> (Sourabh
	Jain's message of "Fri, 21 Aug 2026 16:26:09 +0530")
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
	<20260821105609.983622-4-sourabhjain@linux.ibm.com>
Date: Fri, 21 Aug 2026 13:34:48 +0200
Message-ID: <2vxzecfrzoyv.fsf@kernel.org>
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

On Fri, Aug 21 2026, Sourabh Jain wrote:

> Enabling CONFIG_KEXEC_HANDOVER together with CONFIG_TRANSPARENT_HUGEPAGE
> or CONFIG_HUGETLB_PAGE on powerpc fails to build:
>
>     kernel/liveupdate/kexec_handover.c:49:39: error: expression in static assertion is not constant
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>     ./include/linux/build_bug.h:80:56: note: in definition of macro '__static_assert'
>        80 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>           |                                                        ^~~~
>     kernel/liveupdate/kexec_handover.c:49:1: note: in expansion of macro 'static_assert'
>        49 | static_assert(SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES);
>
> CMA_MIN_ALIGNMENT_BYTES is derived from pageblock_order, which on
> powerpc is not a compile-time constant when THP or HUGETLB_PAGE is
> enabled -- powerpc can determine huge page size at runtime in that
> configuration, so pageblock_order becomes a variable rather than a
> constant expression. KHO's static_assert() on
> SCRATCH_ALIGNMENT_BYTES >= CMA_MIN_ALIGNMENT_BYTES then fails to
> compile, since it requires both sides to be constant expressions.
>
> Until CMA_MIN_ALIGNMENT_BYTES (or KHO's use of it) is made to handle
> the non-constant pageblock_order case on powerpc, exclude
> TRANSPARENT_HUGEPAGE and HUGETLB_PAGE from ARCH_SUPPORTS_KEXEC_HANDOVER
> so the two can't be enabled together and hit this build failure.

This should be a part of patch 2 I think. It is not a good idea to break
the build in one patch and fix it in the next.

That said, this is a debug check of sorts since SCRATCH_ALIGNMENT_BYTES
is of MAX_ORDER_NR_PAGES, and pageblocks _should_ always be smaller of
equal to this.

Anyway, I don't think this is something you should gate by a config. I
think you should either remove the static_assert(), or turn it into a
runtime check.

+Cc Michal.

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
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 61350d3e7a19..f68b9fc883ba 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -720,6 +720,7 @@ config ARCH_SUPPORTS_KEXEC_HANDOVER
>  	def_bool y
>  	depends on PPC64
>  	depends on !CRASH_DUMP
> +	depends on !TRANSPARENT_HUGEPAGE && !HUGETLB_PAGE
>  
>  config ARCH_SUPPORTS_CRASH_HOTPLUG
>  	def_bool y

-- 
Regards,
Pratyush Yadav

