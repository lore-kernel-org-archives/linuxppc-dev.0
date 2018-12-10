Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67256C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D956820855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9o0Iybl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D956820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D68j736wzDqxB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:15:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c9o0Iybl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=robh@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="c9o0Iybl"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D65m3L4RzDqtv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 02:13:16 +1100 (AEDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D3F72086D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544454794;
 bh=dDdcSD7bp88X/qUQ7li/kWdFcWPzomLjZ2LS0nIncr8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=c9o0Iybl72eNWTMT+2cl59R8cWmnK8rbuggLVw+zX2Jm6XhhHZc3sCL9uerXFypsj
 oHoXNUgyqhzUSGql/3wG8n8BnoZgyFZ5S2A7s+lHP32MIq9imbSzu3/gvmZoOsoHrF
 CXQvyhVZwbzuwLs8pajnFvxWpl5FEo0EiVBKROOM=
Received: by mail-qt1-f174.google.com with SMTP id z16so12631466qtq.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 07:13:14 -0800 (PST)
X-Gm-Message-State: AA+aEWbqzZE+80SHoo91UtSieZrPJ6F3B4m409slAkt8HUmVKlrVnXe/
 MApueaPpBXYCEvBobb3yY5BRe9ANjA6G7aWQeg==
X-Google-Smtp-Source: AFSGD/UiArMNFA82E9QwxjiY0qfhpCbk+7rMiWiC+7FVOKqgbNQMOEyhls+PoQniOcLqNQkSqw079lkOVCqQCfwGZlY=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr12028373qtd.257.1544454793279; 
 Mon, 10 Dec 2018 07:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <3170130.k0DT9deCHj@phil>
 <CAL_JsqLwSg=CWQYzvfCq9WVexU5donsF6ugib2ONNN3vvjzZXw@mail.gmail.com>
 <2386212.ILKoqq0Ivo@phil>
In-Reply-To: <2386212.ILKoqq0Ivo@phil>
From: Rob Herring <robh@kernel.org>
Date: Mon, 10 Dec 2018 09:13:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
Message-ID: <CAL_JsqL9PyD=0jy+GF5g8ee-FO_ijvArnzEohuvqK5Od3yr7fg@mail.gmail.com>
Subject: Re: [PATCH v2.1 24/34] dt-bindings: arm: Convert Rockchip board/soc
 bindings to json-schema
To: "heiko@sntech.de" <heiko@sntech.de>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Kumar Gala <kumar.gala@linaro.org>, ARM-SoC Maintainers <arm@kernel.org>,
 Sean Hudson <darknighte@darknighte.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 Grant Likely <grant.likely@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Dec 9, 2018 at 4:14 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Convert Rockchip SoC bindings to DT schema format using json-schema.
>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-rockchip@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> [move to per-board entries and added recently added boards]
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Hi Rob,
>
> there are boards where the description adds much value and on others
> it is maybe less, but personally I'd like to keep things uniform,
> as that makes reading these things easier if the format stays the
> same all the time, so I've gone forward and just did the conversion
>
> make dtbs_check did not complain about the schema it seems but I
> did end up with an error later on:
>
> FATAL ERROR: Unknown output format "yaml"
> make[2]: *** [scripts/Makefile.lib:313: arch/arm/boot/dts/rk3036-evb.dt.yaml] Fehler 1

You need libyaml and its headers installed so dtc can output yaml, but
that's not needed for checking the schema against the meta-schema.

> But I guess I did not mess up the schema yet.
>
> So does it look ok that way?

Yes, but one comment...

> +      - description: Firefly Firefly-RK3288
> +        items:
> +          - const: firefly,firefly-rk3288
> +          - const: rockchip,rk3288
> +
> +      - description: Firefly Firefly-RK3288 (beta board)
> +        items:
> +          - const: firefly,firefly-rk3288-beta
> +          - const: rockchip,rk3288
> +
> +      - description: Firefly Firefly-RK3288 Reload

Seems like combining these 3 (or first 2?) would make sense if this is
just revs of the same board.

But either way is fine.

> +        items:
> +          - const: firefly,firefly-rk3288-reload
> +          - const: rockchip,rk3288
