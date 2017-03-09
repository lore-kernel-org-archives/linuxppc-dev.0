Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0043.outbound.protection.outlook.com [104.47.36.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfCfJ4XPhzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 01:37:28 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <camelia.groza@nxp.com>,
 <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 01/10] fsl/fman: parse result data is big endian
Date: Thu, 9 Mar 2017 16:36:56 +0200
Message-ID: <1489070225-7891-2-git-send-email-madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.h b/drivers/net/ethernet/freescale/fman/fman.h
index 57aae8d..f53e147 100644
--- a/drivers/net/ethernet/freescale/fman/fman.h
+++ b/drivers/net/ethernet/freescale/fman/fman.h
@@ -134,14 +134,14 @@ enum fman_exceptions {
 struct fman_prs_result {
 	u8 lpid;		/* Logical port id */
 	u8 shimr;		/* Shim header result  */
-	u16 l2r;		/* Layer 2 result */
-	u16 l3r;		/* Layer 3 result */
+	__be16 l2r;		/* Layer 2 result */
+	__be16 l3r;		/* Layer 3 result */
 	u8 l4r;		/* Layer 4 result */
 	u8 cplan;		/* Classification plan id */
-	u16 nxthdr;		/* Next Header  */
-	u16 cksum;		/* Running-sum */
+	__be16 nxthdr;		/* Next Header  */
+	__be16 cksum;		/* Running-sum */
 	/* Flags&fragment-offset field of the last IP-header */
-	u16 flags_frag_off;
+	__be16 flags_frag_off;
 	/* Routing type field of a IPV6 routing extension header */
 	u8 route_type;
 	/* Routing Extension Header Present; last bit is IP valid */
-- 
2.1.0
