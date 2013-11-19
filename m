Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C9302C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 19:11:55 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 19 Nov 2013 18:11:53 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1CAF52BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 19:11:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAJ8BUOE2818494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 19:11:30 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAJ8Bfin003315
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 19:11:41 +1100
Message-ID: <1384848697.2511.17.camel@ThinkPad-T5421>
Subject: [RFC PATCH powerpc] Fix a dma_mask issue of vio
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 19 Nov 2013 16:11:37 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, rmk+kernel@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I encountered following issue:
[    0.283035] ibmvscsi 30000015: couldn't initialize event pool
[    5.688822] ibmvscsi: probe of 30000015 failed with error -1

which prevents the storage from being recognized, and the machine from
booting.

After some digging, it seems that it is caused by commit 4886c399da

as dma_mask pointer in viodev->dev is not set, so in
dma_set_mask_and_coherent(), dma_set_coherent_mask() is not called
because dma_set_mask(), which is dma_set_mask_pSeriesLP() returned EIO.
While before the commit, dma_set_coherent_mask() is always called. 

I tried to replace dma_set_mask_and_coherent() with
dma_coerce_mask_and_coherent(), and the machine could boot again. 

But I'm not sure whether this is the correct fix...

---
 arch/powerpc/kernel/vio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88..76a6482 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
 	}
 
 	/* register with generic device framework */
