Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D3BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:23:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4F22184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 09:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4F22184A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4496Xh3RdSzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 20:23:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4496VX6VFczDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 20:21:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4496VW4cJpz9s71; Thu, 28 Feb 2019 20:21:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 11f5acce2fa43b015a8120fa7620fa4efd0a2952
X-Patchwork-Hint: ignore
In-Reply-To: <20190213033818.51452-1-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [kernel,
 v2] powerpc/powernv/ioda: Fix locked_vm counting for memory used by
 IOMMU tables
Message-Id: <4496VW4cJpz9s71@ozlabs.org>
Date: Thu, 28 Feb 2019 20:21:07 +1100 (AEDT)
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
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-02-13 at 03:38:18 UTC, Alexey Kardashevskiy wrote:
> We store 2 multilevel tables in iommu_table - one for the hardware and
> one with the corresponding userspace addresses. Before allocating
> the tables, the iommu_table_group_ops::get_table_size() hook returns
> the combined size of the two and VFIO SPAPR TCE IOMMU driver adjusts
> the locked_vm counter correctly. When the table is actually allocated,
> the amount of allocated memory is stored in iommu_table::it_allocated_size
> and used to decrement the locked_vm counter when we release the memory
> used by the table; .get_table_size() and .create_table() calculate it
> independently but the result is expected to be the same.
> 
> However the allocator does not add the userspace table size to
> .it_allocated_size so when we destroy the table because of VFIO PCI
> unplug (i.e. VFIO container is gone but the userspace keeps running),
> we decrement locked_vm by just a half of size of memory we are releasing.
> 
> To make things worse, since we enabled on-demain allocation of
> indirect levels, it_allocated_size contains only the amount of memory
> actually allocated at the table creation time which can just be
> a fraction. It is not a problem with incrementing locked_vm (as
> get_table_size() value is used) but it is with decrementing.
> 
> As the result, we leak locked_vm and may not be able to allocate more
> IOMMU tables after few iterations of hotplug/unplug.
> 
> This sets it_allocated_size in the pnv_pci_ioda2_ops::create_table()
> hook to what pnv_pci_ioda2_get_table_size() returns so from now on
> we have a single place which calculates the maximum memory a table can
> occupy. The original meaning of it_allocated_size is somewhat lost now
> though.
> 
> We do not ditch it_allocated_size whatsoever here and we do not call
> get_table_size() from vfio_iommu_spapr_tce.c when decrementing locked_vm
> as we may have multiple IOMMU groups per container and even though they
> all are supposed to have the same get_table_size() implementation,
> there is a small chance for failure or confusion.
> 
> Fixes: 090bad39b "powerpc/powernv: Add indirect levels to it_userspace"
> Fixes: a68bd1267 "powerpc/powernv/ioda: Allocate indirect TCE levels on demand"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11f5acce2fa43b015a8120fa7620fa4e

cheers
