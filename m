Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E820FC282C2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:31:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD9A2175B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 04:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD9A2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w53X5q7LzDqQ0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 15:31:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w51P6T7hzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 15:29:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43w51P450Dz9s9G;
 Thu,  7 Feb 2019 15:29:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/idle: Restore IAMR after idle
In-Reply-To: <20190206062837.26917-1-ruscur@russell.cc>
References: <20190206062837.26917-1-ruscur@russell.cc>
Date: Thu, 07 Feb 2019 15:29:13 +1100
Message-ID: <875ztwkyqu.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> writes:
> Without restoring the IAMR after idle, execution prevention on POWER9
> with Radix MMU is overwritten and the kernel can freely execute userspace without
> faulting.
>
> This is necessary when returning from any stop state that modifies user
> state, as well as hypervisor state.
>
> To test how this fails without this patch, load the lkdtm driver and
> do the following:
>
>    echo EXEC_USERSPACE > /sys/kernel/debug/provoke-crash/DIRECT
>
> which won't fault, then boot the kernel with powersave=off, where it
> will fault.  Applying this patch will fix this.
>
> Fixes: 3b10d0095a1e ("powerpc/mm/radix: Prevent kernel execution of user
> space")

Don't word wrap the fixes line please.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/include/asm/cpuidle.h |  1 +
>  arch/powerpc/kernel/asm-offsets.c  |  1 +
>  arch/powerpc/kernel/idle_book3s.S  | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
> index 43e5f31fe64d..ad67dbe59498 100644
> --- a/arch/powerpc/include/asm/cpuidle.h
> +++ b/arch/powerpc/include/asm/cpuidle.h
> @@ -77,6 +77,7 @@ struct stop_sprs {
>  	u64 mmcr1;
>  	u64 mmcr2;
>  	u64 mmcra;
> +	u64 iamr;
>  };

We don't actually need to put this in the paca anymore.

> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 7f5ac2e8581b..bb4f552f6c7e 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -200,6 +200,12 @@ pnv_powersave_common:
>  	/* Continue saving state */
>  	SAVE_GPR(2, r1)
>  	SAVE_NVGPRS(r1)
> +
> +BEGIN_FTR_SECTION
> +	mfspr	r5, SPRN_IAMR
> +	std	r5, STOP_IAMR(r13)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)

We have space for a full pt_regs on the stack, and we're not using it
all.

We don't have a specific slot for the IAMR (we may want to in future),
but for now you could follow the time-honoured tradition of (ab)using
the _DAR slot, with an appropriate comment.

cheers
