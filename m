Return-Path: <SRS0=S6eX=NK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA9DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:50:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5ED610E6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA5ED610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gr0PG2HWCz3cYZ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Aug 2021 19:50:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=X2xgmIDb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2a;
 helo=mail-yb1-xb2a.google.com; envelope-from=lukas.bulwahn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=X2xgmIDb; dkim-atps=neutral
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gr0NV2nxLz2xbB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 19:49:29 +1000 (AEST)
Received: by mail-yb1-xb2a.google.com with SMTP id z18so11211202ybg.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2021 02:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=baqn3nFJ4OCTZu2mfJfEIksHZD7gejF7HwEVWCcEoaQ=;
 b=X2xgmIDbeZp2Ko+ImEdETlccj2ISP/5yZyWVeEyyC8OZGhekNYG0ut5Vh3rGFyfYQa
 +vO7O1JJx06Yk9j173yO72pZXd06vbqAPCGzPssRgjTqIMvY5kn45zdttUsWTZjBD5O/
 kyYzC0Op2LAQ2xwaFeOmvIKD1TRVaohPIcWTJBx73Su8V609yIcxQSr5ktow/HUEeel8
 hxHKEAyyM3OZvKOIYHuXgFaEO3AUHMzvGEMJQdL7e1LJaVUm51o4L+vFvzUkVmJw9XP/
 d+VtaPaljEyDiVPyQQNRPdK2A8PFiY5PzvbMTeu0F1gG/4cg7T3dMqHvshTsHcNUAx9G
 dRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=baqn3nFJ4OCTZu2mfJfEIksHZD7gejF7HwEVWCcEoaQ=;
 b=MvLtJgx214/+c1mYRHvA3GmmNbS0ovoL38tvtvKFwZymkVovbuhLeC528pBbQ3os75
 ARtDbuwMajjyif+zxMVS2E9x+MEGScm1xVyoVK/he1SK+CwhIl5sLoaNAyHvnqhLy7Fo
 lRHV2Ju2FZbFqasm4vFNhqTUWkyWHaahO+oBUQk8UUMk8sMaduJ7sXSbgcof3QsvaIHR
 0DSHqqTyY4sfRHsUct8oFrejvevUJHXUW8ejL5g9uxyQt5CLBOU/2x/nxwDcCgtrdDti
 awQgW1ZWWcmv8Rla8OlQmsMSr7i1RhwkLwxKHXUu8SRVfFIt9EKz1pTnOf7DJ41aqTDw
 FjbA==
X-Gm-Message-State: AOAM533H35rjGsyWoZYriz+faeH+OSiPLtyHwv84nsYZwGA8WvPts1hl
 duNPuxPB8DBhG6g9tPXIDyKZBtR55KzSYu3o6mA=
X-Google-Smtp-Source: ABdhPJyvT3ptpUVFYprs2pXgbIQba2dfM+Mw9N3mgrKFKcuQJ7PSyA/LCEE8nGZkk6PYfyVA1GcRstI/+e3gEonQqvw=
X-Received: by 2002:a25:3046:: with SMTP id w67mr17605524ybw.134.1629366564492; 
 Thu, 19 Aug 2021 02:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819093226.13955-1-lukas.bulwahn@gmail.com>
 <20210819093226.13955-2-lukas.bulwahn@gmail.com>
 <475fa73c-5eef-a60c-c70f-9f6ea7a079d8@csgroup.eu>
In-Reply-To: <475fa73c-5eef-a60c-c70f-9f6ea7a079d8@csgroup.eu>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Thu, 19 Aug 2021 11:49:20 +0200
Message-ID: <CAKXUXMww0jcqdonHLdajQaPRR2Ru6OVMFd+99r55XUEin6Nv=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: kvm: rectify selection to PPC_DAWR
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
Cc: Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 kernel-janitors <kernel-janitors@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, linux- stable <stable@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 19, 2021 at 11:45 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 19/08/2021 =C3=A0 11:32, Lukas Bulwahn a =C3=A9crit :
> > Commit a278e7ea608b ("powerpc: Fix compile issue with force DAWR")
> > selects the non-existing config PPC_DAWR_FORCE_ENABLE for config
> > KVM_BOOK3S_64_HANDLER. As this commit also introduces a config PPC_DAWR=
,
> > it probably intends to select PPC_DAWR instead.
> >
> > Rectify the selection in config KVM_BOOK3S_64_HANDLER to PPC_DAWR.
> >
> > The issue was identified with ./scripts/checkkconfigsymbols.py.
> >
> > Fixes: a278e7ea608b ("powerpc: Fix compile issue with force DAWR")
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >   arch/powerpc/kvm/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
> > index e45644657d49..aa29ea56c80a 100644
> > --- a/arch/powerpc/kvm/Kconfig
> > +++ b/arch/powerpc/kvm/Kconfig
> > @@ -38,7 +38,7 @@ config KVM_BOOK3S_32_HANDLER
> >   config KVM_BOOK3S_64_HANDLER
> >       bool
> >       select KVM_BOOK3S_HANDLER
> > -     select PPC_DAWR_FORCE_ENABLE
> > +     select PPC_DAWR
>
> That's useless, see https://elixir.bootlin.com/linux/v5.14-rc6/source/arc=
h/powerpc/Kconfig#L267
>
> In arch/powerpc/Kconfig, you already have:
>
>         select PPC_DAWR                         if PPC64
>

Ah, I see. Then, it is just a needless and non-effective select here,
and then select can be deleted completely.

I will send a patch series v2.

Lukas
