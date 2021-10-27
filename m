Return-Path: <SRS0=vpml=PP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C76C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 14:19:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91E2608FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Oct 2021 14:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B91E2608FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HfW6Y2prGz3c5Z
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 01:19:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=paul-moore-com.20210112.gappssmtp.com header.i=@paul-moore-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=WO/8J0WH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=paul-moore.com
 (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=paul@paul-moore.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=paul-moore-com.20210112.gappssmtp.com
 header.i=@paul-moore-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=WO/8J0WH; dkim-atps=neutral
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HfW5n3btyz2yHJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2021 01:19:07 +1100 (AEDT)
Received: by mail-ed1-x532.google.com with SMTP id z20so10671618edi.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Oct 2021 07:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=A7VSAROM1Lq92tsQzcvA0FV6paOOKRRSG0CkqXmrfHY=;
 b=WO/8J0WHy3bqbZ8bWtK8os21bmAyrg+d4GoI0FdQVNmBnedrhDrQwHoExDY2HYNc56
 wuGhdsWbyO6HMLfe7SEFEzeORWHjKA3PZMg0C1afDFnRQUD4ZqFUyBM5nPwZFehS7m/X
 W/E1Vfn3gFK5Z6fjNK0H27jiZurO+y4SQwZaV5JTnwtZ2OLx5cmApkpw8B1O6X9Xo+om
 726nvMv4VOVc1TVOL4hZMFRAdnEIUsRQn11GxzVLikDaXwVX/sMLg1dKx8sp7Q28O1DL
 OhJN2gwLwq3QBfaJBJecj9D85HBBgpvARrJFIHfm0cmYWs/UjVH5m3m/ip7qm2ysF2c5
 YYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=A7VSAROM1Lq92tsQzcvA0FV6paOOKRRSG0CkqXmrfHY=;
 b=5cAn3eRXWp50A7qZoiN3wg4Qc9mYoebfj6IkKcTu6B4GqvteEd9HGcVhyI+fDufCmx
 InXdiCRtj1+r3M+HetU8zzvmYAITMsvL9uImUy5wvMdZ3sn0S5lUjugVgQRTrDThwrdN
 RlRpIMYk9L758YjekS20ZbMfrh7BQUe+M54sLX4UkMUwxT2BACZdloyOVzoFg2ecXRsD
 dYsF+dD7TELytNNI4jTzsdU2VsfPtDztxpFTm/K+QutH5EJahBoSHlt6AY4hqP2SE72P
 SOb7AGBAgyPXYt1kiFYA6QKqT6XvXaOq4O6wtvZg5rdWvs35gFM9zPx3/PL0Z2O8UYiZ
 sxYw==
X-Gm-Message-State: AOAM532/EzBx3CSueNDhY22xfuOOANMWemlW5i2bqakwGiNsMJeVF2Gm
 MgeWnaq4ewbP6Q4L/Bk8OyOX5MoQRTINJrcokC9z
X-Google-Smtp-Source: ABdhPJx/AVRgyCKdtHofrLmeNbJZOE7jZKTiy9OBTXYs7O2Og+i8eOPvBwKXpaar1l0AT/K2AG1HPgfhyoHnEQ1j4vY=
X-Received: by 2002:a17:906:919:: with SMTP id
 i25mr38774337ejd.171.1635344330893; 
 Wed, 27 Oct 2021 07:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211026133147.35d19e00@canb.auug.org.au>
 <87k0i0awdl.fsf@mpe.ellerman.id.au>
 <CAHC9VhTj7gn3iAOYctVRKvv_Bk1iQMrmkA8FVJtYzdvBjqFmvg@mail.gmail.com>
 <87tuh2aepp.fsf@mpe.ellerman.id.au>
 <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
In-Reply-To: <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Oct 2021 10:18:40 -0400
Message-ID: <CAHC9VhRHs8Lx8+v+LHmJByxO_m330sfLWRsGDsFtQxyQ1860eg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with the powerpc tree
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Richard Guy Briggs <rgb@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 27, 2021 at 7:41 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 27/10/2021 =C3=A0 13:29, Michael Ellerman a =C3=A9crit :
> > Paul Moore <paul@paul-moore.com> writes:
> >> On Tue, Oct 26, 2021 at 6:55 AM Michael Ellerman <mpe@ellerman.id.au> =
wrote:
> >>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >>>> Hi all,
> >>>>
> >>>> Today's linux-next merge of the audit tree got conflicts in:
> >>>>
> >>>>    arch/powerpc/kernel/audit.c
> >>>>    arch/powerpc/kernel/compat_audit.c
> >>>>
> >>>> between commit:
> >>>>
> >>>>    566af8cda399 ("powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPA=
T_GENERIC")
> >>>>
> >>>> from the powerpc tree and commits:
> >>>>
> >>>>    42f355ef59a2 ("audit: replace magic audit syscall class numbers w=
ith macros")
> >>>>    1c30e3af8a79 ("audit: add support for the openat2 syscall")
> >>>>
> >>>> from the audit tree.
> >>>
> >>> Thanks.
> >>>
> >>> I guess this is OK, unless the audit folks disagree. I could revert t=
he
> >>> powerpc commit and try it again later.
> >>>
> >>> If I don't hear anything I'll leave it as-is.
> >>
> >> Hi Michael,
> >>
> >> Last I recall from the powerpc/audit thread there were still some
> >> issues with audit working properly in your testing, has that been
> >> resolved?
> >
> > No.
> >
> > There's one test failure both before and after the conversion to use th=
e
> > generic code.
> >
> >> If nothing else, -rc7 seems a bit late for this to hit -next for me to
> >> feel comfortable about this.
> >
> > OK. I'll revert the patch in my tree.
>
> But it's been in the pipe since end of August and no one reported any
> issue other issue than the pre-existing one, so what's the new issue
> that prevents us to merge it two monthes later, and how do we walk
> forward then ?

We work to resolve the test failure, it's that simple.  I haven't seen
the failure so I haven't been much help to do any sort of root cause
digging on the problem, it would be helpful if those who are seeing
the problem could dig into the failure and report back on what they
find.  That is what has been missing and why I never ACK'd or merged
the powerpc audit code.

--=20
paul moore
www.paul-moore.com
