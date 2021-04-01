Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F059BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 05:43:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA2760FE9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 05:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA2760FE9
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9sXh6czwz3c8s
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 16:43:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=FOAfm1gx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=paulus@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256
 header.s=201707 header.b=FOAfm1gx; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9sWQ5DWwz30MK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 16:41:54 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4F9sWH4tD8z9sWw; Thu,  1 Apr 2021 16:41:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1617255707; bh=xpTr47Oj6tjUKhlk4O/qkZsmcdxnvdw69ZAkj/Dtjok=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FOAfm1gxfn7uTLaiR9b6w36/PEwtILKm5qD5AV+3i35zLdWZtL9gnJlxmMNrH9Nqn
 rtMkLBiGdqONptXyG+WTu8vUkqcxkNQjHxHKHQdbc1oOZjiZEKfAa3TAyfnNDRV8HH
 Fe4hfs6yRAPsvoL5xACeeKf2k+mVjVj4YeHp2hb7PTj+93JgylV3qjQhF0guCSo5dL
 kh0ccP6q77DQbF1Sc960u8MGUq2rou5lF4m8bOLDupcMWR15lZRIAsiWaAdplnFkz5
 8pizOEwN1pA1lZfhMqZ+xj7PVIVmQYHewVLgLY5oGRAIK/QsX/44rYflE4X/BFt6jo
 mnSoIWRcmg9mw==
Date: Thu, 1 Apr 2021 16:32:50 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 13/46] KVM: PPC: Book3S 64: Move GUEST_MODE_SKIP test
 into KVM
Message-ID: <YGVbApPydgwAU8cP@thinks.paulus.ozlabs.org>
References: <20210323010305.1045293-1-npiggin@gmail.com>
 <20210323010305.1045293-14-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323010305.1045293-14-npiggin@gmail.com>
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 23, 2021 at 11:02:32AM +1000, Nicholas Piggin wrote:
> Move the GUEST_MODE_SKIP logic into KVM code. This is quite a KVM
> internal detail that has no real need to be in common handlers.
> 
> Also add a comment explaining why this thing exists.

[snip]

> diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
> index 7a039ea78f15..a5412e24cc05 100644
> --- a/arch/powerpc/kvm/book3s_64_entry.S
> +++ b/arch/powerpc/kvm/book3s_64_entry.S
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  #include <asm/asm-offsets.h>
>  #include <asm/cache.h>
> +#include <asm/exception-64s.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/kvm_book3s_asm.h>
>  #include <asm/ppc_asm.h>
> @@ -20,9 +21,12 @@ kvmppc_interrupt:
>  	 * guest R12 saved in shadow VCPU SCRATCH0
>  	 * guest R13 saved in SPRN_SCRATCH0
>  	 */
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	std	r9,HSTATE_SCRATCH2(r13)
>  	lbz	r9,HSTATE_IN_GUEST(r13)
> +	cmpwi	r9,KVM_GUEST_MODE_SKIP
> +	beq-	.Lmaybe_skip
> +.Lno_skip:
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
>  	beq	kvmppc_bad_host_intr
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
> @@ -34,3 +38,48 @@ kvmppc_interrupt:
>  #else
>  	b	kvmppc_interrupt_pr
>  #endif

It's a bit hard to see without more context, but I think that in the
PR-only case (CONFIG_KVM_BOOK3S_HV_POSSIBLE undefined), this will
corrupt R9.  You need to restore R9 before the unconditional branch to
kvmppc_interrupt_pr.  (I realize this code gets modified further, but
I'd rather not break bisection.)

Paul.
