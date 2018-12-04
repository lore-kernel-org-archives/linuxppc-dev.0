Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DD2C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:44:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF0B2087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 11:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF0B2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Kl43VKCzDq8Y
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 22:44:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=free-electrons.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=free-electrons.com
 (client-ip=62.4.15.54; helo=mail.bootlin.com;
 envelope-from=antoine.tenart@free-electrons.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=free-electrons.com
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 438Dck3n2wzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 18:53:05 +1100 (AEDT)
Received: by mail.bootlin.com (Postfix, from userid 110)
 id B545A207B0; Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr
 [90.88.18.158])
 by mail.bootlin.com (Postfix) with ESMTPSA id 7F9DD20736;
 Tue,  4 Dec 2018 08:53:02 +0100 (CET)
Date: Tue, 4 Dec 2018 08:53:02 +0100
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 11/34] dt-bindings: arm: Convert Alpine board/soc
 bindings to json-schema
Message-ID: <20181204075302.GC3173@kwain>
References: <20181203213223.16986-1-robh@kernel.org>
 <20181203213223.16986-12-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203213223.16986-12-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Tue, 04 Dec 2018 22:41:43 +1100
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
 Kumar Gala <kumar.gala@linaro.org>, arm@kernel.org,
 Sean Hudson <darknighte@darknighte.com>, Frank Rowand <frowand.list@gmail.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-kernel@vger.kernel.org, Grant Likely <grant.likely@arm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rob,

On Mon, Dec 03, 2018 at 03:32:00PM -0600, Rob Herring wrote:
> diff --git a/Documentation/devicetree/bindings/arm/al,alpine.yaml b/Documentation/devicetree/bindings/arm/al,alpine.yaml
> new file mode 100644
> index 000000000000..82e2fafdfece
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/al,alpine.yaml
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/al,alpine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Annapurna Labs Alpine Platform Device Tree Bindings
> +
> +maintainers:
> +  - Tsahee Zidenberg <tsahee@annapurnalabs.com>

Could you add '- Antoine Tenart <antoine.tenart@bootlin.com>' here?

Thanks!
Antoine

> +description: test
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: al,alpine
> +  model:
> +    items:
> +      - const: "Annapurna Labs Alpine Dev Board"
> +
> +...
> -- 
> 2.19.1
> 

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
