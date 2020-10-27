Return-Path: <SRS0=voBx=EC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797DC388F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6917121655
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6917121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CL8H75713zDqF3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Oct 2020 22:14:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.218.68; helo=mail-ej1-f68.google.com;
 envelope-from=k.kozlowski.k@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CL88h3SyhzDq6q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 22:08:48 +1100 (AEDT)
Received: by mail-ej1-f68.google.com with SMTP id bn26so1618456ejb.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2020 04:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vkB99++sVe3+tJ+75rrN7FpuFdKJPJ67yYVUAZtO1SM=;
 b=oGhcJLt8InXQqZsTKDiSPDJqoaUVjVXKLsEg9gcR7yD+E/bkRmPMptaxk7/0psgiXa
 jh/G9IcBJES+Q4AatIzBS6xpQB+bqHwJX8GuPWgTumxXmrcNeG8d0+KxvsPb4zF92Ov3
 SkzRsLvsp0YhJhTkB/EbJUu7uQ2HdzejaCBK0IfBL2yn9yJLSM068+q1X9CaIwwa5t+J
 d1EgYUN2+3FWLM421cBxIovE7RKzgEpIsQ3r0gegNkFcQnv+utDET4/azaMYKKZ+sWGV
 MJPwCQ1QTWaskxfBFIeF8nCoGnaNdGGLBkgppFLYZKSSy84NSvHIX8TfkbX/3uwIbhaK
 FtWQ==
X-Gm-Message-State: AOAM5327Y/jteLy4ncjDrYHfDfxKLbPPMT2mYuh6etYmvy55eRN6N6bw
 IKHSZwxLnRLMpO7s1ZkJ6RA=
X-Google-Smtp-Source: ABdhPJytrKpdjS5v/Ce2FRPg9aihFnc0X6Ds/w6A+BnKzkrLi9eW/adZBK1qCEgBBJ9aE/G7Cactyg==
X-Received: by 2002:a17:906:3acd:: with SMTP id
 z13mr1900626ejd.118.1603796923984; 
 Tue, 27 Oct 2020 04:08:43 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
 by smtp.googlemail.com with ESMTPSA id j22sm737816edp.77.2020.10.27.04.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:08:42 -0700 (PDT)
Date: Tue, 27 Oct 2020 12:08:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_aud2htx: Add binding doc for
 aud2htx module
Message-ID: <20201027110840.GA23076@kozik-lap>
References: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603708855-2663-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 tiwai@suse.com, robh+dt@kernel.org, perex@perex.cz, nicoleotsuka@gmail.com,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Oct 26, 2020 at 06:40:54PM +0800, Shengjiu Wang wrote:
> AUD2HTX (Audio Subsystem TO HDMI TX Subsystem) is a new
> IP module found on i.MX8MP.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl,aud2htx.yaml           | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> new file mode 100644
> index 000000000000..18548d0889a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,aud2htx.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,aud2htx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio Subsystem to HDMI RTX Subsystem Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^aud2htx@.*"

aud2htx is not a generic class of a device so it should not be enforced.

> +
> +  compatible:
> +    const: fsl,imx8mp-aud2htx
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock
> +
> +  clock-names:
> +    items:
> +      - const: bus
> +
> +  dmas:
> +    items:
> +      - description: DMA controller phandle and request line for TX
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +
> +  power-domains:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - dmas
> +  - dma-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx8mp-clock.h>
> +
> +    aud2htx: aud2htx@30cb0000 {
> +             compatible = "fsl,imx8mp-aud2htx";

Wrong indentation. Most of examples are indented with 4 spaces.

Best regards,
Krzysztof
