Return-Path: <SRS0=RWfA=KN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77039C433ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 May 2021 06:14:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD72611AD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 May 2021 06:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD72611AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fkm1F5tCyz309H
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 May 2021 16:14:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=pNt1eTIi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=pNt1eTIi; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fkm0m118Pz2yXf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 May 2021 16:13:59 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Fkm0c37mNz9sW1;
 Tue, 18 May 2021 16:13:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1621318434;
 bh=IV7+QbI4uh3lLtagt784pHwtdDzEOKkcFGpA1YF+BnY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=pNt1eTIi54r2BF6idmSaqa/SVJwyaW7MWUkYiczrrtrYa/pzo0YwDLue+ox+Wu8ar
 hMwQL2oW2PQr0nTvd0aq0Aii/hA8Snaq89FwtqQfbfI6tMw38q2fU957w5DG5mkc19
 TobmiRLm9ADLRSt+t9ZI1stEezRzfmr/2IaILzAhZT3mn9Gx/jme6PjKxGh5f/hXz2
 V0QwGeA9cHXd5lAPL7M+Jc1hnz5qo7ELbARY9Iz1AwHu8oz3mMUv06O1IsIE5lxf26
 23av0QMe703eZ/UGUz5MD+KJpPfel73/THzo3BNQGSqQhDul2f/kAMm/p2Q9s40L9L
 aXJ8Siv0f1Jzw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nick Desaulniers <ndesaulniers@google.com>, Oliver O'Halloran
 <oohall@gmail.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] powerpc/powernv/pci: remove dead code from !CONFIG_EEH
In-Reply-To: <CAKwvOdmMugQkTRwC3HOEt2-em2zSfAoi7gpvJRkqfdzSDRMeEg@mail.gmail.com>
References: <20210422195405.4053917-1-ndesaulniers@google.com>
 <87lf99zzl3.fsf@dja-thinkpad.axtens.net>
 <CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com>
 <CAKwvOdmMugQkTRwC3HOEt2-em2zSfAoi7gpvJRkqfdzSDRMeEg@mail.gmail.com>
Date: Tue, 18 May 2021 16:13:50 +1000
Message-ID: <87cztok1r5.fsf@mpe.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Joe Perches <joe@perches.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nick Desaulniers <ndesaulniers@google.com> writes:
> On Thu, Apr 22, 2021 at 6:13 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> On Fri, Apr 23, 2021 at 9:09 AM Daniel Axtens <dja@axtens.net> wrote:
>> >
>> > Hi Nick,
>> >
>> > > While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
>> > > possible candidate to convert to #ifdef CONFIG_EEH, but it seems that
>> > > based on Kconfig dependencies it's not possible to build this file
>> > > without CONFIG_EEH enabled.
>> >
>> > This seemed odd to me, but I think you're right:
>> >
>> > arch/powerpc/platforms/Kconfig contains:
>> >
>> > config EEH
>> >         bool
>> >         depends on (PPC_POWERNV || PPC_PSERIES) && PCI
>> >         default y
>> >
>> > It's not configurable from e.g. make menuconfig because there's no prompt.
>> > You can attempt to explicitly disable it with e.g. `scripts/config -d EEH`
>> > but then something like `make oldconfig` will silently re-enable it for
>> > you.
>> >
>> > It's been forced on since commit e49f7a9997c6 ("powerpc/pseries: Rivet
>> > CONFIG_EEH for pSeries platform") in 2012 which fixed it for
>> > pseries. That moved out from pseries to pseries + powernv later on.
>> >
>> > There are other cleanups in the same vein that could be made, from the
>> > Makefile (which has files only built with CONFIG_EEH) through to other
>> > source files. It looks like there's one `#ifdef CONFIG_EEH` in
>> > arch/powerpc/platforms/powernv/pci-ioda.c that could be pulled out, for
>> > example.
>> >
>> > I think it's probably worth trying to rip out all of those in one patch?
>>
>> The change in commit e49f7a9997c6 ("powerpc/pseries: Rivet CONFIG_EEH
>> for pSeries platform") never should have been made.
>
> I'll change my patch to keep the conditionals, but use #ifdef instead
> of #if then?

Yeah, please.

I'm not sure I agree with oohal that untangling pseries/powernv from
EEH is something we should do, but let's kick that can down the road by
just fixing up the ifdef.

cheers
