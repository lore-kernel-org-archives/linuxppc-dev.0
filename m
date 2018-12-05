Return-Path: <SRS0=GwW7=OO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E051AC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 17:52:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5018C213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 17:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6GXKa9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5018C213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4395sM1QsjzDqwb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 04:52:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c6GXKa9O";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="c6GXKa9O"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4395pQ1GTyzDqv2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 04:49:33 +1100 (AEDT)
Received: from localhost (unknown [106.201.124.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F244E2084C;
 Wed,  5 Dec 2018 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544032171;
 bh=MePwmX+i9XEEu4ESz9qr//H9dp5rCVBzexST1kjLkMU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c6GXKa9OxlEaOASE2gnOLGv+fX2M6vkY2VnJhIlctwRaAlncLrG1MKVOKoo+Fgr5O
 /kT74gTjNQigb1xten6xmcrRTaq3h/2KQoN48l4q6bEadwX1uBjnsG6KbDMLni8Oe7
 yvepgPSvFYdjG9tsGvzBVRLT3wVvfXsJfaCh0bJg=
Date: Wed, 5 Dec 2018 23:19:23 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [v11 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by FSL_DMA_IN/OUT
Message-ID: <20181205174923.GU2847@vkoul-mobl>
References: <20181030023604.34027-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030023604.34027-1-peng.ma@nxp.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Wen He <wen.he_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, zw@zh-kernel.org, robh+dt@kernel.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 30-10-18, 10:35, Peng Ma wrote:
> From: Wen He <wen.he_1@nxp.com>
> 
> This patch implement a standard macro call functions is
> used to NXP dma drivers.

Applied all except DTS patches, thanks
-- 
~Vinod
