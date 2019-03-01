Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72517C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:14:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45A82084F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45A82084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=flatmax.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449fK60M76zDq9p
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:14:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=flatmax.org
 (client-ip=13.55.16.222; helo=mx.flatmax.org;
 envelope-from=flatmax@flatmax.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=flatmax.org
X-Greylist: delayed 1162 seconds by postgrey-1.36 at bilbo;
 Fri, 01 Mar 2019 16:24:08 AEDT
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449dBc3V7bzDqQj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 16:24:08 +1100 (AEDT)
Received: from pa49-195-186-101.pa.nsw.optusnet.com.au ([49.195.186.101]
 helo=[192.168.1.51])
 by mx.flatmax.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <flatmax@flatmax.org>)
 id 1gzaLh-0001RG-Ev; Fri, 01 Mar 2019 16:04:42 +1100
Subject: Re: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
To: Nicolin Chen <nicoleotsuka@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
From: Matt Flax <flatmax@flatmax.org>
Message-ID: <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
Date: Fri, 1 Mar 2019 16:04:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190301045041.GA5064@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-AU
X-Mailman-Approved-At: Fri, 01 Mar 2019 17:13:24 +1100
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

It would be a mistake to remove S32_LE from the format list.

If you removed that, then we wouldn't be able to do 32 bit native 
playback - it would force users to go through an ALSA plugin.

If you look at the cs42448 data sheet for example, the I2S and TDM bus 
uses a 32 bit word size. For that reason, native S32_LE format is 
handled by the codec. While the codec only uses the 24 MSBs, the I2S bus 
is 32 bit.

Matt

On 1/3/19 3:50 pm, Nicolin Chen wrote:
> Hi Shengjiu,
>
> On Thu, Feb 28, 2019 at 05:56:31AM +0000, S.j. Wang wrote:
>> cs42xx8 is a 24-bit A/D and 24-bit D/A device, so the S32_LE
>> should not be in the supported format list.
>>
>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>> ---
>>   sound/soc/codecs/cs42xx8.c | 3 +--
> This is for cs42xx8 codec driver, but its maintainers aren't
> seemly in To/Cc list. Please run ./scripts/get_maintainer.pl
> for it and resend.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
