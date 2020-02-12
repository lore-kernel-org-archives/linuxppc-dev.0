Return-Path: <SRS0=Z2Z0=4A=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5075CC2BA83
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 17:26:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C034E2082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Feb 2020 17:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLVtOPey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C034E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48Hmln0N6VzDqRR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Feb 2020 04:26:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::941;
 helo=mail-ua1-x941.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=mLVtOPey; dkim-atps=neutral
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com
 [IPv6:2607:f8b0:4864:20::941])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48Hmjn2GGTzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2020 04:24:56 +1100 (AEDT)
Received: by mail-ua1-x941.google.com with SMTP id c7so1168019uaf.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2020 09:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jCGxfylxy3MldAt/reEr7p2HcESXZ2SEVCL7ze7sb8M=;
 b=mLVtOPeyTrlGTAOEBO32ZUHoFId8CdOxxgdZYat1MHSCbZKEoRcEDicBnpT71GntOI
 jE9GscwR8WoZBDG3NW2w5NV4KY4Y8KfFRmaVsjrpAkVgBIy1+dNvlJV4eDDZDPfUqKVK
 oorEhZlJcQWCPlGU6yTKKyzkjd8lVDC09X8BRQFifOVlbdeW8BUCX8oUY+gdFrqV43ve
 A7HVKdPyoFHMCkXVqFcQSKxCEkspuET12AzZarmTfBeGT1hUgL0I2kOfIADygzgcXX0I
 HilyTVF18ofv8eL17GJwyyCw6bLnd7ieFA+NvVspb+P0wA90z7swiFmFjYi2DXaQkKOH
 2Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jCGxfylxy3MldAt/reEr7p2HcESXZ2SEVCL7ze7sb8M=;
 b=hgyVxK9YIhgp/dt3KBVZbGiVQHi8kayk74j5MBATf3M/Rxn0ZFMTzsWcX9haWWZYzT
 YezLW61ZPm8vDu8RR8qcd7aOh26uq7avQgPj2nKSLu7J3CnYexAWfbPg4X6YIwsLiENY
 xU5byU2bp0wTK9esbAr0DqK5jHQh2AKCrDUpna/NJE7oz0PiBJ3BXc1P7TJCTFnFhZzL
 7OQdMz2l1ah0CyMnngHQ83XIaThr9rw+n8v3aKn+cpE9OX5oenZoou/rqiUBUPwqu3Ok
 tRSiUSKcihQe1cg6xeRb92qd6tloKXLKlj3Ki6ISUz2vudbBVRfNL3gTmlNJwXl7MDx3
 Ubhg==
X-Gm-Message-State: APjAAAVADsJcto15VqIh+yQVF84AausHoG3HXecHBg7oW+0sO7/Y9lka
 tRXxIUijLCI5heBIauI7tjcLK/fWeC5BvmqdFI8=
X-Google-Smtp-Source: APXvYqyAepvFaN7GJfHPGtS87hCZr+gc51607hAiqYlgiF4eorNgglWZn4G42TMyi4n7UoLDOJ1DHv82wxTfkbU3tGs=
X-Received: by 2002:ab0:66d6:: with SMTP id d22mr5082237uaq.92.1581528292397; 
 Wed, 12 Feb 2020 09:24:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
 <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
In-Reply-To: <1ae9af586a2003e23885ccc7ef58ee2b1dce29f7.1581475981.git.shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 12 Feb 2020 14:24:40 -0300
Message-ID: <CAOMZO5Do=dzh4WXvm44mB7-PeesWuA6qRtMXwHCH9piXd1dZEw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: fsl_easrc: Add document for EASRC
To: Shengjiu Wang <shengjiu.wang@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 12, 2020 at 1:35 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX815.

i.MX815 in an internal terminology. Please avoid it on the commit log.

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.txt   | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.txt
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.txt b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> new file mode 100644
> index 000000000000..0e8153165e3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.txt
> @@ -0,0 +1,57 @@
> +NXP Asynchronous Sample Rate Converter (ASRC) Controller
> +
> +The Asynchronous Sample Rate Converter (ASRC) converts the sampling rate of a
> +signal associated with an input clock into a signal associated with a different
> +output clock. The driver currently works as a Front End of DPCM with other Back
> +Ends Audio controller such as ESAI, SSI and SAI. It has four context to support
> +four substreams within totally 32 channels.
> +
> +Required properties:
> +- compatible:                Contains "fsl,imx8mn-easrc".
> +
> +- reg:                       Offset and length of the register set for the
> +                            device.
> +
> +- interrupts:                Contains the asrc interrupt.
> +
> +- dmas:                      Generic dma devicetree binding as described in
> +                            Documentation/devicetree/bindings/dma/dma.txt.
> +
> +- dma-names:                 Contains "ctx0_rx", "ctx0_tx",
> +                                     "ctx1_rx", "ctx1_tx",
> +                                     "ctx2_rx", "ctx2_tx",
> +                                     "ctx3_rx", "ctx3_tx".
> +
> +- clocks:                    Contains an entry for each entry in clock-names.
> +
> +- clock-names:               "mem" - Peripheral clock to driver module.
> +
> +- fsl,easrc-ram-script-name: The coefficient table for the filters
> +
> +- fsl,asrc-rate:             Defines a mutual sample rate used by DPCM Back
> +                            Ends.
> +
> +- fsl,asrc-width:            Defines a mutual sample width used by DPCM Back
> +                            Ends.
> +
> +Example:
> +
> +easrc: easrc@300C0000 {
> +       compatible = "fsl,imx8mn-easrc";
> +       reg = <0x0 0x300C0000 0x0 0x10000>;
> +       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clk IMX8MN_CLK_ASRC_ROOT>;
> +       clock-names = "mem";
> +       dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
> +              <&sdma2 18 23 0> , <&sdma2 19 23 0>,
> +              <&sdma2 20 23 0> , <&sdma2 21 23 0>,
> +              <&sdma2 22 23 0> , <&sdma2 23 23 0>;
> +       dma-names = "ctx0_rx", "ctx0_tx",
> +                   "ctx1_rx", "ctx1_tx",
> +                   "ctx2_rx", "ctx2_tx",
> +                   "ctx3_rx", "ctx3_tx";
> +       fsl,easrc-ram-script-name = "imx/easrc/easrc-imx8mn.bin";
> +       fsl,asrc-rate  = <8000>;
> +       fsl,asrc-width = <16>;
> +       status = "disabled";
> +};
> --
> 2.21.0
>
