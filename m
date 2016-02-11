Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D09391A03C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:46 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 20:32:44 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C890CC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:32:39 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1WfrW12648522
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:41 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TOoX003780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:25 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 6/7] ibmvscsi: Add endian conversions to sysfs attribute
 show functions
Date: Wed, 10 Feb 2016 19:32:27 -0600
Message-Id: <1455154348-3226-7-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1455154348-3226-1-git-send-email-tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The values returned by the show functions for the host os_type,
mad_version, and partition_number attributes get their values
directly from the madapter_info struct whose associated fields are
__be32 typed. Added endian conversion to ensure these values are
sane on LE platforms.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index e8d4af5..6025481 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1983,7 +1983,7 @@ static ssize_t show_host_partition_number(struct device *dev,
 	int len;
 
 	len = snprintf(buf, PAGE_SIZE, "%d\n",
-		       hostdata->madapter_info.partition_number);
+		       be32_to_cpu(hostdata->madapter_info.partition_number));
 	return len;
 }
 
@@ -2003,7 +2003,7 @@ static ssize_t show_host_mad_version(struct device *dev,
 	int len;
 
 	len = snprintf(buf, PAGE_SIZE, "%d\n",
-		       hostdata->madapter_info.mad_version);
+		       be32_to_cpu(hostdata->madapter_info.mad_version));
 	return len;
 }
 
@@ -2022,7 +2022,8 @@ static ssize_t show_host_os_type(struct device *dev,
 	struct ibmvscsi_host_data *hostdata = shost_priv(shost);
 	int len;
 
-	len = snprintf(buf, PAGE_SIZE, "%d\n", hostdata->madapter_info.os_type);
+	len = snprintf(buf, PAGE_SIZE, "%d\n",
+		       be32_to_cpu(hostdata->madapter_info.os_type));
 	return len;
 }
 
-- 
2.5.0
