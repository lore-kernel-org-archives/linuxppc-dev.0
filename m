Return-Path: <SRS0=CiaY=UX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57901C43613
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 11:49:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA32F20674
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 11:49:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32F20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XSJd0ZjmzDqTp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 21:49:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XSGj2slpzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2019 21:48:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45XSGh6ycXz9s6w;
 Mon, 24 Jun 2019 21:48:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix CR0 setting in TM emulation
In-Reply-To: <20190620060040.26945-1-mikey@neuling.org>
References: <20190620060040.26945-1-mikey@neuling.org>
Date: Mon, 24 Jun 2019 21:48:12 +1000
Message-ID: <87tvcf8arn.fsf@concordia.ellerman.id.au>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Neuling <mikey@neuling.org> writes:
> When emulating tsr, treclaim and trechkpt, we incorrectly set CR0. The
> code currently sets:
>     CR0 <- 00 || MSR[TS]
> but according to the ISA it should be:
>     CR0 <-  0 || MSR[TS] || 0

Seems bad, what's the worst case impact?

Do we have a test case for this?

> This fixes the bit shift to put the bits in the correct location.

Fixes: ?

cheers

> diff --git a/arch/powerpc/kvm/book3s_hv_tm.c b/arch/powerpc/kvm/book3s_hv_tm.c
> index 888e2609e3..31cd0f327c 100644
> --- a/arch/powerpc/kvm/book3s_hv_tm.c
> +++ b/arch/powerpc/kvm/book3s_hv_tm.c
> @@ -131,7 +131,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
>  		}
>  		/* Set CR0 to indicate previous transactional state */
>  		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
> -			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
> +			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
>  		/* L=1 => tresume, L=0 => tsuspend */
>  		if (instr & (1 << 21)) {
>  			if (MSR_TM_SUSPENDED(msr))
> @@ -175,7 +175,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
>  
>  		/* Set CR0 to indicate previous transactional state */
>  		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
> -			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
> +			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
>  		vcpu->arch.shregs.msr &= ~MSR_TS_MASK;
>  		return RESUME_GUEST;
>  
> @@ -205,7 +205,7 @@ int kvmhv_p9_tm_emulation(struct kvm_vcpu *vcpu)
>  
>  		/* Set CR0 to indicate previous transactional state */
>  		vcpu->arch.regs.ccr = (vcpu->arch.regs.ccr & 0x0fffffff) |
> -			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 28);
> +			(((msr & MSR_TS_MASK) >> MSR_TS_S_LG) << 29);
>  		vcpu->arch.shregs.msr = msr | MSR_TS_S;
>  		return RESUME_GUEST;
>  	}
> -- 
> 2.21.0
