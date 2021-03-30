Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF41C433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 17:30:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF78E619C5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 17:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF78E619C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8xKz4CFXz3c6d
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 04:30:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YlhQsQQW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=vkoul@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YlhQsQQW; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8xKW24Ypz2xxl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 04:30:05 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F5D4619C7;
 Tue, 30 Mar 2021 17:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617125402;
 bh=C8O0alZVc/4m1eevRMOdvFYGpb/wNNuDuufNDrLUuQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YlhQsQQWUsLXlFqsj68qjAmIgwrUB402VoS+aB1erd03q1KOtJUCQb4U3Wqqgs3SB
 iTOrSWjppww4kGCLWZZI91Y2m/j+eP9OmPXhydxgZgfbLsrqJIkmQNtk8bP0v+jzSx
 TzeQjHeg5mqpcqD0e+KpcPYJMMteIb4Av6YuXlE+5P7dyrr1LCOjlf1f5O6Lgajas+
 zNgTDQXLJzHb/6M8m8Mo8XsHxB2fsNF6A4XX0rnAgxxGk8JSqW0GkayeK8I2df+7X1
 TZxQLOAh6IZUxUJ6H6x7ULZIO+4bNvxITYEnjczyVgn7ZP3pZjCMaZVOqwYTXT0P0y
 bhWPgaKY+z35Q==
Date: Tue, 30 Mar 2021 22:59:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: Re: [PATCH 14/30] Revert "s3c24xx-dma.c: Fix a typo"
Message-ID: <YGNgFuLWc91aGoQj@vkoul-mobl.Dlink>
References: <cover.1616971780.git.unixbhaskar@gmail.com>
 <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d989f71fbebd15de633c187d88cb3be3a0f2723.1616971780.git.unixbhaskar@gmail.com>
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
Cc: dave.jiang@intel.com, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 29-03-21, 05:23, Bhaskar Chowdhury wrote:
> s/transferred/transfered/
> 
> This reverts commit a2ddb8aea8106bd5552f8516ad7a8a26b9282a8f.

This is not upstream, why not squash in. Also would make sense to write
sensible changelog and not phrases and use the right subsystem
conventions!

Droped the series now


-- 
~Vinod
