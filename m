Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05290C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:10:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398DC20872
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="zO1Yownh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398DC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bSYX149NzDr1D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 14:10:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="zO1Yownh"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bSWL1VX7zDqxW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 14:09:01 +1100 (AEDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x0B38e3n024857
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 12:08:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0B38e3n024857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1547176122;
 bh=gaxhBMrxiaTkXMhUzpaE+DTNWXXVNmnaKXsC40qFtKM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=zO1Yownh4QQhdm1YymI2M+B0FPfr34k9AQrLMx21KtmlWlJsi2xT4rkF5ScRPNHVI
 UlDhyhJAhsFBGxUVw7ogVKnqu9htjdU4xHHXNo6tPkPfCuWvJUBDal2zX/dFQ4CBQz
 VV2wgMmUvSPvgmssQ6MlKPPMGcKlJ9ReThTLWgQAW+rdKPwjMKp8GjcexggYhj7spf
 u5YSSqhBZ+weVjcDpAF5VFudB/JAFTdsT5uiluvnETOouGIWosj+qnFvyKQUXyST4t
 wt+184qzP2OabByyPNLlQMwXcjx9wFaQpXAP7LNSqZSDJCh0BoucDgy7f+vKnAoyU3
 9kZEJ06RWbA2Q==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id d21so4311984uap.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2019 19:08:42 -0800 (PST)
X-Gm-Message-State: AJcUukekng69dfchbNVEUGmK2LBCbzaz+Gn+U4IcQ5zAO+Uqqkon4gLU
 A8IdwzgtUr+s4moTWMfiNAuAZbNY/yoq3bdA1lM=
X-Google-Smtp-Source: ALg8bN5yNn7rtF3SmBrlBZKIYWH2L1cvvx8ESnDLVMX8f/PO9aEHv6ZgcrN1KSGSwBWHN0xOkI9BiiMhlb7+a6enrVQ=
X-Received: by 2002:ab0:3402:: with SMTP id z2mr4854577uap.6.1547176120170;
 Thu, 10 Jan 2019 19:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20190110054216.74248-1-aik@ozlabs.ru>
In-Reply-To: <20190110054216.74248-1-aik@ozlabs.ru>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 11 Jan 2019 12:08:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Message-ID: <CAK7LNAQUDMhXxku2wqq=VX2cbntMWgsvrFL4C5Bk=x1TU79wjg@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] powerpc/stack_protector: Fix external modules
 building
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 2:44 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
> c3ff2a519 "powerpc/32: add stack protector support" addes stack protector
> support so now powerpc's "prepare" target depends on prepare0 (via
> stack_protector_prepare target).
>
> It works fine until we try build an external module where it fails with:
> Run: 'make -j128 SYSSRC=/home/aik/p/kernel SYSOUT=/home/aik/pbuild/kernel-le-pseries/ ARCH=powerpc'
> make[1]: Entering directory '/home/aik/p/kernel'
> make[2]: Entering directory '/home/aik/pbuild/kernel-le-pseries'
> make[2]: *** No rule to make target 'prepare0', needed by 'stack_protector_prepare'.  Stop.
>
> The reason for that is that the main Linux Makefile defines "prepare0"
> only if KBUILD_EXTMOD=="".
>
> This hacks powerpc's Makefile to make external modules build again.
>
> Fixes: c3ff2a519 "powerpc/32: add stack protector support"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>
>
> It has been suggested that there is a better way of fixing this hence RFC.
>
>
> ---
>  arch/powerpc/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 488c9ed..0492f62 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -419,7 +419,11 @@ archheaders:
>  ifdef CONFIG_STACKPROTECTOR
>  prepare: stack_protector_prepare
>
> +ifeq ($(KBUILD_EXTMOD),)
>  stack_protector_prepare: prepare0
> +else
> +stack_protector_prepare:
> +endif


Honestly, I think this is ugly.

Do you want me to send an alternative solution?




>  ifdef CONFIG_PPC64
>         $(eval KBUILD_CFLAGS += -mstack-protector-guard-offset=$(shell awk '{if ($$2 == "PACA_CANARY") print $$3;}' include/generated/asm-offsets.h))
>  else
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
