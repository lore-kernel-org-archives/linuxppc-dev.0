Return-Path: <SRS0=o3hI=CF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC817C433E1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 01:40:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245B82074A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 01:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245B82074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BcQQk4YMRzDqVP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2020 11:40:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=cmss.chinamobile.com (client-ip=221.176.66.81;
 helo=cmccmta3.chinamobile.com; envelope-from=tangbin@cmss.chinamobile.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=cmss.chinamobile.com
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BcQP10gXGzDqLp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2020 11:38:41 +1000 (AEST)
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95f470e8bb0d-600b0;
 Thu, 27 Aug 2020 09:38:20 +0800 (CST)
X-RM-TRANSID: 2ee95f470e8bb0d-600b0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.21.77] (unknown[10.42.68.12])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55f470e8be69-26624;
 Thu, 27 Aug 2020 09:38:20 +0800 (CST)
X-RM-TRANSID: 2ee55f470e8be69-26624
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix unnecessary check infsl_spdif_probe()
To: Mark Brown <broonie@kernel.org>
References: <20200826150918.16116-1-tangbin@cmss.chinamobile.com>
 <20200826165308.GJ4965@sirena.org.uk>
From: Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f2196e55-6458-4f55-96ac-bd18ecb461d1@cmss.chinamobile.com>
Date: Thu, 27 Aug 2020 09:37:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200826165308.GJ4965@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, linux-kernel@vger.kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mark

在 2020/8/27 0:53, Mark Brown 写道:
> On Wed, Aug 26, 2020 at 11:09:18PM +0800, Tang Bin wrote:
>> The function fsl_spdif_probe() is only called with an openfirmware
>> platform device. Therefore there is no need to check that the passed
>> in device is NULL.
> Why is this an issue - the check will make things more robust if someone
> manages to load the driver on a non-DT system and otherwise costs us a
> couple of instructions?
Thanks for your reply.

In this function,  function fsl_spdif_probe() can be triggered only if 
the platform_device and platform_driver matches,

so I think the judgement at the beginning is redundant.

Thanks

Tang Bin



