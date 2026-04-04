Return-Path: <linuxppc-dev+bounces-19300-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E3E88D72
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 01:04:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fncn32LP8z2xYw;
	Sat, 04 Apr 2026 12:04:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775264663;
	cv=none; b=DC8SwuaXh288se1yq8xzJjADoMdL4PJgr7m1wbO+gAzl6kIjLYnRI4+kS6NF6Cqvosm3IjL92YFyTQVWuyc+p8CAvK0DVnAnrbBPvZljZbvigEtZJH1ZCWRnvnv+W7OqxiBqD7Ju1PYEC31B02No8D6tF4ImKlJZhsj9Xh3s7SZABKhFSiIMkN+K/Z+uwywPxpjyxGVRVWZedQY0Zbq6Tg14D9+f8mr0tZKEry5RhQUCtDFZnvK7tCYv7mt4LP6iWRQtcat0EiOOH0Y6ExZOxIcZAWg17EIxGa6O2SXEr7Nx7+MYX/U0cRGjQh7z4iRiQnwjQZcfP/xnCw47MaGz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775264663; c=relaxed/relaxed;
	bh=edNGcFx1CXG5zY263vAjylqpwkQzI0eE+O2C6Le7MCw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=jAIihlNO6pV6EzSANzq0STNkXMTRFz33qVVfAGcvsNzVRzVtqUCbeuWeCMWiEMDCd+IM5knsjdCSjNKbK1S4akZy3FK13+yptR++vP3jzUJapk4+S38XqFb0xQGFrsQs+nktMwjh1StIZhh0UZtTDCDZmDcAgTccbz+QDa/9Gj/iMt57OJe4kCuRzDh2UmX3g0Z1TaachBAJ8KTpUUVSne8jk0HBAMgTNMn9O/Z1CJ4xobykl3onUYd9d2ywAff9KATq4Qsf/mJ3i3Nqik9bHMeheMQn3XAQuKQrI6O+tI73CYSGGJIj5/BDCfPrjfoRveLY2rB2A6cbvRM/Kd2G3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJI5fEzF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UJI5fEzF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fncn21shNz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 12:04:22 +1100 (AEDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82748257f5fso2082698b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 18:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775264660; x=1775869460; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=edNGcFx1CXG5zY263vAjylqpwkQzI0eE+O2C6Le7MCw=;
        b=UJI5fEzFJo9igbOboDKFEBCRnytS3CzrBW/rXCWUk28e25OO4CL6jHVf9N5lHZmXrW
         obri7dybXjrNUG9vyahSVXAcvDzFkZW39YldVJHukdd5Jy79wWeB88247tF3E6p3vrxy
         uxKi3XMJsiFIWj5MnFkelyk3MW9qdCpEDcmrAFyILTS5CrvVfnKIFFYkyaSXD7FcnN7i
         LTlIXPDIvkXZlUT1wApxDlfbZUCl4lurwBtwKiLlXw005HhqgGyd60+QIr23mib45Jm5
         Objz1b7GTnYfvaMskUvTqzZ6hoWdIDnoEki9+la3ryp0Z9/hxzXzn6H3GDxFJmvMMt8x
         IzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775264660; x=1775869460;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=edNGcFx1CXG5zY263vAjylqpwkQzI0eE+O2C6Le7MCw=;
        b=lYZ7/BB+LZg5czKjhXif1jYusswCS2Smo75bfnPsLog4AZ7ORSRFS5w8yKOVp4eYRt
         asIN9IeGSxwweoUibtYbJlAqPXjoVp6OAtFdaEzv8NlZEVSEJbQp0y2fEFyB2SO+SQ5/
         +kHoODnGrB92g6tC7oqo3uZfBXfSaoapIHjzqc0lPB4PygxisSQqtC1R6l/UBDWISCEn
         mWh1ZS6NmE4tq2EYRJC6JumDAkC+/PaJnOdagzvOjhYXbkdAqiR17OEMQBN94WuP/mb0
         eDJVPqaI+YQNImRltKQXoNPMsGoXC+B8xefqfGG08/iWGgwntzPb7YlCDHbHH3N1OaGh
         Lc3A==
X-Forwarded-Encrypted: i=1; AJvYcCVyBwsJcPX4q95Ijsl3mEV2MyXZL/IMcJLTzuK7RuS5nBof02oxr/ZiPzx4Ny8Dd2jNBLN5MpbbkbNC96c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yyd5wiasUVbNFu9IKu8fWR3K0+FRRCxgELxUFQps6FGsD1SjrFx
	GDXet6cQZYnJ2XfRvCAz/aXYSoPQVAtaHdfx0Jc+CH6Y1ecJ10GWrFX8
X-Gm-Gg: AeBDietAJMzRThUBx3ux6ywmDP2+RnrEvjvp40Tg20Am+zGRbqCl+4+FI/YzkK03hZZ
	USsiZHkIjhvtXy00oZ1CgG8st/S1IiUE0matC5ParNyWDEh/IzhWElON8MMUaI8D2nakdVdFTRv
	Mogkt0/VOmjy4AnvR5yDtvYehJm3gWk3LogurVQSHmzZgbG70qAM+X6fyfOv4W2IEghaU0kf4/o
	kkjWRAohMjpJzZQwVPBUMMuVmk+EuKf97objMCXJHfWwzOGbQlcRPhlT0optoEB/vsbKtPhX8yJ
	piQ5X3fk7Rl8FcAyaOhqbSh5e8Ck23KbtkzN2xdQonowjsjPpl877wxUJuRBVPncWd4A3SBLTsf
	J0aey1enmDn/R20DKDorhggjFDPDX41Gn+L4K873/4xtvZEHL/jv1snDAu0g4CGvxshanYpdCMl
	HCboEy3safrDYaRUfTMEN3Pg==
X-Received: by 2002:a05:6a00:198b:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-82d0db5d24emr3887653b3a.10.1775264659884;
        Fri, 03 Apr 2026 18:04:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261absm8279923b3a.7.2026.04.03.18.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 18:04:19 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Hari Bathini <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shivang Upadhyay <shivangu@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] powerpc/vmx: avoid KASAN instrumentation in enter_vmx_ops() for kexec
In-Reply-To: <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
Date: Sat, 04 Apr 2026 06:31:04 +0530
Message-ID: <cy0fmtdb.ritesh.list@gmail.com>
References: <20260403190123.1383198-1-sourabhjain@linux.ibm.com> <20260403190123.1383198-2-sourabhjain@linux.ibm.com>
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

> The kexec sequence invokes enter_vmx_ops() via copy_page() with the MMU
> disabled. In this context, code must not rely on normal virtual address
> translations or trigger page faults.
>
> With KASAN enabled, functions get instrumented and may access shadow
> memory using regular address translation. When executed with the MMU
> off, this can lead to page faults (bad_page_fault) from which the
> kernel cannot recover in the kexec path, resulting in a hang.
>
> The kexec path sets preempt_count to HARDIRQ_OFFSET before entering
> the MMU-off copy sequence.
>
> current_thread_info()->preempt_count = HARDIRQ_OFFSET
>   kexec_sequence(..., copy_with_mmu_off = 1)
>     -> kexec_copy_flush(image)
>          copy_segments()
>            -> copy_page(dest, addr)
> 	         bl enter_vmx_ops()
>                    if (in_interrupt())
>                      return 0
> 	         beq .Lnonvmx_copy
>
> Since kexec sets preempt_count to HARDIRQ_OFFSET, in_interrupt()
> evaluates to true and enter_vmx_ops() returns early.
>
> As in_interrupt() (and preempt_count()) are always inlined, mark
> enter_vmx_ops() with __no_sanitize_address to avoid KASAN
> instrumentation and shadow memory access with MMU disabled, helping
> kexec boot fine with KASAN enabled.
>

Nice! LGTM. Please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

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
> Changelog:
>
> v2:
> - Remove __no_sanitize_address from exit_vmx_ops
> - Add a comment explaining that marking only enter_vmx_ops
>   with __no_sanitize_address is sufficient for kexec to
>   function properly with KASAN enabled
>
> v1:
> https://lore.kernel.org/all/20260321053121.614022-1-sourabhjain@linux.ibm.com/
> ---
>  arch/powerpc/lib/vmx-helper.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
> index 554b248002b4..57e897b60db8 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -52,7 +52,14 @@ int exit_vmx_usercopy(void)
>  }
>  EXPORT_SYMBOL(exit_vmx_usercopy);
>  
> -int enter_vmx_ops(void)
> +/*
> + * Can be called from kexec copy_page() path with MMU off. The kexec
> + * code sets preempt_count to HARDIRQ_OFFSET so we return early here.
> + * Since in_interrupt() is always inline, __no_sanitize_address on this
> + * function is sufficient to avoid KASAN shadow memory accesses in real
> + * mode.
> + */
> +int __no_sanitize_address enter_vmx_ops(void)
>  {
>  	if (in_interrupt())
>  		return 0;
> -- 
> 2.52.0

