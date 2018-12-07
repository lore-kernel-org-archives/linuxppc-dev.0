Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF73CC64EB1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:10:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E5DD20868
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 11:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E5DD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B8s92kDhzDrgq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 22:10:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B8pY0TZMzDrdp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 22:08:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43B8pX4Plvz9s47;
 Fri,  7 Dec 2018 22:08:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S PR: Set hflag to indicate that POWER9
 supports 1T segments
In-Reply-To: <20181207034326.3564-2-sjitindarsingh@gmail.com>
References: <20181207034326.3564-1-sjitindarsingh@gmail.com>
 <20181207034326.3564-2-sjitindarsingh@gmail.com>
Date: Fri, 07 Dec 2018 22:08:20 +1100
Message-ID: <871s6tlhln.fsf@concordia.ellerman.id.au>
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
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, sjitindarsingh@gmail.com,
 kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:

> When booting a kvm-pr guest on a POWER9 machine the following message is
> observed:
> "qemu-system-ppc64: KVM does not support 1TiB segments which guest expects"
>
> This is because the guest is expecting to be able to use 1T segments
> however we don't indicate support for it. This is because we don't set
> the BOOK3S_HFLAG_MULTI_PGSIZE flag in the hflags in kvmppc_set_pvr_pr()
> on POWER9.
>
> POWER9 does indeed have support for 1T segments, so add a case for
> POWER9 to the switch statement to ensure it is set.

If this just checked mmu_has_feature(MMU_FTR_1T_SEGMENT) it would have
been right in this case, and we'd also never have to update it in
future.

Any reason not to?

cheers

> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 4efd65d9e828..82840160c606 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -587,6 +587,7 @@ void kvmppc_set_pvr_pr(struct kvm_vcpu *vcpu, u32 pvr)
>  	case PVR_POWER8:
>  	case PVR_POWER8E:
>  	case PVR_POWER8NVL:
> +	case PVR_POWER9:
>  		vcpu->arch.hflags |= BOOK3S_HFLAG_MULTI_PGSIZE |
>  			BOOK3S_HFLAG_NEW_TLBIE;
>  		break;
> -- 
> 2.13.6
