Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64801C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:26:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD582087C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 02:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD582087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KXdr19pCzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 13:26:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KXZv4jR7zDqM7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 13:24:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44KXZt2snjz9s70;
 Thu, 14 Mar 2019 13:24:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] powerpc: use $(origin ARCH) to select KBUILD_DEFCONFIG
In-Reply-To: <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
References: <1550223519-18290-1-git-send-email-yamada.masahiro@socionext.com>
 <CA+7wUswJ5+nb3OdZYrx6++batRMUcnje3jLTgdN4zAQo=--xBg@mail.gmail.com>
 <CAK7LNAQUEivnhFnmkP+5uCHRJcYWDtK_fm2gB0rsbzGv1taBCg@mail.gmail.com>
 <CA+7wUsxruu0GdyRGJ3vsjRvSBAptMn8_f5BmeMo=-E3zbhGGxQ@mail.gmail.com>
Date: Thu, 14 Mar 2019 13:24:03 +1100
Message-ID: <87y35i9osc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:
> On Sat, Feb 16, 2019 at 3:26 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> On Sat, Feb 16, 2019 at 1:11 AM Mathieu Malaterre <malat@debian.org> wrote:
>> >
>> > On Fri, Feb 15, 2019 at 10:41 AM Masahiro Yamada
>> > <yamada.masahiro@socionext.com> wrote:
>> > >
>> > > I often test all Kconfig commands for all architectures. To ease my
>> > > workflow, I want 'make defconfig' at least working without any cross
>> > > compiler.
>> > >
>> > > Currently, arch/powerpc/Makefile checks CROSS_COMPILE to decide the
>> > > default defconfig source.
>> > >
>> > > If CROSS_COMPILE is unset, it is likely to be the native build, so
>> > > 'uname -m' is useful to choose the defconfig. If CROSS_COMPILE is set,
>> > > the user is cross-building (i.e. 'uname -m' is probably x86_64), so
>> > > it falls back to ppc64_defconfig. Yup, make sense.
>> > >
>> > > However, I want to run 'make ARCH=* defconfig' without setting
>> > > CROSS_COMPILE for each architecture.
>> > >
>> > > My suggestion is to check $(origin ARCH).
>> > >
>> > > When you cross-compile the kernel, you need to set ARCH from your
>> > > environment or from the command line.
>> > >
>> > > For the native build, you do not need to set ARCH. The default in
>> > > the top Makefile is used:
>> > >
>> > >   ARCH            ?= $(SUBARCH)
>> > >
>> > > Hence, $(origin ARCH) returns 'file'.
>> > >
>> > > Before this commit, 'make ARCH=powerpc defconfig' failed:
>> >
>> > In case you have not seen it, please check:
>> >
>> > http://patchwork.ozlabs.org/patch/1037835/
>>
>> I did not know that because I do not subscribe to ppc ML.
>>
>> Michael's patch looks good to me.
>
> OK
>
>>
>> If you mimic x86, the following will work:
>>
>
> Nice! Michael do you have a preference ?

Yeah I don't like playing games with ARCH. Doing so means auto builders
and other build scripts need to learn about the special rules for ARCH,
which is a pain.

So I'll merge my patch, which I think will also work for Masahiro's
case.

cheers
