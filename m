Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCBD51A0FE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:29:20 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 16:29:19 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 621DD3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 16:29:16 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13NTGFa22675466
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:16 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13NTFHl029932
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:16 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 6/6] ibmvscsi: Add endian conversions to sysfs attribute show
 functions
Date: Wed,  3 Feb 2016 17:28:34 -0600
Message-Id: <1454542114-1797-7-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1454542114-1797-1-git-send-email-tyreld@linux.vnet.ibm.com>
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
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index a2b8db1..3621ac5 100644
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
