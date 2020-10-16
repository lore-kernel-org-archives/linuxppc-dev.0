Return-Path: <SRS0=n4ep=DX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A31C433E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 23:14:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF64E20878
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2020 23:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Pge7Xeim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF64E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CChmN08HSzDr37
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2020 10:13:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=googlemail.com (client-ip=2a00:1450:4864:20::642;
 helo=mail-ej1-x642.google.com;
 envelope-from=martin.blumenstingl@googlemail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=googlemail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=googlemail.com header.i=@googlemail.com
 header.a=rsa-sha256 header.s=20161025 header.b=Pge7Xeim; 
 dkim-atps=neutral
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCdVX1yfwzDqwr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2020 07:46:38 +1100 (AEDT)
Received: by mail-ej1-x642.google.com with SMTP id p5so5104835ejj.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2020 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mAY0QDFqvIDjx5HUOQ+MdvNYA3kylWMqxJWjR23AFzk=;
 b=Pge7XeimtOGQPWwobIeFhAVFY6hovQZpX0ZLcKzZ8AVgQQQ672h2NV6G4tVk7cpmI+
 1+gpE/GaiJ6rOXia2sUQl2tkgPYRwpujI/1jI9yUuZbMHNhhdIPSSFFZisDCvdGyMNCm
 Bv7XKMjurquBEjLiG0g7MIjYLAxlPxapoizFVEWiVkAHI83UW9jV/Zr0Oj+Y0jv0AGkL
 cttkNhvMmB1Ql9iOu8/GJqu+JOcP+inoZKVjC8g7gRUssTThoHFHguWhzOQMKNXZP0Bi
 /t44sdZ14d2mGGgRgIH93pq2zHZDD0h2Gi9RGZg69aSc7fX52eFBBVlYAcrwgabfDNox
 6p+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mAY0QDFqvIDjx5HUOQ+MdvNYA3kylWMqxJWjR23AFzk=;
 b=aYsGi4RYDy+oPjSL8SP1+oT6qvYFFyQJ2Vv58UanMbH3Tjrd7bqTizMQdGwsDKqqvb
 cik4sIvp/7jbapmhGSlSecy2TfZ3tg8kosWZ0CTm0/winkDk6Y66owqFkbcyOzPnV30Q
 r1etfExsDJuZGWvGsYguaSgoyaHuUvkriU5nuMjbhArCAjb6v80vviKfZEc9cYqJgFYq
 ydXqPXgcPR331lQ3KW/Lsrcw3IrSl4rLZ9T2cG67MTQP7mjSteMLRR0kLlnAd5TYKsUC
 yT9hIVMJrsQ0SZvevF1t26zZoFJx7fZvpAYpvc2MMeqH2Kyl80JQg+yzw2UXrx910lZ7
 QLVw==
X-Gm-Message-State: AOAM532CCZtOwsS4xHeCAi0NuLS5BXHBCf8feNOM+epmBsaHsgG4rLtU
 g2TclMGRGoiU60Tswwy9tdM79Cnirs8K/OR/ZpM=
X-Google-Smtp-Source: ABdhPJzZH9WV53owno/ZkjiRehR4EVV/83Ve6RR9ZDeTZs5Z1Fi5I5Jf9JSdZ0IMRjggvROTLl8Mkpi59PwKfkncEXs=
X-Received: by 2002:a17:906:cc0d:: with SMTP id
 ml13mr5630435ejb.2.1602881195652; 
 Fri, 16 Oct 2020 13:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201014101402.18271-1-Sergey.Semin@baikalelectronics.ru>
 <20201014101402.18271-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201014101402.18271-15-Sergey.Semin@baikalelectronics.ru>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 16 Oct 2020 22:46:24 +0200
Message-ID: <CAFBinCDYu+C62P37QjY75xG8iXa+MwZEL-agNhoOsaXQ0OQpgQ@mail.gmail.com>
Subject: Re: [PATCH 14/20] dt-bindings: usb: meson-g12a-usb: Fix FL-adj
 property value
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 17 Oct 2020 10:12:34 +1100
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
Cc: Neil Armstrong <narmstrong@baylibre.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Andy Gross <agross@kernel.org>, linux-snps-arc@lists.infradead.org,
 devicetree@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Rob Herring <robh+dt@kernel.org>, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>, linux-kernel@vger.kernel.org,
 Manu Gautam <mgautam@codeaurora.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Oct 14, 2020 at 12:14 PM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
>
> An empty snps,quirk-frame-length-adjustment won't cause any change
> performed by the driver. Moreover the DT schema validation will fail,
> since it expects the property being assigned with some value. So set
> fix the example by setting a valid FL-adj value in accordance with
> Neil Armstrong comment.
>
> Link: https://lore.kernel.org/linux-usb/20201010224121.12672-16-Sergey.Semin@baikalelectronics.ru/
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
