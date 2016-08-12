Return-Path: <peter.chen@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0085.outbound.protection.outlook.com [104.47.33.85])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9Wr83y86zDr1l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 14:19:51 +1000 (AEST)
From: Peter Chen <peter.chen@nxp.com>
To: <minghuan.Lian@freescale.com>, <mingkai.hu@freescale.com>,
 <tie-fei.zang@freescale.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 1/1] pci: host: pci-layerscape: add missing of_node_put after
 calling of_parse_phandle
Date: Fri, 12 Aug 2016 09:34:41 +0800
Message-ID: <1470965681-30496-1-git-send-email-peter.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Minghuan Lian <minghuan.Lian@freescale.com>
Cc: Mingkai Hu <mingkai.hu@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/pci/host/pci-layerscape.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
index 114ba81..573b996 100644
--- a/drivers/pci/host/pci-layerscape.c
+++ b/drivers/pci/host/pci-layerscape.c
@@ -173,6 +173,8 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp,
 		return -EINVAL;
 	}
 
+	of_node_put(msi_node);
+
 	return 0;
 }
 
-- 
1.9.1
