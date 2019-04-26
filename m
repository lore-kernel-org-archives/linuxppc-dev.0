Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B8C43218
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F198A206C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F198A206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44rGHR2MTSzDqhY
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Apr 2019 00:13:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44rGD91bl9zDqgb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Apr 2019 00:10:32 +1000 (AEST)
Received: by mail-oi1-f193.google.com with SMTP id l203so3043785oia.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 07:10:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8v9DH79LZGkh+kC4t48ObZxoaexvFW5xWdyB9L1ZiiY=;
 b=bgjjQqdWHfJHNpe1k58fvJueDAqUG6JtuVmW6Qwm/x2udXQqPDE+Z0zX/PhEdO6LuI
 K7Zl32aZrKNUQn6lerTt2ITXlG2QXuDL/EYQfNfVui7jf0+/YGffK0DcCMkBYQsJRdeS
 sXIzacrldKPSQakPe0H6y8CdzxdVwspx/Y0XGrn1+P6lvoj8ceGif28YpwnCloBbo8ej
 QXujd1xJmRAj7dK1CKFNIHnoIaiRJHzfrKITCgwtXNcxr8pw1IwEKa194xdjhXaRgiFK
 ddhmyLokVbCzx58QvXW2KseosbnyA1DzVcilzn+UQ2X0ypP0aanAGldgTE6EwtRIEoLR
 4GLA==
X-Gm-Message-State: APjAAAX0QVqw6QN5jPizPqq/moK8MSmeAAzwHGR6kKMAxX07PyatnHRB
 d9ABqpGHCeIhLSPDZzgWiA==
X-Google-Smtp-Source: APXvYqzep6Kpkuzni+CTxXftgX5vn9rtgx9vdMLHNbJl/akS2tn94vZEcsdpiJMSmV5sSqC7U+UubQ==
X-Received: by 2002:aca:dcc4:: with SMTP id t187mr7488561oig.3.1556287828943; 
 Fri, 26 Apr 2019 07:10:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p205sm10213668oia.49.2019.04.26.07.10.27
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 26 Apr 2019 07:10:28 -0700 (PDT)
Date: Fri, 26 Apr 2019 09:10:27 -0500
From: Rob Herring <robh@kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v10 15/18] dt-bindings: counter: ftm-quaddec
Message-ID: <20190426141027.GA27110@bogus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
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
Cc: mark.rutland@arm.com, benjamin.gaignard@st.com, linux-pwm@vger.kernel.org,
 linux-iio@vger.kernel.org, patrick.havelange@essensium.com,
 thierry.reding@gmail.com, pmeerw@pmeerw.net, shawnguo@kernel.org,
 lars@metafoo.de, daniel.lezcano@linaro.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 david@lechnology.com, tglx@linutronix.de, fabrice.gasnier@st.com,
 esben@haabendal.dk, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, knaack.h@gmx.de, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, jic23@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 02, 2019 at 03:30:50PM +0900, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> FlexTimer quadrature decoder driver.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
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
> +
> +Required properties:
> +- compatible:		Must be "fsl,ftm-quaddec".

This needs an SoC specific compatible.

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

Don't show status in examples.

> +		};
> -- 
> 2.21.0
> 
