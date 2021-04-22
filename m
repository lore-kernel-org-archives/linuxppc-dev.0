Return-Path: <SRS0=xMs2=JT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA8C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:21:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1923E6142F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1923E6142F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQpkD51Hnz3btR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Apr 2021 17:21:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jzhBxobm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+ccca8c562e79e8576e72+6451+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=jzhBxobm; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQphk51Wxz3bTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Apr 2021 17:19:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=aEdQBTMaUl2RRYZxc6tzp9x+ou0hYnPrwcHo24gdihQ=; b=jzhBxobmLoI0NNUrL8/EfTlash
 db9hFe8bub19NNsbPLexbUbQ/0Oek+2WiesnCwx+loiACq5t8ge/EL9W4DSMZFpoY87u/RPIoJkV0
 skPkrzEfku4t6XaFVhJGfYG1YSfoV53RnF9KVwcg5ui97sd7esymHU1XwRs6WoLw1zeQ/xSUREnAc
 pLvhgSOCyQ9FtJwrIeBOmivQMw3NSJjC5ztzsFnOy7RFUbjIm1NeQM1uhJ+ll3xBSMmyBBrUfwNnU
 aNTNXR8y7wle+wwoQB70hJnfC//sRMKPPOusASzTKEHs37fKR/o1nitVIKirzjTWHnkI4mspElf5g
 mAplpQhw==;
Received: from [2001:4bb8:19b:f845:15fc:cef6:715a:fb03] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTcS-00DRkA-CT; Thu, 22 Apr 2021 07:19:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: cleanup and fix swiotlb sizing
Date: Thu, 22 Apr 2021 09:19:14 +0200
Message-Id: <20210422071921.1428607-1-hch@lst.de>
X-Mailer: git-send-email 2.30.1
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
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 iommu@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi all,

based on a report from Tom that overriding the default sizing provided
by the x86 SEV code on the command line doesn't work anymore, this series
cleans up how we handle default and command line sizes for the swiotlb
buffer and then fixes the recently introduced bug in a straight-forward
way.

Diffstat:
 arch/mips/cavium-octeon/dma-octeon.c      |   16 +--------------
 arch/mips/include/asm/octeon/pci-octeon.h |    1 
 arch/mips/pci/pci-octeon.c                |    2 -
 arch/powerpc/platforms/pseries/svm.c      |   13 ++----------
 drivers/xen/swiotlb-xen.c                 |    2 -
 include/linux/swiotlb.h                   |    2 -
 kernel/dma/swiotlb.c                      |   32 +++++++++++++++---------------
 7 files changed, 25 insertions(+), 43 deletions(-)
