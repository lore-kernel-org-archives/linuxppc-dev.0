Return-Path: <SRS0=owsf=57=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70DEC2BA19
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 19:31:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B2220732
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2020 19:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B2220732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 492XXz6JGTzDrBl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2020 05:31:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 492XV00lF6zDr99
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2020 05:29:11 +1000 (AEST)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1jOngW-00079u-N9; Wed, 15 Apr 2020 14:26:56 -0500
Message-ID: <ef9f59f98f6bcf81891de87fd9cd0b5973bbd468.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org, 
 linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr, 
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 15 Apr 2020 14:26:55 -0500
In-Reply-To: <20200415152442.122873-6-wenhu.wang@vivo.com>
References: <20200415124929.GA3265842@kroah.com>
 <20200415152442.122873-1-wenhu.wang@vivo.com>
 <20200415152442.122873-6-wenhu.wang@vivo.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.wang@vivo.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, christophe.leroy@c-s.fr,
 linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, mpe@ellerman.id.au
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v2,5/5] drivers: uio: new driver for fsl_85xx_cache_sram
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: kernel@vivo.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-04-15 at 08:24 -0700, Wang Wenhu wrote:
> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> +	{	.compatible = "uio,fsl,p2020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p2010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1011-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1013-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1022-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8548-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8544-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8572-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8536-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1021-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1012-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1025-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1016-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1024-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1015-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,bsc9131-l2-cache-controller",	},
> +	{},
> +};

NACK

The device tree describes the hardware, not what driver you want to bind the
hardware to, or how you want to allocate the resources.  And even if defining
nodes for sram allocation were the right way to go, why do you have a separate
compatible for each chip when you're just describing software configuration?

Instead, have module parameters that take the sizes and alignments you'd like
to allocate and expose to userspace.  Better still would be some sort of
dynamic allocation (e.g. open a fd, ioctl to set the requested size/alignment,
if it succeeds you can mmap it, and when the fd is closed the region is
freed).

-Scott


