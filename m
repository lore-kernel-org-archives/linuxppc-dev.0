Return-Path: <SRS0=8b8/=EE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F299C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 22:11:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784A92087D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2020 22:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHz77CTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784A92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMfmd70ZzzDqcj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 09:11:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=jingoohan1@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=CHz77CTX; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMfk62186zDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 09:09:30 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so3491846pgk.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2020 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:thread-topic:thread-index:date:message-id
 :references:in-reply-to:accept-language:content-language
 :content-transfer-encoding:mime-version;
 bh=U8lXi8OOUAKAM9HahPF2MhkRdpGxM+5pjA1LOCJjWUc=;
 b=CHz77CTXIopVkDxKJbskTpevdxOSErQasxAubh+6XkNKbmt/zLZmVMXibi5/HjH/pS
 zIbuovqvbQ744DbkJN2jcoQdGJGyQwaAgfc3fjciWEMeOu4Okb0yGJEs6nXkzuKqT2jv
 95HlWsYsbQYe7Z6O1TyIZfvd0yOeIm5oh4f28/B+3RwEHyqhPQt3QsoK8RoqZySOSGL6
 iZ5S16MRosVlHePQlw6lxoW05ZwRHCvZ8Zdb3p5J8KoN9KWq899H8ajHZu+9NdJi1LkH
 Ei4CHD9QIBNsUSZ4b7X4QVRuZv6pl0yk4T1r44uSVYWRc1FlfRksdP88IOS3alDxWRhH
 YsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
 :date:message-id:references:in-reply-to:accept-language
 :content-language:content-transfer-encoding:mime-version;
 bh=U8lXi8OOUAKAM9HahPF2MhkRdpGxM+5pjA1LOCJjWUc=;
 b=Wm7zQVyH/R5rKaFZQXp2WWKXdF14cIDy4Ut4J1Y0+uRMFd1njT1+Od7ostFYKPfWA5
 dy+4ltfg269KG3tP9b8fqOMr1KVZ/KAVRw4C1J4yptuHKAYbduyt0O1jdWJXlFtUhEQS
 sPxQLphMjcTPaVnhfPldexVX3S3V4a0TF/nndYZ4NndPhAJ8aCrUZompecXECE60ujdO
 DWdZ5/9Hc7DtejAijYjdHW92aw/dIH7qVuIhcp3g9JAxGv23S6EYOAPu6PVPQvyTRLLe
 nT/sKeyLQJdNp08hVvkj/gwsRmn3w7b8okUoaEjgT0KlNm/v60DXfCIv/xNIYmaZqDR1
 cwpg==
X-Gm-Message-State: AOAM533h7waIiJdBLOHeXyA/jXd+2bzxkoMyWcmJQhFqWzqS7N5xAdRP
 YWdpl06La9dplfT/CYYlOzo=
X-Google-Smtp-Source: ABdhPJySlPJX+5wSZiGXs3aTLYF3FP4syhZTj4GSQN2pZhFq/YPl9Z6nMYMsZfnD64YioPfafQ+hGg==
X-Received: by 2002:a17:90a:ef81:: with SMTP id
 m1mr1995068pjy.212.1604009367153; 
 Thu, 29 Oct 2020 15:09:27 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
 by smtp.gmail.com with ESMTPSA id
 s38sm3556477pgm.62.2020.10.29.15.09.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2020 15:09:26 -0700 (PDT)
From: Jingoo Han <jingoohan1@gmail.com>
To: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 03/13] PCI: dwc: Move "dbi", "dbi2", and "addr_space"
 resource setup into common code
Thread-Topic: [PATCH 03/13] PCI: dwc: Move "dbi", "dbi2", and "addr_space"
 resource setup into common code
Thread-Index: AQHWrWt+/uCmOjVzWE+cqKXErEipD6mvJWds
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Thu, 29 Oct 2020 22:09:15 +0000
Message-ID: <SL2P216MB04752DF9839E1CCC8D1B1706AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201028204646.356535-1-robh@kernel.org>
 <20201028204646.356535-4-robh@kernel.org>
In-Reply-To: <20201028204646.356535-4-robh@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Neil Armstrong <narmstrong@baylibre.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Binghui Wang <wangbinghui@hisilicon.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jonathan Chocron <jonnyc@amazon.com>, Shawn Guo <shawnguo@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Fabio Estevam <festevam@gmail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Jesper Nilsson <jesper.nilsson@axis.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Minghuan Lian <minghuan.Lian@nxp.com>, Kevin Hilman <khilman@baylibre.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>,
 Kukjin Kim <kgene@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Xiaowei Song <songxiaowei@hisilicon.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Yue Wang <yue.wang@Amlogic.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Andy Gross <agross@kernel.org>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Han Jingoo <jingoohan1@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Lucas Stach <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 10/28/20, 4:46 PM, Rob Herring wrote:
>=20
> Most DWC drivers use the common register resource names "dbi", "dbi2", an=
d
> "addr_space", so let's move their setup into the DWC common code.
>
> This means 'dbi_base' in particular is setup later, but it looks like no
> drivers touch DBI registers before dw_pcie_host_init or dw_pcie_ep_init.
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Murali Karicheri <m-karicheri2@ti.com>
> Cc: Minghuan Lian <minghuan.Lian@nxp.com>
> Cc: Mingkai Hu <mingkai.hu@nxp.com>
> Cc: Roy Zang <roy.zang@nxp.com>
> Cc: Jonathan Chocron <jonnyc@amazon.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Xiaowei Song <songxiaowei@hisilicon.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
> Cc: Pratyush Anand <pratyush.anand@gmail.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-omap@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@axis.com
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  8 ----
>  drivers/pci/controller/dwc/pci-keystone.c     | 29 +-----------
>  .../pci/controller/dwc/pci-layerscape-ep.c    | 37 +--------------
>  drivers/pci/controller/dwc/pcie-al.c          |  9 +---
>  drivers/pci/controller/dwc/pcie-artpec6.c     | 43 ++----------------
>  .../pci/controller/dwc/pcie-designware-ep.c   | 29 ++++++++++--
>  .../pci/controller/dwc/pcie-designware-host.c |  7 +++
>  .../pci/controller/dwc/pcie-designware-plat.c | 45 +------------------
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  4 --
>  drivers/pci/controller/dwc/pcie-kirin.c       |  5 ---
>  drivers/pci/controller/dwc/pcie-qcom.c        |  8 ----
>  drivers/pci/controller/dwc/pcie-spear13xx.c   | 11 +----
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 22 ---------
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 38 +---------------
>  drivers/pci/controller/dwc/pcie-uniphier.c    |  6 ---
>  15 files changed, 47 insertions(+), 254 deletions(-)

[...]
