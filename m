Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03ACC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B7B2183E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhRPPknW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B7B2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lCt74FcrzDqR3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:07:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qhRPPknW"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lCr85YpnzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:05:44 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id t21so826999pfh.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 02:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Mw07+ygDicv9TP/v0i5onh329mIidrytyEynXCO/hFo=;
 b=qhRPPknWeBW9G71Oe3gNvtJddZ65QlL8lnumFGTmHHg1WBSZM/drMc/yxvL5oAYWyC
 QTNAXxEVDimHvqsNaVkcZ5Te8Duqq32yCJIVSBwZSpQZ7QEI3YyKXK3FOigtrvqV5sYf
 ssA3ZvjcdOXSKEevXrGsjuJKaBWgsIbg6AkgDlNLeaI6vmwg3Xe5ivDUXeT9x/Pdwz7L
 mVCZyZhaJ/9HwFja6eKxJlvK6fX0o2x3r+4ibZdKVRguj01uvcTr/FToX1aVxoIvxx0O
 mWnMbFw0dABYojHQ/os0DxoSxO8cj/NhQ5BZgU39FvyQBM/EcT56I3FdgisyJinOBP/k
 IwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Mw07+ygDicv9TP/v0i5onh329mIidrytyEynXCO/hFo=;
 b=EPx21Ei6UWTzz8bemy1aGSqmeUildcJh8u9BJuoKUrjq7mqneE/unPfT5XXk6+NzCL
 f6fvXYsxZuj2OGAsuyu6Blo5gd6CGFDetaucvpSYRSBG4kHNoNRea1tAy/tHElLmmp/F
 Q+QwxkNOlGrRYFrxL/uk/kpMXMC2PfKUXG4lXvJO4SC4QgsYsRshMI/bQ0ACi4vM3UeV
 XsDgKKNAtuY2StqQ1SksfV4OYu0rkslu3oQoBOEo2gAhy9140fIZjrjQcW2zFlqxMoGn
 RiNT5iQvcoRb/n/fAtjKJ96WkvqG0dOzn/wChBt8+NHmmy0CUBBoGbmILFRMQNvnXLUC
 NdsQ==
X-Gm-Message-State: APjAAAUnhB26MAqUCfgJuYN5qVN014Juz+49TRge7UIkBkv5Hcu3ZGqf
 5w4W9Ump3Nlqfg2fxoBEiWU=
X-Google-Smtp-Source: APXvYqzjJ2S/f0g+n091XtubI+Cj5X0L/JXkSvovNUDzGVVzCVcJf9G4slAIv7RyoT+/yzql8uNeDA==
X-Received: by 2002:a63:4c:: with SMTP id 73mr49571539pga.210.1555578340723;
 Thu, 18 Apr 2019 02:05:40 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 q75sm2109865pfi.102.2019.04.18.02.05.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 02:05:40 -0700 (PDT)
Date: Thu, 18 Apr 2019 02:05:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 1/2] ASoC: fsl_asrc: replace the process_option table
 with function
Message-ID: <20190418090534.GB4028@Asurada>
References: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB647965FEAF3506E1775397AEE3260@VE1PR04MB6479.eurprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 18, 2019 at 08:50:48AM +0000, S.j. Wang wrote:
> > And this is according to IMX6DQRM:
> >     Limited support for the case when output sampling rates is
> >     between 8kHz and 30kHz. The limitation is the supported ratio
> >     (Fsin/Fsout) range as between 1/24 to 8
> > 
> > This should cover your 8.125 condition already, even if having an outrate
> > range between [8KHz, 30KHz] check, since an outrate above 30KHz will not
> > have an inrate bigger than 8.125 times of it, given the maximum input rate
> > is 192KHz.
> > 
> > So I think that we can just drop that 8.125 condition from your change and
> > there's no need to error out any more.
> > 
> No, if outrate=8kHz,  inrate > 88.2kHz, these cases are not supported. 
> This is not covered by
> 
>         if ((outrate > 8000 && outrate < 30000) &&
>             (outrate/inrate > 24 || inrate/outrate > 8)) {

Good catch. The range should be [8KHz, 30KHz] vs. (8KHz, 32KHz)
in the code. Then I think the fix should be at both lines:

-         if ((outrate > 8000 && outrate < 30000) &&
-             (outrate/inrate > 24 || inrate/outrate > 8)) {
+         if ((outrate >= 8000 && outrate =< 30000) &&
+             (outrate > 24 * inrate || inrate > 8 * outrate)) {

Overall, I think we should fix this instead of adding an extra
one, since it is very likely saying the same thing.
