Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB6C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:07:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1782321904
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rRNSYcyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1782321904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrFS0g9VzDqRf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:07:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="rRNSYcyM"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr6z19rCzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8ZZTvJaPw8PfKadwYBXqBlltfSltHnwtr+g4DE3dCCY=; b=rRNSYcyMxmzDkNMx3oHrGcp/n
 pPD8CE++qGNHThZhR2Nr5HJEJEX4kXXKD8lsKOKFs3JiQ0Ga/ainxJiqQpPoC204MNm+MdxpaT25W
 7+rDdIygaB9sa2Bzvi0JG0+DWS+0FWywolTlDWaO+XE582h2uzm5dSZwDnUMa4iHxUq80LIpMuTnw
 Gg3BFCESqYr/p4+vvQbCiAVzaLZAgrZFJ480p8lEtUeWflW2BN2BFMWewLH4zeqTRoKuaWrPX0MtS
 6mp5sSpTMhiJm377UoTKDchRIsxFZfQ7fHo69A5xnchljYxfHX2BsicFiXrnVZ5jgHmN9q66Dewr5
 +XHpoL9eQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoY2-0000Ej-3Z; Wed, 13 Feb 2019 07:01:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: use generic DMA mapping code in powerpc V7
Date: Wed, 13 Feb 2019 08:01:01 +0100
Message-Id: <20190213070133.11259-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

this series switches the powerpc port to use the generic swiotlb and
noncoherent dma ops, and to use more generic code for the coherent
direct mapping, as well as removing a lot of dead code.

As this series is very large and depends on the dma-mapping tree I've
also published a git tree:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.7

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.7

Thanks a lot to Christian Zigotzky who spent a lot of time testing
iterations on pasemi and FSL boards!


Changes since v4:
 - rebased on top of the latests powerpc/next tree
 - fix the DART IOMMU bypass selection
 - remove the return value from arch_dma_set_mask, which was done
   incorrectly and isn't actually needed.
 - add a new patch to remove swiotlb_dma_supported
 - add a new patch to set a dma mask in the pasemi ethernet driver,
   given that we now validate it
 - add a new patch to fix a ZONE_DMA32 assumption in the dma-direct
   patch
 - split up a few patches to improve bisectability
 (v5 and v6 were never posted)

Changes since v3:
 - rebase on the powerpc fixes tree
 - add a new patch to actually make the baseline amigaone config
   configure without warnings
 - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
   always present
 - fix compile in mem.c for one configuration
 - drop the full npu removal for now, will be resent separately
 - a few git bisection fixes

The changes since v1 are to big to list and v2 was not posted in public.

 arch/powerpc/kernel/dma.c                       |  362 ------------------------
 b/arch/powerpc/Kconfig                          |    5 
 b/arch/powerpc/include/asm/device.h             |   10 
 b/arch/powerpc/include/asm/dma-direct.h         |   18 -
 b/arch/powerpc/include/asm/dma-mapping.h        |   92 ------
 b/arch/powerpc/include/asm/iommu.h              |   17 +
 b/arch/powerpc/include/asm/machdep.h            |    4 
 b/arch/powerpc/include/asm/pci-bridge.h         |    5 
 b/arch/powerpc/include/asm/pci.h                |    2 
 b/arch/powerpc/include/asm/pgtable.h            |    1 
 b/arch/powerpc/include/asm/swiotlb.h            |    5 
 b/arch/powerpc/kernel/Makefile                  |    3 
 b/arch/powerpc/kernel/dma-iommu.c               |   75 ++++
 b/arch/powerpc/kernel/dma-mask.c                |   12 
 b/arch/powerpc/kernel/dma-swiotlb.c             |   89 -----
 b/arch/powerpc/kernel/pci-common.c              |   10 
 b/arch/powerpc/kernel/setup-common.c            |    1 
 b/arch/powerpc/mm/dma-noncoherent.c             |   40 +-
 b/arch/powerpc/mm/mem.c                         |   22 -
 b/arch/powerpc/platforms/44x/ppc476.c           |    1 
 b/arch/powerpc/platforms/44x/warp.c             |    2 
 b/arch/powerpc/platforms/85xx/corenet_generic.c |    5 
 b/arch/powerpc/platforms/85xx/ge_imp3a.c        |    2 
 b/arch/powerpc/platforms/85xx/mpc8536_ds.c      |    2 
 b/arch/powerpc/platforms/85xx/mpc85xx_ds.c      |    4 
 b/arch/powerpc/platforms/85xx/mpc85xx_mds.c     |    4 
 b/arch/powerpc/platforms/85xx/p1010rdb.c        |    1 
 b/arch/powerpc/platforms/85xx/p1022_ds.c        |    2 
 b/arch/powerpc/platforms/85xx/p1022_rdk.c       |    2 
 b/arch/powerpc/platforms/85xx/qemu_e500.c       |    1 
 b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |    1 
 b/arch/powerpc/platforms/Kconfig.cputype        |    3 
 b/arch/powerpc/platforms/cell/iommu.c           |  172 +----------
 b/arch/powerpc/platforms/pasemi/iommu.c         |    2 
 b/arch/powerpc/platforms/pasemi/setup.c         |   51 ---
 b/arch/powerpc/platforms/powernv/npu-dma.c      |    2 
 b/arch/powerpc/platforms/powernv/pci-ioda.c     |  132 +-------
 b/arch/powerpc/platforms/pseries/iommu.c        |   99 +-----
 b/arch/powerpc/platforms/pseries/vio.c          |   95 ++----
 b/arch/powerpc/sysdev/dart_iommu.c              |   58 +--
 b/arch/powerpc/sysdev/fsl_pci.c                 |   25 -
 b/drivers/misc/cxl/vphb.c                       |    3 
 b/drivers/net/ethernet/pasemi/pasemi_mac.c      |    1 
 b/include/linux/swiotlb.h                       |    3 
 b/kernel/dma/Kconfig                            |    3 
 b/kernel/dma/direct.c                           |    3 
 b/kernel/dma/mapping.c                          |   11 
 b/kernel/dma/swiotlb.c                          |   12 
 48 files changed, 317 insertions(+), 1158 deletions(-)
