Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987ACC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 15:47:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC45B61A1E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 15:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC45B61A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6RFF2V6Yz3c5N
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Mar 2021 02:47:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AcCDpzU7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=robh@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AcCDpzU7; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6RDn2zbjz3btB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Mar 2021 02:47:21 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7F3E61A1E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616773639;
 bh=FOq/AGTP4gWQcAqm6gE3CbPMoPZd/s7+r0gDFMG3q6U=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=AcCDpzU7tp9iwdGG8gDfzEHT/oRIXsIga7wXxu53WqUJhT2ul2T9YDS65RNqPU2n3
 Xvn+RFssUybeWEZgEY2lh1i4UxjZPbwmKsgliPvp0IToMiB2a/WA5KR9z10HdDinOv
 UYM5sw/0IvqfBsKxROncwVaSX/vsAHxPYgALR1dSYHioveObkwXiHIvFx1Yj/tNdZJ
 KMRbv1ObJxkt+zXV5bOiWGyn/1VwvDn/9VCA4p517RmAt9EEHqYSMNig8Oj+y1Zu4e
 B4aIe1rurjyjKfoN2EcYkT1/pA82eHFw94cAgT8CIulbihfa0tOaUKwaviLlzc9Bb9
 p9VnLj0VX7D0A==
Received: by mail-ed1-f45.google.com with SMTP id e7so6800801edu.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 08:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM5336Iobs7JYlApBA/03UMz5e1UtUWI/dMIJc7dpPoM4VFRSUw5kY
 WtAbjsYRNkpVrjflFP6F96Fpnpy8jFAqrGTt0A==
X-Google-Smtp-Source: ABdhPJyGMjMWznP/BbCajkt9nas+eMG/Qmwgar26pPUJYE7aEhO5sSz0Y/IOGFJNx4RiD0k/WjxUTeg0KAhhn6cQx0c=
X-Received: by 2002:a05:6402:c88:: with SMTP id
 cm8mr15784199edb.62.1616773637523; 
 Fri, 26 Mar 2021 08:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1616765869.git.christophe.leroy@csgroup.eu>
 <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7362e4f6a5f5b79e6ad3fd3cec3183a4a283f7fc.1616765870.git.christophe.leroy@csgroup.eu>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Mar 2021 09:47:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
Message-ID: <CAL_Jsq+LF-s5K4Jwd5jCHrU8271L5WCiGb0tR7aTUa8ddHF1YQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/17] arm: Convert to GENERIC_CMDLINE
To: Christophe Leroy <christophe.leroy@csgroup.eu>
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
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 devicetree@vger.kernel.org, microblaze <monstr@monstr.eu>,
 Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>,
 linux-xtensa@linux-xtensa.org, SH-Linux <linux-sh@vger.kernel.org>,
 Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 nios2 <ley.foon.tan@intel.com>, "open list:MIPS" <linux-mips@vger.kernel.org>,
 Openrisc <openrisc@lists.librecores.org>, linux-hexagon@vger.kernel.org,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Daniel Walker <danielwa@cisco.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 26, 2021 at 7:44 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> This converts the architecture to GENERIC_CMDLINE.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/arm/Kconfig              | 38 +----------------------------------
>  arch/arm/kernel/atags_parse.c | 15 +++++---------
>  2 files changed, 6 insertions(+), 47 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5da96f5df48f..67bc75f2da81 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -50,6 +50,7 @@ config ARM
>         select GENERIC_ARCH_TOPOLOGY if ARM_CPU_TOPOLOGY
>         select GENERIC_ATOMIC64 if CPU_V7M || CPU_V6 || !CPU_32v6K || !AEABI
>         select GENERIC_CLOCKEVENTS_BROADCAST if SMP
> +       select GENERIC_CMDLINE if ATAGS

Don't we need this enabled for !ATAGS (i.e. DT boot)?

Can we always enable GENERIC_CMDLINE for OF_EARLY_FLATTREE?

Rob
