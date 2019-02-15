Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA3C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:06:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2691D21920
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 08:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2xQN4FpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2691D21920
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4415S00x5zzDq9m
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 19:06:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.80; helo=conssluserg-01.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="2xQN4FpO"; 
 dkim-atps=neutral
Received: from conssluserg-01.nifty.com (conssluserg-01.nifty.com
 [210.131.2.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4415Q45WG2zDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 19:04:28 +1100 (AEDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x1F83tEw013174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 17:03:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1F83tEw013174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1550217836;
 bh=kHKbz0gOv35Ah/QQhnBmrwbYc/guOMnBm5JbWFvPQrQ=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=2xQN4FpOTqwbGcbGEAXjXa1e5FmcwxC1oMXIrbgyonBS8oOg+OxMYYj+BopMRwQT2
 mfw1/xYm6D1zg3Jl1C31m+Ty3OMt76hWZWvEgERXHeIj2NcKWorfDmF3TsCMkG+kmV
 D5lmyddj5bl8AR/fmRgqcJkGu+rHpx8disQoPAG7PIQGDTjlmxhrWBR6qn0Lrj/zSj
 xZFb5vpuG14b/GJNk7w1iGxO3LypxIGQ7iBEYW4S7j6HXSq57Eeha0stlVVn3CI20y
 J3tnZLR9VoaZxOcVYKN52ouG3lFuy0066/ATAokp1APUpVobxNlfeXM8t5yX8v+jL2
 8DfVCzOym/fsw==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id m20so4781627vsq.8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 00:03:56 -0800 (PST)
X-Gm-Message-State: AHQUAua4cG40BfpXvlxAhJbuJoYpQz++jwMX/QXJHiiN+Zh+6Edb7uAN
 MKZjX+qdcRH8FseAnJsonIYX7Qvq611KqKjUnD4=
X-Google-Smtp-Source: AHgI3Iahfm5Xcwy0sIHWy0ApJ/yAOiV7JONTiN2xT2/kKwRTRvgfCpC9tfWmVJeNXL9iAgxPRe2CjirFE+7P4rhB788=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr4278793vsd.155.1550217835117; 
 Fri, 15 Feb 2019 00:03:55 -0800 (PST)
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-10-hch@lst.de>
In-Reply-To: <20190213174005.28785-10-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 17:03:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQL-7fMadH1R2SrmwJyDBRoCiECJ-WSJrztO2o+wkV06w@mail.gmail.com>
Message-ID: <CAK7LNAQL-7fMadH1R2SrmwJyDBRoCiECJ-WSJrztO2o+wkV06w@mail.gmail.com>
Subject: Re: [PATCH 09/11] lib: consolidate the GENERIC_CSUM symbol
To: Christoph Hellwig <hch@lst.de>
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
Cc: linux-xtensa@linux-xtensa.org,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 2:41 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add one definition to lib/Kconfig and let the architectures
> select if it supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>



> diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
> index 52b4d48e351a..9de1d983a99a 100644
> --- a/arch/unicore32/Kconfig
> +++ b/arch/unicore32/Kconfig
> @@ -29,9 +29,6 @@ config UNICORE32
>           designs licensed by PKUnity Ltd.
>           Please see web page at <http://www.pkunity.com/>.
>
> -config GENERIC_CSUM
> -       def_bool y
> -
>  config NO_IOPORT_MAP
>         bool
>



You missed to add 'select GENERIC_CSUM' for unicore32.



-- 
Best Regards
Masahiro Yamada
