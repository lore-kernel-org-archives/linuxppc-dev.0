Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0087.outbound.protection.outlook.com [104.47.36.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSJmZ0YvvzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 22:53:33 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
 <camelia.groza@nxp.com>, <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [PATCH 3/9] fsl/fman: remove wrong free
Date: Tue, 21 Feb 2017 13:52:48 +0200
Message-ID: <1487677974-13678-4-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
References: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_port.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_port.c b/drivers/net/ethernet/freescale/fman/fman_port.c
index f314348..57bf44f 100644
--- a/drivers/net/ethernet/freescale/fman/fman_port.c
+++ b/drivers/net/ethernet/freescale/fman/fman_port.c
@@ -1312,7 +1312,7 @@ int fman_port_config(struct fman_port *port, struct fman_port_params *params)
 	/* Allocate the FM driver's parameters structure */
 	port->cfg = kzalloc(sizeof(*port->cfg), GFP_KERNEL);
 	if (!port->cfg)
-		goto err_params;
+		return -EINVAL;
 
 	/* Initialize FM port parameters which will be kept by the driver */
 	port->port_type = port->dts_params.type;
@@ -1393,8 +1393,6 @@ int fman_port_config(struct fman_port *port, struct fman_port_params *params)
 
 err_port_cfg:
 	kfree(port->cfg);
-err_params:
-	kfree(port);
 	return -EINVAL;
 }
 EXPORT_SYMBOL(fman_port_config);
-- 
2.1.0
