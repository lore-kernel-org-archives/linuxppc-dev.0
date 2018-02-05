Return-Path: <desnesn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZtTT2QZxzF0W8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Feb 2018 03:34:20 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w15GXrtZ156224
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Feb 2018 11:34:17 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fxqb028j1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 11:34:17 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <desnesn@linux.vnet.ibm.com>;
 Mon, 5 Feb 2018 11:34:15 -0500
From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, tyreld@linux.vnet.ibm.com,
 tlfalcon@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com,
 nfont@linux.vnet.ibm.com
Subject: [PATCH, net] ibmvnic: fix empty firmware version and errors cleanup
Date: Mon,  5 Feb 2018 14:33:55 -0200
Message-Id: <20180205163355.16064-1-desnesn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes sure that the firmware version is never NULL. Moreover,
it also performs some cleanup on the error messages.

Fixes: a107311d7fdf ("ibmvnic: fix firmware version when no firmware level
has been provided by the VIOS server")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.vnet.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5caaa9033841..afaf29b201dc 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3286,7 +3286,7 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 			   struct ibmvnic_adapter *adapter)
 {
 	struct device *dev = &adapter->vdev->dev;
-	unsigned char *substr = NULL, *ptr = NULL;
+	unsigned char *substr = NULL;
 	u8 fw_level_len = 0;
 
 	memset(adapter->fw_version, 0, 32);
@@ -3306,10 +3306,6 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
 	if (!substr) {
 		dev_info(dev, "Warning - No FW level has been provided in the VPD buffer by the VIOS Server\n");
-		ptr = strncpy((char *)adapter->fw_version, "N/A",
-			      3 * sizeof(char));
-		if (!ptr)
-			dev_err(dev, "Failed to inform that firmware version is unavailable to the adapter\n");
 		goto complete;
 	}
 
@@ -3324,16 +3320,14 @@ static void handle_vpd_rsp(union ibmvnic_crq *crq,
 	/* copy firmware version string from vpd into adapter */
 	if ((substr + 3 + fw_level_len) <
 	    (adapter->vpd->buff + adapter->vpd->len)) {
-		ptr = strncpy((char *)adapter->fw_version,
-			      substr + 3, fw_level_len);
-
-		if (!ptr)
-			dev_err(dev, "Failed to isolate FW level string\n");
+		strncpy((char *)adapter->fw_version, substr + 3, fw_level_len);
 	} else {
 		dev_info(dev, "FW substr extrapolated VPD buff\n");
 	}
 
 complete:
+	if (adapter->fw_version[0] == '\0')
+		strncpy((char *)adapter->fw_version, "N/A", 3 * sizeof(char));
 	complete(&adapter->fw_done);
 }
 
-- 
2.14.3
