Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0062.outbound.protection.outlook.com [104.47.32.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfCfV1YRlzDqZ6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:37:37 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <camelia.groza@nxp.com>,
 <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 03/10] fsl/fman: remove wrong free
Date: Thu, 9 Mar 2017 16:36:58 +0200
Message-ID: <1489070225-7891-4-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
References: <1489070225-7891-1-git-send-email-madalin.bucur@nxp.com>
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
