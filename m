Return-Path: <SRS0=J6Sm=EF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7DBC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 00:50:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5182071A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 00:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="HwfSehNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5182071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMkHY6byJzDqlL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 11:50:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMkFb1jGqzDqjM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 11:48:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HwfSehNv; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CMkFZ6vryz9sPB;
 Fri, 30 Oct 2020 11:48:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1604018915;
 bh=NXDJ+W6AruE7t9bsOTVMhirY27hZ6xexbabMGso5090=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=HwfSehNv9LOk5emhPkZABLJOOMKAFoawwzrM0R2dIcqxLXxwqQsqU7qw44EuviiwR
 NjazC3hrtXd//7X1oaqPTxxYQcDiv4a72BklYzdxRqcTEWahYtRKDSCpYdGve8jGVT
 PQv+UQn8ur/L5zOVFetaGDSuZxH2iIxA1Ap6NaASwnZ6lD6zfpEesod6Rcdo4yt3uV
 BLZkCtlXz5xRBAMML73A2Wb5rGxbY6pdSMmjRabT9YdbkuuMPQdY4kuDYehjuST+Tc
 vt4Vb7Mu3ZoVRyuNJafK+Q06+3AM91B8RpPThQjZKyqnPavJBAR0PYGmlyWcn2Vx0w
 LlbM/oWtwk5vw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jens Axboe <axboe@kernel.dk>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: add support for TIF_NOTIFY_SIGNAL
In-Reply-To: <7adea1eb-d193-9d31-6244-e8cd5b2084b2@kernel.dk>
References: <7adea1eb-d193-9d31-6244-e8cd5b2084b2@kernel.dk>
Date: Fri, 30 Oct 2020 11:48:30 +1100
Message-ID: <871rhgwnc1.fsf@mpe.ellerman.id.au>
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

Jens Axboe <axboe@kernel.dk> writes:
> Wire up TIF_NOTIFY_SIGNAL handling for powerpc.
>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
>
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
>
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.

Happy for you to take it along with the rest of the series.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers

> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 46a210b03d2b..53115ae61495 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -90,6 +90,7 @@ void arch_setup_new_exec(void);
>  #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
>  #define TIF_SIGPENDING		1	/* signal pending */
>  #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
> +#define TIF_NOTIFY_SIGNAL	3	/* signal notifications exist */
>  #define TIF_SYSCALL_EMU		4	/* syscall emulation active */
>  #define TIF_RESTORE_TM		5	/* need to restore TM FP/VEC/VSX */
>  #define TIF_PATCH_PENDING	6	/* pending live patching update */
> @@ -115,6 +116,7 @@ void arch_setup_new_exec(void);
>  #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
>  #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
>  #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
> +#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
>  #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
>  #define _TIF_32BIT		(1<<TIF_32BIT)
>  #define _TIF_RESTORE_TM		(1<<TIF_RESTORE_TM)
> @@ -136,7 +138,8 @@ void arch_setup_new_exec(void);
>  
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>  				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> -				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING)
> +				 _TIF_RESTORE_TM | _TIF_PATCH_PENDING | \
> +				 _TIF_NOTIFY_SIGNAL)
>  #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
>  
>  /* Bits in local_flags */
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index d2c356f37077..a8bb0aca1d02 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -318,7 +318,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_info_flags)
>  	if (thread_info_flags & _TIF_PATCH_PENDING)
>  		klp_update_patch_state(current);
>  
> -	if (thread_info_flags & _TIF_SIGPENDING) {
> +	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
>  		BUG_ON(regs != current->thread.regs);
>  		do_signal(current);
>  	}
> -- 
> 2.29.0
>
> -- 
> Jens Axboe
