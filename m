Return-Path: <SRS0=aOOO=IS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4B1C433C1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 09:08:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BC26197E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 09:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC26197E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F2Zg20QK3z3c0C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Mar 2021 20:08:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=snN3tVHS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::633;
 helo=mail-pl1-x633.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=snN3tVHS; dkim-atps=neutral
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F2ZfX0pqpz300T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 20:07:44 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id t20so4054500plr.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Mar 2021 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=bXKKCKnz/33aAei7zUlJGr2xMyWZ9KodS3FoI2Gsia4=;
 b=snN3tVHSqTWGJQIiCP/UTPKWnguOwN1n3tRbrw4J9wqgSBZ2ogRAuvponaYotPLrys
 E/qEW8KWKDsRmfRzNGdrc6YqU9bv9aqqe80d4uXZSplDOVRhWWMDUby5sqJHK2s/jVNZ
 n8lDusSFQd6o6rrXCinufXdoy6iRtuFo0Zuf4kye/1PmFbwq4UB/SSXSlm3GBmCDrNyn
 9aBAyYAN2wHSSCdQXjxsGe8ObCwQqJ0/oeszpKVzVGz0/Tkbo5UUN3gVxRmm2tpVaLk3
 +Db4s/QbKtTdb1zrKiWvwpXfeh95hKjYjfkwbdJ5XNMs0rwNCsqmCTsuZ4hzX25ZEX2U
 FTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=bXKKCKnz/33aAei7zUlJGr2xMyWZ9KodS3FoI2Gsia4=;
 b=U+JksSCg0W0ZzVQeM3tAYByD2IU2hLVTCcWkcZ01gruiplCrBbbSgNP40JDNJ/fqpE
 XKf7xPi0lUeZqtokeng4VqIM0rnhEGZkLxSf+L0Fv/w9AkYvHiOQNSTjalNCDM6P8S0+
 BSO/Qk8TsZfTTVM224DvsAwJYA8w572wWj8/UX3JBpl1vJBajM6MAwYPJqpJV1XJGu9E
 t+h26GBUuJHC4j42D89AE9VxqVTGhaGuLvwV0OaRYooQ6lrjrSm9vX7LTFjzuAHRoz55
 mGW7PYLx9z0KnTajQLgWWSv4Ycx/oDOxAvUAvqePWjcRANPgowpLwiEZbXmnjrfGafyW
 ynkg==
X-Gm-Message-State: AOAM531s19ozES/Fw/9CFqEBv6bb0u0SPwCJ0EvwIbOrzFNomUYhSJW+
 7j1Kwj12hkaDfg0NXMHPoVd6D0ipin7aEG4W
X-Google-Smtp-Source: ABdhPJxOSI1SGW4UP6cRyzkQzxM3OHVzn049dE5cOy6QTjHTlSzgr+RYPwVLLFba9uvnq3aQtfbxIA==
X-Received: by 2002:a17:90a:df91:: with SMTP id
 p17mr2704648pjv.23.1616231256476; 
 Sat, 20 Mar 2021 02:07:36 -0700 (PDT)
Received: from [192.168.10.23] (124-171-107-241.dyn.iinet.net.au.
 [124.171.107.241])
 by smtp.gmail.com with UTF8SMTPSA id gm9sm7333749pjb.13.2021.03.20.02.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Mar 2021 02:07:35 -0700 (PDT)
Message-ID: <1f68b37c-7167-30d7-ee19-f6ebc69bd4a6@ozlabs.ru>
Date: Sat, 20 Mar 2021 20:07:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Subject: Re: [PATCH v3 14/41] KVM: PPC: Book3S 64: move bad_host_intr check to
 HV handler
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
References: <20210305150638.2675513-1-npiggin@gmail.com>
 <20210305150638.2675513-15-npiggin@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <20210305150638.2675513-15-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 06/03/2021 02:06, Nicholas Piggin wrote:
> This is not used by PR KVM.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

a small tote - it probably makes sense to move this before 09/41 as this 
one removes what 09/41 added to book3s_64_entry.S. Thanks,


> ---
>   arch/powerpc/kvm/book3s_64_entry.S      | 3 ---
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S | 4 +++-
>   arch/powerpc/kvm/book3s_segment.S       | 7 +++++++
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3s_64_entry.S
> index d06e81842368..7a6b060ceed8 100644
> --- a/arch/powerpc/kvm/book3s_64_entry.S
> +++ b/arch/powerpc/kvm/book3s_64_entry.S
> @@ -78,11 +78,8 @@ do_kvm_interrupt:
>   	beq-	.Lmaybe_skip
>   .Lno_skip:
>   #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
> -	beq	kvmppc_bad_host_intr
>   #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>   	cmpwi	r9,KVM_GUEST_MODE_GUEST
> -	ld	r9,HSTATE_SCRATCH2(r13)
>   	beq	kvmppc_interrupt_pr
>   #endif
>   	b	kvmppc_interrupt_hv
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index f976efb7e4a9..75405ef53238 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1265,6 +1265,7 @@ hdec_soon:
>   kvmppc_interrupt_hv:
>   	/*
>   	 * Register contents:
> +	 * R9		= HSTATE_IN_GUEST
>   	 * R12		= (guest CR << 32) | interrupt vector
>   	 * R13		= PACA
>   	 * guest R12 saved in shadow VCPU SCRATCH0
> @@ -1272,6 +1273,8 @@ kvmppc_interrupt_hv:
>   	 * guest R9 saved in HSTATE_SCRATCH2
>   	 */
>   	/* We're now back in the host but in guest MMU context */
> +	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
> +	beq	kvmppc_bad_host_intr
>   	li	r9, KVM_GUEST_MODE_HOST_HV
>   	stb	r9, HSTATE_IN_GUEST(r13)
>   
> @@ -3272,7 +3275,6 @@ END_FTR_SECTION_IFCLR(CPU_FTR_P9_TM_HV_ASSIST)
>    * cfar is saved in HSTATE_CFAR(r13)
>    * ppr is saved in HSTATE_PPR(r13)
>    */
> -.global kvmppc_bad_host_intr
>   kvmppc_bad_host_intr:
>   	/*
>   	 * Switch to the emergency stack, but start half-way down in
> diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
> index 1f492aa4c8d6..ef1d88b869bf 100644
> --- a/arch/powerpc/kvm/book3s_segment.S
> +++ b/arch/powerpc/kvm/book3s_segment.S
> @@ -167,8 +167,15 @@ kvmppc_interrupt_pr:
>   	 * R12             = (guest CR << 32) | exit handler id
>   	 * R13             = PACA
>   	 * HSTATE.SCRATCH0 = guest R12
> +	 *
> +	 * If HV is possible, additionally:
> +	 * R9              = HSTATE_IN_GUEST
> +	 * HSTATE.SCRATCH2 = guest R9
>   	 */
>   #ifdef CONFIG_PPC64
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	ld	r9,HSTATE_SCRATCH2(r13)
> +#endif
>   	/* Match 32-bit entry */
>   	rotldi	r12, r12, 32		  /* Flip R12 halves for stw */
>   	stw	r12, HSTATE_SCRATCH1(r13) /* CR is now in the low half */
> 

-- 
Alexey
