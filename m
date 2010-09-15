Return-Path: <nacc@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DC5A710083F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:07:01 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHvdR1021906
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 11:57:39 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6aCm208498
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FI6Z7d005965
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:35 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
Date: Wed, 15 Sep 2010 11:05:58 -0700
Message-Id: <1284573958-8397-16-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this change drivers, such as ibmvscsi, fail to load with the
previous change.
---
 arch/powerpc/kernel/vio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 3c3083f..e8d73de 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1259,6 +1259,9 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 	viodev->dev.parent = &vio_bus_device.dev;
 	viodev->dev.bus = &vio_bus_type;
 	viodev->dev.release = vio_dev_release;
+        /* needed to ensure proper operation of coherent allocations
+         * later, in case driver doesn't set it explicitly */
+        dma_set_coherent_mask(&viodev->dev, DMA_BIT_MASK(64));
 
 	/* register with generic device framework */
 	if (device_register(&viodev->dev)) {
-- 
1.7.0.4
