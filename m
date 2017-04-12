Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3D9n2ylqzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 05:14:05 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3CJ9UcX029781
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 15:13:53 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sb7d2euf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 15:13:53 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 13:13:51 -0600
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 04/17] cxlflash: Update sysfs helper routines to pass config
 structure
Date: Wed, 12 Apr 2017 14:13:34 -0500
In-Reply-To: <1492024215-55579-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1492024215-55579-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1492024414-55770-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>

As staging for future function, pass the config pointer instead of the
AFU pointer for port-related sysfs helper routines.

Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/main.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index 30d68af..157d806 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2058,13 +2058,16 @@ static int cxlflash_change_queue_depth(struct scsi_device *sdev, int qdepth)
 /**
  * cxlflash_show_port_status() - queries and presents the current port status
  * @port:	Desired port for status reporting.
- * @afu:	AFU owning the specified port.
+ * @cfg:	Internal structure associated with the host.
  * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
  *
  * Return: The size of the ASCII string returned in @buf.
  */
-static ssize_t cxlflash_show_port_status(u32 port, struct afu *afu, char *buf)
+static ssize_t cxlflash_show_port_status(u32 port,
+					 struct cxlflash_cfg *cfg,
+					 char *buf)
 {
+	struct afu *afu = cfg->afu;
 	char *disp_status;
 	u64 status;
 	__be64 __iomem *fc_regs;
@@ -2099,9 +2102,8 @@ static ssize_t port0_show(struct device *dev,
 			  char *buf)
 {
 	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
-	struct afu *afu = cfg->afu;
 
-	return cxlflash_show_port_status(0, afu, buf);
+	return cxlflash_show_port_status(0, cfg, buf);
 }
 
 /**
@@ -2117,9 +2119,8 @@ static ssize_t port1_show(struct device *dev,
 			  char *buf)
 {
 	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
-	struct afu *afu = cfg->afu;
 
-	return cxlflash_show_port_status(1, afu, buf);
+	return cxlflash_show_port_status(1, cfg, buf);
 }
 
 /**
@@ -2208,15 +2209,16 @@ static ssize_t ioctl_version_show(struct device *dev,
 /**
  * cxlflash_show_port_lun_table() - queries and presents the port LUN table
  * @port:	Desired port for status reporting.
- * @afu:	AFU owning the specified port.
+ * @cfg:	Internal structure associated with the host.
  * @buf:	Buffer of length PAGE_SIZE to report back port status in ASCII.
  *
  * Return: The size of the ASCII string returned in @buf.
  */
 static ssize_t cxlflash_show_port_lun_table(u32 port,
-					    struct afu *afu,
+					    struct cxlflash_cfg *cfg,
 					    char *buf)
 {
+	struct afu *afu = cfg->afu;
 	int i;
 	ssize_t bytes = 0;
 	__be64 __iomem *fc_port;
@@ -2245,9 +2247,8 @@ static ssize_t port0_lun_table_show(struct device *dev,
 				    char *buf)
 {
 	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
-	struct afu *afu = cfg->afu;
 
-	return cxlflash_show_port_lun_table(0, afu, buf);
+	return cxlflash_show_port_lun_table(0, cfg, buf);
 }
 
 /**
@@ -2263,9 +2264,8 @@ static ssize_t port1_lun_table_show(struct device *dev,
 				    char *buf)
 {
 	struct cxlflash_cfg *cfg = shost_priv(class_to_shost(dev));
-	struct afu *afu = cfg->afu;
 
-	return cxlflash_show_port_lun_table(1, afu, buf);
+	return cxlflash_show_port_lun_table(1, cfg, buf);
 }
 
 /**
-- 
2.1.0
