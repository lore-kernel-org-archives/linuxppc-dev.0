Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F6AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:36:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA13522419
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 11:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="D4A56fLb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA13522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tpcZ0DXszF3XT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 22:36:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="D4A56fLb";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::744; helo=mail-qk1-x744.google.com;
 envelope-from=joel.stan@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.b="D4A56fLb"; 
 dkim-atps=neutral
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tpYS3N17zF3GH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 22:33:48 +1100 (AEDT)
Received: by mail-qk1-x744.google.com with SMTP id y16so12620516qki.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eXNu3aEpnOBBdNn/YBJjGkd3CR6kNeCAprI/r9Zbec8=;
 b=D4A56fLbnBsZ6KL2pWd79JYMOi5CEvOnE4wwQ2dsw5eQPBYegabIhD1MqX3vaL7S5q
 MR5AHyfvP17F5PDuGzoXUfZhdmP/nWBdWiSRgKn77m8Ozi/fVtSrjyXtFpa7kWGV9c9X
 G9rIdDSWk3D5F+CUfXKnYZtyfl1ohMCO2vgtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eXNu3aEpnOBBdNn/YBJjGkd3CR6kNeCAprI/r9Zbec8=;
 b=ivAzPkduqowKukHD25AL/Vs72llIlHv++UePnQyFz3bOzKpz1ipxm+ZtZI+887dFuM
 NbrmbP0wenSSBr+iLeWPlUoYDLFuVqdQ3PB+eLS8rEsua+QtYWSxcjret7N7xcUUu65B
 vlbNrkB75z8WddGa2UQ7qBDAeG1fmb4CPUUYq2t3rZyouok4EDkNoNJ8Fdau0drdwB0u
 4AXYxdR0jSsIapNnana8d2pRFf/Te1fSM+Q+bhQDSJxYo1QrOGgNmywuRSV26m3Scmtd
 XE79k+ANKd9jxJekx5Mf6NoPnihrwn52lHtuKdhtTOshrO2B9oRlhijAkMFi8ieWSol2
 ad/g==
X-Gm-Message-State: AGRZ1gIUgyiW1xX7bimulb3KZB7RVW6/kzqvtk7Ed5Oia6JqWzamRug4
 PxMAKujdymBKmNY+deQ+/Y2lA8EXWGDtj4xlc28=
X-Google-Smtp-Source: AJdET5eRg4HQcEKrgm7Ex55Ua+Hi9aXz5kttjpYE+w3OaxPv3cww7b3PL351Q0PuNSakfRQFYD8raJaopNmEq6n1FYg=
X-Received: by 2002:aed:2764:: with SMTP id n91mr491422qtd.37.1542022425670;
 Mon, 12 Nov 2018 03:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20181102033713.31916-1-joel@jms.id.au>
 <CAKwvOdnVr8_bg-ND29PWihzdD_YVcGH6z+0zHZhK8nEv-k0-2A@mail.gmail.com>
In-Reply-To: <CAKwvOdnVr8_bg-ND29PWihzdD_YVcGH6z+0zHZhK8nEv-k0-2A@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 12 Nov 2018 22:03:34 +1030
Message-ID: <CACPK8XcPxOot2-Abn-o0-5ECyz6KfmkUfKSh6L5+pok7eNtCFQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
To: Nick Desaulniers <ndesaulniers@google.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 3 Nov 2018 at 03:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Thu, Nov 1, 2018 at 8:37 PM Joel Stanley <joel@jms.id.au> wrote:
> >
> >   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  ppc44x_defconfig
> >   make CC=clang-8 ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
> >
> >   ...
> >
> >   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
> >   inline asm context requiring an l-value: remove the cast or build with
> >   -fheinous-gnu-extensions
> >           FP_ADD_D(R, T, B);
> >           ^~~~~~~~~~~~~~~~~
> >   ./include/math-emu/double.h:110:27: note: expanded from macro 'FP_ADD_D'
> >   #define FP_ADD_D(R,X,Y)                 _FP_ADD(D,2,R,X,Y)
> >                                           ^~~~~~~~~~~~~~~~~~
> >   ./include/math-emu/op-common.h:367:34: note: expanded from macro '_FP_ADD'
> >   #define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL(fs, wc, R, X, Y, '+')
> >                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >   ./include/math-emu/op-common.h:264:4: note: expanded from macro '_FP_ADD_INTERNAL'
> >             _FP_FRAC_ADD_##wc(R, X, Y);                                        \
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>
> ^^^ Hi Joel, would you mind recompiling with
> `-fmacro-backtrace-limit=0` hacked in and including the full
> backtrace?  I'm curious if there's a more appropriate fix, but can't
> tell where the inline asm is that clang is complaining about.

Sure. Here's the full backtrace:

arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
inline asm context requiring an l-value: remove
      the cast or build with -fheinous-gnu-extensions
        FP_ADD_D(R, T, B);
        ^~~~~~~~~~~~~~~~~
./include/math-emu/double.h:110:27: note: expanded from macro 'FP_ADD_D'
#define FP_ADD_D(R,X,Y)                 _FP_ADD(D,2,R,X,Y)
                                        ^~~~~~~~~~~~~~~~~~
./include/math-emu/op-common.h:367:34: note: expanded from macro '_FP_ADD'
#define _FP_ADD(fs, wc, R, X, Y) _FP_ADD_INTERNAL(fs, wc, R, X, Y, '+')
                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/math-emu/op-common.h:274:4: note: expanded from macro
'_FP_ADD_INTERNAL'
          _FP_FRAC_SUB_##wc(R, X, Y);                                        \
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:268:1: note: expanded from here
_FP_FRAC_SUB_2
^
./include/math-emu/op-2.h:97:19: note: expanded from macro '_FP_FRAC_SUB_2'
  __FP_FRAC_SUB_2(R##_f1, R##_f0, X##_f1, X##_f0, Y##_f1, Y##_f0)
  ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
<scratch space>:269:1: note: expanded from here
R_f1
^
./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
macro 'sub_ddmmss'
               : "=r" ((USItype)(sh)),                                  \
                       ~~~~~~~~~~^~~
