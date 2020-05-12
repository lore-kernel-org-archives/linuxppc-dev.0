Return-Path: <SRS0=zMZh=62=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE3CA90AF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 16:41:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EA7206CC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2020 16:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EA7206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49M3TV1bbbzDqkP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2020 02:41:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.196;
 helo=mail-oi1-f196.google.com; envelope-from=robherring2@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49M3QK2x3CzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2020 02:38:16 +1000 (AEST)
Received: by mail-oi1-f196.google.com with SMTP id i13so18773516oie.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2020 09:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=KeYFuchHUV4oG06etMyeWZGVdFDkZmCFlBwg/KVFhKU=;
 b=OT1ojkOU6Ys4L9qEOkMMzWsH+WfKTy4DiBmUhCExuT3VFZD6LB39GAEYS3ve/0wi68
 za+brmaKHNgQ1kRjDVEMVnLexBHHJd7mu/0Tq1rKj4jpf3RUVElbU4opbpQKHuy7q5IK
 2QdCL0S/KsuhQ7A8WQ3/wC7ONBAdOGo86fFJA9+rP1szRvpoCbiok1U1MAHQV+kX6zMS
 bRHp5BjSum92bAgOp2jVTUs6Bl3DLp6xkvhRnmh4DX3GicDdz7mok3rmJDlacoiQOTiV
 7xrWYPppG7YIg9T2OjgrHSpKmUyv2fHe8w7qJrc4uO5QAzBeN5wSlHWfrrTGddcUdY0b
 MyDQ==
X-Gm-Message-State: AGi0PubsoC7erYq1inToBFdwGqHfTbLJ+cBpmAkDFlTnPGInJDsSvUuD
 5hBp8WnlgecoMk3Bt15q9Q==
X-Google-Smtp-Source: APiQypKIND1xo73jiriB4lL8f7Yv7R7T6ZKHMlotm4ARjozaBncOmDZy+ZFpBOhARLLZciwC/lXy8A==
X-Received: by 2002:aca:3cc6:: with SMTP id
 j189mr20111395oia.137.1589301494954; 
 Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id 34sm144510otq.67.2020.05.12.09.38.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 09:38:14 -0700 (PDT)
Received: (nullmailer pid 12285 invoked by uid 1000);
 Tue, 12 May 2020 16:38:13 -0000
Date: Tue, 12 May 2020 11:38:13 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_esai: Add new compatible string for imx8qm
Message-ID: <20200512163813.GA12151@bogus>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307a82c80c27b807165e1f532dd9aecbad9b2eae.1588320656.git.shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com, robh+dt@kernel.org,
 tiwai@suse.com, nicoleotsuka@gmail.com, broonie@kernel.org, perex@perex.cz,
 festevam@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri,  1 May 2020 16:12:06 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx8qm-esai" in the binding document.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,esai.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
