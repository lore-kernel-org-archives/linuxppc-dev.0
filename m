Return-Path: <SRS0=4hqj=IF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFCEC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Mar 2021 06:31:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2289F650ED
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Mar 2021 06:31:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2289F650ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DtWpf0g20z3dF3
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Mar 2021 17:31:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20161025 header.b=B8lJWYRs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::62f;
 helo=mail-pl1-x62f.google.com; envelope-from=maskray@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20161025 header.b=B8lJWYRs; dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DtWpC2F6vz30JT
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Mar 2021 17:31:30 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id s16so3367467plr.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Mar 2021 22:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lgTVaBNy62FaQXG4T7xAtsLpQb7SJOUo67w7wxLxPEA=;
 b=B8lJWYRslFfmnZRMNrhVfkxmfp4MFiFQw1YP0x5TKFi1oeC7TCND4+2D3S910wYBj1
 xkftjqHwg81TT5F7Eu7d8F5vUWc7vvBVZTyEM2EQKq6aNnmWGQw9Xv/LkIPIUACgpzR3
 3OOhXNQEkTopGcMFBGmwA+5Q5kQkQ4VXn4GaxdOlsPDqRwx7yFZfaG6e0cuV1rJTFVcD
 i/6PcrGH7p+CCdxEGRFAIkmgfA6n4WMBgTorYalHPtmJJuRnCUePdFpHJXcQlENclB9p
 jkv1+FcUnY1e/HMpqaY7hEuAPm85tKM7jUitwDEvoLhh+06R2lBttlPQd14lM4l9gM1L
 iZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lgTVaBNy62FaQXG4T7xAtsLpQb7SJOUo67w7wxLxPEA=;
 b=GovQffamHL+ZK4a22P1zGqoZPNhf65D3flF8pApqNAe5vDB/m4aHyuMweIdzRTCAVq
 RdoduUBPdVFWGrNF447tOLooPjHggrxCnaa63f/q5oTTdVM4Pdk2E6dX6irQNEm0oeFs
 oIiV/2mLIyi/YcgMixBUHfB4nkz6exjXdjSvrPOlJ0C5116Ku+UhXy2WaW+d63+JQcZi
 sWT/5ZRPFrart4ofj4svFESTbxyNAaWL9XKISfK3l75LI64x4phPcbjxpCW09AJFMNDG
 933e55hFaYtZXmSHAgjTGPTB8u+34+nxolHowWwmJXPYCvETCQQEnnuoWsYggWLKHqv5
 iK+g==
X-Gm-Message-State: AOAM530pjKzbB7QbHv5qzLtxPIl94KbJqeaTBzyHGvG6SLbXLSuPfdYF
 Jehvgx982uJc/ckzb2osnxidJg+cj80ZHhNyHBpqag==
X-Google-Smtp-Source: ABdhPJzdZxodEAfZsSGiMWKYWmBZtbZMMbxfaNo2TkklrGQdBeIRlu5Mhe/eB7JuNoJTwCVMn2xKbSEMlWhgFor9+gg=
X-Received: by 2002:a17:902:ead5:b029:e5:bd04:bf48 with SMTP id
 p21-20020a170902ead5b02900e5bd04bf48mr16013637pld.38.1615098686849; Sat, 06
 Mar 2021 22:31:26 -0800 (PST)
MIME-Version: 1.0
References: <20210307051433.2756645-1-maskray@google.com>
 <20210307062336.GD29191@gate.crashing.org>
In-Reply-To: <20210307062336.GD29191@gate.crashing.org>
From: =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date: Sat, 6 Mar 2021 22:31:15 -0800
Message-ID: <CAFP8O3L91xzZtTQ3gDzpLE=-FvgM3ot5oaBK6jGUZbeT7Pg-RA@mail.gmail.com>
Subject: Re: [PATCH] Replace __toc_start + 0x8000 with .TOC.
To: Segher Boessenkool <segher@kernel.crashing.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 6, 2021 at 10:25 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Sat, Mar 06, 2021 at 09:14:33PM -0800, Fangrui Song wrote:
> > TOC relocations are like GOT relocations on other architectures.
> > However, unlike other architectures, GNU ld's ppc64 port defines .TOC.
> > relative to the .got output section instead of the linker synthesized
> > .got input section. LLD defines .TOC. as the .got input section plus
> > 0x8000. When CONFIG_PPC_OF_BOOT_TRAMPOLINE=y,
> > arch/powerpc/kernel/prom_init.o is built, and LLD computed .TOC. can be
> > different from __toc_start defined by the linker script.
> >
> > Simplify kernel_toc_addr with asm label .TOC. so that we can get rid of
> > __toc_start.
> >
> > With this change, powernv_defconfig with CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
> > is bootable with LLD. There is still an untriaged issue with Alexey's
> > configuration.
>
> Do you have any explanation why this *does* work, while the original
> doesn't?  Some explanation that says *what* is wrong.  To me it doesn't
> look like the kernel script is.
>
>
> Segher

The kernel code probably wants to access .TOC. (the TOC base symbol)
via __toc_start+0x8000.
If the kernel understood TOC base is different from the linker
understood TOC base (.TOC.), there should be a problem.
By using .TOC. in the kernel code, the two concepts are guaranteed to match.
