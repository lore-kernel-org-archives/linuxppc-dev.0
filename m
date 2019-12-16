Return-Path: <SRS0=uftn=2G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2417C43603
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 21:42:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676B820717
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 21:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676B820717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cF9x04tjzDqS9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 08:42:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.65; helo=mail-ot1-f65.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cF7k3Cd4zDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2019 08:40:49 +1100 (AEDT)
Received: by mail-ot1-f65.google.com with SMTP id f71so1330125otf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2019 13:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=w/B4Ufn2vEQWN8qDF+PdKshh4CtUrJHulKoVBKykf+I=;
 b=B36z22IVga4BA7qv+R00v+KT6xd008XPm2YDpMqwks4WfgMI7D3Qvo9sHkSKQMko0F
 G3pW1rF61v80EVZgLvJwJ/fUMXUdcgbIUeQfWWFN/zCpWGAvS6uM2ietcfXl9ydNXfqr
 m6GmiNUgqMuXKUnfA0IOXCi5EOBFmNkORUFUSrJelVa9eu9XRGhIK0xwibGmUoToyUMR
 1zrlFkVAOLaZ2j3+WnU+6Hp2BxLA04dNCoO+ly1S7O2/XUJXDxitRkre8ihQhICiiwPy
 cqPlH8JvghXSjDPtc0MpQbIJLRg+Z/Nf49gGoVD3IMbY/is5ky7OkIdcbwoiRgyphRGx
 Cllg==
X-Gm-Message-State: APjAAAV6XspIwFlVfRunnf+lRtJ7+c0rwd04jYu2sKEgx4kOtrRcqW4K
 FankVsjJvsy6fgHbK+tHYQ==
X-Google-Smtp-Source: APXvYqxx/YyPyFV09xDlJezz/+Zd9ug5RlT5+zsybfzBCYv9hYcK/r6VQMlyDfmf4Beo5bdrVmC4+A==
X-Received: by 2002:a9d:7c97:: with SMTP id q23mr17133632otn.253.1576532446957; 
 Mon, 16 Dec 2019 13:40:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id i25sm97492otc.67.2019.12.16.13.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 13:40:46 -0800 (PST)
Date: Mon, 16 Dec 2019 15:40:45 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v5 1/2] ASoC: dt-bindings: fsl_asrc: add compatible
 string for imx8qm & imx8qxp
Message-ID: <20191216214045.GA6988@bogus>
References: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, perex@perex.cz, nicoleotsuka@gmail.com, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed,  4 Dec 2019 20:00:18 +0800, Shengjiu Wang wrote:
> Add compatible string "fsl,imx8qm-asrc" for imx8qm platform,
> "fsl,imx8qxp-asrc" for imx8qxp platform.
> 
> There are two asrc modules in imx8qm & imx8qxp, the clock mapping is
> different for each other, so add new property "fsl,asrc-clk-map"
> to distinguish them.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> -none
> 
> changes in v3
> -use only one compatible string "fsl,imx8qm-asrc",
> -add new property "fsl,asrc-clk-map".
> 
> changes in v4
> -add "fsl,imx8qxp-asrc"
> 
> changes in v5
> -refine the comments for compatible
> 
>  Documentation/devicetree/bindings/sound/fsl,asrc.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
