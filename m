Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C4EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB0A2087E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 04:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktY9IR7J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB0A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449cTy4gtyzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 15:52:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ktY9IR7J"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449cSF5cW9zDqQb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 15:50:53 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id b65so7833909plb.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=sf9iXAhsKEALZI3pS8gdl60opIE8WuTMCE/H0KhxJO0=;
 b=ktY9IR7JqbkKJgQbBRJJtqcVr7xC3PnCepD+aURJge1A8sFSnb8/jE5dOyXmlcJtsE
 chcn9xALTgHAXwbw/YuDs6Dh+kdUQizWDSVbzj/7kIg+CW9OlA8MtPq2cVfDII7qLn5w
 LJJ24tw7oPlsOrSBPVqQOF4FhRBxBjkIn4qhNzNRMtqzX8IG2G+pyeeNbTy2hzBhWYhd
 wWHWbqNBZTAeS2mhjyXIbjjSdn2mGJHbaXiLPIbqSNXh/FSVlUVQX047MsfoADlQxVAO
 07juKpRSmvEwn6vPMSZgr0ZlKWTlvc2qIQmq5rmariiSg/8lBaN6lcoN5VSrRuowjqYE
 4jOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sf9iXAhsKEALZI3pS8gdl60opIE8WuTMCE/H0KhxJO0=;
 b=JB7Cz54vPrB43w4iPNv3IXYgD+v38qdMKjNKsghb+M+CPgP9ohb0GD7zmC80GLw5Pj
 7KGxsOcb8Joxus8eMOZNEtKAGedApkzOBPbeg6l5A4kiPnBzSVbS4bXg79rYwyS36vmy
 Eb4c7VRHTV7t+xoe/wNuacPWxjk30e6S4f2WebASRoETOblMsr2dpkr8AJVfF9+CRHha
 lCcLkszC9AvVoZdQL4fpQILZLOSlaQdhgO4FGI0zy3PNDSf6jOIeQNDgq4t3SMjcuuFg
 ThKc43rM1QSf5ZKPBZP8s0riMpbFFbZPgRvKaS1z0fQKduZZdV15vbHOtGZqxfmXjcgz
 qsbA==
X-Gm-Message-State: APjAAAXzjv/+nSwiKoVkQkYUF7aR+RZ6+dN8UQJUL0+pe8v733g5KrZg
 jHOIpuezaEDOjf+sAq69CoY=
X-Google-Smtp-Source: APXvYqyRWi4vMxN8jGNVKvFmDj5MDCRekQdyMCxABCfYJ5IGrN7dkbdY33WYW80WxEqQfTJQxDKngA==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr3378670ply.41.1551415849961; 
 Thu, 28 Feb 2019 20:50:49 -0800 (PST)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 i79sm17744909pfj.28.2019.02.28.20.50.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Feb 2019 20:50:49 -0800 (PST)
Date: Thu, 28 Feb 2019 20:50:42 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Message-ID: <20190301045041.GA5064@Asurada>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
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
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Thu, Feb 28, 2019 at 05:56:31AM +0000, S.j. Wang wrote:
> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
> should not be in the supported format list.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/cs42xx8.c | 3 +--

This is for cs42xx8 codec driver, but its maintainers aren't
seemly in To/Cc list. Please run ./scripts/get_maintainer.pl
for it and resend.
