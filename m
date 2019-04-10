Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D486C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:32:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1066720854
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+0tnqUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1066720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fB8q1NHlzDqM1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:32:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+0tnqUs"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fB5Y4P3wzDqM4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 14:29:53 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id k3so723723pga.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 21:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=VdZvdqQbly2GoV2VZDP1pA/PSw3bIDCmLQVWa6Yk5Gk=;
 b=R+0tnqUsekcm2vwKrlIEpRE2SVXQg6xzizRoIy7QYlwO0Oo8GP9airmKXyeZUllEic
 LpCe5O1ph5QZmThq4R5kNa4Ep0m5J9xaDj+215CdmBpVHzK5h9DbOzd4Z+3hKvYJm1pq
 UAoGcaO7IyPsPv6tss0qwzR9JrA8JSGjpiGVvBMJElv1m/GKjICeN0hTHUeHY6LGe/EQ
 yxP5CzVt84vwZeNbuZKmSRh1+BnazcgmgaBDn0YzixUpsLb6gfHLlQ+0xScVzbiaEyF4
 BbLqb2NF2vwBeiCLJXVo1S0h7goNJS4EN1DKgjTlTpgwWYOm7ayl0DHxFMj2TAED1dEE
 hWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=VdZvdqQbly2GoV2VZDP1pA/PSw3bIDCmLQVWa6Yk5Gk=;
 b=hSQ4vSE9lc9mgFzPaotTwzdSLyOwV6jUv5cQ1E9k8qpSUuWWSxK6f1SQ8fKO09dMy3
 mqTqku+dAnINYhOPWuH+VLYTA7B4pg6lrE1yi+sieEgVNPS6AOXE26dbzaImgbKwucRC
 rUJ+iRWEuVqYE1lXKfA1ZyatJOhPldBDpq6oYj4rxokq2cJiRodhz69JtFq0M2VN+P5W
 5r1ZJAAwItqd4d9JeKH/QsqT/8Ld3pR/EzXIWY3waQlpm7JQPyqzB6Yp/D6RK9bm1Ma0
 Cs9DK4PGzhI7SQf+4GaAe4ZEbZ4t8Dy3mDF7iMH2x9t8nYUNZqmO6zPefIVhisebqSYs
 u39A==
X-Gm-Message-State: APjAAAVFmEfcoL1H+bmBF8FOb0AtAzdcDX+N0wabSAVptsKOQWjQixrC
 BtPuRYAHj2wiZO4a63Ftda0uIEan
X-Google-Smtp-Source: APXvYqytZvgU6i31AKx4F+iaDTgAuy3kkHWv5rZ5/XHnUekJxP8fZTGRhfIo8NZZiULekhMlWhp0qA==
X-Received: by 2002:a65:6105:: with SMTP id z5mr39437569pgu.378.1554870590961; 
 Tue, 09 Apr 2019 21:29:50 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 s21sm12520228pfm.3.2019.04.09.21.29.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 21:29:50 -0700 (PDT)
Date: Tue, 9 Apr 2019 21:29:47 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: fsl,audmix: remove "model" attribute
Message-ID: <20190410042946.GD3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-3-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Viorel Suman <viorel.suman@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 09, 2019 at 11:27:40AM +0000, Viorel Suman wrote:
> Remove "model" attribute.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
