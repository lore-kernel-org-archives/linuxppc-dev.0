Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D437EC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:45:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0262133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXwmF8KA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0262133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449FjH6flrzDqQY
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:45:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=timur@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="JXwmF8KA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449FRC3L6XzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 01:33:42 +1100 (AEDT)
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com
 [24.28.70.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 84783214D8;
 Thu, 28 Feb 2019 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551364420;
 bh=YmWjXZzkDAmGP6cIxMxdbozvJsLmID0lqbudLpktuko=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=JXwmF8KANDWuxbA0bdxQRLxCNYL+40YzuuW5C35pN8b+b03MPqrIWl91CoO9V5Z2g
 jeIQA2oRnO+lJhgrQhJtZ7FzbKe/X7dbfWkt37+lWs68AOr7tUlhPpT1wIQ+KNMWBd
 7KjbU3Fmff9z84vzeHVDfwzB6Tjo8oT2L35CUrKc=
Subject: Re: [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
To: "S.j. Wang" <shengjiu.wang@nxp.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
From: Timur Tabi <timur@kernel.org>
Message-ID: <ab0a0d6c-4905-328c-0e22-931c045ed8d9@kernel.org>
Date: Thu, 28 Feb 2019 08:33:37 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 01 Mar 2019 01:44:22 +1100
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/27/19 11:56 PM, S.j. Wang wrote:
> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
> should not be in the supported format list.
> 
> Signed-off-by: Shengjiu Wang<shengjiu.wang@nxp.com>

Is the device capable of accepting 32-bit samples, even if it downgrades 
it to 24-bit internally?  If so, then maybe SNDRV_PCM_FMTBIT_S32_LE 
should stay.

