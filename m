Return-Path: <SRS0=3A4D=LA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D269C47096
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 11:37:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3FE61220
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 11:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3FE61220
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FyZGh6FdSz3c6Q
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Jun 2021 21:37:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FyZFf5N4qz2yWt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Jun 2021 21:36:05 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FyZFb5v3rz9sRN; Sun,  6 Jun 2021 21:36:03 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.ibm.com>, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210526144540.117795-1-fbarrat@linux.ibm.com>
References: <20210526144540.117795-1-fbarrat@linux.ibm.com>
Subject: Re: [PATCH] Revert "powerpc/kernel/iommu: Align size for
 IOMMU_PAGE_SIZE() to save TCEs"
Message-Id: <162297929376.2342154.14151322164907909539.b4-ty@ellerman.id.au>
Date: Sun, 06 Jun 2021 21:34:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: zdai@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 26 May 2021 16:45:40 +0200, Frederic Barrat wrote:
> This reverts commit 3c0468d4451eb6b4f6604370639f163f9637a479.
> 
> That commit was breaking alignment guarantees for the DMA address when
> allocating coherent mappings, as described in
> Documentation/core-api/dma-api-howto.rst
> 
> It was also noticed by Mellanox' driver:
> [ 1515.763621] mlx5_core c002:01:00.0: mlx5_frag_buf_alloc_node:146:(pid 13402): unexpected map alignment: 0x0800000000c61000, page_shift=16
> [ 1515.763635] mlx5_core c002:01:00.0: mlx5_cqwq_create:181:(pid
> 13402): mlx5_frag_buf_alloc_node() failed, -12

Applied to powerpc/fixes.

[1/1] Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs"
      https://git.kernel.org/powerpc/c/59cc84c802eb923805e7bba425976a3df5ce35d8

cheers
