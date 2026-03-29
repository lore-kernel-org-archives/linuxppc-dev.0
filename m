Return-Path: <linuxppc-dev+bounces-18966-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7943310D1487
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 01:56:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjyCQ5sDrz2ygd;
	Sun, 29 Mar 2026 12:56:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774749362;
	cv=none; b=muw8xfI98HAdmmjiAtgyY5e4wuBifk7ubYy5MsHt/rbqy8tktJ2fe+7hDS01pq9a6mRoBc545rwjdjB5anPdCMOQRi1Ahq4GL5iNadRcUSza1we8NmYSuuYiRHfd41Zv2groeffTaOK2lCdoK6qWLbkH+Ms36Nwfs1nUlcgecyxNpUjH8IbV0/YczvKhW0u5p/jixtVx4GzVNzM93fLCoLFIUrGnpZjSvHeQGcqbGcvBbnxQSt5se7o+uFQYvT7nhnLo9f+VlT2M/bYU2Zg+3H8Rmbn3VrFjeC18TXys7q2sW7prp88M4bRJK0D2fBrMMFRWq7q6kOcophsYVYkUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774749362; c=relaxed/relaxed;
	bh=E+PbjK/EVYjdCqDf2xBTTVtaGqcPI4gr+f1syl3pPEg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CgzFdv0YNXfA/Ldn9v29LnuPUmTNjr1GzB2cwzjJIcynB73hUz11Acxk7p1BSzKAmWTWAc5R9mr2ZLWfgMIe82FULgxbx/+pebWviuR581n7MBselyTU5m3D/FrFHrvN7L05IqIvGKMXFbJBD6Cm5mBgCtvmBKuDsdiKFdMWduzU658TJ1smygEbvcsOqnN03q1eHYA7lp+DcM8ytziiwevFt5AIYmdTkuhPNK3rhuIhjYJQLSjGX+DjjxLFnlLn3FXDCE4dYuhuNnuR680MtKZV2nozPcv6Ujputdta9aeOXI0552RZoJVHhpezTmzWsuMk9h3xgskn/KbMgvT/jw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IO7dXDcN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IO7dXDcN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjyCP5977z2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 12:56:00 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ad21f437eeso22241845ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 18:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774749358; x=1775354158; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+PbjK/EVYjdCqDf2xBTTVtaGqcPI4gr+f1syl3pPEg=;
        b=IO7dXDcNVyQ7lP6dPe4p2o6gWczeSkBDObpvHOzzXEEG2016ec0Kpna+wS0KC91pZw
         1wQap1jVh1deR4BwRj4G5NAReaTB+qrQKeoYo+pRDVIeSkdmFj8O03+F1oNbR5s22Liw
         5JLdNIpgejBVaEeJGPhSXxQZoqqApAJyrqdDoDYE6ewzhtKNnhRJfr4QVhjZKbPWXqDs
         rpdHbDDofwGQjLEnEOTrsp1vMK9dT/ZJwI6t2JblMLZJuKznQWOESoVfyeuE5B/E/w9A
         WmNDrB9tFOG25JEmIE93+x6crrzQfha6VGxQh9hgEJe75AmcSfZqVQ0lHuJLSVO/69Yu
         A3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774749358; x=1775354158;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+PbjK/EVYjdCqDf2xBTTVtaGqcPI4gr+f1syl3pPEg=;
        b=NnmOMy5fP8dU8BS6/48NZeIYQ8i8u1hBiyGDksnKTRPPks+haELEts1Mq82JGDQdI/
         3JuOzdfb9ujEZj1meeU2aPuUUwXwuyA8zkp4g+Z3vEK7CpG4X1C/wKYKBIhbSE9ZlzVu
         imcxLWZHR599CXiCAvwZLOufaVAHepO6Lzh0AT8XTkFhInV/TLHs70NLpm6BuenwbdkB
         jwBRKNzGERrOA6CktIL+fmX2w/FaPfn9Mvuc/h00QfNqnDD2/rSB/QDzWHK7WJYNWWv/
         MhE0khEq9KfH+8BkMvRY7B/EuSLpESsgyVZMpV06e5kItMA2EqgGILKbxYRjQyAnW05w
         Ebdg==
X-Forwarded-Encrypted: i=1; AJvYcCUEYmXYvMmxgZnHkYhqU4690jpjaF6QXLgdbWS/FOo/0w9vTRRz/HxIG5/CZMWn7at8kENeRbPYfE5cF90=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxgznVUH3+M2DwDgktYS7KVvuk6x9gxdveuGwwkJgj1pY6pl1pP
	77PqSGz1unpdRwf6nPFDdGsg58bQKsP38ry3AUYfZ4ioBr4sGaK3+XRt
X-Gm-Gg: ATEYQzylO61Ob3hsasxCCBgDkQD1LlT4gvYVYEfHx0K2lkIVnhKfiCrRtkQQs92yl9p
	WcqlXquNhVTujyRvi/lRZMQsJ5EPMjHMqFdu8m+C0rmQcbqhMneUHweXbClyhTH1GpumojEqMT8
	zU2QO8pP8Fx1LZm8HqEuGmxI3geZFOxZSoZ404PthqbQNBvA3zbTQUDnWsU9HrvQnDTZ04IDrWX
	EWZ/woIG3GqvHOW57It0JYHmTeBB9e3Z/tLwf8n8+3/4BxWyCLjuTOcsJndV9aOHilUt2/RHhX0
	gw9TBd17hrECjgTFJaLeYsJSHWhyL0c1oW0mDtWuz/WsK9fNUYC4YmzADtx1dGVLMmLd9vKwm4a
	olPIHIMUs5KGvq3/nmu4R1sjH/r5pcd9GPMqFqaEBnuci3EwQKBg4ZCgwi1l0yQGyAbPnVaJatN
	pd7K7CBT4c02PGJi0+mXL4e8eg0hhGXffh
X-Received: by 2002:a17:902:e94c:b0:2b0:5a4c:726f with SMTP id d9443c01a7336-2b0c48e9a76mr104852485ad.15.1774749358019;
        Sat, 28 Mar 2026 18:55:58 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm34928185ad.20.2026.03.28.18.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 18:55:57 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/kexec: Disable KASAN for VMX helpers used in MMU-off path
In-Reply-To: <20260321053121.614022-2-sourabhjain@linux.ibm.com>
Date: Sun, 29 Mar 2026 06:48:45 +0530
Message-ID: <wlyvmo0a.ritesh.list@gmail.com>
References: <20260321053121.614022-1-sourabhjain@linux.ibm.com> <20260321053121.614022-2-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> The kexec sequence invokes enter_vmx_ops() and exit_vmx_ops() with the
> MMU disabled. In this context, code must not rely on normal virtual
> address translations or trigger page faults.
> With KASAN enabled, these functions get instrumented and may access
> shadow memory using regular address translation. When executed with
> the MMU off, this can lead to page faults (bad_page_fault) from which
> the kernel cannot recover in the kexec path, resulting in a hang.

Right, so with mmu off, kernel can't access KASAN shadow memory.

So, let me trace down the path a bit... you skipped an important detail
i.e. preempt_count() is always inline, and we play a few tricks in kexec
path to tell enter_vmx_ops() that we are in HARDIRQ mode.

default_machine_kexec(image)
    current_thread_info()->preempt_count = HARDIRQ_OFFSET

    kexec_sequence(..., copy_with_mmu_off = 1)
        if (copy_with_mmu_off) bl real_mode

        bl kexec_copy_flush(image)
            memcpy(ranges, image->segment, ...)

            copy_segments()
                copy_page(dest, addr)

                    bl enter_vmx_ops()
                        if (in_interrupt() == true) return 0 // preempt_count == HARDIRQ_OFFSET
                    beq .Lnonvmx_copy

>
> Mark enter_vmx_ops() and exit_vmx_ops() with __no_sanitize_address to
> avoid KASAN instrumentation and ensure kexec boots fine with KASAN
> enabled.
>

IIUC, preempt_count() is always inline, and since you are disabling kasan
instrumentation on enter_vmx_ops(), hence it just works for this reason.  
But you missed adding that detail here.

enter_vmx_ops()
    if (in_interrupt()) // return 0
           preempt_count() & ... | HARDIRQ_OFFSET   // preempt_count() is this is __always_inline 

static __always_inline int preempt_count(void)
{
	return READ_ONCE(current_thread_info()->preempt_count);
}

> Cc: Aditya Gupta <adityag@linux.ibm.com>
> Cc: Daniel Axtens <dja@axtens.net>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
> Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reported-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/lib/vmx-helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
> index 554b248002b4..c01b2d856650 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -52,7 +52,7 @@ int exit_vmx_usercopy(void)
>  }
>  EXPORT_SYMBOL(exit_vmx_usercopy);
>  
> -int enter_vmx_ops(void)

In that case, should we should add a comment here saying:

/*
 * Can be called from kexec copy_page() path with MMU off. The kexec
 * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
 * Since in_interrupt() is always inline, __no_sanitize_address on this
 * function is sufficient to avoid KASAN shadow memory accesses in real
 * mode.
 */
> +int __no_sanitize_address enter_vmx_ops(void)
>  {
>  	if (in_interrupt())
>  		return 0;
> @@ -69,7 +69,7 @@ int enter_vmx_ops(void)
>   * passed a pointer to the destination which we return as required by a
>   * memcpy implementation.
>   */
> -void *exit_vmx_ops(void *dest)
> +void __no_sanitize_address *exit_vmx_ops(void *dest)

I am assuming since we never enter into VMX in kexec path, so kexec path
must not be calling exit_vmx_ops anyways? So do we need __no_sanitize_address here?

-ritesh


>  {
>  	disable_kernel_altivec();
>  	preempt_enable();
> -- 
> 2.52.0

