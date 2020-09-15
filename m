Return-Path: <SRS0=6Pj3=CY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248FDC43461
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 01:04:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2C620897
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 01:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2C620897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Br4l04Rt7zDqSN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2020 11:04:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.166.193;
 helo=mail-il1-f193.google.com; envelope-from=robherring2@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com
 [209.85.166.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Br4j26w0yzDqQk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2020 11:03:02 +1000 (AEST)
Received: by mail-il1-f193.google.com with SMTP id a8so1454310ilk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2020 18:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xcbN9iKTXDr7Aos7+pozhifKeLZIE17W1Yh8urQPGxY=;
 b=nLsovkd04GCYoZcmHp/jw8H5F6IVCu3AEfkWkMxei85hZId8iPB9hJwU+jyliV42tl
 4gUdwfwhuc3fPXkunt25ao9xrqLwif3E8Q/NAb4OV278cRQA6iRy/c/5ouycgHV92wM1
 czaYcKt8Vg6BstR1Ie/ws24R4YFWy+8yEEh2qX8XFfFaLX2vXxGjgKDC9hSTb9oMIF6X
 AajwEw99oLK8RbRzPZnxvbtyIEwCEej+dTyKJB+J2SPSW4yJLUn/PQYIat0VZosFS+g+
 siX9aP1tMoNTStuHlafz68JWkUncFM1WOdsXX8/3EfkUmkXhsIAgZzb/BcoPx8sgRtlY
 33rQ==
X-Gm-Message-State: AOAM530KbRxyTR9qUxd1cRqTgeMhXjl9jCirCDRaaj2+izc6l1vc+Lln
 z5LMzxMyjlEceub/PjTQkA==
X-Google-Smtp-Source: ABdhPJwADcHTTX8ykmWhIg1RbZQXXVUi9q14Cx8OKh2wwKij6EZxvnlf1fyQFPnwV22wrzrdT8Qy9w==
X-Received: by 2002:a05:6e02:f06:: with SMTP id
 x6mr12734734ilj.222.1600131779984; 
 Mon, 14 Sep 2020 18:02:59 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id m7sm8082416ili.26.2020.09.14.18.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 18:02:59 -0700 (PDT)
Received: (nullmailer pid 623833 invoked by uid 1000);
 Tue, 15 Sep 2020 01:02:58 -0000
Date: Mon, 14 Sep 2020 19:02:58 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Lamparter <chunkeey@gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: powerpc: define apm,apm82181 binding
Message-ID: <20200915010258.GA612463@bogus>
References: <cover.1599343429.git.chunkeey@gmail.com>
 <aa51a2aaffcbf98c90d378f6f6c7b926989b6c27.1599343429.git.chunkeey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa51a2aaffcbf98c90d378f6f6c7b926989b6c27.1599343429.git.chunkeey@gmail.com>
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
Cc: devicetree@vger.kernel.org, Chris Blake <chrisrblake93@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Sep 06, 2020 at 12:06:11AM +0200, Christian Lamparter wrote:
> make a binding for the various boards based on the
> AppliedMicro/APM APM82181 SoC.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  .../bindings/powerpc/4xx/apm,apm82181.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/4xx/apm,apm82181.yaml
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/4xx/apm,apm82181.yaml b/Documentation/devicetree/bindings/powerpc/4xx/apm,apm82181.yaml
> new file mode 100644
> index 000000000000..03a3c02fe920
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/4xx/apm,apm82181.yaml
> @@ -0,0 +1,29 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/powerpc/4xx/apm,apm82181.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: APM APM82181 device tree bindings
> +
> +description:
> +  AppliedMicro APM82181 Wi-Fi/network SoCs based
> +  on the PPC464-CPU architecture.
> +
> +maintainers:
> +  - Christian Lamparter <chunkeey@gmail.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: APM82181 based boards
> +        items:
> +          - enum:
> +              - apm,bluestone
> +              - meraki,mr24
> +              - wd,mybooklive
> +          - const: amcc,apm82181

This doesn't match neither the existing dts nor your modifications.
