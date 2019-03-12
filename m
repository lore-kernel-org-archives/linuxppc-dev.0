Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89886C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 19:11:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0482087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 19:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0482087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jl2F2RnXzDqGL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 06:11:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.196; helo=mail-oi1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jl0P1ymGzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 06:09:56 +1100 (AEDT)
Received: by mail-oi1-f196.google.com with SMTP id k11so2511551oic.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 12:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jJKOnB1P9PKNpKShB0uPqUX+B71dLq4m19fT/OZ0LME=;
 b=iX6qczHQQYcJQTKiBxhmHM/A3O03ORWHQ25AGJV/BZr2aBC+zaSbvFCP8e+7e8XMHN
 b0FHszU0vt5pFb4wVB93FSYAHHhg3fcCI70ZEanjPqJdaDFbYxDvjz8H9XAM6fG8peZ2
 VA4TZsvokfnj7I7TPVwR91xhbxrp8Gk8yIXIdk6Lh2MMtxODkQsVynzKy+2x9MykWSHn
 FxU3FIlZtiDe6ibXeSl/1R0k8oMZF+U5xS/mcW/b/8ks/vBxCtUmlQGK4Yw/zqC/wp35
 D6PlypGu5Q86k0tuPF8tL2NAlRFRTrtS7vdu5K71MRt2t/MhPSKonNQBQ7TGN9NX3WmV
 E9qw==
X-Gm-Message-State: APjAAAWcai3H3iN+bsSS0wIdN9Wsr8nCTt4it0Ox7V/lZ1V6iFoZHzes
 WiVl/XtmPjhq0vq32l463Q==
X-Google-Smtp-Source: APXvYqzOmYiyevn4pfx/OmhV9QmJPBrm3c1cxWiC68YfOw7IRUa9Y5zI+wZ8qBznprpY0q72PHFdMw==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr2810071oig.92.1552417793942; 
 Tue, 12 Mar 2019 12:09:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id l93sm3981536otc.15.2019.03.12.12.09.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 12 Mar 2019 12:09:53 -0700 (PDT)
Date: Tue, 12 Mar 2019 14:09:52 -0500
From: Rob Herring <robh@kernel.org>
To: Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: counter: ftm-quaddec
Message-ID: <20190312190952.GA18547@bogus>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
 <20190306111208.7454-5-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306111208.7454-5-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>,
 linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Li Yang <leoyang.li@nxp.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Shawn Guo <shawnguo@kernel.org>, Esben Haabendal <esben@haabendal.dk>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 06, 2019 at 12:12:05PM +0100, Patrick Havelange wrote:
> FlexTimer quadrature decoder driver.
> 
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> ---
> Changes v2
>      - None
> ---
>  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> new file mode 100644
> index 000000000000..4d18cd722074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> @@ -0,0 +1,18 @@
> +FlexTimer Quadrature decoder counter
> +
> +This driver exposes a simple counter for the quadrature decoder mode.

Seems like this is more a mode of a h/w block than describing a h/w 
block. Bindings should do the latter.

> +
> +Required properties:
> +- compatible:		Must be "fsl,ftm-quaddec".
> +- reg:			Must be set to the memory region of the flextimer.
> +
> +Optional property:
> +- big-endian:		Access the device registers in big-endian mode.
> +
> +Example:
> +		counter0: counter@29d0000 {
> +			compatible = "fsl,ftm-quaddec";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			big-endian;
> +			status = "disabled";
> +		};
> -- 
> 2.19.1
> 
