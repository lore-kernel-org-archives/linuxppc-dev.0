Return-Path: <SRS0=q90n=DN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A2C4363A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 00:37:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071412074A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 00:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ibuCy+u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071412074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C4z7D4NxYzDqGv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2020 11:36:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::841;
 helo=mail-qt1-x841.google.com; envelope-from=joel.stan@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=jms.id.au header.i=@jms.id.au header.a=rsa-sha256
 header.s=google header.b=ibuCy+u5; dkim-atps=neutral
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C4z4r2MxvzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2020 11:34:52 +1100 (AEDT)
Received: by mail-qt1-x841.google.com with SMTP id y11so11513115qtn.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2020 17:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BC+Sg9HWCWkWpUC1Bzc2G/+Jd/qZ/kelvEvSs6pcygY=;
 b=ibuCy+u5v9dpSLfj0DVMWS2aVgXgFfYmW+QLQ5dkIRbF1qDIy6Knwo0swgB8sAwJU1
 8v3VTWh8RAcxV3imLQ3oc09SZMBU2ooOsr634pzNjjEPweSltVZdWeZ2Q77y/8NQBTfe
 Ypl7bQP00/I88eNQgof4aby7AuiAMutsnVyXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BC+Sg9HWCWkWpUC1Bzc2G/+Jd/qZ/kelvEvSs6pcygY=;
 b=cyuiy9n1DMy8ssZDYs2VwcA4q+1VXbYRseGw+MHijUJNHSPgIjard45DCdOWhTEZrl
 w5iGNDEOP2Zp0DXwIkpBMF7++DugtdoPNNNJHVobRksESzKZZb7k/u6A+08ISJ6tFi+Q
 fjKETvdSb9Am696k/BzOABJtT8b5+BaEc+FuIsujaHlNHlKJ2ztWx5Yg3ukQahz9NbIe
 Gz1hrWzcM4P66lnfPPnkESOZT8q6gA8UNEkFNamrWWcxVVA6NtSHEHtaTEkOUh3fqSxs
 vbtV4IzvWz9mdEbJxheikBEAdsj3i8hu7+Vj9A66I1Wi3ubES4Tn17/VvO4xhwrh2fY0
 hkug==
X-Gm-Message-State: AOAM530lyf6BpIGAAZXpkBiA0SuVUv7rkh2s9r0wy7qCAmMIxnD8Pk6b
 5z8wGSDvAcHuFyiGjR3mEBVORQa0bzu5P7JVjEU=
X-Google-Smtp-Source: ABdhPJzgP3hgjixz3aD2KNSFT9xsH6N9pOYQ2fTX0rS0HIiHOh5cIG9MdVHCKM+lkeXQGNgCcrV+6WHi4MIcxkqgBFw=
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr2722902qta.176.1601944487836; 
 Mon, 05 Oct 2020 17:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200929192549.501516-1-ndesaulniers@google.com>
 <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
 <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
 <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com>
 <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
 <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
 <aefe941251d5d58062d06099afb58dea1d1d4e17.camel@perches.com>
 <46040e2776a4848add06126ce1cb8f846709294f.camel@perches.com>
 <CANiq72mSjs4myQQtUoegjRggjTx9UF70nAcWoXRoTeLMOuf0xQ@mail.gmail.com>
 <20201001193937.GM28786@gate.crashing.org>
 <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
In-Reply-To: <61445711991c2d6eb7c8fb05bed2814458e2593b.camel@perches.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 6 Oct 2020 00:34:35 +0000
Message-ID: <CACPK8XdwX=1T8WrsVYurL+JedEsb1ZTyrWtJXDLXycu-qu4UTg@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To: Joe Perches <joe@perches.com>, Michael Ellerman <mpe@ellerman.id.au>
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
Cc: Kees Cook <keescook@chromium.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sedat Dilek <sedat.dilek@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 1 Oct 2020 at 20:19, Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-10-01 at 14:39 -0500, Segher Boessenkool wrch/ote:
> > Hi!
> >
> > On Thu, Oct 01, 2020 at 12:15:39PM +0200, Miguel Ojeda wrote:
> > > > So it looks like the best option is to exclude these
> > > > 2 files from conversion.
> > >
> > > Agreed. Nevertheless, is there any reason arch/powerpc/* should not be
> > > compiling cleanly with compiler.h? (CC'ing the rest of the PowerPC
> > > reviewers and ML).
> >
> > You need to #include compiler_types.h to get this #define?
>
> Actually no, you need to add
>
> #include <linux/compiler_attributes.h>
>
> to both files and then it builds properly.
>
> Ideally though nothing should include this file directly.

arch/powerpc/boot is the powerpc wrapper, and it's not built with the
same includes or flags as the rest of the kernel. It doesn't include
any of the headers in the top level include/ directory for hysterical
raisins.

The straightforward fix would be to exclude this directory from your script.

Cheers,

Joel
