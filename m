Return-Path: <SRS0=n52k=JZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD929C433B4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 20:20:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D724A611BE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Apr 2021 20:20:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D724A611BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FVqkr121dz3037
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 06:20:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.193;
 helo=relay1-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FVqkT1p3sz2xYx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Apr 2021 06:20:13 +1000 (AEST)
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr
 [90.65.108.55]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3B541240008;
 Wed, 28 Apr 2021 20:20:07 +0000 (UTC)
Date: Wed, 28 Apr 2021 22:20:06 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: youling257 <youling257@gmail.com>
Subject: Re: [PATCH 04/17] rtc: cmos: remove cmos_rtc_ops_no_alarm
Message-ID: <YInDdgd2r1SDdv4k@piout.net>
References: <20210110231752.1418816-5-alexandre.belloni@bootlin.com>
 <20210428184946.23999-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428184946.23999-1-youling257@gmail.com>
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
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

On 29/04/2021 02:49:46+0800, youling257 wrote:
> this patch cause suspend failed on my Bay trail z3735f tablet.
> 
> [  162.038713] PM: dpm_run_callback(): platform_pm_suspend+0x0/0x40 returns -22
> [  162.038760] alarmtimer alarmtimer.0.auto: PM: failed to suspend: error -22

I think I know what is happening, there is one patch I wanted to send
this cycle but didn't, can you test it?

https://github.com/alexandrebelloni/linux/commit/50641a5a19cedf7561410d7db614da46c228bacc

Thanks for the report!

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
