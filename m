Return-Path: <SRS0=cjtt=VF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E7CC0650E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:58:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D332053B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 01:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D332053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45hpWZ68zNzDqY5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jul 2019 11:58:18 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45hng43HQjzDqQ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2019 11:19:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45hng34j7nz9sNF; Mon,  8 Jul 2019 11:19:43 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 5636427d087a55842c1a199dfb839e6545d30e5d
In-Reply-To: <20190628065300.41674-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv: Fix stale iommu table base after
 VFIO
Message-Id: <45hng34j7nz9sNF@ozlabs.org>
Date: Mon,  8 Jul 2019 11:19:43 +1000 (AEST)
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
 Alistair Popple <alistair@popple.id.au>, Sam Bobroff <sbobroff@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-06-28 at 06:53:00 UTC, Alexey Kardashevskiy wrote:
> The powernv platform uses @dma_iommu_ops for non-bypass DMA. These ops
> need an iommu_table pointer which is stored in
> dev->archdata.iommu_table_base. It is initialized during
> pcibios_setup_device() which handles boot time devices. However when
> a device is taken from the system in order to pass it through, the default
> IOMMU table is destroyed but the pointer in a device is not updated;
> also when a device is returned back to the system, a new table pointer
> is not stored in dev->archdata.iommu_table_base either. So when a just
> returned device tries using IOMMU, it crashes on accessing stale
> iommu_table or its members.
> 
> This calls set_iommu_table_base() when the default window is created.
> Note it used to be there before but was wrongly removed (see "fixes").
> It did not appear before as these days most devices simply use bypass.
> 
> This adds set_iommu_table_base(NULL) when a device is taken from
> the system to make it clear that IOMMU DMA cannot be used past that point.
> 
> Fixes: c4e9d3c1e65a ("powerpc/powernv/pseries: Rework device adding to IOMMU groups")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5636427d087a55842c1a199dfb839e6545d30e5d

cheers
