Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD98C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:09:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBDD21873
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBDD21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nBR267fBzDqNW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:09:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBNn27dczDqMK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:07:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBNn08nDz9s9h; Mon, 22 Apr 2019 00:07:20 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7a3a4d763837d3aa654cd1059030950410c04d77
X-Patchwork-Hint: ignore
In-Reply-To: <20190403041233.57619-3-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel,v2,2/2] powerpc/mm_iommu: Allow pinning large regions
Message-Id: <44nBNn08nDz9s9h@ozlabs.org>
Date: Mon, 22 Apr 2019 00:07:20 +1000 (AEST)
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
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-04-03 at 04:12:33 UTC, Alexey Kardashevskiy wrote:
> When called with vmas_arg==NULL, get_user_pages_longterm() allocates
> an array of nr_pages*8 which can easily get greater that the max order,
> for example, registering memory for a 256GB guest does this and fails
> in __alloc_pages_nodemask().
> 
> This adds a loop over chunks of entries to fit the max order limit.
> 
> Fixes: 678e174c4c16 ("powerpc/mm/iommu: allow migration of cma allocated pages during mm_iommu_do_alloc", 2019-03-05)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7a3a4d763837d3aa654cd10590309504

cheers
