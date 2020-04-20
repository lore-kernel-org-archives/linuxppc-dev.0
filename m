Return-Path: <SRS0=UNki=6E=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38448C55181
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 21:11:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98CC2078C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2020 21:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98CC2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 495fWQ0FlYzDqLZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2020 07:11:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 495fPg5ZfFzDqLZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2020 07:06:14 +1000 (AEST)
Received: by mail-ot1-f68.google.com with SMTP id c3so9404567otp.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2020 14:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uB24L/EHWMUmjNtmjWGehiMAvY3CkKcJfhSvIbdPK9U=;
 b=WJ+tX/vrxyx2JoMv4y6DZVNFJ2gkg/imETbxKuClk8t5rLpTurlI3S1P1g+X4qTd37
 uFJ4SBWcdsRkq5fwqbVbJf8E8Rbd4M9hjVmokES6ng6ehZKFiJ/y74rfQ0tZECPzrdI5
 AEeH3CuitlJx4T8ZFuWBSwLzOjKpDmHChnZjw+DVOytbWNo9Y0oo1ZDA9ZKkS9mhCjbG
 0J8K7g/2Diy8muWTjQyvyk/nwipcgHQ64e+XWjMoIb23IX2mqDLkJSndcuDL/JGRyBpP
 cmf12zGQfXbaoDB8N12zzt5BAirIWw6j5Rh1VBdxj13+3pLaTwvekbz70sKhPzhwItif
 4ZZQ==
X-Gm-Message-State: AGi0PuZ2N6vOu2TBkv3dpy+5OHCnjDh6AUBZkQlSDewkQFjn+ownLt9i
 0tQBysmMhCd23KwsthdeVg==
X-Google-Smtp-Source: APiQypJ61QuLn0gRFwjv7tBbNaZhcCNVOe5uH4hWnq+9Kov3OqipkZNTDsd+9hUszKj/zQnlos6E3g==
X-Received: by 2002:a05:6830:1b65:: with SMTP id
 d5mr10613823ote.141.1587416771097; 
 Mon, 20 Apr 2020 14:06:11 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 33sm205505otn.50.2020.04.20.14.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2020 14:06:10 -0700 (PDT)
Received: (nullmailer pid 28621 invoked by uid 1000);
 Mon, 20 Apr 2020 21:06:09 -0000
Date: Mon, 20 Apr 2020 16:06:09 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v8 6/7] ASoC: dt-bindings: fsl_easrc: Add document for
 EASRC
Message-ID: <20200420210609.GA28583@bogus>
References: <cover.1586845137.git.shengjiu.wang@nxp.com>
 <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396a73da2a2fa8b77d0b773d321500b3e504d919.1586845138.git.shengjiu.wang@nxp.com>
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

On Tue, 14 Apr 2020 14:56:06 +0800, Shengjiu Wang wrote:
> EASRC (Enhanced Asynchronous Sample Rate Converter) is a new
> IP module found on i.MX8MN.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,easrc.yaml  | 101 ++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
