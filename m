Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E36C433B4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 01:37:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 646B5611AE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 01:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646B5611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmTkl6snFz3bw7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 11:37:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.52; helo=mail-ot1-f52.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmTkK3znWz2yXK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 11:37:27 +1000 (AEST)
Received: by mail-ot1-f52.google.com with SMTP id
 t10-20020a05683022eab0290304ed8bc759so16615862otc.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 18:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=PU0wqAPlfXa5ioTwymYq6yRTqRxt/LLzW8WseVv/Exo=;
 b=NAuRhtKaerwPaw/Msq+jaa9j7wcIqgTCoqi6MEyjVu9DoJ3xdCEbDkVUz+FTWMUpJC
 LxfnpigSfNu/fGckUz6P/MeZTdza3LJXELf8WYNx45VneWV+Lzb3TFPHVVLi+R2RnmT4
 dixhOkbczFpmEbHJx8VG2Ks2ywYedK0nwHF/vLx/X3lmUFAf30YZKgibkPdxW8VlKpdn
 VITewgIr89Ru+coIJs2ViTVNLvJshmUpxUu69/C728i/gWPgmf8bIybI4zi5fZpLPKZd
 qM43anVSHQJZlXAV99jLzYISCH6KiurXbtyJEexqkzza1Y9QRTu5+Wpp5zxWk61UAAuj
 ABkA==
X-Gm-Message-State: AOAM532zIwAst90ipnOrX1TWyI3CVTvMRpid45kHJB/6n2DXyGP3Oq5v
 w01uk88enKmbJFaMbkiLug==
X-Google-Smtp-Source: ABdhPJzLevEdXk1J/LS6sp90IY4zxHV2okOGcnhpXvtdzFZ2I7YcOpoKuJRUBf4lqNmPYoivs6uhpw==
X-Received: by 2002:a9d:470e:: with SMTP id a14mr6173715otf.236.1621561043894; 
 Thu, 20 May 2021 18:37:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id f8sm857214oos.33.2021.05.20.18.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 18:37:23 -0700 (PDT)
Received: (nullmailer pid 2455951 invoked by uid 1000);
 Fri, 21 May 2021 01:37:22 -0000
Date: Thu, 20 May 2021 20:37:22 -0500
From: Rob Herring <robh@kernel.org>
To: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
Subject: Re: [PATCH v2 2/4] dt-bindings: nintendo-otp: Document the Wii and
 Wii U OTP support
Message-ID: <20210521013722.GA2454145@robh.at.kernel.org>
References: <20210519095044.4109-1-linkmauve@linkmauve.fr>
 <20210519095044.4109-3-linkmauve@linkmauve.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519095044.4109-3-linkmauve@linkmauve.fr>
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Ash Logan <ash@heyquark.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 19, 2021 at 11:50:42AM +0200, Emmanuel Gil Peyrot wrote:
> Both of these consoles use the exact same two registers, even at the
> same address, but the Wii U has eight banks of 128 bytes memory while
> the Wii only has one, hence the two compatible strings.
> 
> Signed-off-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
> ---
>  .../devicetree/bindings/nvmem/nintendo-otp.txt     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/nintendo-otp.txt

Bindings should be in DT schema format now.

> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
> new file mode 100644
> index 000000000000..b26d705ec52d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/nintendo-otp.txt
> @@ -0,0 +1,14 @@
> +Nintendo Wii and Wii U OTP
> +
> +Required Properties:
> +- compatible: depending on the console this should be one of:
> +	- "nintendo,hollywood-otp" for the Wii
> +	- "nintendo,latte-otp" for the Wii U
> +- reg: base address and size of the OTP registers
> +
> +
> +Example:
> +	otp@d8001ec {
> +		compatible = "nintendo,latte-otp";
> +		reg = <0x0d8001ec 0x8>;
> +	};
> -- 
> 2.31.1
> 
