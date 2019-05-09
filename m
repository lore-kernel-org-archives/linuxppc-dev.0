Return-Path: <SRS0=tA1z=TJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75CBC04AB1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 15:36:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DDCC2173B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 May 2019 15:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDCC2173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450HWB5ZcYzDqSL
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 01:36:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450HTZ0mQMzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 01:34:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 450HTY6bHSz9s9y; Fri, 10 May 2019 01:34:57 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: f39356261c265a0689d7ee568132d516e8b6cecc
X-Patchwork-Hint: ignore
In-Reply-To: <5ae0401c-a84a-1e59-5d9d-70659f5a85de@linux.vnet.ibm.com>
To: Rick Lindsley <ricklind@linux.vnet.ibm.com>,
 Michael Ellerman <michaele@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/book3s/64: check for NULL pointer in pgd_alloc()
Message-Id: <450HTY6bHSz9s9y@ozlabs.org>
Date: Fri, 10 May 2019 01:34:57 +1000 (AEST)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-05-06 at 00:20:43 UTC, Rick Lindsley wrote:
> When the memset code was added to pgd_alloc(), it failed to consider that kmem_cache_alloc() can return NULL.  It's uncommon, but not impossible under heavy memory contention.
> 
> Signed-off-by: Rick Lindsley <ricklind@vnet.linux.ibm.com>
> Fixes: cf266dbcd2a7 ("Zero PGD pages on allocation")

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f39356261c265a0689d7ee568132d516

cheers
