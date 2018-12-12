Return-Path: <SRS0=1eNT=OV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D8C65BAE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 03:12:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8D9420839
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 03:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mzqSbOCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D9420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43F21D3mFpzDqsX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 14:12:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="mzqSbOCk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.83; helo=conssluserg-04.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="mzqSbOCk"; 
 dkim-atps=neutral
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F1tN1QQCzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 14:06:35 +1100 (AEDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com
 [209.85.217.45]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id wBC36AZ8002116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 12:06:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wBC36AZ8002116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1544583971;
 bh=6N6RaQ3wOc5su8qLy+bJz8CBzbjrgjGBbfJL+Zs0A8I=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=mzqSbOCkOEqhbf4OQ0ewjDCoQoQA3IgGMlZn6sN4Ms0Dtjegs8WHUWfW5iVumz7EF
 WsAUNlQ6ZXf5IAqJZMnspq8yfyFQpF8NbOMDzQOEZ1lzjUNs+1Wov7ABnWEXpZQjDl
 F6stobTLy7H/XeLSRlyWCI2TTqqz8I58Ao2/PUvxoHjFRhnPLnCjRoBtSQRItqEILP
 +rrHSmsS5cfrnCPCrksPhcNT/WLjfOCH8qwbWcJW0F+tCgldZ0R29uGUnmJCtFShcX
 G4ADaFBvO9yHdlYyr/kmDxWAqrHYQXQTVl8lLCQ4HEfTzroBErKC3tTzNTu9SBS05g
 8wRKpdiJXrF+w==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id b74so10215297vsd.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 19:06:11 -0800 (PST)
X-Gm-Message-State: AA+aEWaCsSUeeZpL6KBxnzSv6bVr/4wdkrzhNFCk5Tz7oTgG22frjf5k
 fiOL8pokvtMjSBKJCVdNzgud0tOTYCVVGCA9I9s=
X-Google-Smtp-Source: AFSGD/VERKFbaF0SBtxWKtriGXKkGFdxuiwSlwd3i91soixgKZm5tqCgfSyRuHTxgC3c6MPKZTcle5pStFMzaQADVac=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr8404903vsm.181.1544583970188; 
 Tue, 11 Dec 2018 19:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org>
In-Reply-To: <20181211202406.27721-1-robh@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 12 Dec 2018 12:05:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkR-V+tuhSytcdEhvBX6wosKQBuWo57Qo7fqdxyGFq_Q@mail.gmail.com>
Message-ID: <CAK7LNAQkR-V+tuhSytcdEhvBX6wosKQBuWo57Qo7fqdxyGFq_Q@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To: Rob Herring <robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
 darknighte@darknighte.com, Jonathan Corbet <corbet@lwn.net>,
 Frank Rowand <frowand.list@gmail.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Michal Marek <michal.lkml@markovi.net>, grant.likely@arm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Dec 12, 2018 at 5:24 AM Rob Herring <robh@kernel.org> wrote:
>
> This adds the build infrastructure for checking DT binding schema
> documents and validating dts files using the binding schema.
>
> Check DT binding schema documents:
> make dt_binding_check
>
> Build dts files and check using DT binding schema:
> make dtbs_check
>
> Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> use for validation. This makes it easier to find and fix errors
> generated by a specific schema.
>
> Currently, the validation targets are separate from a normal build to
> avoid a hard dependency on the external DT schema project and because
> there are lots of warnings generated.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: linux-doc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v4:
> - Rework libyaml check and error message with Masahiro's version
> - Simplify build rules and dependencies
>


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


-- 
Best Regards
Masahiro Yamada
