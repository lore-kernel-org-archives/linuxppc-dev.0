Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B54C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:27:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5290C61364
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5290C61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1Pr51zqTz308y
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:27:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=K61ueDjS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b;
 helo=mail-pg1-x52b.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=K61ueDjS; dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Pqd4Kyyz3063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 12:26:53 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id n12so1225856pgs.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 19:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=lASTtq1Plgoc+ovhi4JOG1rfLsoGZjNrlYTsEEjYDG0=;
 b=K61ueDjSmueJf2vK4kFVHQCzp0Dvw8cjL2wfSEmQyqBUPzXDee40g1LkClHwz1mP6d
 0AhqiPiRi1Ho6DVPEthY60ui8J3uLjmtzs7HRtAjG3KNtSKGw2VyjD69nIvppeooF8QN
 VgWQmCwGNWdWHSsZq+0bPwqsSb8RGGHG92h+PFYiFzWPFFuWyzOrJDvANwNb4PKQoV3l
 ZbmWGT5vdBHOvmpQ3yGzTNmk7afgFkrcYUMOdTyRhwRPmgJ4NbFaIfXqcBXCSikAao9t
 Ot88l7OrYPbTVwpim6V4Ju+NxUdsqS2Fy3MMJgC4h9BjFpyXycH5PAlOZRlBUJb1zh4E
 7hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=lASTtq1Plgoc+ovhi4JOG1rfLsoGZjNrlYTsEEjYDG0=;
 b=iwwQiGp3HzfP/PbGp1dgnygBAR8iYdZgr/G/1cCLgAj32Jr+5iBFxRhYu+z+qb2DDf
 SqJ/K19gxgGcO10D6UO66RyYFMKGdwYvw5jwg+qwlPgBWHZtANvpx+EOkG/FYynbQu/D
 bcAtcSmy1rohhuqEiQKEIw59tbL+vqqj8x7CbFAme+eSCpx104+eOYYCZJOk+qnjzjIZ
 NQMybkilARU/k9F/iIZniLg83i5tCyNMUoYPhxrnFu0U8cFppjrxhW44/1y1oWRfVqhQ
 96ABVVsHsAPZPICWLeehDJNPcySIN+MLkVYyRvA5iFMgJc5gJiFCXYglRidhtb2Az5T6
 iogg==
X-Gm-Message-State: AOAM5308eGYQQRvEFjJ+nB9qRS4Xf0m9JRObCxdKxuEevcPkVi8UculP
 1W5oV+WiHk7LbYPDGC+/HAQ=
X-Google-Smtp-Source: ABdhPJz2tV0ph+NxM9/a/7THrV3jaVL5c9vIoPxWJJOJm9S4gqc245s1G+wsmXH5V0BLXDlr2QPUzA==
X-Received: by 2002:a63:1a0e:: with SMTP id a14mr1312701pga.294.1623378410394; 
 Thu, 10 Jun 2021 19:26:50 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id f3sm8237202pjo.3.2021.06.10.19.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 19:26:49 -0700 (PDT)
Date: Fri, 11 Jun 2021 12:26:44 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/interrupt: Interchange
 prep_irq_for_{kernel_enabled/user}_exit()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623378363.09q00gd3lj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Christophe Leroy's message of June 5, 2021 12:56 am:
> prep_irq_for_user_exit() is a superset of
> prep_irq_for_kernel_enabled_exit(). In order to allow refactoring in
> following patch, interchange the two as prep_irq_for_user_exit() will
> call prep_irq_for_kernel_enabled_exit().
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> This series applies on top of Nic's series to speed up interrupt return o=
n 64s

Thanks for rebasing it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
>  arch/powerpc/kernel/interrupt.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 74c995a42399..539455c62c5b 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -40,33 +40,27 @@ static inline bool exit_must_hard_disable(void)
>  #endif
> =20
>  /*
> - * local irqs must be disabled. Returns false if the caller must re-enab=
le
> - * them, check for new work, and try again.
> - *
> - * This should be called with local irqs disabled, but if they were prev=
iously
> - * enabled when the interrupt handler returns (indicating a process-cont=
ext /
> - * synchronous interrupt) then irqs_enabled should be true.
> + * restartable is true then EE/RI can be left on because interrupts are =
handled
> + * with a restart sequence.
>   */
> -static notrace __always_inline bool prep_irq_for_user_exit(void)
> +static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(boo=
l restartable)
>  {
> -	user_enter_irqoff();
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> =20
>  #ifdef CONFIG_PPC32
>  	__hard_EE_RI_disable();
>  #else
> -	if (exit_must_hard_disable())
> +	if (exit_must_hard_disable() || !restartable)
>  		__hard_EE_RI_disable();
> =20
>  	/* This pattern matches prep_irq_for_idle */
>  	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable()) {
> +		if (exit_must_hard_disable() || !restartable) {
>  			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
>  			__hard_RI_enable();
>  		}
>  		trace_hardirqs_off();
> -		user_exit_irqoff();
> =20
>  		return false;
>  	}
> @@ -75,27 +69,33 @@ static notrace __always_inline bool prep_irq_for_user=
_exit(void)
>  }
> =20
>  /*
> - * restartable is true then EE/RI can be left on because interrupts are =
handled
> - * with a restart sequence.
> + * local irqs must be disabled. Returns false if the caller must re-enab=
le
> + * them, check for new work, and try again.
> + *
> + * This should be called with local irqs disabled, but if they were prev=
iously
> + * enabled when the interrupt handler returns (indicating a process-cont=
ext /
> + * synchronous interrupt) then irqs_enabled should be true.
>   */
> -static notrace __always_inline bool prep_irq_for_kernel_enabled_exit(boo=
l restartable)
> +static notrace __always_inline bool prep_irq_for_user_exit(void)
>  {
> +	user_enter_irqoff();
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> =20
>  #ifdef CONFIG_PPC32
>  	__hard_EE_RI_disable();
>  #else
> -	if (exit_must_hard_disable() || !restartable)
> +	if (exit_must_hard_disable())
>  		__hard_EE_RI_disable();
> =20
>  	/* This pattern matches prep_irq_for_idle */
>  	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable() || !restartable) {
> +		if (exit_must_hard_disable()) {
>  			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
>  			__hard_RI_enable();
>  		}
>  		trace_hardirqs_off();
> +		user_exit_irqoff();
> =20
>  		return false;
>  	}
> --=20
> 2.25.0
>=20
>=20
