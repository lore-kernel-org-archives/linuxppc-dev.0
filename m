Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5A5C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:44:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24F2A20818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:44:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F2A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445Sdz1NDlzDq5g
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:44:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Rgw21LJzDqPV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 21:01:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445Rgv63KTz9s8m; Fri, 22 Feb 2019 21:01:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8f5b27347e88b171c755562f0090ce40e514fc00
X-Patchwork-Hint: ignore
In-Reply-To: <20190218055801.35165-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel] powerpc/powernv/sriov: Register IOMMU groups for VFs
Message-Id: <445Rgv63KTz9s8m@ozlabs.org>
Date: Fri, 22 Feb 2019 21:01:31 +1100 (AEDT)
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-18 at 05:58:01 UTC, Alexey Kardashevskiy wrote:
> The compound IOMMU group rework moved iommu_register_group() together in
> pnv_pci_ioda_setup_iommu_api() (which is a part of ppc_md.pcibios_fixup).
> As the result, pnv_ioda_setup_bus_iommu_group() does not create groups
> any more, it only adds devices to groups.
> 
> This works fine for boot time devices. However IOMMU groups for SRIOV's
> VFs were added by pnv_ioda_setup_bus_iommu_group() so this got broken:
> pnv_tce_iommu_bus_notifier() expects a group to be registered for VF
> and it is not.
> 
> This adds missing group registration and adds a NULL pointer check into
> the bus notifier so we won't stop in xmon if there is no group, although
> it is not expected to happen now.
> 
> Fixes: 0bd971676e68 "powerpc/powernv/npu: Add compound IOMMU groups"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reported-by: Santwana Samantray<santwana.samantray@in.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/8f5b27347e88b171c755562f0090ce40

cheers
