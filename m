Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DAB1A1F44
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 10:48:31 +1000 (AEST)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1AA121401CD
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 10:48:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 7 Sep 2015 10:48:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 334072BB004D
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Sep 2015 10:48:25 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t870m82N197020
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 10:48:16 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t870lqsx005630
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Sep 2015 10:47:52 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, imunsie@au1.ibm.com, dja@axtens.net
Subject: [PATCH] cxl: abort cxl_pci_enable_device_hook() if PCI channel is
 offline
Date: Mon,  7 Sep 2015 10:47:18 +1000
Message-Id: <1441586838-5371-1-git-send-email-andrew.donnellan@au1.ibm.com>
In-Reply-To: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1441347624-9787-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cxl_pci_enable_device_hook() is called when attempting to enable an AFU
sitting on a vPHB. At present, the state of the underlying CXL card's PCI
channel is only checked when it calls cxl_afu_check_and_enable() at the
very end, after it has already set DMA options and initialised a default
context.

Check the CXL card's link status before setting DMA options or initialising
a default context. If the link is down, print a warning and return
immediately.

Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/vphb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 6dd16a6..94b5208 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -48,6 +48,12 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 
 	phb = pci_bus_to_host(dev->bus);
 	afu = (struct cxl_afu *)phb->private_data;
+
+	if (!cxl_adapter_link_ok(afu->adapter)) {
+		dev_warn(&dev->dev, "%s: Device link is down, refusing to enable AFU\n", __func__);
+		return false;
+	}
+
 	set_dma_ops(&dev->dev, &dma_direct_ops);
 	set_dma_offset(&dev->dev, PAGE_OFFSET);
 
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
