Return-Path: <SRS0=JxsT=JO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397EAC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 01:02:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570F660FEE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 01:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570F660FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FMZYL6VdYz3cXn
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Apr 2021 11:02:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=N/Jg6sWs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::12c;
 helo=mail-il1-x12c.google.com; envelope-from=tony.ambardar@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=N/Jg6sWs; dkim-atps=neutral
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FMZWd24xmz3c4g
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Apr 2021 11:00:44 +1000 (AEST)
Received: by mail-il1-x12c.google.com with SMTP id e14so840177ils.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Apr 2021 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iY+RihvUPyX8tk9Gf02ocgT2AcANbu5qgEKSYd9h/Ek=;
 b=N/Jg6sWs2uTjuQV8jiDzF6n5Lf3QwDms6wQEpSc8aWUFWSMPkbQ9QEMbRYUk6xfqBj
 dzck2Rm9wPsvncZr7eAWIH/wSp/IcaLZhcQGNjOPXh8yPty1LyIcR6Mlte++IiC6AM1r
 ordl5QUCnOxEsKIyaXsVFCZe99JutM+4Ofn41bUD32SHhNQJBvYNf5QELhXqW+7e5c4N
 meIktTQ8UNgn4agwzzCwycOjPqcNWEZ4Z30EPVybzvpvMQlc6TwR8CR0Qa64cH8hNXKA
 kmn3JEMYRCJ9FZuM+MdA33Bb+KaUsCEH+Oj5ZzAAJAvHPcSMeu8LohfQ2RFTgZ6jb4VF
 K8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iY+RihvUPyX8tk9Gf02ocgT2AcANbu5qgEKSYd9h/Ek=;
 b=tE7k34JtzA9fPkPDnMACWh5WfO4KC5ROxzbI/FfUcOdO8MZ8As2CNaio4gi+oCuOnC
 vBPhvlWQtwr10FX198JN8NX06c2TdVOfio3wLUUFDnzvobwKa8aT84MC89nZ0CssQq81
 Tm9t/Fw2oCj/c8igh9VJiG1LrYBMuJA9tZwFBlz+Xec5ZUdD0HqQch82cY0NxufDPYOX
 zzRd0pyoaw45h8jT6X2korvp1DkX0WizRoyX5xiDwJGcLCgFFkrAdYSf81Fml2qJ2SFS
 JqpofwXzqKfdj02bAMVHLOlhfReJHPiSy11hLrwom0gzoxO1nKc/XppSUNYNHSr4AEeT
 vYyQ==
X-Gm-Message-State: AOAM531nOtOz8hvLspD2q3gd00a48gKhdtoXq4uV3l+POgntk9fWiCSy
 cVl1s8Lh68SP01Hzee7jA2o5QqUs+CQmQOkW3Fg=
X-Google-Smtp-Source: ABdhPJzsa5kRDU9e1LTH578C8d3QJIyrDRz+zu/YLglh/0yMAo2iePlaNMdHQwGNda+kPmEY9OrI07+IhNdKg1wI6nA=
X-Received: by 2002:a92:c78a:: with SMTP id c10mr9318404ilk.64.1618621237415; 
 Fri, 16 Apr 2021 18:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200917000757.1232850-1-Tony.Ambardar@gmail.com>
 <20200917135437.1238787-1-Tony.Ambardar@gmail.com>
 <CAPGftE-Q+Q479j7SikDBQLiM+VKbpXpRYnTeEJeAHeZrh_Ok2A@mail.gmail.com>
 <87r1jaeclf.fsf@mpe.ellerman.id.au>
In-Reply-To: <87r1jaeclf.fsf@mpe.ellerman.id.au>
From: Tony Ambardar <tony.ambardar@gmail.com>
Date: Fri, 16 Apr 2021 18:00:26 -0700
Message-ID: <CAPGftE_JthCCWdH8sgTNp7WVcuUu7zPCpmG1KWZ8iovcEwSd2w@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: fix EDEADLOCK redefinition error in
 uapi/asm/errno.h
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 LKML <linux-kernel@vger.kernel.org>, Stable <stable@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Rosen Penev <rosenp@gmail.com>,
 bpf <bpf@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 16 Apr 2021 at 03:41, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Tony Ambardar <tony.ambardar@gmail.com> writes:
> > Hello Michael,
> >
> > The latest version of this patch addressed all feedback I'm aware of
> > when submitted last September, and I've seen no further comments from
> > reviewers since then.
> >
> > Could you please let me know where this stands and if anything further
> > is needed?
>
> Sorry, it's still sitting in my inbox :/
>
> I was going to reply to suggest we split the tools change out. The
> headers under tools are usually updated by another maintainer, I think
> it might even be scripted.
>
> Anyway I've applied your patch and done that (dropped the change to
> tools/.../errno.h), which should also mean the stable backport is more
> likely to work automatically.
>
> It will hit mainline in v5.13-rc1 and then be backported to the stable
> trees.
>
> I don't think you actually need the tools version of the header updated
> to fix your bug? In which case we can probably just wait for it to be
> updated automatically when the tools headers are sync'ed with the kernel
> versions.
>
> cheers

I appreciate the follow up. My original bug was indeed with the tools
header but is being patched locally, so waiting for those headers to
sync with the kernel versions is fine if it simplifies things overall.

Thanks,
Tony
