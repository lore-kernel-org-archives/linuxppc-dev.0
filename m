Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C8BC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98B65205F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ6aG/Ue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98B65205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dWXN2qcqzDqVd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 22:32:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=manivannan.sadhasivam@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="RZ6aG/Ue"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dV4n3GvJzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 21:26:28 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id b7so10150860pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 02:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
 b=RZ6aG/UeMLc3x/q1qXUBTiBXPAG9jUV8ZsjANH7ne9PfWJm7eymoitG4SLWwykixmv
 nxLvDlwa1no0v2S/OkZmEuBqoaUoMWsBR+otVwZPPAMNYPDnHTwLh700Xw91pV0Usc6y
 Fu0e4uOJFyUXzbD83A5/+LZM7p1XrhIIgNVM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=CzcCJxnbl0LzIdopm5qsKPZ2eNi80mOCKExFL5bi0I4=;
 b=dBw1T2mvSzlD8E6snWoTTtO/h1j7unHwdbWFPRCTZMSQ62R9XSi0uc0+eWt5k7YqDi
 +4xqbXQ17Pkqf8ZYEGvnX78dUMgE3ChAJ8Q03Z1qsWZuu8b2nRyqiaCEpb1vv/P3NPKH
 SHxbjCNQJZma+JQvBRroBTiGO+BKhNwJWp0fHMiItPlPB/BuYpySTkdmSjtgasz1fLxl
 KFrUSwHupiIKMGgK1SKMi8kma5OYOmNB1bqWfjy7DSJLHT/0JD+a+yzZPqC+aZ604HLD
 oy+z6EH+aEFWeEDDntNuCMvbl38dBPEf5pY/jR1UNPiFE9XO24rXvuN5KI9VfEZO5vqL
 ja4w==
X-Gm-Message-State: AJcUukdEF9JYCLWXoSOa91NMVCgvnToURLV3fIABUWXsPkBHJSeKEcin
 bkmilQX2KJLKrkc7zWo+izWx
X-Google-Smtp-Source: ALg8bN5E/GLwEsy8uAR2BAL7TYdCum31eDVFue3S1vnmVsc49NhDEiiFgLqKF2MzXd1Yh1KAwuN/sQ==
X-Received: by 2002:a62:5fc4:: with SMTP id t187mr24930399pfb.66.1547461586717; 
 Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6306:f12b:7d9b:d1a4:6536:aa21])
 by smtp.gmail.com with ESMTPSA id l185sm114470pfl.54.2019.01.14.02.26.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 14 Jan 2019 02:26:26 -0800 (PST)
Date: Mon, 14 Jan 2019 15:56:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de
Subject: Re: [PATCH v2 10/34] dt-bindings: arm: Convert Actions Semi bindings
 to jsonschema
Message-ID: <20190114102614.GC13162@Mani-XPS-13-9360>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-11-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203213223.16986-11-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Mon, 14 Jan 2019 22:30:25 +1100
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
Cc: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Grant Likely <grant.likely@arm.com>, Frank Rowand <frowand.list@gmail.com>,
 Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 03, 2018 at 03:31:59PM -0600, Rob Herring wrote:
> Convert Actions Semi SoC bindings to DT schema format using json-schema.
> 

Andreas,

Shall I just apply this patch to Actions sub-tree?

Thanks,
Mani

> Cc: "Andreas Färber" <afaerber@suse.de>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
>  2 files changed, 38 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
> deleted file mode 100644
> index d54f33c4e0da..000000000000
> --- a/Documentation/devicetree/bindings/arm/actions.txt
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -Actions Semi platforms device tree bindings
> --------------------------------------------
> -
> -
> -S500 SoC
> -========
> -
> -Required root node properties:
> -
> - - compatible :  must contain "actions,s500"
> -
> -
> -Modules:
> -
> -Root node property compatible must contain, depending on module:
> -
> - - LeMaker Guitar: "lemaker,guitar"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Allo.com Sparky: "allo,sparky"
> - - Cubietech CubieBoard6: "cubietech,cubieboard6"
> - - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
> -
> -
> -S700 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s700"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - Cubietech CubieBoard7: "cubietech,cubieboard7"
> -
> -
> -S900 SoC
> -========
> -
> -Required root node properties:
> -
> -- compatible :  must contain "actions,s900"
> -
> -
> -Boards:
> -
> -Root node property compatible must contain, depending on board:
> -
> - - uCRobotics Bubblegum-96: "ucrobotics,bubblegum-96"
> diff --git a/Documentation/devicetree/bindings/arm/actions.yaml b/Documentation/devicetree/bindings/arm/actions.yaml
> new file mode 100644
> index 000000000000..60abd371e474
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/actions.yaml
> @@ -0,0 +1,38 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/actions.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Actions Semi platforms device tree bindings
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      # The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
> +      - items:
> +          - enum:
> +              - allo,sparky # Allo.com Sparky
> +              - cubietech,cubieboard6 # Cubietech CubieBoard6
> +          - const: actions,s500
> +      - items:
> +          - enum:
> +              - lemaker,guitar-bb-rev-b # LeMaker Guitar Base Board rev. B
> +          - const: lemaker,guitar
> +          - const: actions,s500
> +
> +      # The Actions Semi S700 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - cubietech,cubieboard7 # Cubietech CubieBoard7
> +          - const: actions,s700
> +
> +      # The Actions Semi S900 is a quad-core ARM Cortex-A53 SoC.
> +      - items:
> +          - enum:
> +              - ucrobotics,bubblegum-96 # uCRobotics Bubblegum-96
> +          - const: actions,s900
> -- 
> 2.19.1
> 
