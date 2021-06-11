Return-Path: <SRS0=pFgb=LF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5E3C48BD1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:31:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C542461285
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 02:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C542461285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G1PwT6Nvgz3c1s
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jun 2021 12:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=DpdK8nFi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029;
 helo=mail-pj1-x1029.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DpdK8nFi; dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G1Pw13yRfz3063
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jun 2021 12:30:39 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id ei4so4820723pjb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jun 2021 19:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=e5K1WutpQ4ryjeQEihlJkVsIbkqUeWrgN2WO92sXGZM=;
 b=DpdK8nFit9zJKc3vGDOsEhXvWZneuG0L6UNjz9r3fmVqhTLU4dnCqJI6xxbnq8MKHI
 tVyWV97fRO7s2J2S+U1Yc+6TRH4+8wRl+g0UqNmG5K2W04pojtCFKuKJMzSeelwCUJv3
 KgE5zrTItICTaeUSUe/vbGSZ2EetRqp3QPaxF5hT1pmlYG7mfR3kLDnbr+CHf0NmhcX/
 kqlqsTvbZwGDeqjUbKKLPQenUSLAkEm0MZsvVpZ0yiRT6JqcEAwrYPs6YDzsK45JdUQd
 H9inz2DX3Hf72c0Chfz9tiALQQrqqtyxqtU0ZoOMgXGnK/7xSTn2YputnZ9bJEcSOTZ/
 c6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=e5K1WutpQ4ryjeQEihlJkVsIbkqUeWrgN2WO92sXGZM=;
 b=HM2DvtqKP98vdGfrGKjAmAIFoneR51wZe1FO7ZyuMtW9w+BiSaCP8aJKemeZAtnalX
 b04odsUZgvJxmq3xCyH4/SNLv0ZhZM4aP8J4G08f7NOSci2VXl4AwCSvdYbeE70Uk+qQ
 63Hr69ua3zGlu2IxpupRC4zk3IvtliL9Sf7sWHYJp56YUCKPo1K+o2o7KK8qGErctvhQ
 XaT0iMxQUdjSZ/C2K8esTC0B5C+IrJdAUYi+i/NxjMI6jvVbaLKWcK7Ovk0brzs864sK
 GNsHlrHmQLrlJdDi8q1MXWol54IWTI0W6pc8Qn+TT3uh4w/00a/T7VbIWqZRJV5lzFsD
 zxRg==
X-Gm-Message-State: AOAM530eB+X2DsqwrFKM6re132LVPXCMBSe3ICWLCRN9vpGQGix20roE
 ojauUZiBOcg1RkGNj8SXHXc=
X-Google-Smtp-Source: ABdhPJxaL9tsPBJ3ab510EBcjK/c2Pq5L6EHhqrAf9vODjJkZ852MryO6R/xO90ntmz424S6Wxx8Cg==
X-Received: by 2002:a17:90b:503:: with SMTP id
 r3mr1975950pjz.195.1623378636861; 
 Thu, 10 Jun 2021 19:30:36 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
 by smtp.gmail.com with ESMTPSA id k136sm3593681pfd.87.2021.06.10.19.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 19:30:36 -0700 (PDT)
Date: Fri, 11 Jun 2021 12:30:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/4] powerpc/interrupt: Refactor
 prep_irq_for_user_exit()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
 <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
In-Reply-To: <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1623378421.ayihg84s3a.astroid@bobo.none>
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
> prep_irq_for_kernel_enabled_exit().
>=20
> Refactor it.

I like the refactoring, but now prep_irq_for_user_exit() is calling=20
prep_irq_for_kernel_enabled_exit(), which seems like the wrong naming.

You could re-name prep_irq_for_kernel_enabled_exit() to
prep_irq_for_enabled_exit() maybe? Or it could be=20
__prep_irq_for_enabled_exit() then prep_irq_for_kernel_enabled_exit()
and prep_irq_for_user_exit() would both call it.

Otherwise

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/interrupt.c | 25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 539455c62c5b..b6aa80930733 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -78,29 +78,14 @@ static notrace __always_inline bool prep_irq_for_kern=
el_enabled_exit(bool restar
>   */
>  static notrace __always_inline bool prep_irq_for_user_exit(void)
>  {
> -	user_enter_irqoff();
> -	/* This must be done with RI=3D1 because tracing may touch vmaps */
> -	trace_hardirqs_on();
> -
> -#ifdef CONFIG_PPC32
> -	__hard_EE_RI_disable();
> -#else
> -	if (exit_must_hard_disable())
> -		__hard_EE_RI_disable();
> +	bool ret;
> =20
> -	/* This pattern matches prep_irq_for_idle */
> -	if (unlikely(lazy_irq_pending_nocheck())) {
> -		if (exit_must_hard_disable()) {
> -			local_paca->irq_happened |=3D PACA_IRQ_HARD_DIS;
> -			__hard_RI_enable();
> -		}
> -		trace_hardirqs_off();
> +	user_enter_irqoff();
> +	ret =3D prep_irq_for_kernel_enabled_exit(true);
> +	if (!ret)
>  		user_exit_irqoff();
> =20
> -		return false;
> -	}
> -#endif
> -	return true;
> +	return ret;
>  }
> =20
>  /* Has to run notrace because it is entered not completely "reconciled" =
*/
> --=20
> 2.25.0
>=20
>=20
