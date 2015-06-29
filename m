Return-Path: <maninder1.s@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C06E41A0D30
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2015 20:45:58 +1000 (AEST)
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NQP01K4HC3RRYB0@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Mon, 29 Jun 2015 19:35:51 +0900 (KST)
From: Maninder Singh <maninder1.s@samsung.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: pankaj.m@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] cxl/vphb.c: Use phb pointer after NULL check
Date: Mon, 29 Jun 2015 16:05:11 +0530
Message-id: <1435574111-45617-1-git-send-email-maninder1.s@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

static Anlaysis detected below error:-
(error) Possible null pointer dereference: phb

So, Use phb after NULL check.

Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 drivers/misc/cxl/vphb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index b1d1983a..2eba002 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -112,9 +112,10 @@ static int cxl_pcie_config_info(struct pci_bus *bus, unsigned int devfn,
 	unsigned long addr;
 
 	phb = pci_bus_to_host(bus);
-	afu = (struct cxl_afu *)phb->private_data;
 	if (phb == NULL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
+	afu = (struct cxl_afu *)phb->private_data;
+
 	if (cxl_pcie_cfg_record(bus->number, devfn) > afu->crs_num)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	if (offset >= (unsigned long)phb->cfg_data)
-- 
1.7.9.5
