Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB05DC0650E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:27:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50862064A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50862064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hnql1CVHzDq9P
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 11:27:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hnfp4DDbzDqPk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45hnfp3P7vz9sNx; Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: efd176a04bef41aab5b3087e977fea2b69915174
In-Reply-To: <20190507062559.20295-2-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH kernel 1/2] powerpc/pseries/dma: Allow swiotlb
Message-Id: <45hnfp3P7vz9sNx@ozlabs.org>
Date: Mon,  8 Jul 2019 11:19:30 +1000 (AEST)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-05-07 at 06:25:58 UTC, Alexey Kardashevskiy wrote:
> The commit 8617a5c5bc00 ("powerpc/dma: handle iommu bypass in
> dma_iommu_ops") merged direct DMA ops into the IOMMU DMA ops allowing
> SWIOTLB as well but only for mapping; the unmapping and bouncing parts
> were left unmodified.
> 
> This adds missing direct unmapping calls to .unmap_page() and .unmap_sg().
> 
> This adds missing sync callbacks and directs them to the direct DMA hooks.
> 
> Fixes: 8617a5c5bc00 (powerpc/dma: handle iommu bypass in dma_iommu_ops)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/efd176a04bef41aab5b3087e977fea2b69915174

cheers
