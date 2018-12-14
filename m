Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6CC67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 13:31:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B6720643
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 13:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B6720643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GWfG6zxzzDrC7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 00:31:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GWby0HbFzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 00:29:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43GWbw5Rh4z9s0n;
 Sat, 15 Dec 2018 00:29:16 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 12/34] powerpc/cell: move dma direct window setup out of
 dma_configure
In-Reply-To: <20181212143604.GA5137@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-13-hch@lst.de> <871s6r3sno.fsf@concordia.ellerman.id.au>
 <20181212143604.GA5137@lst.de>
Date: Sat, 15 Dec 2018 00:29:11 +1100
Message-ID: <87mup8uti0.fsf@concordia.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christoph Hellwig <hch@lst.de> writes:
> On Sun, Dec 09, 2018 at 09:23:39PM +1100, Michael Ellerman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > Configure the dma settings at device setup time, and stop playing games
>> > with get_pci_dma_ops.  This prepares for using the common dma_configure
>> > code later on.
>> >
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> > ---
>> >  arch/powerpc/platforms/cell/iommu.c | 20 +++++++++++---------
>> >  1 file changed, 11 insertions(+), 9 deletions(-)
>> 
>> This one's crashing, haven't dug into why yet:
>
> Can you provide a gdb assembly of the exact crash site?  This looks
> like for some odd reason the DT structures aren't fully setup by the
> time we are probing the device, which seems odd.

It's dev->of_node which is NULL.

Because we were passed a platform_device which doesn't have an of_node.

It's the cbe-mic device created in cell_publish_devices().

I can fix that by simply checking for a NULL node, then the system boots
but then I have no network devices, due to:

  tg3 0000:00:01.0: enabling device (0140 -> 0142)
  tg3 0000:00:01.0: DMA engine test failed, aborting
  tg3: probe of 0000:00:01.0 failed with error -12
  tg3 0000:00:01.1: enabling device (0140 -> 0142)
  tg3 0000:00:01.1: DMA engine test failed, aborting
  tg3: probe of 0000:00:01.1 failed with error -12


I think the problem is that we don't want to set iommu_bypass_supported
unless cell_iommu_fixed_mapping_init() succeeds.

Yep. This makes it work for me on cell on top of your v5.

cheers


diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 348a815779c1..8329fda17cc8 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -813,6 +813,10 @@ static u64 cell_iommu_get_fixed_address(struct device *dev)
 	int i, len, best, naddr, nsize, pna, range_size;
 
 	np = of_node_get(dev->of_node);
+	if (!np)
+		/* We can be called for platform devices that have no of_node */
+		goto out;
+
 	while (1) {
 		naddr = of_n_addr_cells(np);
 		nsize = of_n_size_cells(np);
@@ -1065,8 +1069,11 @@ static int __init cell_iommu_init(void)
 	/* Setup various callbacks */
 	cell_pci_controller_ops.dma_dev_setup = cell_pci_dma_dev_setup;
 
-	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() == 0)
+	if (!iommu_fixed_disabled && cell_iommu_fixed_mapping_init() == 0) {
+		cell_pci_controller_ops.iommu_bypass_supported =
+			cell_pci_iommu_bypass_supported;
 		goto done;
+	}
 
 	/* Create an iommu for each /axon node.  */
 	for_each_node_by_name(np, "axon") {
@@ -1085,10 +1092,6 @@ static int __init cell_iommu_init(void)
 	}
  done:
 	/* Setup default PCI iommu ops */
-	if (!iommu_fixed_disabled) {
-		cell_pci_controller_ops.iommu_bypass_supported =
-				cell_pci_iommu_bypass_supported;
-	}
 	set_pci_dma_ops(&dma_iommu_ops);
 	cell_iommu_enabled = true;
  bail:
