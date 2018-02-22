Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTX20nKyzF1c1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:28:17 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1MMS5Ib025053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:28:16 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ga31w861m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 17:28:15 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Thu, 22 Feb 2018 17:28:14 -0500
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 34/38] cxlflash: Update synchronous interrupt status bits
Date: Thu, 22 Feb 2018 16:28:08 -0600
In-Reply-To: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1519338010-51782-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1519338488-53012-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SISLite specification has been updated to define new synchronous
interrupt status bits. These bits are set by the AFU when a given PASID or
EA is bad and a synchronous interrupt is triggered.

The SISLite header file is updated to support these new bits. Note that
there are also some formatting updates to some of the existing bits to
allow all of the definitions to line up uniformly.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/sislite.h | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/cxlflash/sislite.h b/drivers/scsi/cxlflash/sislite.h
index c08b9d3..874abce 100644
--- a/drivers/scsi/cxlflash/sislite.h
+++ b/drivers/scsi/cxlflash/sislite.h
@@ -258,23 +258,30 @@ struct sisl_host_map {
 				 * exit since there is no way to tell which
 				 * command caused the error.
 				 */
-#define SISL_ISTATUS_PERM_ERR_CMDROOM    0x0010ULL	/* b59, user error */
-#define SISL_ISTATUS_PERM_ERR_RCB_READ   0x0008ULL	/* b60, user error */
-#define SISL_ISTATUS_PERM_ERR_SA_WRITE   0x0004ULL	/* b61, user error */
-#define SISL_ISTATUS_PERM_ERR_RRQ_WRITE  0x0002ULL	/* b62, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_3_EA		0x0400ULL /* b53, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_2_EA		0x0200ULL /* b54, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_1_EA		0x0100ULL /* b55, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_3_PASID	0x0080ULL /* b56, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_2_PASID	0x0040ULL /* b57, user error */
+#define SISL_ISTATUS_PERM_ERR_LISN_1_PASID	0x0020ULL /* b58, user error */
+#define SISL_ISTATUS_PERM_ERR_CMDROOM		0x0010ULL /* b59, user error */
+#define SISL_ISTATUS_PERM_ERR_RCB_READ		0x0008ULL /* b60, user error */
+#define SISL_ISTATUS_PERM_ERR_SA_WRITE		0x0004ULL /* b61, user error */
+#define SISL_ISTATUS_PERM_ERR_RRQ_WRITE		0x0002ULL /* b62, user error */
 	/* Page in wait accessing RCB/IOASA/RRQ is reported in b63.
 	 * Same error in data/LXT/RHT access is reported via IOASA.
 	 */
-#define SISL_ISTATUS_TEMP_ERR_PAGEIN     0x0001ULL	/* b63, can be generated
-							 * only when AFU auto
-							 * retry is disabled.
-							 * If user can determine
-							 * the command that
-							 * caused the error, it
-							 * can be retried.
-							 */
-#define SISL_ISTATUS_UNMASK  (0x001FULL)	/* 1 means unmasked */
-#define SISL_ISTATUS_MASK    ~(SISL_ISTATUS_UNMASK)	/* 1 means masked */
+#define SISL_ISTATUS_TEMP_ERR_PAGEIN		0x0001ULL /* b63, can only be
+							   * generated when AFU
+							   * auto retry is
+							   * disabled. If user
+							   * can determine the
+							   * command that caused
+							   * the error, it can
+							   * be retried.
+							   */
+#define SISL_ISTATUS_UNMASK	(0x07FFULL)		/* 1 means unmasked */
+#define SISL_ISTATUS_MASK	~(SISL_ISTATUS_UNMASK)	/* 1 means masked */
 
 	__be64 intr_clear;
 	__be64 intr_mask;
-- 
2.1.0
