Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A5C4338F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 09:50:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1331D60527
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 09:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1331D60527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GmJht2rfyz3bWc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Aug 2021 19:50:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=W2rEqQW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::1035;
 helo=mail-pj1-x1035.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=W2rEqQW+; dkim-atps=neutral
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GmJh61P5kz3bWJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Aug 2021 19:50:11 +1000 (AEST)
Received: by mail-pj1-x1035.google.com with SMTP id nt11so14508764pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Aug 2021 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=RAz/Im2O2D0PVJYzLw0GvtWHajffI0uko6BVtdR8kig=;
 b=W2rEqQW+usxN+AbT4yJeR+eFoGAbEaXrBkpYVDbqByhFW+KdAjLYQgy7xM7c80wIGk
 NZ9sJVV9LDiAfhMhjLdbLNr4zJLFAZaGsm3Ah/0xO+Zu+Km8F+F8ZXtgslo2Z6BIS2D7
 bRXHOFiqHcjNwt76sWp2Z3gRNI9VgIJOR009bPZzC3iYOue2oBzqiBpMS7n6C3XZWLTE
 SnaWg+S5WnJUxxG5z2fOjE/iLs2336z1pyrMucIE+jHhYfEg/hLPv7SSDYj2ZLEqmQRP
 7pdLpeP4oSHq75iirkmw4SQFJPRd4+HIJmQpqsMmo39vUMaXj+u6ZEYG8P+rdUN8k9T+
 /fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=RAz/Im2O2D0PVJYzLw0GvtWHajffI0uko6BVtdR8kig=;
 b=uLIUNQzbS/wzjheyKhQ2pGM3VhZTJC++xfLuXiBVclD9Ud7jvDFKhFChVZ7yAyMZ9n
 +lBWEqSYl217pjz6so5PUrwQ2wFpyYepsGTtEiyLfGI21YL/1dViik/r2SMOjoZWSbua
 Ot6HqYedbyAFLsMOtxn27NaFJ7ECpi+1zJMnw2RVaOW4/CWPg/KMat8Xf3tvylnWy5LD
 IrugVAK+fEV16TyabI24oz3Y6Fi8hnzbmBsis+hgIuWiaOjnnRQHdDKwHlmVkrHetdKJ
 l0OUMIKVR2SZqZIXX5DWp2ymTWS9UFemAin6b1CGy2zeql0N6jduUiOkOBpNXhb4RDm7
 YleA==
X-Gm-Message-State: AOAM533uN+EMXWI7h85yDpLzHGC9+uG06Rx342ebdpWdQGbtDmv3M9eS
 hv6Zju2TE/2NxaOmMjSSz4nVGQ==
X-Google-Smtp-Source: ABdhPJw5cyWuImWVnIxRZJhPAyC9HkG/H/PERXnp/EEW2ZTkpCJE1GhFPgK7fxh0A1Xld0XtU3NVjg==
X-Received: by 2002:a63:ed47:: with SMTP id m7mr1640554pgk.194.1628848209313; 
 Fri, 13 Aug 2021 02:50:09 -0700 (PDT)
Received: from [192.168.10.23] (219-90-184-65.ip.adam.com.au. [219.90.184.65])
 by smtp.gmail.com with UTF8SMTPSA id
 j6sm1937877pgq.0.2021.08.13.02.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Aug 2021 02:50:08 -0700 (PDT)
Message-ID: <be02290c-60a0-48af-0491-61e8a6d5b7b7@ozlabs.ru>
Date: Fri, 13 Aug 2021 19:50:04 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0
Subject: Re: [PATCH kernel] KVM: PPC: Book3S HV: Make unique debugfs nodename
Content-Language: en-US
To: Paul Mackerras <paulus@ozlabs.org>
References: <20210707041344.3803554-1-aik@ozlabs.ru>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210707041344.3803554-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 07/07/2021 14:13, Alexey Kardashevskiy wrote:
> Currently it is vm-$currentpid which works as long as there is just one
> VM per the userspace (99.99% cases) but produces a bunch
> of "debugfs: Directory 'vm16679' with parent 'kvm' already present!"
> when syzkaller (syscall fuzzer) is running so only one VM is present in
> the debugfs for a given process.
> 
> This changes the debugfs node to include the LPID which alone should be
> system wide unique. This leaves the existing pid for the convenience of
> matching the VM's debugfs with the running userspace process (QEMU).
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Looks like this is not enough as syzkaller still manages to cause the 
error message, I need more robust approach as in 
https://lore.kernel.org/patchwork/patch/1472025/  or   alternatively 
move this debugfs stuff under the platform-independent directory, how 
about that?


> ---
>   arch/powerpc/kvm/book3s_hv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 1d1fcc290fca..0223ddc0eed0 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -5227,7 +5227,7 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
>   	/*
>   	 * Create a debugfs directory for the VM
>   	 */
> -	snprintf(buf, sizeof(buf), "vm%d", current->pid);
> +	snprintf(buf, sizeof(buf), "vm%d-lp%ld", current->pid, lpid);
>   	kvm->arch.debugfs_dir = debugfs_create_dir(buf, kvm_debugfs_dir);
>   	kvmppc_mmu_debugfs_init(kvm);
>   	if (radix_enabled())
> 

-- 
Alexey
