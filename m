Return-Path: <SRS0=OEx3=NM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D760C0044C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 16:08:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723D72081B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 16:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="AKamKBN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723D72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42m9912zgpzF3NG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 03:08:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AKamKBN4";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=google.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=ndesaulniers@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.b="AKamKBN4"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42m96J5mMlzF3Jn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Nov 2018 03:05:44 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id u13-v6so3937728pfm.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Nov 2018 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mMrw8HVK6jGfR2DhUTHCWV+WpzQB8IOgQavwOC2eyKM=;
 b=AKamKBN44a0qgpFozWUUxMcT3t/S6Kh4Nb48t9WLwkEPcS8aLuPQ4i0ppB7xjk0RqH
 NSEZNJtlSqtkzecJMmjL4n4JMh99s7ZEQRMmNGLXgGeLEuyEiacekgNzAyRkWz9DdCUd
 ORXQYIvPVT9qyHqD1G3vyhmN0qBqOk7afDP0/flvYD183FGMIqJoFZKYczPTQ6vhmfsR
 rRbX+5xnz20DxVKq9VHt8wx9a6ompwuGpgqS6XnENKi+7hZAOLhpDP0UVJar8wLzCHSQ
 8bWR+gwfu5033mbyDpaIrBI4NPsph3/MOWLCl12eK1DDda38M8W5WeFQYWjz+qCrQODB
 DLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mMrw8HVK6jGfR2DhUTHCWV+WpzQB8IOgQavwOC2eyKM=;
 b=KOfo/TdzYMHBcQ/23Iqncc2W6J6uY//zZMtqizXDl4Ea2jxzioBvHL5bYJhWTh//V/
 2AdMFycWmZE8cTg7hI5OyMzRj7i4ignwJJKOxBbNbDkq0laSauBmw7TadkJ5Mp3/F2LQ
 fOxRSp9zgnlxjNGDXPjHrhs3wnEz/j/1lqRrNyV0E5SE3k+1k5hzeedesgh3G6wYbebg
 Vgxx9EkjEzHYSECiohW/SW9Bu7y6UV9D1l94dqyioG8+zG3q+qb7V1jb44PQoFzwwT2w
 LxT1u+YYeiiuprVKHdas6LgrTu+YJ4BTHGqDurrumJHgx9jnP76d1PixYwQZnwzvhgYv
 53qw==
X-Gm-Message-State: AGRZ1gLZJJTNsbHmPmpzuWLmFBdqbCSfu+Geur0lbR6h5iqac3BPUB+h
 Atxi8foxfcEgNi4iCwQrmwepq/X/ytNorzeqwu0Jmw==
X-Google-Smtp-Source: AJdET5eoXK+W3sjCsFzF3em56oE9gR3q2hRRkV7GpbD8JpV8KwXSd/opxS6J+169dfl6d9sLxALHWuQgtLAU0mgunj4=
X-Received: by 2002:a63:a064:: with SMTP id u36mr4990902pgn.145.1541088341709; 
 Thu, 01 Nov 2018 09:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181031032829.18131-1-joel@jms.id.au>
 <CAKwvOdm8rFNEG39_6f5voZo3nU1g9eC6M8uxeQPVE8=JUoB3mg@mail.gmail.com>
 <87y3ad76pg.fsf@concordia.ellerman.id.au>
In-Reply-To: <87y3ad76pg.fsf@concordia.ellerman.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 1 Nov 2018 09:05:29 -0700
Message-ID: <CAKwvOdnSO8dXS6MXinFCwm5xu-PFU78GnZCzPKAOHTSPpF9pKg@mail.gmail.com>
Subject: Re: [PATCH] raid6/ppc: Fix build for clang
To: mpe@ellerman.id.au
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
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 jji@us.ibm.com, LKML <linux-kernel@vger.kernel.org>, joel@jms.id.au,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 31, 2018 at 9:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
> > On Tue, Oct 30, 2018 at 8:28 PM Joel Stanley <joel@jms.id.au> wrote:
> >>
> >> We cannot build these files with clang as it does not allow altivec
> >> instructions in assembly when -msoft-float is passed.
> >>
> >> Jinsong Ji <jji@us.ibm.com> wrote:
> >> > We currently disable Altivec/VSX support when enabling soft-float.  So
> >> > any usage of vector builtins will break.
> >> >
> >> > Enable Altivec/VSX with soft-float may need quite some clean up work, so
> >> > I guess this is currently a limitation.
> >> >
> >> > Removing -msoft-float will make it work (and we are lucky that no
> >> > floating point instructions will be generated as well).
> >>
> >> This is a workaround until the issue is resolved in clang.
> >>
> >> Link: https://bugs.llvm.org/show_bug.cgi?id=31177
> >> Link: https://github.com/ClangBuiltLinux/linux/issues/239
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >
> > Hopefully we can have this fixed up soon.  I'll try to see who works
> > on Clang+PPC here and see if they can help move that bug along. Thanks
> > for the patch!
> >
> >> ---
> >>  lib/raid6/Makefile | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
> >> index 2f8b61dfd9b0..3a844e6fd01c 100644
> >> --- a/lib/raid6/Makefile
> >> +++ b/lib/raid6/Makefile
> >> @@ -18,6 +18,21 @@ quiet_cmd_unroll = UNROLL  $@
> >>
> >>  ifeq ($(CONFIG_ALTIVEC),y)
> >>  altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
> >> +
> >> +ifdef CONFIG_CC_IS_CLANG
> >
> > Note that the top level makefile detects clang via:
> >
> > ifeq ($(cc-name),clang)
> >
> > Does that not work here? I'd prefer to keep compiler detection in
> > Makefiles consistent, if it works?
>
> cc-name is being removed in favor of CONFIG_CC_IS_CLANG:
>
> https://lore.kernel.org/lkml/1540905994-6073-1-git-send-email-yamada.masahiro@socionext.com/
>
> cheers

Cool, thanks for the link!

-- 
Thanks,
~Nick Desaulniers
