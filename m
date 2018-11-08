Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5AC32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 07:27:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC532081D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 07:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC532081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rFHL0lfBzF3NG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 18:27:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.195; helo=mail-oi1-f195.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
 [209.85.167.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rFFQ4n73zF3Lj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 18:26:02 +1100 (AEDT)
Received: by mail-oi1-f195.google.com with SMTP id w66-v6so16130879oiw.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Nov 2018 23:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=m5QoePyAj2YI6QUty4NP8hZpIkgaGBT9QFNFVrkmBkU=;
 b=jbLRHi+LL1x0DhLxu4u/YIHw6/dkRlMqI3iF9BGttBNLI7oFSF1LuL5cqT9xLy+oXF
 8wurDIbKdbuArKoIMu/CD9NQaKtXAw09ZinqfzgKWD/Dv6Zx1q/OH2Fxnyw52ZlcKCxZ
 QuZhPKxgOypzh+K6qLsfeqFFPXT+8X5oSiCXIPXvXJCcgaAlU8Zmtts7QITUeJdgWIgC
 yPJSv/w2tLCgsXA6E4XiVJHYunsaMGoHYPRY5N1QzghUrjfR9i5fBxTm6D46j49f5eyw
 HpTz7Sd8rMOMdOcLVYlh0v6kbZevMudYd5fHrAOq8FXJyLi1n0puT5XUcoAuFQXPIPyr
 c5iA==
X-Gm-Message-State: AGRZ1gKn27VHoCatTa8Hbf6jp0SN9Ay44+7yAANwwSZMtdwJXVpGbb1h
 G24nQScahfLMHBqFS9KAMCgFuvRbya1T1MNEY54=
X-Google-Smtp-Source: AJdET5elf07R5uCUGxPaTC6fZMJRiDCclIPfeQLpTxCho2NHE9L4Vrej7h5BV8U+F5FhpEGStoUj+m06y1uzbbUIBrQ=
X-Received: by 2002:aca:aa84:: with SMTP id
 t126-v6mr2093746oie.218.1541661960379; 
 Wed, 07 Nov 2018 23:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20181107202641.7865-1-malat@debian.org>
 <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
In-Reply-To: <d3ba180c-9ab1-d204-7a62-0563ecabad70@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 8 Nov 2018 08:25:47 +0100
Message-ID: <CA+7wUsz8TVtOuSvmWVGeZmPKGvxFhHy2mVSKex4REFs9uGb_xQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Mark variable `cpumsr` as unused
To: Christophe LEROY <christophe.leroy@c-s.fr>
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
Cc: Breno Leitao <leitao@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 8, 2018 at 7:09 AM Christophe Leroy <christophe.leroy@c-s.fr> w=
rote:
>
>
>
> On 11/07/2018 08:26 PM, Mathieu Malaterre wrote:
> > Add gcc attribute unused for `cpumsr` variable.
> >
> > Fix warnings treated as errors with W=3D1:
> >
> >    arch/powerpc/kernel/process.c:231:16: error: variable =E2=80=98cpums=
r=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
> >    arch/powerpc/kernel/process.c:296:16: error: variable =E2=80=98cpums=
r=E2=80=99 set but not used [-Werror=3Dunused-but-set-variable]
> >
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
>
> I don't think this is the good way to fix that. This problem was
> introduced by commit 5c784c8414fb ("powerpc/tm: Remove
> msr_tm_active()"). That commit should be reverted and fixed.

I see, it makes sense.

> That commit should have removed the macro and kept the inline function.

Breno, what do you think ?

> Christophe
>
> > ---
> >   arch/powerpc/kernel/process.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/proces=
s.c
> > index 96f34730010f..b9f1a2408738 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -228,7 +228,7 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
> >
> >   void enable_kernel_fp(void)
> >   {
> > -     unsigned long cpumsr;
> > +     unsigned long cpumsr __maybe_unused;
> >
> >       WARN_ON(preemptible());
> >
> > @@ -293,7 +293,7 @@ EXPORT_SYMBOL(giveup_altivec);
> >
> >   void enable_kernel_altivec(void)
> >   {
> > -     unsigned long cpumsr;
> > +     unsigned long cpumsr __maybe_unused;
> >
> >       WARN_ON(preemptible());
> >
> >
