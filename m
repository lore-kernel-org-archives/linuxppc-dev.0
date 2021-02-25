Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E765AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 10:53:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E22E64EAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 10:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E22E64EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmV4W5XYFz3ckZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 21:52:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=JaY4tBNY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036;
 helo=mail-pj1-x1036.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=JaY4tBNY; dkim-atps=neutral
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DmV436BLCz30Mk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 21:52:35 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id c19so3266383pjq.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2021 02:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=D9ceHkRWopAfZY+M1nz75DyCbP32W8Pm3rrNwuMcCQQ=;
 b=JaY4tBNYjtKmCwBirMFUEBxaE7utPSyyL2dIFC9TM1sCLcbGTSqi4h9mviUPq9XvnZ
 VYjKfW5wcvqU+UJow9jioiDvmeyGXcLlaDG6LjNpA6pRH14qVrD49fW5Tozrv94qoBXm
 cdh7n9yFCo6BlrwZ1CSqx1v7ogEi6mcXfYKIE411pUN5n+KGT8jjX4OsNUhMEAySxCRG
 75cBLSmL7QotBIIIDHeZudbW9GHjHywLWE8DgtgX4jIMySN/Xi3foVnYsaU1hJTr7Wql
 AgWasVfJN2o+ZRJEe4H7NsQY7pOGbOnDRP/KEWlseJYc2yVAOULMVmT2+Av36Xoxc2/t
 tc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=D9ceHkRWopAfZY+M1nz75DyCbP32W8Pm3rrNwuMcCQQ=;
 b=ILIT0K7YKB6ccXAqlDjnh4cMUri2/C0xgQvvlUYZbVgx7jh4OCv8dZYSTVKkVilsO2
 +in2nGVO8oxfXeZe01PuXGUkEV+l1D4WZcuUWCqOlnuKsyvP9rX8ffL7OQbsjIxBX/B3
 uQWoMBZr1rVwIaulVhjrNgwjs9UBDyFqfFRFVbTDcQgmcnFZHOKynpc/v2iW0Bk3WIDx
 yk4Tjr1kxf6SG1QcAejIYM/zfdJkWiwU/xkOpnD4Lxt0Ne6gojdtvOvGSl22o4s5UV2n
 eYtdyLVq5UQAGi+kYKyyXVvkV00iIUksH/YVTkzsDj1Wkhe8khohqWrbkfUgISyshyin
 XTMA==
X-Gm-Message-State: AOAM532k2GRTC0kn9Aaz1bx9kvQOK6dV/ROCgwA3KTzM+SPXR2CFaKgh
 GX3MbL7+655NFPsnUXH6S8U=
X-Google-Smtp-Source: ABdhPJz2SpAMWHJwuwceLTjQOTEJerL2MfQ7sD1wVgIxUmkxwbmrwXrAjBKcLZ6Y9KUSxfUBP3oLSA==
X-Received: by 2002:a17:902:e551:b029:de:8dba:84a3 with SMTP id
 n17-20020a170902e551b02900de8dba84a3mr2637711plf.8.1614250352254; 
 Thu, 25 Feb 2021 02:52:32 -0800 (PST)
Received: from localhost (58-6-239-121.tpgi.com.au. [58.6.239.121])
 by smtp.gmail.com with ESMTPSA id j1sm5858952pjf.26.2021.02.25.02.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Feb 2021 02:52:31 -0800 (PST)
Date: Thu, 25 Feb 2021 20:52:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/syscall: Force inlining of
 __prep_irq_for_enabled_exit()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
In-Reply-To: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1614250330.9u6pqclx87.astroid@bobo.none>
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

Excerpts from Christophe Leroy's message of February 24, 2021 4:34 pm:
> As reported by kernel test robot, a randconfig with high amount of
> debuging options can lead to build failure for undefined reference
> to replay_soft_interrupts() on ppc32.
>=20
> This is due to gcc not seeing that __prep_irq_for_enabled_exit()
> always returns true on ppc32 because it doesn't inline it for
> some reason.
>=20
> Force inlining of __prep_irq_for_enabled_exit() to fix the build.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Fixes: 344bb20b159d ("powerpc/syscall: Make interrupt.c buildable on PPC3=
2")
> ---
>  arch/powerpc/kernel/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 398cd86b6ada..2ef3c4051bb9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -149,7 +149,7 @@ notrace long system_call_exception(long r3, long r4, =
long r5,
>   * enabled when the interrupt handler returns (indicating a process-cont=
ext /
>   * synchronous interrupt) then irqs_enabled should be true.
>   */
> -static notrace inline bool __prep_irq_for_enabled_exit(bool clear_ri)
> +static notrace __always_inline bool __prep_irq_for_enabled_exit(bool cle=
ar_ri)
>  {
>  	/* This must be done with RI=3D1 because tracing may touch vmaps */
>  	trace_hardirqs_on();
> --=20
> 2.25.0
>=20
>=20
