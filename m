Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958F8C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 07:30:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39E7214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 07:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BArjKazA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39E7214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tKBK6Tb4zDqFG
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 18:30:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="BArjKazA"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tK8S2j4XzDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 18:29:12 +1100 (AEDT)
Received: from localhost (unknown [171.76.74.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6D3392177E;
 Mon,  4 Feb 2019 07:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1549265350;
 bh=jZ8I0n4psRKB4oOXlJyJH9O/6ngBUFqzTstMTd+5LEg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BArjKazA6D6bq2w93nrN911l2soHr5s21dHc4bNKC5IazNb9EKeL/neeHUCnVVRdn
 qY0C4L2BFdv6nFzLhjxwaqo16RQ77TT04hrznRLRBpi+bCAGvg5Zl12Mwl62nVwHAv
 hE5XiSVhSO24DDskxUQVcf7kFgWgU3T3JjwaEWO0=
Date: Mon, 4 Feb 2019 12:57:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH] dmaengine: fsldma: Add 64-bit I/O accessors for powerpc64
Message-ID: <20190204072741.GK4296@vkoul-mobl>
References: <20181222043445.GA29462@home.buserror.net>
 <VI1PR04MB443154AEE42853B62234075EEDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <193b66f8bcc52c4900144b4cd742cacd001c9830.camel@buserror.net>
 <VI1PR04MB4431C33B5155312CF7035584EDBB0@VI1PR04MB4431.eurprd04.prod.outlook.com>
 <20190119125841.GE4635@vkoul-mobl>
 <VI1PR04MB44311D9A8F8CD3A0143BCC99ED9B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44311D9A8F8CD3A0143BCC99ED9B0@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Wen He <wen.he_1@nxp.com>, Leo Li <leoyang.li@nxp.com>,
 Scott Wood <oss@buserror.net>, Zhang Wei <zw@zh-kernel.org>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 25-01-19, 05:54, Peng Ma wrote:
> Hi Vinod,
> 
> Sorry to replay late.
> 1:This patch has already send to the patchwork.
> 	Please see the patch link: https://patchwork.kernel.org/patch/10741521/
> 2:I have already compile the fsl patches on arm and powerpc after patched https://patchwork.kernel.org/patch/10741521/
> 	The compile will successful, please let me know the reported regression results, thanks very much.

And I thought there were further comments  on this patch. I have applied
this, please watch for failures reported if any..
-- 
~Vinod
