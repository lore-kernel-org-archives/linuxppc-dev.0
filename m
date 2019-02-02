Return-Path: <SRS0=/SFz=QJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73410C282D8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:16:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 964A12148D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 01:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRw2twCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 964A12148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43rwzX0YM1zDqjh
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Feb 2019 12:16:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=bsingharora@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vRw2twCK"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43rwxd0Jn4zDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Feb 2019 12:15:00 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id p4so800077plq.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Feb 2019 17:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0rJ7i+EV9cWj3/MnMr0WxrLS3AGD0khiA71WozRXWsY=;
 b=vRw2twCK5YipJ78jZe0ia/FV8SD3jMr5UhhJhGGlpQoFdw96oU0oqN0LWlRG0GUC5d
 Q4LNWZNC9xaaINWO+c+nzNBXNimHpDIyTcwkVH5GcnGrKZ7U2GPKLcmNVJmw1rZq2NGX
 SqiPhmqOdMc7DN4qOmzs9VqpIaHNE56Y4C0XVpvYq4FO2AeLEMh2FczE7vIV6b54nITx
 frzzI0/sGb704XNnvElYr4Oqx1lOGm+GINKoEdu3WSGz9i2WyBpGGZWfx6bWY2tQb/7Z
 +gpVBtM2LXtlF6rxIE3BCg7Nek4myBsRU67ZSIKc0WkgYf9tsOIAsrXIkmSwz7q3RL1F
 Zn3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0rJ7i+EV9cWj3/MnMr0WxrLS3AGD0khiA71WozRXWsY=;
 b=gmOfP4UOjjpsWyUJTCyJHEBgD6TVFXYnOeJE1TGhSMCWBJM3/IEyvZvn8wlMitA20N
 PoKCe5T5bJ5EYBwN8XavjIwNDq9OIlh6UzAmaAqzXlLyqGXxUv5dLLXJqYHIHFUO4eJx
 WVA9Y0pj580M1zgWgjDu/+4agbGMasz8PXYnbV2Oy2nM++NkUu0q91rxEW9qfLe4/z10
 NrZ6SK21CxurXQrB5/6zcAEnIAToJqhqxi8WcD2/5tIymUWLabbkr5zoQ1NkBEJ3A373
 lPGq2KlxqQi8l6P5yuOQTxGZxyFZUDHZ3i92KjZFvJxKmjuQaEjSC5D2KvoV254f0Aw1
 kXHA==
X-Gm-Message-State: AJcUukdSpGS+Gpu1J453cuDUAbDMGhI7AW8NqrSNNfSQUxXtZ+ZkmK0S
 cx7LINk67SCz05dDi5s2FlXUq4JJgUw=
X-Google-Smtp-Source: ALg8bN5+FKSDjPtgEULcwzNRN+QiRcaez12HT1ekKJfTmviGjzipybskvQzISvLOFcYjQeVfj5WM9A==
X-Received: by 2002:a17:902:2468:: with SMTP id
 m37mr42002179plg.314.1549070098955; 
 Fri, 01 Feb 2019 17:14:58 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
 by smtp.gmail.com with ESMTPSA id
 z9sm27419422pfd.99.2019.02.01.17.14.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Feb 2019 17:14:58 -0800 (PST)
Date: Sat, 2 Feb 2019 12:14:55 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH 1/4] powerpc/64s: Clear on-stack exception marker upon
 exception return
Message-ID: <20190202011455.GN26056@350D>
References: <20190122155724.27557-1-joe.lawrence@redhat.com>
 <20190122155724.27557-2-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122155724.27557-2-joe.lawrence@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: Nicolai Stange <nstange@suse.de>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Torsten Duwe <duwe@lst.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jan 22, 2019 at 10:57:21AM -0500, Joe Lawrence wrote:
> From: Nicolai Stange <nstange@suse.de>
> 
> The ppc64 specific implementation of the reliable stacktracer,
> save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
> trace" whenever it finds an exception frame on the stack. Stack frames
> are classified as exception frames if the STACK_FRAME_REGS_MARKER magic,
> as written by exception prologues, is found at a particular location.
> 
> However, as observed by Joe Lawrence, it is possible in practice that
> non-exception stack frames can alias with prior exception frames and thus,
> that the reliable stacktracer can find a stale STACK_FRAME_REGS_MARKER on
> the stack. It in turn falsely reports an unreliable stacktrace and blocks
> any live patching transition to finish. Said condition lasts until the
> stack frame is overwritten/initialized by function call or other means.
> 
> In principle, we could mitigate this by making the exception frame
> classification condition in save_stack_trace_tsk_reliable() stronger:
> in addition to testing for STACK_FRAME_REGS_MARKER, we could also take into
> account that for all exceptions executing on the kernel stack
> - their stack frames's backlink pointers always match what is saved
>   in their pt_regs instance's ->gpr[1] slot and that
> - their exception frame size equals STACK_INT_FRAME_SIZE, a value
>   uncommonly large for non-exception frames.
> 
> However, while these are currently true, relying on them would make the
> reliable stacktrace implementation more sensitive towards future changes in
> the exception entry code. Note that false negatives, i.e. not detecting
> exception frames, would silently break the live patching consistency model.
> 
> Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
> rely on STACK_FRAME_REGS_MARKER as well.
> 
> Make the exception exit code clear the on-stack STACK_FRAME_REGS_MARKER
> for those exceptions running on the "normal" kernel stack and returning
> to kernelspace: because the topmost frame is ignored by the reliable stack
> tracer anyway, returns to userspace don't need to take care of clearing
> the marker.
> 
> Furthermore, as I don't have the ability to test this on Book 3E or
> 32 bits, limit the change to Book 3S and 64 bits.
> 
> Finally, make the HAVE_RELIABLE_STACKTRACE Kconfig option depend on
> PPC_BOOK3S_64 for documentation purposes. Before this patch, it depended
> on PPC64 && CPU_LITTLE_ENDIAN and because CPU_LITTLE_ENDIAN implies
> PPC_BOOK3S_64, there's no functional change here.
> 
> Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  arch/powerpc/Kconfig           | 2 +-
>  arch/powerpc/kernel/entry_64.S | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2890d36eb531..73bf87b1d274 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -220,7 +220,7 @@ config PPC
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_RCU_TABLE_FREE		if SMP
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> -	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
> +	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
>  	select HAVE_IRQ_TIME_ACCOUNTING
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 435927f549c4..a2c168b395d2 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
>  	ld	r2,_NIP(r1)
>  	mtspr	SPRN_SRR0,r2
>  
> +	/*
> +	 * Leaving a stale exception_marker on the stack can confuse
> +	 * the reliable stack unwinder later on. Clear it.
> +	 */
> +	li	r2,0
> +	std	r2,STACK_FRAME_OVERHEAD-16(r1)
> +

Could you please double check, r4 is already 0 at this point
IIUC. So the change might be a simple

std r4,STACK_FRAME_OVERHEAD-16(r1)

Balbir
