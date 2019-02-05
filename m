Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D36C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:22:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AFB2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AFB2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2Hb1fw7zDqDD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:22:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2F371z5zDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:20:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43v2F35Mfjz9sMp;
 Tue,  5 Feb 2019 22:20:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH] powerpc: fix get_arch_dma_ops() for NTB devices
In-Reply-To: <20190204081752.GA5730@lst.de>
References: <20190128133203.mon4a3nkrzijn43g@alfbook-pro.local>
 <87imy6pain.fsf@concordia.ellerman.id.au> <20190204081752.GA5730@lst.de>
Date: Tue, 05 Feb 2019 22:20:32 +1100
Message-ID: <87h8dimqgv.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Alexander Fomichev <fomichev.ru@gmail.com>, linux@yadro.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:
> On Wed, Jan 30, 2019 at 11:58:40PM +1100, Michael Ellerman wrote:
>> Alexander Fomichev <fomichev.ru@gmail.com> writes:
>> 
>> > get_dma_ops() falls into arch-dependant get_arch_dma_ops(), which
>> > historically returns NULL on PowerPC. Therefore dma_set_mask() fails.
>> > This affects Switchtec (and probably other) NTB devices, that they fail
>> > to initialize.
>> 
>> What's an NTB device?
>> 
>> drivers/ntb I assume?
>> 
>> So it's a PCI device of some sort, but presumably the device you're
>> calling dma_set_mask() on is an NTB device not a PCI device?
>> 
>> But then it works if you tell it to use the PCI DMA ops?
>> 
>> At the very least the code should be checking for the NTB bus type and
>> only returning the PCI ops in that specific case, not for all devices.
>
> Can you provide the context?  E.g. the patch and the rest of the commit
> log.  This all looks rather odd to me.

Sorry, here it is.

Or on lore: https://lore.kernel.org/linuxppc-dev/20190128133203.mon4a3nkrzijn43g@alfbook-pro.local/

Subject: [RFC PATCH] powerpc: fix get_arch_dma_ops() for NTB devices

get_dma_ops() falls into arch-dependant get_arch_dma_ops(), which
historically returns NULL on PowerPC. Therefore dma_set_mask() fails.
This affects Switchtec (and probably other) NTB devices, that they fail
to initialize.
The proposed patch should fix the issue.

---
 arch/powerpc/include/asm/dma-mapping.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index ebf6680..cb6ac96 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -70,14 +70,11 @@ extern struct dma_map_ops dma_iommu_ops;
 #endif
 extern const struct dma_map_ops dma_nommu_ops;

+extern const struct dma_map_ops *get_pci_dma_ops(void);
+
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/* We don't handle the NULL dev case for ISA for now. We could
-	 * do it via an out of line call but it is not needed for now. The
-	 * only ISA DMA device we support is the floppy and we have a hack
-	 * in the floppy driver directly to get a device for us.
-	 */
-	return NULL;
+	return get_pci_dma_ops();
 }

 /*
