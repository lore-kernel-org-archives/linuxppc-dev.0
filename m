Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D68DC169C4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 15:18:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1CE2080D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 15:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1CE2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vlTM5j8BzDqMT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 02:18:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vlRG4BqHzDqRX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 02:16:58 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 4EF4F68D93; Wed,  6 Feb 2019 16:16:55 +0100 (CET)
Date: Wed, 6 Feb 2019 16:16:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190206151655.GA31172@lst.de>
References: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206151505.GA31065@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>,
 linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 06, 2019 at 04:15:05PM +0100, Christoph Hellwig wrote:
> The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
> ("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
> remember correctly.  powerpc/dma: use the dma_direct mapping routines
> was the one that you said makes the pasemi ethernet stop working.
> 
> Can you post the dmesg from the failing runs?

But I just noticed I sent you a wrong patch - the pasemi ethernet
should set a 64-bit DMA mask, not 32-bit.  Updated version below,
32-bit would just keep the previous status quo.

commit 6c8f88045dee35933337b9ce2ea5371eee37073a
Author: Christoph Hellwig <hch@lst.de>
Date:   Mon Feb 4 13:38:22 2019 +0100

    pasemi WIP

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index 8a31a02c9f47..2d7d1589490a 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENODEV;
 		goto out;
 	}
+	dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
 
 	mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
 	if (!mac->iob_pdev) {
