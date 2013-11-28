Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 810B72C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 20:22:41 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Wed, 27 Nov 2013 14:52:37 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 592F2E005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 14:54:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAR9MT3d65863820
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 14:52:29 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAR9MX0E031320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Nov 2013 14:52:34 +0530
Message-ID: <1385630545.2439.11.camel@ThinkPad-T5421>
Subject: [PATCH powerpc] Revert c6102609 and replace it with the correct fix
 for vio dma mask setting
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Nov 2013 17:22:25 +0800
In-Reply-To: <1384993347.26969.124.camel@pasglop>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
 <20131120232337.GT16735@n2100.arm.linux.org.uk>
 <1384992102.26969.120.camel@pasglop>
 <20131121000819.GU16735@n2100.arm.linux.org.uk>
 <1384993347.26969.124.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch reverts my previous "fix", and replace it with the correct
fix from Russell. 

And as Russell pointed out -- dma_set_mask_and_coherent() (and the other
dma_set_mask() functions) are really supposed to be used by drivers
only.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/vio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 76a6482..d771778 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		viodev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
+		viodev->dev.dma_mask = &viodev->dev.coherent_dma_mask;
 	}
 
 	/* register with generic device framework */
