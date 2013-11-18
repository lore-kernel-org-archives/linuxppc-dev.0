Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 310C62C0086
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 21:58:23 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 18 Nov 2013 10:58:20 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5E9D22190087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:58:15 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAIAw2AR60883028
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 10:58:02 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAIAwEFa012337
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 03:58:15 -0700
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] DMA-API: ppc: vio: use dma_coerce_mask_and_coherent()
Date: Mon, 18 Nov 2013 11:57:22 +0100
Message-Id: <1384772242-15869-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <20131116153244.GD25039@n2100.arm.linux.org.uk>
References: <20131116153244.GD25039@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Russell King <rmk+kernel@arm.linux.org.uk>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 4886c399da70d5f8a4016c2213850dce6cac88c5 (DMA-API: ppc: vio.c: 
replace dma_set_mask()+dma_set_coherent_mask() with new helper) 
introduced the usage of the new helper routine dma_set_mask_and_coherent(). 
This breaks the initialization of the pseries vio devices which do not 
setup an initial dev->dma_mask for the device.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>
---

 arch/powerpc/kernel/vio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88f..76a6482 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,7 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		dma_coerce_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
 	}
 
 	/* register with generic device framework */
-- 
1.7.10.4
