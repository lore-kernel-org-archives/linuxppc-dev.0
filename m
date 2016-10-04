Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-bn3nam01on0077.outbound.protection.outlook.com [104.47.33.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp9d14hq6zDrX4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 18:33:25 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linuxdev.baldrick@gmail.com>
Subject: [net-next 10/13] fsl/fman: simplify redundant condition
Date: Tue, 4 Oct 2016 10:32:56 +0300
Message-ID: <1475566379-5078-11-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
References: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
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

Change suggested by David Binderman, thanks.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 2278bbd..1fc1049 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2331,8 +2331,7 @@ int fman_set_mac_max_frame(struct fman *fman, u8 mac_id, u16 mfl)
 	 * or equal to the port's max
 	 */
 	if ((!fman->state->port_mfl[mac_id]) ||
-	    (fman->state->port_mfl[mac_id] &&
-	    (mfl <= fman->state->port_mfl[mac_id]))) {
+	    (mfl <= fman->state->port_mfl[mac_id])) {
 		fman->state->mac_mfl[mac_id] = mfl;
 	} else {
 		dev_warn(fman->dev, "%s: MAC max_frame_length is larger than Port max_frame_length\n",
-- 
2.1.0
