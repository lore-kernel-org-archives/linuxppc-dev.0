Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897C0C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC0A20657
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 20:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC0A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fN0X3BrrzDqV1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:55:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.193; helo=mail-oi1-f193.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fMyV4NGHzDqQJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 07:54:10 +1100 (AEDT)
Received: by mail-oi1-f193.google.com with SMTP id x202so3219352oif.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 12:54:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=tCufrnVtPaZqOkEYBnOPtUAF+6VFtPE6s/wKoCMVLps=;
 b=heSY5vjTkxVzUreaG+IOv3VIvLmVPuT1CE8zQTmvefQuqYla3lEWVzQzo+nhCFBfA6
 DBhDHSx2abz4bUWJL80InA1T3k5pYPmpkHFduqNDe8J6pxCvUfEZ+MNYrOrp31kUUoWT
 sjA5yiIif5SmQbUEU425fE800SIMc9Orpj1lp6pelW+FyqNzHpsTVVNM+rdovig6z6dr
 Fu7wAhJ2fnEoqGsIOsDDE9bA7mZb6RS16L85krfsPdDvAxmcvB9O7MweH8DVblIgKdQv
 D2poaDGxoisOXhaMpXkUW0NJc6pe0tVtAxxhyworjXk9Yd+1EwaIsgH5p3IDez9/JffA
 TT8Q==
X-Gm-Message-State: AJcUukd6fkSanPepQUUkHYpT9S/EJU6rzTx81wV8FZwteXSIvtEXFrpH
 R9CQqxv2zu6a1NuxdHUR/9Occ80=
X-Google-Smtp-Source: ALg8bN7q9lekpN6ufkUFXNwCbIBXkinQRwI9hfb5S1WrrQenRCh3yCTF4q6/rW13xAfvdmrkeHc4cg==
X-Received: by 2002:aca:ac13:: with SMTP id v19mr2866254oie.160.1547585648579; 
 Tue, 15 Jan 2019 12:54:08 -0800 (PST)
Received: from localhost ([70.231.7.113])
 by smtp.gmail.com with ESMTPSA id h24sm1929230otq.11.2019.01.15.12.54.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 15 Jan 2019 12:54:07 -0800 (PST)
Date: Tue, 15 Jan 2019 14:54:07 -0600
From: Rob Herring <robh@kernel.org>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 2/4] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190115205407.GA3442@bogus>
References: <1546952716-2743-1-git-send-email-viorel.suman@nxp.com>
 <1546952716-2743-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546952716-2743-3-git-send-email-viorel.suman@nxp.com>
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
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Cosmin Samoila <cosmin.samoila@nxp.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Viorel Suman <viorel.suman@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Jan 2019 13:05:47 +0000, Viorel Suman wrote:
> Add the DT binding documentation for NXP Audio Mixer
> CPU DAI driver.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,audmix.txt       | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
