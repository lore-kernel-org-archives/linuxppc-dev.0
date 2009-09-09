Return-Path: <roel.kluin@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1AD5FB7BCD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 01:03:59 +1000 (EST)
Received: from mail-qy0-f173.google.com (mail-qy0-f173.google.com
	[209.85.221.173]) by ozlabs.org (Postfix) with ESMTP id 63C24DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 01:03:58 +1000 (EST)
Received: by qyk3 with SMTP id 3so3426194qyk.4
	for <linuxppc-dev@ozlabs.org>; Wed, 09 Sep 2009 08:03:56 -0700 (PDT)
Message-ID: <4AA7C380.6030805@gmail.com>
Date: Wed, 09 Sep 2009 17:02:24 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] powerpc: kmalloc failure ignored in vio_build_iommu_table()
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Prevent NULL dereference if kmalloc() fails.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with sed: http://kernelnewbies.org/roelkluin

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 819e59f..1f5266f 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1054,6 +1054,8 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 		return NULL;
 
 	tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
+	if (tbl == NULL)
+		return NULL;
 
 	of_parse_dma_window(dev->dev.archdata.of_node, dma_window,
 			    &tbl->it_index, &offset, &size);
