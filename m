Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2906BC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 10:34:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4272145D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 10:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4272145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435rNZ2Tx0zDq9W
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 21:34:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435rLM2qh4zDrPw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 21:32:25 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 964A868BDF; Fri, 30 Nov 2018 11:32:22 +0100 (CET)
Date: Fri, 30 Nov 2018 11:32:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181130103222.GA23393@lst.de>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, hch@lst.de,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Rui,

can you check if the patch below fixes the issue for you?

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 2e24fc87ed84..809797dbe169 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -392,7 +392,9 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 
 static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
 {
-	return dart_is_u4 && dart_device_on_pcie(&dev->dev);
+	return dart_is_u4 &&
+		dart_device_on_pcie(&dev->dev) &&
+		mask >= DMA_BIT_MASK(40);
 }
 
 void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
