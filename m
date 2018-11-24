Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CCFC43441
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 14:08:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCEC2086B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 14:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyzd3EjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCEC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 432FQR534SzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Nov 2018 01:08:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wyzd3EjB";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vkoul@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wyzd3EjB"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 432FMj18SyzDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 01:06:05 +1100 (AEDT)
Received: from localhost (unknown [122.178.235.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 929B22086B;
 Sat, 24 Nov 2018 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543068363;
 bh=cAUODXnN0bd/5FPeBUzD/o00hGIH9sKkV2f7Rv3WRos=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Wyzd3EjBEfn6aZDGOhEdN87u0XAMgZHXb+J2lkIQecoEVbW2MUztHQfLrlvr70MwZ
 JsPOjylVoj2PxsH+B6OHNYeCVKfj4xRTNYBSQvVKLhMSmUa/bsxbMVUgtAuq34DxmR
 /nA9baU4VcG3Hpkn/1eu6Q+QrvbBMxh0RYlp8Vkk=
Date: Sat, 24 Nov 2018 19:35:54 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
Message-ID: <20181124140554.GG3175@vkoul-mobl.Dlink>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
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
Cc: hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org, jiangqi903@gmail.com,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 23-11-18, 15:24, Anshuman Khandual wrote:

> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -386,7 +386,8 @@ EXPORT_SYMBOL(dma_issue_pending_all);
>  static bool dma_chan_is_local(struct dma_chan *chan, int cpu)
>  {
>  	int node = dev_to_node(chan->device->dev);
> -	return node == -1 || cpumask_test_cpu(cpu, cpumask_of_node(node));
> +	return node == NUMA_NO_NODE ||
> +		cpumask_test_cpu(cpu, cpumask_of_node(node));
>  }

I do not see dev_to_node being updated first, that returns -1 so I would
prefer to check for -1 unless it return NUMA_NO_NODE

-- 
~Vinod
