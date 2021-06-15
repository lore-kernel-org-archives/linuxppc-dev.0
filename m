Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7EAC48BE5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 03:48:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0017F613DE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 03:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0017F613DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3vRq27DQz30J6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:48:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=Mg+8v23p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b32;
 helo=mail-yb1-xb32.google.com; envelope-from=jniethe5@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Mg+8v23p; dkim-atps=neutral
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3vRJ6jrdz2yYQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 13:47:56 +1000 (AEST)
Received: by mail-yb1-xb32.google.com with SMTP id g38so18473842ybi.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jun 2021 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=honLpRS5BN/c2OkeqRE0xa+BxqCXma5P6oZc4YqSaPE=;
 b=Mg+8v23pivt6Zp5p5+GDfXoaCDNdSAUyb5ugGA1H4TvgXOxNuc3e+P73Ee2LrcGqdr
 Q9cKeOEF020LWaK3asdbZwnCBnswvyl7yJqQw5+ewetqrkt0XodouzDJ0Zi7RlYLeg7z
 82S9yycBLPt5+WPIiWkXXEdxWaWns8XQoEzBxpdgqREQeYFsVISK2s5zrJ9MNBrcO3Uk
 22qUxIfTZBp55zMJfWyLPHiQqixxk873ENISYpesziAAWVrvcZuoWmr44+G4rE4hcFRL
 PORcweIU8HS0Hp8aVdRi2uVVscqlBX3Sj6FRiGGWZ5A73TRoUMx0jQgKZCRpJE1w2fV4
 l5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=honLpRS5BN/c2OkeqRE0xa+BxqCXma5P6oZc4YqSaPE=;
 b=mRtVHgsO6A41kEPzddXxaDPWAiYobQEhZQgBv2LguqtQ0sJ+qeWansi1WnCrWsnTEy
 hYDJiE6CVdrmQ8FaQ/fuSWwRMF7euDMF+p3PdH1dNYp44mqbXmFOJNxgAO3PUCli0q7S
 F3Akn/SWdzZa2TGv3QVtW5YEpqoSaMDbeS/KIp4NAjtEIboCBdvsAAoBZHaoEJKmKaH6
 fadgPFusoR+0B0eJwVO9qC5FfdE/MF6jiqMINYOxkMiNUCv1k31jfRIwCrNrCyHv3FO0
 yoHy0MkU02lIhTW3RRWfqDxjWhoZcRAw+yX7eYQmiD3tvYiIUbbOEcsnXYouU7rVkG45
 w3VQ==
X-Gm-Message-State: AOAM5324EP+HYS05XaMH0uJeJse1zDAx3D/F4N+GFMS8eWaGBN0n9rpb
 mNCUw6N75274AhI2uZvApgUmQ8BIt1sk8/7fi+I=
X-Google-Smtp-Source: ABdhPJx60/JHwFkAApq2VGhT0raLJZpQSP3Rn44dJUEOtivCEVQESrJ+p6+YiIgMvdLOSAxeMzaxSeSzrDsQsOhh/3Y=
X-Received: by 2002:a25:694d:: with SMTP id e74mr4751923ybc.377.1623728872887; 
 Mon, 14 Jun 2021 20:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
 <7062722b087228e42cbd896e39bfdf526d6a340a.1621516826.git.christophe.leroy@csgroup.eu>
 <871r93vqcb.fsf@mpe.ellerman.id.au>
In-Reply-To: <871r93vqcb.fsf@mpe.ellerman.id.au>
From: Jordan Niethe <jniethe5@gmail.com>
Date: Tue, 15 Jun 2021 13:47:41 +1000
Message-ID: <CACzsE9pajbu70rm4AAk8=S1zDj6LCfSwemEd+dhRyPw2F4WF+A@mail.gmail.com>
Subject: Re: [PATCH v2 08/12] powerpc: Don't use 'struct ppc_inst' to
 reference instruction location
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 15, 2021 at 12:01 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> > diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
> > index 5a0740ebf132..32d318c3b180 100644
> > --- a/arch/powerpc/include/asm/inst.h
> > +++ b/arch/powerpc/include/asm/inst.h
> > @@ -139,7 +139,7 @@ static inline int ppc_inst_len(struct ppc_inst x)
> >   * Return the address of the next instruction, if the instruction @value was
> >   * located at @location.
> >   */
> > -static inline struct ppc_inst *ppc_inst_next(void *location, struct ppc_inst *value)
> > +static inline unsigned int *ppc_inst_next(unsigned int *location, unsigned int *value)
> >  {
> >       struct ppc_inst tmp;
> >
>
> It's not visible in the diff, but the rest of the function is:
>
>         tmp = ppc_inst_read(value);
>
>         return location + ppc_inst_len(tmp);
> }
>
> And so changing the type of location from void * to int * changes the
> result of that addition, ie. previously it was in units of bytes, now
> it's units of 4 bytes.
>
> To fix it I've kept location as unsigned int *, and added a cast where
> we do the addition. That way users of the function just see unsigned int *,
> the cast to void * is an implementation detail.
>
> We only have a handful of uses of ppc_inst_len(), so maybe that should
> change name and return a result in units of int *. But that can be a
> separate change.
>
> > diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > index 87f524e4b09c..302f2a1e0361 100644
> > --- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > +++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> > @@ -83,7 +83,7 @@ smp_86xx_kick_cpu(int nr)
> >               mdelay(1);
> >
> >       /* Restore the exception vector */
> > -     patch_instruction((struct ppc_inst *)vector, ppc_inst(save_vector));
> > +     patch_instruction(vector, ppc_inst(save_vector));
> >
> >       local_irq_restore(flags);
> >
>
> There was another usage in here:
>
>         /* Setup fake reset vector to call __secondary_start_mpc86xx. */
>         target = (unsigned long) __secondary_start_mpc86xx;
> -       patch_branch((struct ppc_inst *)vector, target, BRANCH_SET_LINK);
> +       patch_branch(vector, target, BRANCH_SET_LINK);
>
>         /* Kick that CPU */
>         smp_86xx_release_core(nr);
>
> I fixed it up.
>
> cheers
fwiw
Reviewed by: Jordan Niethe <jniethe5@gmail.com>
