Return-Path: <SRS0=JEJ8=7P=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A2C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 06:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88432077D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 06:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9F/7sic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88432077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49bht91FQNzDqVk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2020 16:27:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::343;
 helo=mail-ot1-x343.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=f9F/7sic; dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49bhrV4lCJzDqJK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2020 16:26:18 +1000 (AEST)
Received: by mail-ot1-x343.google.com with SMTP id u23so10047125otq.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2020 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RmMIqc5cke45a5Qr22iA05nvgiFpVERb+wjHqaLOWS4=;
 b=f9F/7sicUsscj/Rtu2eJka5s47NWAEYHkny+GJ57RnSOcrplxhdLGv7CxpQ+/8jxy8
 KFcZNZRA6Rjpe+VeSkfuYUJnwtFX0B4atncirqabAm6eXhgzyea2uhmnnjbijh6edUmc
 tQNviprjwQcaoxQ2Sfg52sih6ADGGlSVO1M6UN3dUo6QKvsTPg5X/eE9O45B+u8aYY86
 Dhmmu4BDiQrXc7so4+aPb/1v+Ff/c/UWvnCazkjtLIfjQumUYUzD06CVMHU9MRhHgLK8
 l3F4Ho4nk7CqeiYljIWVPBIGLhWhE6HHYSsTa3eGjE3lYLEst3Ng0DOveD6ql7BGnsez
 k7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RmMIqc5cke45a5Qr22iA05nvgiFpVERb+wjHqaLOWS4=;
 b=qRFB146g9TV7qNjOxaHNXRoN+WtLbj8/br7qZ9t+oyMuWoMpdyk5r8qz7N3odMlmGO
 V8BHBiGFLwWYdo0iznwKwySCVRaXPd2dpEVZ7vbPVbF/2REKcpXdTZrqD/UPOeMJ++JV
 9eES+paZKgggK90SVtm9lJFd1jB9N6Uk7YUY7YKkE6b1ljfRjoQrJ+QUIJDGT384GFLG
 nXyCMO5PfNiRQpOEMGqlgO9sqNSpb58RETB9UgK1sZwB5aWRjulO01vtxMb9awbTvAhU
 t9C7EMFei4gFgk/QytO4rCxaTnh2lIOwgHsgtc1U+AEA4jszHcoSvB7K7TShoksgudgR
 /B1A==
X-Gm-Message-State: AOAM531AHPQJLL955L0ja95908pjJH53RYePkRyboQtNBUdY3Ue+7Hiq
 qOxYuesZvLOVh4XuO1Kq1BEc2YzZxc3RkEp3x58=
X-Google-Smtp-Source: ABdhPJwLfN+rTeFBH3QN5TVTEDbOh42l01S5Bcsq2qaoyfsZOc+3zSbodmzScIgSorVB97tEgUXj42UorMECv+uIaoI=
X-Received: by 2002:a9d:2046:: with SMTP id n64mr18892998ota.51.1591079175154; 
 Mon, 01 Jun 2020 23:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200602055325.6102-1-alistair@popple.id.au>
In-Reply-To: <20200602055325.6102-1-alistair@popple.id.au>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 2 Jun 2020 16:26:03 +1000
Message-ID: <CACzsE9proNZDwZMHLRouajYJo6f7Y_obm5pfNniSvvLXRLZsPQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kvm: Enable support for ISA v3.1 guests
To: Alistair Popple <alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
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
Cc: ravi.bangoria@linux.ibm.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 2, 2020 at 3:55 PM Alistair Popple <alistair@popple.id.au> wrote:
>
> Adds support for emulating ISAv3.1 guests by adding the appropriate PCR
> and FSCR bits.
>
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/include/asm/reg.h |  1 +
>  arch/powerpc/kvm/book3s_hv.c   | 11 ++++++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 773f76402392..d77040d0588a 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1348,6 +1348,7 @@
>  #define PVR_ARCH_206p  0x0f100003
>  #define PVR_ARCH_207   0x0f000004
>  #define PVR_ARCH_300   0x0f000005
> +#define PVR_ARCH_31    0x0f000006
>
>  /* Macros for setting and retrieving special purpose registers */
>  #ifndef __ASSEMBLY__
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 93493f0cbfe8..359bb2ed43e1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -345,7 +345,7 @@ static void kvmppc_set_pvr_hv(struct kvm_vcpu *vcpu, u32 pvr)
>  }
>
>  /* Dummy value used in computing PCR value below */
> -#define PCR_ARCH_300   (PCR_ARCH_207 << 1)
> +#define PCR_ARCH_31    (PCR_ARCH_300 << 1)
>
>  static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  {
> @@ -353,7 +353,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>         struct kvmppc_vcore *vc = vcpu->arch.vcore;
>
>         /* We can (emulate) our own architecture version and anything older */
> -       if (cpu_has_feature(CPU_FTR_ARCH_300))
> +       if (cpu_has_feature(CPU_FTR_ARCH_31))
> +               host_pcr_bit = PCR_ARCH_31;
> +       else if (cpu_has_feature(CPU_FTR_ARCH_300))
>                 host_pcr_bit = PCR_ARCH_300;
>         else if (cpu_has_feature(CPU_FTR_ARCH_207S))
>                 host_pcr_bit = PCR_ARCH_207;
> @@ -379,6 +381,9 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>                 case PVR_ARCH_300:
>                         guest_pcr_bit = PCR_ARCH_300;
>                         break;
> +               case PVR_ARCH_31:
> +                       guest_pcr_bit = PCR_ARCH_31;
> +                       break;
>                 default:
>                         return -EINVAL;
>                 }
> @@ -2318,7 +2323,7 @@ static int kvmppc_core_vcpu_create_hv(struct kvm_vcpu *vcpu)
>          * to trap and then we emulate them.
>          */
The comment above this:
"...
     * Set the default HFSCR for the guest from the host value.
     * This value is only used on POWER9..."
would need to be updated.
>         vcpu->arch.hfscr = HFSCR_TAR | HFSCR_EBB | HFSCR_PM | HFSCR_BHRB |
> -               HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP;
> +               HFSCR_DSCR | HFSCR_VECVSX | HFSCR_FP | HFSCR_PREFIX;
>         if (cpu_has_feature(CPU_FTR_HVMODE)) {
>                 vcpu->arch.hfscr &= mfspr(SPRN_HFSCR);
>                 if (cpu_has_feature(CPU_FTR_P9_TM_HV_ASSIST))
> --
> 2.20.1
>
