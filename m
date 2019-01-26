Return-Path: <SRS0=UfQ7=QC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E10C282C0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 01:51:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A48E21855
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 01:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrXg/1Wk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A48E21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43mf4k2T2lzDqR2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jan 2019 12:51:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrXg/1Wk"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43mf2b6DPwzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jan 2019 12:49:27 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id z11so4933256pgu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 17:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z31oC3yzCXeE8gwNzZb7c+UyH2VYUHaOsK2yTfHBL38=;
 b=mrXg/1Wk6jQhvCIai+RxDFsBL9W9egTtNMpDrQt5qcqmpvPILdn7IRcwwd2iAT/kKV
 46XrJIleLhD13kWeYOsrX36zdkZLpl1F+QYul9OpGMfCuFUyDQz96yuqR08m96BzcOCC
 2wAkIibqR8+Rh7s1Oo8LCOuiB+DNS8jcLAll5CuLmMM2gdS5OrKmM+yzL+dBak8JfvAA
 sEX8PFDmp9vXMIqIEpeiUgukkaeJxrxeIYOuaGqhoorbU/CPkFGvGo3RFyxhJ67qnz2A
 oL/n2yLk2+RqItbiY3vlXIjPONMtDn8yIkjM3NS1nUewE2r8PDmLHFUvCAsmVPVhozZN
 eDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z31oC3yzCXeE8gwNzZb7c+UyH2VYUHaOsK2yTfHBL38=;
 b=mlHzQw2IYQ+EBSdmtjWBLjaaLXmsikeBwG7M+SlJm+9RPv7MNLaLO5QD7a+1eM6I8r
 /8bGzCb2zhP7v40V1JP+ykb/dyHnQiUawF7PuBfBK6YFCdVo3qwJ284aj3Bc6PBkK51c
 95+QcHcxnpkxRUfVz8X/JzyHNs0YDy/UvvOktvlW6qUsqZR4+x4ykJ1XI7A9Y7hKqkX8
 usiDZiVSLve/u5IWEsrnfGe7wzF7kYXo5Gg8CrXbmAXif2GvGF+eieOZKdaZxWzKE9MP
 kY/VnDZkb4rcGZXVpfSN0UrkMBX94DqUqqbpI3nYqKfkWdWVXZxlyWzGyEjLaNmFiGTM
 Co6g==
X-Gm-Message-State: AJcUukcXJp2XAkjJs4tTcSjdp2mftrQNyTv5dqymg9Ww1uRMmxRSs4rC
 YRUtt0o0EQs5nC3gCZ9d7+8=
X-Google-Smtp-Source: ALg8bN6LNwjIcCOtzPL86VZMRi8QaLPut6xIKH1PZUt4RMpqs+MBj9+pyxUIqu3HuBajUJFlLuUWQg==
X-Received: by 2002:a63:4d:: with SMTP id 74mr12263296pga.248.1548467365246;
 Fri, 25 Jan 2019 17:49:25 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id o66sm42745234pgo.75.2019.01.25.17.49.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Jan 2019 17:49:24 -0800 (PST)
Date: Fri, 25 Jan 2019 17:49:19 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/4] ASoC: add fsl_audmix DT binding documentation
Message-ID: <20190126014918.GA2617@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547729177-14317-3-git-send-email-viorel.suman@nxp.com>
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
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Viorel Suman <viorel.suman@gmail.com>, Cosmin Samoila <cosmin.samoila@nxp.com>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Jaroslav Kysela <perex@perex.cz>,
 Daniel Baluta <daniel.baluta@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 17, 2019 at 12:46:29PM +0000, Viorel Suman wrote:

> +  - dais		: Must contain a list of phandles to AUDMIX connected
> +			  DAIs. The current implementation requires two phandles
> +			  to SAI interfaces to be provided, the first SAI in the
> +			  list being used to route the AUDMIX output.

Another small thing, that I just noticed, is this list. It forces
the first input source to be the output source without giving any
chance. I feel that we could have some flexibility here: one node
for two input sources, and one node for the output source.

Well, there is no critical problem with the current binding since
it follows the SoC design. Yet I doubt if this routing logic will
never break.

Any suggestion, Rob?
