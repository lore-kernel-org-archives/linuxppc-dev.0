Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EB6C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 23:57:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D0B2087B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 23:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="GkjQVI6O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D0B2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444ZK82FmJzDqNQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:57:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444ZHG4jnJzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 10:55:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="GkjQVI6O"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 444ZHG3CsRz9s8m; Thu, 21 Feb 2019 10:55:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550706938; bh=Ew7z1PSV//fdA/RV7+MMlBKKAuUhsfKc7yT5IsVq/n8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GkjQVI6O7BIhsPtaQ36tkd3DuNmIJw7vHfw+JBxQELYHEz8l9JX/2F4h4X1gy+ejy
 pWuMwQg1reLb2ldgLQuOBlbmwqr8tUEB1/nslUHRHby49B2L6J+qugYi0TBcD4PNj7
 qO6T2jVozM1RbyyxILE3gC0/edOfC6K3/VEtvdAOywEes+IvRJ+TsQNPdMYC56e4yJ
 gQ9mKAzwxvdpo9bWi9Sk0oMCvs0coWNpMMO2hAt7v/Avcajkr1tdVUW0llFeiWw3Fd
 21r5pC5uB4QpphRyq5tm0/n31XJem/gYspu+Xw3P+UB0FM5wDYLMe8cn4P9AQ2eLZ+
 YK40ihj6G/uig==
Date: Thu, 21 Feb 2019 10:55:30 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH] powerpc/kvm: Save and restore AMR instead of zeroing
Message-ID: <20190220235530.pl36pd56hs5rfcup@oak.ozlabs.ibm.com>
References: <20190220045958.14966-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220045958.14966-1-ruscur@russell.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 03:59:58PM +1100, Russell Currey wrote:
> Using the hash MMU on P7+, the AMR is used for pkeys.  It's important

This needs a bit of rewording.  The "Using" ... "used" construct is a
bit confusing on the first read.  Also, there was a processor called
P7+, but I think you're trying to say P7 and subsequent processors.

> that the host and guest never end up with each other's AMR value, since
> this could disrupt operations and break things.

What sort of breakage?  Guest kernel crash?  Host kernel crash?

> The AMR gets correctly restored on context switch, however before this
> happens (i.e. in a program like qemu) having the host value of the AMR
> be zero would interfere with that program using pkeys.
> 
> In addition, the AMR on Radix can control kernel access to userspace
> data, which you wouldn't want to be zeroed.
> 
> So, just save and restore it like the other registers that get saved and
> restored.
> 
> Fixes: cf43d3b26452 ("powerpc: Enable pkey subsystem")
> Cc: <stable@vger.kernel.org> # v4.16+
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> ---
> I'm not entirely sure the stack frame numbers are correct, I've tested it
> and it works but it'd be good if someone could double check this.
> 
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 9b8d50a7cbaf..6291751c4ad9 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -47,7 +47,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  #define NAPPING_NOVCPU	2
>  
>  /* Stack frame offsets for kvmppc_hv_entry */
> -#define SFS			208
> +#define SFS			224		/* must be divisible by 16 */

I don't think this needs to be increased.  What's happening here is
that we have a "short path" where most SPRs are saved/loaded/restored
etc. in C code in book3s_hv.c, and that path uses 144 bytes on the
stack to save/restore 18 GPR values (r14 - r31).  Your patch needs to
add code to context-switch AMR in kvmhv_p9_guest_entry() to fix that
path.

Alternatively there is the slow path where we go to real mode and do
most of the SPR loading in assembler code.  That path uses the stack
to store host SPR values in STACK_SLOT_TID, PSSCR, PID, etc.

>  #define STACK_SLOT_TRAP		(SFS-4)
>  #define STACK_SLOT_SHORT_PATH	(SFS-8)
>  #define STACK_SLOT_TID		(SFS-16)
> @@ -58,8 +58,9 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  #define STACK_SLOT_DAWR		(SFS-56)
>  #define STACK_SLOT_DAWRX	(SFS-64)
>  #define STACK_SLOT_HFSCR	(SFS-72)
> +#define STACK_SLOT_AMR		(SFS-80)
>  /* the following is used by the P9 short path */
> -#define STACK_SLOT_NVGPRS	(SFS-152)	/* 18 gprs */
> +#define STACK_SLOT_NVGPRS	(SFS-160)	/* 18 gprs */

I don't see why you need to change this either.

>  
>  /*
>   * Call kvmppc_hv_entry in real mode.
> @@ -743,6 +744,9 @@ BEGIN_FTR_SECTION
>  	std	r7, STACK_SLOT_DAWRX(r1)
>  END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  
> +	mfspr	r5, SPRN_AMR
> +	std	r5, STACK_SLOT_AMR(r1)
> +
>  BEGIN_FTR_SECTION
>  	/* Set partition DABR */
>  	/* Do this before re-enabling PMU to avoid P7 DABR corruption bug */
> @@ -1640,13 +1644,14 @@ BEGIN_FTR_SECTION
>  END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  8:
>  
> -	/* Save and reset AMR and UAMOR before turning on the MMU */
> +	/* Save and restore/reset AMR and UAMOR before turning on the MMU */
>  	mfspr	r5,SPRN_AMR
>  	mfspr	r6,SPRN_UAMOR
>  	std	r5,VCPU_AMR(r9)
>  	std	r6,VCPU_UAMOR(r9)
> +	ld	r5,STACK_SLOT_AMR(r1)
>  	li	r6,0
> -	mtspr	SPRN_AMR,r6
> +	mtspr	SPRN_AMR, r5
>  	mtspr	SPRN_UAMOR, r6
>  
>  	/* Switch DSCR back to host value */
> -- 
> 2.20.1

Rest looks fine, but as I said, the patch needs to hit
kvmhv_p9_guest_entry() also.

Paul.
