Return-Path: <SRS0=xfaR=NB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C038C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 08:35:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23936108F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 08:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C23936108F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GkR8h2lVJz3cTc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Aug 2021 18:35:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Vxow0MH4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::131;
 helo=mail-lf1-x131.google.com; envelope-from=sxwjean@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Vxow0MH4; dkim-atps=neutral
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GkR7p5LGdz3bYx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Aug 2021 18:34:14 +1000 (AEST)
Received: by mail-lf1-x131.google.com with SMTP id z20so2760934lfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Aug 2021 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=a6dGXjWO0NCC+0cj+bZFV+qIFXfEn1q96bp9PHM8gws=;
 b=Vxow0MH4iTUSKGYSfuLuIum/eTzzBI1YAPCzCfZXxGQz2BfVWTfRfbtBdl5j2FjJqX
 6qgD7BdR3wVR8R/uX/z0U7o9vI0u/Q6H/rBslZGQvz2Lm1pJXS4Ti70DucY+udnR48an
 Rl3/zOInosa4ev0POv5PVAA9rn6mQ+VHjFo51QlbE0aDlToVfvMIKgF2tbW+uneZWrxD
 3bGoTtwN/9cUzDDVeP2MgTLtH2LdvjJHtkDrgNnwUcWEBy9QEtIdCoOY2yzfUqkVk68z
 QKsYGmB9FxXsC3aeT31KhRpw7JvP/kNdlzPhb8L9/zor3BMwIq+ZVnTD992Xwlu69yx8
 g/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=a6dGXjWO0NCC+0cj+bZFV+qIFXfEn1q96bp9PHM8gws=;
 b=Ibq2s35HvsSXjDq2QDCGpjxHqyCpubkUATo08XTjjIcwsrHe0WyXfrRu6kl5NrmxgT
 FI5S4IKCbv0A+kK7jXDXJELglN6QXRoBn9HVZud8FGi7PQzFfc5H/kOGmGHgUtllukVd
 WQz5ZOm29oKrtGuuSi+Tl7z6fJ/38+TGQSYdnWR+EsKNtPbVIq7RHklN+PM5BPVs0LXV
 CskurHJNClnP/3NNJX4v+r1NAyJb5iyuMBTcw3r3pQZ2L4AYkgEQCkz7NYLtN3YDqgod
 gfX1UHw/TQU5ORhyf/CYfLufi2uylZLfxZT/6keKvqfBTUYy8HyvfcnAFa6p2VepaUPT
 o7Qw==
X-Gm-Message-State: AOAM531SYDMxxDfIn1MwWNzbbUbXUgQiZ50KqcZdzQL135c2Z9T2y9Y0
 SJ31ux88eRuzMU8FTk2DiSWfowfwzvow/xC4zPI=
X-Google-Smtp-Source: ABdhPJxlem10rUrgwQzm2KR3+POEFuLuoRZoBA7fkmY5PZ8qejYLtr7C/lo8nKg8cuZJ7R0kzYMu6r0f4ANGgsm9PVo=
X-Received: by 2002:ac2:4ed3:: with SMTP id p19mr20580652lfr.307.1628584450567; 
 Tue, 10 Aug 2021 01:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210807010239.416055-1-sxwjean@me.com>
 <20210807010239.416055-4-sxwjean@me.com>
 <dfd24c4a-c43f-912c-5876-f1cac704f336@csgroup.eu>
In-Reply-To: <dfd24c4a-c43f-912c-5876-f1cac704f336@csgroup.eu>
From: Xiongwei Song <sxwjean@gmail.com>
Date: Tue, 10 Aug 2021 16:33:44 +0800
Message-ID: <CAEVVKH972N2hT-WP=5p6GrYEdEV1DO=D0PJo24WZ9gMVgqzaWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] powerpc: Optimize register usage for dear register
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
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
Cc: ravi.bangoria@linux.ibm.com, Xiongwei Song <sxwjean@me.com>,
 oleg@redhat.com, npiggin@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, efremov@linux.com,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.ibm.com,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Aug 7, 2021 at 2:58 PM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 07/08/2021 =C3=A0 03:02, sxwjean@me.com a =C3=A9crit :
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > Create an anonymous union for dar and dear regsiters, we can reference
> > dear to get the effective address when CONFIG_4xx=3Dy or CONFIG_BOOKE=
=3Dy.
> > Otherwise, reference dar. This makes code more clear.
> >
> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   arch/powerpc/include/asm/ptrace.h   | 5 ++++-
> >   arch/powerpc/kernel/process.c       | 2 +-
> >   arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
> >   3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/a=
sm/ptrace.h
> > index c252d04b1206..fa725e3238c2 100644
> > --- a/arch/powerpc/include/asm/ptrace.h
> > +++ b/arch/powerpc/include/asm/ptrace.h
> > @@ -43,7 +43,10 @@ struct pt_regs
> >                       unsigned long mq;
> >   #endif
> >                       unsigned long trap;
> > -                     unsigned long dar;
> > +                     union {
> > +                             unsigned long dar;
> > +                             unsigned long dear;
> > +                     };
> >                       union {
> >                               unsigned long dsisr;
> >                               unsigned long esr;
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index f74af8f9133c..50436b52c213 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
> >           trap =3D=3D INTERRUPT_DATA_STORAGE ||
> >           trap =3D=3D INTERRUPT_ALIGNMENT) {
> >               if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> > -                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, reg=
s->esr);
> > +                     pr_cont("DEAR: "REG" ESR: "REG" ", regs->dear, re=
gs->esr);
> >               else
> >                       pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, re=
gs->dsisr);
> >       }
> > diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/=
ptrace/ptrace.c
> > index a222fd4d6334..7c7093c17c45 100644
> > --- a/arch/powerpc/kernel/ptrace/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> > @@ -373,6 +373,8 @@ void __init pt_regs_check(void)
> >                    offsetof(struct user_pt_regs, trap));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=3D
> >                    offsetof(struct user_pt_regs, dar));
> > +     BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=3D
> > +                  offsetof(struct user_pt_regs, dar));
>
> dar and dear are the same, so checking the same thing a second time is po=
intless.

Same reply as the patch 1.

Regards,
Xiongwei

>
> >       BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=3D
> >                    offsetof(struct user_pt_regs, dsisr));
> >       BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=3D
> >
