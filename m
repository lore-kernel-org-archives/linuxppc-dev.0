Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DC60A2601
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gpq5lk6h
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGSKG5tdmz30Vd;
	Sat, 31 Oct 2026 04:10:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1236"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793380226;
	cv=none; b=OLkACXuxb47x5bq7hoI5fb65PYWkt2m/29FSl/LGT/lrkWhnUerPevgYxJeNK/ABmtoXXBYcBx0V9NbkTOoKqG+8po7b4bXVCDHr9dlcahmDZ8aCIkMTavLxfbeQlEl7X4aH7Whs7U8Xtsc1FKeWqQ5N3iriShmdUAcxcuYc/n+Iw44pK6TOw4c3x6skzdRgJ/0jXZ985Yygwd4WIOtFcPeb3KVdm8ntmRxSTDUnRRsNiB31q9VaEkevKv4d4RqFFbHB+VZnTZtooy2SGsHSuwbKtH84s5LBq9rid8EwLihCAKdBdLd6GG5ljUhu7QIiWbWwgFyjiIBTAqb2CQrWRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793380226; c=relaxed/relaxed;
	bh=RVLcv6zKH1BoTG3sQqbFYNoEzC22RlRRF312R8k02Ag=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=AE369IqFFWiElqiOr3osymGXMJJovzelvSv7s3127Q/fauX0PdiHDOF95ptfmL2GFLi1E9u6TNrsZ+awezCstDGPldmO+mDEzWL1D7RmWrmCHLBalrxLUcSw2yiXYGSbgLsjSY7pE5FVQCevF+dpWQNDHH9aNXl+NlfpFKmSlrLvh9cTEHMq3AHvij5S9203hCGGjzMglH5rYoG3BuYVn/bLJsdfL2K14MiZVhrfk9JYMxiErDAzKfNP3moNbVGpkm6e3WFTVOaxc5nwe8bSC/M+ji/yAr5mGuHbw8CUWx4nALF1CzQNDJVjmykOMcSf8SwMzlRvLbUgtYz8xR2luw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gpq5lk6h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gpq5lk6h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1236; helo=mail-dl1-x1236.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1236.google.com (mail-dl1-x1236.google.com [IPv6:2607:f8b0:4864:20::1236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGSK95zsHz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Oct 2026 04:10:21 +1100 (AEDT)
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1a3c08d6928so1208019c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 10:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380219; x=1793985019; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RVLcv6zKH1BoTG3sQqbFYNoEzC22RlRRF312R8k02Ag=;
        b=Gpq5lk6hlpTAtmtolBPpBydmZHV7dx3eSj8lKgrav+wBpD+vxh5RLJSX97S5CORY6e
         oJcbrnFWmNBTvvwofnhY6Hi3Q4r1sP+REuUQUMpWAKuTnPD7HvtjFUt4YOm28YDlqCBx
         8kP1Vc1kvNyFVwJ5hxkm46FeikZKTEVMqwp3xDJ0xoJJIMZeRddXRTYIAlbkTMoCEge7
         1z7ugTRDSmoiZSBMV9Qe0EbiAyLYJlmYBFd1I967xmSrj/fn4WseP+3qV42pr5c+lQCA
         EG1YfD90SDYUiInzgx5Y/mqvvEPmWm8z3Ph4D4yuK5Dwwd3i4cV10V2EE4nr7zpRNtUb
         oXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380219; x=1793985019;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVLcv6zKH1BoTG3sQqbFYNoEzC22RlRRF312R8k02Ag=;
        b=e/oZnFJ/DSjAgkSn0dJTvHnjiYzM79vsyIxlKw/Gv43jzM1JZzN8qbXr5Vw+GsNADB
         U41dx7YCJlTrO+se18yyM4YB5w+6xB0BM7x+MjsfX8wFROVr5xZX33E/Aqj0no4vtuGh
         s8xVnq/G7jBQBudgTE9o8jSMHIKYNhEVeS+EO6YTReR1VUE4U1Sa6geLu7iYQhVo6oQ6
         ZqokPIMRTPomaH274yfVci/845cnENoxCbkCPn1oClKMtIXJF//h3drg0b8R9qNtS45s
         lZykehKs+33efS/ct49zENQjgu2lqEE8kZDW+Q7wsKFdC5ygGA/4yG2G6E+ZaXESGZyh
         /OQg==
X-Forwarded-Encrypted: i=1; AKwUvBx9jrING/BTPO8hRUI82mceCi7gcXFHr9qAm/1wv7SfaPeqZ8t+3UpNMDQQ4Lzljy3mQpcII4XIApYdtdU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLK7eYkwyC50QpEJvd6OaUPl7ehP12gYjt+I5D2EKpAZXouZl4/
	FhOQ9I5HQKfKM1EPzp0HH1o1TbS87D7SGNbuqzilFcVJXs3MVHnXkUQJ
X-Gm-Gg: AYBFou3UWEAwlykYXBLSWPZdMUzIq7owcCS0HrZwkFWKCGAtHvcTBo4yaArfuzhVSMz
	BP5neBFlMaEUMxhUmSbPC4Rofye//mAO7+I+oXxV0Y07a353ws//RljvpWygwjBL8clXc75EluF
	0nRFrIdi/1h6BlfW8fdUK32CJq6vOEtcZy1XVOVH5Xi+iibwRWBPk3ol29LsYfz2iLYxy8arneT
	ZwXUUC0xluacJcfp1j3Ob3DHENdGzh/DlJFbI0VORDsOOhjtbUvn+7QGv96EhaMh6IqGHnwi4fJ
	B48aYU93F/A6u0td9UGBfHwDWcaY5yRO5RawNlhUycX1n07+4ZhAQWBJMW39t2jKR0hDcmVGdRV
	I7IhWCB+62T0AgWMk1qtff5Ieb+ISz61ISXuwINH0AtyV8O8YK21bVlIEjkG0PKZWZq2ECab22F
	0TzYZoiZ1QZZgASXSdK6z5tl1w5g9+4z2IsCipl+glcyo7tx0imlZPNbjOOV4AjQIJVpkHGuolM
	jt8tly5jNRK2rQ0BeNWICrLWhmxtnAnKrQe00n/oicsv6iLBbmuyR61JawZGGL3hK2dONQV5AsW
	/FYbt3owI6omoslupJU1neLrv3Y=
X-Received: by 2002:a05:7023:d0b:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1ac5de53bbdmr4084875c88.41.1793380219122;
        Fri, 30 Oct 2026 10:10:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac192c2e9dsm10616964c88.9.2026.10.30.10.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:10:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de, Vishal Chourasia <vishalc@linux.ibm.com>
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, msuchanek@suse.de, harshpb@linux.ibm.com, gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: Re: [PATCH 2/2] KVM: PPC: Replay pending interrupts before entering the guest
In-Reply-To: <20260928110411.844582-3-sshegde@linux.ibm.com>
Date: Fri, 30 Oct 2026 22:00:50 +0530
Message-ID: <zevvup51.ritesh.list@gmail.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com> <20260928110411.844582-3-sshegde@linux.ibm.com>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>


Hi Shrikanth,

Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> After applying preempt disable patch, i.e PATCH 1/2, Christian reported
> a subsequent warning stopping his board to boot properly.
>
> WARNING: at .kvmppc_fix_ee_before_entry+0x10/0x28, CPU#0: qemu-system-ppc/4667
> CPU: 0 UID: 1000 PID: 4667 Comm: qemu-system-ppc Tainted: G        W           7.3.0-rc4-2-powerpc64-smp #1 PREEMPT
> Tainted: [W]=WARN
> Hardware name: varisys,CYRUS5040 e5500 0x80240012 CoreNet Generic
> NIP [c00000000005dc3c] .kvmppc_fix_ee_before_entry+0x10/0x28
> LR [c00000000005f298] .kvmppc_handle_exit+0x5b4/0x5e8
> Call Trace:
> [c000000086587780] [c00000000005ee10] .kvmppc_handle_exit+0x12c/0x5e8 (unreliable)
> [c000000086587830] [c000000000062068] .kvmppc_resume_host+0xb8/0x10c
>
> It triggers below warning...
>
> static inline void kvmppc_fix_ee_before_entry(void)
> {
>         trace_hardirqs_on();
>
>         /*
>          * To avoid races, the caller must have gone directly from having
>          * interrupts fully-enabled to hard-disabled.
>          */
>         WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
>
> This happens since kvmppc_prepare_to_enter does first local_irq_disable
> followed by hard_irq_disable. This leaves a small window where interrupt
> may occur and it could set the irq pending bit in PACA. When that
> happens replay that interrupt before entering the guest.
>
> Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Closes: https://lore.kernel.org/all/b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/kvm/powerpc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..847ff07c364b 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>  			continue;
>  		}
>  
> +#ifdef CONFIG_PPC64
> +		/*
> +		 * Interrupt arrived between the soft and hard
> +		 * disable. Replay it and retry guest entry.
> +		 */
> +		if (unlikely(local_paca->irq_happened != PACA_IRQ_HARD_DIS)) {
> +			local_irq_enable();
> +			local_irq_disable();
> +			hard_irq_disable();
> +			continue;
> +		}
> +#endif
> +

I looked at the commit which causes this regression, I see there are few
more call sites which can hit the same WARN in kvmppc_fix_ee_before_entry().

So what I was thinking was - while we are at it - do you think we could
use the following helper instead of {local|hard}_irq_{disable|enable}()
pair and ...


/*
 * Hard disable interrupts before entering the guest.
 *
 * On 64-bit don't use local_irq_disable() here. It only soft-masks, so
 * an interrupt can still come in before we hard disable. That interrupt
 * gets marked pending in irq_happened and kvmppc_fix_ee_before_entry()
 * then throws it away. hard_irq_disable() clears MSR[EE] first and does
 * the irq tracing itself, so there's no such window.
 *
 * On 32-bit there is no soft mask and hard_irq_disable() doesn't do the
 * irq tracing, so use local_irq_disable().
 */
static inline void kvmppc_irq_disable_for_entry(void)
{
#ifdef CONFIG_PPC64
        hard_irq_disable();
#else
        local_irq_disable();
#endif
}

... and then update the other call sites too which the following commit
added - which can cause the WARN.
   Fixes: 12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")

Thoughts?

-ritesh

>  		guest_enter_irqoff();
>  		return 1;
>  	}
> -- 
> 2.52.0

