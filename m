Return-Path: <SRS0=USe9=7X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D8CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 05:45:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29540207ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F8IQUAA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29540207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49hbYl2P8JzDqXl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Jun 2020 15:45:31 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49hbWS5YjTzDqTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2020 15:43:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=F8IQUAA3; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49hbWQ50Pcz9sRR;
 Wed, 10 Jun 2020 15:43:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1591767812;
 bh=pcbWSPwKHYKUiqwhEF2FHnUMBRR9mr+AM4yZy/n/Q8I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=F8IQUAA3kWCkFCWuHeYkNqUREzy+4KqCzh7klNtixSzs921xmG/GxnersS77Mi9/U
 sHdjk4Z7XhsgEB7dPXauvZKo+NcLEu3WHhqsl5ZY/4CW0u7jVAW32uOTtZ6YWGSylg
 pFPYCAzg0F7MsWCrUBF47Sc/Oh+8/13K+3iK3IybEYtDsD2Q0N/EMOLzKlY+fP3L2E
 K7QaVdu8KaiWPWhrmPr+YwUV2ymA7pLeI0l0Rz+FSumECm/O5gFxfyxLLFdUm7oaaP
 Skn4eyNynDdzqfMo/nful4oZI19JZlMkg8XiWqA4xqgbRrEpMvSZ85VlksnkXwNL5M
 EeRvhl8RR3JNQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: ipr crashes due to NULL dma_need_drain since cc97923a5bcc
 ("block: move dma drain handling to scsi")
In-Reply-To: <20200609154230.GA18426@lst.de>
References: <87zh9cftj0.fsf@mpe.ellerman.id.au> <20200609154230.GA18426@lst.de>
Date: Wed, 10 Jun 2020 15:43:58 +1000
Message-ID: <87tuzjfpb5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, brking@us.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:
> Can you try this patch?
>
> ---
> From 1c9913360a0494375c5655b133899cb4323bceb4 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 9 Jun 2020 14:07:31 +0200
> Subject: scsi: wire up ata_scsi_dma_need_drain for SAS HBA drivers
>
> We need ata_scsi_dma_need_drain for all drivers wired up to drive ATAPI
> devices through libata.  That also includes the SAS HBA drivers in
> addition to native libata HBA drivers.
>
> Fixes: cc97923a5bcc ("block: move dma drain handling to scsi")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yep that works for me here with ipr.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
