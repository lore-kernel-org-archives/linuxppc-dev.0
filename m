Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXShd6LYbzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2018 05:05:37 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w11I0CbM130553
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Feb 2018 13:05:35 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fv7nc8k3d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Feb 2018 13:05:35 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Thu, 1 Feb 2018 13:05:34 -0500
From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tlfalcon@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com
Subject: [PATCH,
 net] ibmvnic: fix firmware version when no firmware level has been
 provided by the VIOS server
Date: Thu,  1 Feb 2018 16:04:30 -0200
Message-Id: <20180201180430.16950-1-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older versions of VIOS servers do not send the firmware level in the VPD
buffer for the ibmvnic driver. Thus, not only the current message is mis-
leading but the firmware version in the ethtool will be NULL. Therefore,
this patch fixes the firmware string and its warning.

Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of VPD for the ibmvnic driver")

Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index b65f5f3ac034..2b3e71b63a7a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3290,7 +3290,11 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	 */
 	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
 	if (!substr) {
-		dev_info(dev, "No FW level provided by VPD\n");
+		dev_info(dev, "Warning - No FW level has been provided in the VPD buffer by the VIOS Server\n");
+		ptr = strncpy((char *)adapter->fw_version, "N/A",
+			      3 * sizeof(char));
+		if (!ptr)
+			dev_err(dev, "Failed to inform that firmware version is unavailable to the adapter\n");
 		goto complete;
 	}
 
-- 
2.14.3
