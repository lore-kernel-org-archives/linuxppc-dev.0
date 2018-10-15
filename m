Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C6AC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:09:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220252089D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 17:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9pIUCnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220252089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YlKw1PPSzF3Nq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 04:09:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9pIUCnS";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9pIUCnS"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YlHK0lJRzF3Nd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 04:07:22 +1100 (AEDT)
Received: from localhost (unknown [106.201.39.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 61608208AE;
 Mon, 15 Oct 2018 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539623240;
 bh=UYaB7YXdEiZMsIUW/cwkAaiGi73UuQuG7o0eBUQc3ws=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L9pIUCnSKXtamEck4cUeIyi3hI0UMbRyvhC5oVw0rWMyRslOp0VVGWOm10WD7oBdM
 Cq6/0zd05qlhy2BPnbFCFrmu/EE8zhWVOBTysfZVuuZnjnTqJBfKQDArJ49jC4YxGL
 rqTFOWhczKNiwWEk/AjQY19ZkJ2K159HNutsmtnc=
Date: Mon, 15 Oct 2018 22:37:11 +0530
From: Vinod <vkoul@kernel.org>
To: Peng Ma <peng.ma@nxp.com>
Subject: Re: [PATCH 1/7] dmaengine: fsldma: Replace DMA_IN/OUT by
 FSL_DMA_IN/OUT
Message-ID: <20181015170711.GK2400@vkoul-mobl>
References: <20181011094655.45707-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011094655.45707-1-peng.ma@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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

On 11-10-18, 17:46, Peng Ma wrote:
> From: Wen He <wen.he_1@nxp.com>
> 
> This patch implement a standard macro call functions is
> used to NXP dma drivers.
> 
> Signed-off-by: Wen He <wen.he_1@nxp.com>

Please read Documentation/process/submitting-patches.rst, we expect each
patch you send to have your signed off and signed off from orignal
authors

Also as Rob pointed out this patch series should be v8 or so as this is
following the previous work submitted to the list

Please also indicated changes from last rev which help in the review.


-- 
~Vinod
