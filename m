Return-Path: <SRS0=EeCa=TU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7730BC04AAF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:39:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A939820815
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 06:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Tuc+fMdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A939820815
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 456q434HtyzDqL8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 May 2019 16:38:59 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 456q2g4x7MzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 May 2019 16:37:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="Tuc+fMdf"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 456q2g3FqHz9sBb; Mon, 20 May 2019 16:37:47 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 456q2g20V9z9s9y; Mon, 20 May 2019 16:37:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1558334267; bh=KMvPkfmRTz792i4T4gnia0zZY7D8IlGpYuJ3hjuUXsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Tuc+fMdfRe9ei0Q/0+/guTHfXvOu47MbPR5V6VnMHzKXhjHRjx9sUvJbABvl4C2q+
 jhA3znoOvbi6FV3JlF0YE6zpJrPI86KgQeqNxwFLUNocqtt8t5S6k5pGosoEfdENDF
 OvMkF8SKE5MMjjfGFMTvaYSJBin67U52tFJcsb8wIduDc4apI2wfAfMbn59uOdFdzd
 SPjVDYUYH5t/80+IMZ6D6N3SAxnoU0ZY0Ob3e0CYdrKSX86sTGInjf4n0TYAiDjTdc
 E5K5ptQW+1yXN18aJBQ/D4pPtlN/b8Ow89LDbQEL7NQF7wyN/c/HZiBg5JUo7+5018
 hfpAjGIWIuaow==
Date: Mon, 20 May 2019 15:43:57 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Claudio Carvalho <cclaudio@linux.ibm.com>
Subject: Re: [RFC PATCH v2 07/10] KVM: PPC: Ultravisor: Restrict LDBAR access
Message-ID: <20190520054357.GB21382@blackberry>
References: <20190518142524.28528-1-cclaudio@linux.ibm.com>
 <20190518142524.28528-8-cclaudio@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518142524.28528-8-cclaudio@linux.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Michael Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 kvm-ppc@vger.kernel.org, Bharata B Rao <bharata@linux.ibm.com>,
 linuxppc-dev@ozlabs.org, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, May 18, 2019 at 11:25:21AM -0300, Claudio Carvalho wrote:
> From: Ram Pai <linuxram@us.ibm.com>
> 
> When the ultravisor firmware is available, it takes control over the
> LDBAR register. In this case, thread-imc updates and save/restore
> operations on the LDBAR register are handled by ultravisor.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> [Restrict LDBAR access in assembly code and some in C, update the commit
>  message]
> Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>

Some of the places that you are patching below are explicitly only
executed on POWER8, which can't have an ultravisor, and therefore
the change isn't needed:

> ---
>  arch/powerpc/kvm/book3s_hv.c                 |  4 +-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S      |  2 +
>  arch/powerpc/perf/imc-pmu.c                  | 64 ++++++++++++--------
>  arch/powerpc/platforms/powernv/idle.c        |  6 +-
>  arch/powerpc/platforms/powernv/subcore-asm.S |  4 ++
>  5 files changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 0fab0a201027..81f35f955d16 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -75,6 +75,7 @@
>  #include <asm/xics.h>
>  #include <asm/xive.h>
>  #include <asm/hw_breakpoint.h>
> +#include <asm/firmware.h>
>  
>  #include "book3s.h"
>  
> @@ -3117,7 +3118,8 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>  			subcore_size = MAX_SMT_THREADS / split;
>  			split_info.rpr = mfspr(SPRN_RPR);
>  			split_info.pmmar = mfspr(SPRN_PMMAR);
> -			split_info.ldbar = mfspr(SPRN_LDBAR);
> +			if (!firmware_has_feature(FW_FEATURE_ULTRAVISOR))
> +				split_info.ldbar = mfspr(SPRN_LDBAR);

This is inside an if (is_power8) statement.

> diff --git a/arch/powerpc/platforms/powernv/subcore-asm.S b/arch/powerpc/platforms/powernv/subcore-asm.S
> index 39bb24aa8f34..e4383fa5e150 100644
> --- a/arch/powerpc/platforms/powernv/subcore-asm.S
> +++ b/arch/powerpc/platforms/powernv/subcore-asm.S
> @@ -44,7 +44,9 @@ _GLOBAL(split_core_secondary_loop)
>  
>  real_mode:
>  	/* Grab values from unsplit SPRs */
> +BEGIN_FW_FTR_SECTION
>  	mfspr	r6,  SPRN_LDBAR
> +END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ULTRAVISOR)
>  	mfspr	r7,  SPRN_PMMAR
>  	mfspr	r8,  SPRN_PMCR
>  	mfspr	r9,  SPRN_RPR
> @@ -77,7 +79,9 @@ real_mode:
>  	mtspr	SPRN_HDEC, r4
>  
>  	/* Restore SPR values now we are split */
> +BEGIN_FW_FTR_SECTION
>  	mtspr	SPRN_LDBAR, r6
> +END_FW_FTR_SECTION_IFCLR(FW_FEATURE_ULTRAVISOR)

Only POWER8 supports split-core mode, so we can only get here on
POWER8.

Paul.
