Return-Path: <SRS0=xBJK=IW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42F2C433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:46:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35170619C9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Mar 2021 14:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35170619C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F59zV59H4z3bsr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Mar 2021 01:46:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=f0uoMNCs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=f0uoMNCs; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F59z2745sz30CM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Mar 2021 01:46:06 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37E9D619C9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Mar 2021 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616597163;
 bh=IpQqeZizpAkmktM1ykYR3SVGsq3cc7ebBvwgwpKHb54=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=f0uoMNCsY34YsQOjwo+6nuFTZULLZcwjyfF47zMiOqHO2Z6jhu9AMPSUvR3Y57LD1
 028suKzN0rxO3FrrVNP8rSV5SOb/SKEDKLnumQ3lPCKg8ZwW0RwojHzFkqya5YkbJx
 mtaG3DKcNkFLNBUJ7P0NxijHB7C+WtD7/83CWSjhqIqpVJ3IFWMEYAhgV9Bu86JWBy
 6tMunJLtesSZL5fTjqhA2zCdAm5jabL7ePNZaapK5elYb95ayP6XfRS+Hbc2mg0ctR
 VIdu3IvKk677XPRepzNoqzs5dFvbI5rG4AV9oN1JGg2tE7IWyiVqUe+LE0BiDI2H1b
 8qlzjB/MeeLlQ==
Received: by mail-ed1-f41.google.com with SMTP id y6so27964960eds.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Mar 2021 07:46:03 -0700 (PDT)
X-Gm-Message-State: AOAM531qCU8H4y66yxwUIt36ZOm+Ak8sxOyDP9vEQqNVLMFzj4bUgRA4
 WLjj4ZqNUD0bcKGOBAuzLDiXlTsge+SJVCvLRQ==
X-Google-Smtp-Source: ABdhPJx9s+DKhEIneKlm50ecrAh88tChNkD/fmlCgrTsMQymYLNt6jDsywvmbgGVambNzhd8cZzpeq1mkk+S3JmVtj4=
X-Received: by 2002:a05:6402:2d0:: with SMTP id
 b16mr3933538edx.194.1616597161877; 
 Wed, 24 Mar 2021 07:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210309000247.2989531-1-danielwa@cisco.com>
In-Reply-To: <20210309000247.2989531-1-danielwa@cisco.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Mar 2021 08:45:48 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLN=TtAck+0cT+MFtxRiMUpiWRUMnrvnJJf55fwCxATLg@mail.gmail.com>
Message-ID: <CAL_JsqLN=TtAck+0cT+MFtxRiMUpiWRUMnrvnJJf55fwCxATLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Generic Command Line changes
To: Daniel Walker <danielwa@cisco.com>
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
Cc: devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "open list:MIPS" <linux-mips@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, xe-linux-external@cisco.com,
 Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 8, 2021 at 5:02 PM Daniel Walker <danielwa@cisco.com> wrote:
>
> This fixed some problem identified in my last release. I made updates
> based on comments from Christophe Leroy.
>
> I added scripted updates to the defconfig file for mips and powerpc.
> This is required in order to maintain the status quo for those platforms
> which used the prior builtin command line system.
>
> These were tested on all effected architectures.
>
> Daniel Walker (7):
>   CMDLINE: add generic builtin command line
>   CMDLINE: drivers: of: ifdef out cmdline section
>   powerpc: convert config files to generic cmdline
>   CMDLINE: powerpc: convert to generic builtin command line
>   mips: convert config files to generic cmdline
>   CMDLINE: mips: convert to generic builtin command line
>   CMDLINE: x86: convert to generic builtin command line

Can you send out or provide a branch of the other converted arches you
have patches for? Given this got revived due to arm64 cmdline changes,
including arm64 patches at least would be beneficial as there are
folks motivated to review and test this on Arm.

Rob
