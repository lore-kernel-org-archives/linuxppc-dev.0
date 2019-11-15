Return-Path: <SRS0=VpUd=ZH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3C3C432C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 13:16:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B197B20740
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Nov 2019 13:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B197B20740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47DzQc3kgDzF41g
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 00:16:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.178.242;
 helo=mslow2.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47DzN7498hzF7Dj
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2019 00:14:43 +1100 (AEDT)
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
 by mslow2.mail.gandi.net (Postfix) with ESMTP id 1CCC93AEE4C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Nov 2019 13:01:54 +0000 (UTC)
X-Originating-IP: 90.66.177.178
Received: from localhost (lfbn-1-2888-178.w90-66.abo.wanadoo.fr
 [90.66.177.178])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 55AB2FF805;
 Fri, 15 Nov 2019 13:01:21 +0000 (UTC)
Date: Fri, 15 Nov 2019 14:01:21 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: remove select FSL_RCPM and default y
 from Kconfig
Message-ID: <20191115130121.GS3572@piout.net>
References: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 YueHaibing <yuehaibing@huawei.com>, lkml <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 08/11/2019 16:40:56-0600, Li Yang wrote:
> The Flextimer alarm is primarily used as a wakeup source for system
> power management.  But it shouldn't select the power management driver
> as they don't really have dependency of each other.
> 
> Also remove the default y as it is not a critical feature for the
> systems.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/rtc/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
