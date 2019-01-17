Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43003C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:26:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B408A20851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbbjY6YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B408A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gdwT080WzDqst
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 09:26:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JbbjY6YU"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gdtR3vrHzDqnT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 09:25:03 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id g9so5390876plo.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 14:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ja01K34YvVKV97X4JIcwkhIC9kBYMpmVCBRsRoM7qWM=;
 b=JbbjY6YU0Fu+itmrSj6IjuiiUeS4yXFAEXlYBmyKMH74AzNvYXtFat5zlgoAq9Lyk+
 +8mheQ5qAfX1hELedeTZzyYplrlju0H4XEABkxYUIpMn6AgvnADp+to8yZCcMW2YHBll
 AHsrWzQB4+rPDYjsdZIJE9ecf+gOp3JC11LxrcXNmogqepG09RiAimh7PAUosMNrj5Rv
 C/RfWJcdw3pAMHIpTJhEEVRLCZuX7d9PAPZVnzcZecl0rdwRQvkaC7Iqu2z3DUEzkYgC
 yF8mpBWQAhJs4Qb+Cg5SVc1tjE9fXMz7sKmWBZIC5l+fM9xex109/F+WAU3k81y10v6/
 VymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ja01K34YvVKV97X4JIcwkhIC9kBYMpmVCBRsRoM7qWM=;
 b=fLk3bBmeC/1zK8FOVdKOym2pdq0rx7XfPXl7HoGyUAvcM/7snhj+7b82s67AALvsA9
 wcuL5LQ3cfihLD50erUKqzG5cNzclX6A7QIpgDglPUe8enB77d1vMIBylKYYpMWNK3b8
 aMQRLtzG4Ih8f38IpTJ4rrik78BFTLbbx6qj5AnLNvKCDQEm/HfYdvhqsITSr1JAmk5/
 ExXiLKikpD+k7QIgcJqyQnq3AqhWkw4UC0WbiSZ2POsmIzAnFlsYRBSf2oDIZ5xFGfA6
 6XeRxCrgL8NI2QTA7SZ2sA5mIMojKCR1Q6TMBS+LXoKYaPYUaDAc7iHBSqKzumw+8u9n
 WbCQ==
X-Gm-Message-State: AJcUukeiSpLp5nw+njK8W5bF+QQR9Xz3kTJNwfx/kgLwWiRouTjOY50X
 eKK4SOy6l8xC/EXwKLbKWSQ=
X-Google-Smtp-Source: ALg8bN45mDgTS+6IDIWy92W+1lBIWzgKkBpPj5IYpWQ1PSSAwsauspnaD0GO9CBLBIcZUYlvnIw2GQ==
X-Received: by 2002:a17:902:f20b:: with SMTP id
 gn11mr16168541plb.274.1547763901431; 
 Thu, 17 Jan 2019 14:25:01 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id q1sm4165517pfb.96.2019.01.17.14.25.00
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Jan 2019 14:25:01 -0800 (PST)
Date: Thu, 17 Jan 2019 14:24:58 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190117222458.GG16918@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117222218.GF16918@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Viorel Suman <viorel.suman@gmail.com>,
 Cosmin Samoila <cosmin.samoila@nxp.com>, Mark Brown <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 02:22:18PM -0800, Nicolin Chen wrote:
> On Thu, Jan 17, 2019 at 12:46:25PM +0000, Viorel Suman wrote:
> > The patchset adds NXP Audio Mixer (AUDMIX) device and machine
> > drivers and related DT bindings documentation.
> > 
> > Changes since V2:
> > 1. Moved "dais" node from machine driver DTS node to device driver DTS node
> >   as suggested by Rob.
> 
> Yea, it makes a lot of sense. Otherwise, since the connection
> between IP blocks is fixed inside the SoC, the virtual sound
> node would need to be put in the soc-level dtsi, which sounds
> odd to me.
> 
> > Changes since V1:
> > 1. Original patch split into distinct patches for the device driver and
> >   DT binding documentation.
> > 2. Replaced AMIX with AUDMIX in both code and file names as it looks more
> >   RM-compliant.
> > 3. Removed polarity control from CPU DAI driver as suggested by Nicolin.
> > 4. Added machine driver and related DT binding documentation.
> > 
> > Viorel Suman (4):
> >   ASoC: fsl: Add Audio Mixer CPU DAI driver
> >   ASoC: add fsl_audmix DT binding documentation
> >   ASoC: fsl: Add Audio Mixer machine driver
> >   ASoC: add imx-audmix DT binding documentation
> 
> Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>

Oops. Just saw Rob's new reply. The drivers look good to me though.
