Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90288C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E2E2084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0IfNvNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E2E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449sPM0s4dzDqS0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 01:34:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=timur@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="V0IfNvNb"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449sMh5Tx7zDqQC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 01:32:48 +1100 (AEDT)
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8FFE02084F;
 Fri,  1 Mar 2019 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551450765;
 bh=/c22KNcAcHmVjbLY4p1/ZJuwqFetYwxho0XaRqooCsY=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=V0IfNvNbSe221kiCdtBDrHpOykSDEJlRZ3GJz6w1uKBzS99d/m9YUAvYW3Yq77HG8
 Dzswlzs1oBTre6tQCSXJ5mwkmWfX1U+iIYWMKw3OYQCAK2R+iottkVz8R+4Nkvb47g
 8+1ltEy1JPv0j4QU2rX/e92Z4BoRvlF+twWE8K1s=
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
To: "S.j. Wang" <shengjiu.wang@nxp.com>, Matt Flax <flatmax@flatmax.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
 <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
 <VI1PR0402MB3392CCF09FE75CE856C6174EE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
From: Timur Tabi <timur@kernel.org>
Message-ID: <de5ebabd-52a5-dedb-6710-8f09e1a4e380@kernel.org>
Date: Fri, 1 Mar 2019 08:32:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3392CCF09FE75CE856C6174EE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 3/1/19 12:32 AM, S.j. Wang wrote:
> This case is covered by S24_LE I think.  The S32_LE means the data is 32bit and slot width
> Is 32bit, this is not in data sheet.

The problem is that if you have 32-bit samples in your audio file, and 
you want to play them, then software (e.g. alsalib) will need to convert 
the audio to 24-bit before sending it to hardware.  This is unnecessary 
because the hardware can "convert" the sample to 24-bit automatically by 
ignoring the lower 8 bits.

I think a lot of codecs do this already.
