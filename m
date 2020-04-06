Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB221C2BA19
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:41:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498352336E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 13:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498352336E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wsBk1Qq4zDrCJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:41:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wrPv3x1MzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 23:05:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 48wrPp3nXMz9sSJ; Mon,  6 Apr 2020 23:05:47 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 54fc3c681ded9437e4548e2501dc1136b23cfa9a
In-Reply-To: <20200331012338.23773-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/pseries/ddw: Extend upper limit for huge
 DMA window for persistent memory
Message-Id: <48wrPp3nXMz9sSJ@ozlabs.org>
Date: Mon,  6 Apr 2020 23:05:47 +1000 (AEST)
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
Cc: Brian J King <bjking1@us.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Wen Xiong <wenxiong@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-03-31 at 01:23:38 UTC, Alexey Kardashevskiy wrote:
> Unlike normal memory ("memory" compatible type in the FDT),
> the persistent memory ("ibm,pmemory" in the FDT) can be mapped anywhere
> in the guest physical space and it can be used for DMA.
> 
> In order to maintain 1:1 mapping via the huge DMA window, we need to
> know the maximum physical address at the time of the window setup.
> So far we've been looking at "memory" nodes but "ibm,pmemory" does not
> have fixed addresses and the persistent memory may be mapped afterwards.
> 
> Since the persistent memory is still backed with page structs,
> use MAX_PHYSMEM_BITS as the upper limit.
> 
> This effectively disables huge DMA window in LPAR under pHyp if
> persistent memory is present but this is the best we can do.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/54fc3c681ded9437e4548e2501dc1136b23cfa9a

cheers
