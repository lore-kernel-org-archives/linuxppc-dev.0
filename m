Return-Path: <SRS0=iKE2=CL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3460C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39751207EA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2020 17:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="d39r+fQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39751207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BhWWs5Xj2zDr2h
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 03:43:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::542;
 helo=mail-pg1-x542.google.com; envelope-from=ndesaulniers@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=d39r+fQ+; dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BhWTT2v2QzDqwl
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 03:41:40 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id d19so18710pgl.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2020 10:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=znhEfk0qTGWBjhVRC5OGNZnEjwpfUwpiOjd2s/MZEpw=;
 b=d39r+fQ+ZKppU6xr06OXOhgfj4QOu9x/V4/qeLwYIEZowrhfMPnCGYnHc8e2rr5bNg
 hosNhQIfLCa9gHNfwq9djzCOomM8TSBsmIpLr5aGCorfhi23KtVPw7VuKXDHHC7m64pD
 9mczWXHGWHWDj7GO254W0OS6GgkG9+dOQ/nCsMp8iS1gQ373tNOGry74xYrh+Dx+4IUC
 iiTJ8cs40ETrMJOsdGnbPi3rBY1LZzlobMcJn7nSKWvau2Z6kLl5r7uLTisVL9AIOB6x
 BPUiCO4CwmY0SqXbmR3gOtM2FX13w+TlllYsaf1NYA2afjf2L4DQPLlOqsCHgxXFJBg1
 c49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=znhEfk0qTGWBjhVRC5OGNZnEjwpfUwpiOjd2s/MZEpw=;
 b=XNi9NlAwSHecW/byvqa19StKJwjSvKxwXCNtHjm2mz6HO/VlT+IC37Y65N8m2ct+R8
 ufkeFis5w3+oMsRMAqC2THIdo8HVhk/RmcNCu9cS+/Zt90kwPclbPRW6K+etWggBrUU1
 US9WLZ6vvM43cd6z7TV5o8Zyswlh4pD+SZW8TCqPOEkazSmqRNVuG3GdsBU8CudLrJmX
 CW34ijU6yYn8IbMe+YSbqY94hZTN1Clak9QXqS2+nGqeXYu7/F5SXXuGuA+ixvY1B5eV
 YAXxHt/QejJtVVUbjq3Q0B39Ab/gbBJgZKQuoIF+20uOg08OyJknsRBHykmzH5WHS71v
 Uj3Q==
X-Gm-Message-State: AOAM5336Wo2m0L3KzaGXk2nWR+xgLs8aCQ2iJIOYZcyzOkP3pzh3X35b
 gF3OTScxox75BqHhZLxXeJAJ37xarNLVYyINVUxNiQ==
X-Google-Smtp-Source: ABdhPJzC5f9FwVt7oqUVenernnCrhELQIg8r9QLPwTdiiB+Q0kv2dXLebNbp/nRBqFOm3g52zmuOiErLfVTe7yrOsPI=
X-Received: by 2002:a63:9d09:: with SMTP id i9mr2625820pgd.381.1599068495912; 
 Wed, 02 Sep 2020 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200901222523.1941988-1-ndesaulniers@google.com>
 <20200901222523.1941988-2-ndesaulniers@google.com>
 <87blio1ilu.fsf@mpe.ellerman.id.au>
In-Reply-To: <87blio1ilu.fsf@mpe.ellerman.id.au>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 2 Sep 2020 10:41:24 -0700
Message-ID: <CAKwvOd=ZeJU+vLUk2P7FpX35haj7AC50B9Yps4pyoGCpd7ueTw@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/vdso64: link vdso64 with linker
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Joe Lawrence <joe.lawrence@redhat.com>, Kees Cook <keescook@chromium.org>,
 Fangrui Song <maskray@google.com>, LKML <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Sep 2, 2020 at 5:14 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nick Desaulniers <ndesaulniers@google.com> writes:
> > Fixes: commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
>
> I think I'll just revert that for v5.9 ?

SGTM; you'll probably still want these changes with some modifications
at some point; vdso32 did have at least one orphaned section, and will
be important for hermetic builds.  Seeing crashes in supported
versions of the tools ties our hands at the moment.
-- 
Thanks,
~Nick Desaulniers
