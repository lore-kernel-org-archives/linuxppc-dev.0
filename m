Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4804D1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 12:32:43 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 10 Feb 2016 18:32:41 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 085BE3E40047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 18:32:38 -0700 (MST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1B1Wc8A21430296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 01:32:38 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1B1TLo0003673
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 20:29:21 -0500
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: james.bottomley@hansenpartnership.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com,
 jthumshirn@suse.de, manoj@linux.vnet.ibm.com,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH v2 3/7] ibmvscsi: Replace magic values in set_adpater_info()
 with defines
Date: Wed, 10 Feb 2016 19:32:24 -0600
Message-Id: <1455154348-3226-4-git-send-email-tyreld@linux.vnet.ibm.com>
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

Add defines for mad version and mad os_type, and replace the magic
numbers in set_adapter_info() accordingly.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 8 ++++----
 drivers/scsi/ibmvscsi/viosrp.h   | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index c888ea1..4b09a9b 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -283,8 +283,8 @@ static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
 	hostdata->madapter_info.partition_number =
 					cpu_to_be32(partition_number);
 
-	hostdata->madapter_info.mad_version = cpu_to_be32(1);
-	hostdata->madapter_info.os_type = cpu_to_be32(2);
+	hostdata->madapter_info.mad_version = cpu_to_be32(SRP_MAD_VERSION_1);
+	hostdata->madapter_info.os_type = cpu_to_be32(SRP_MAD_OS_LINUX);
 }
 
 /**
@@ -1398,7 +1398,7 @@ static void adapter_info_rsp(struct srp_event_struct *evt_struct)
 			hostdata->host->max_sectors = 
 				be32_to_cpu(hostdata->madapter_info.port_max_txu[0]) >> 9;
 		
-		if (be32_to_cpu(hostdata->madapter_info.os_type) == 3 &&
+		if (be32_to_cpu(hostdata->madapter_info.os_type) == SRP_MAD_OS_AIX &&
 		    strcmp(hostdata->madapter_info.srp_version, "1.6a") <= 0) {
 			dev_err(hostdata->dev, "host (Ver. %s) doesn't support large transfers\n",
 				hostdata->madapter_info.srp_version);
@@ -1407,7 +1407,7 @@ static void adapter_info_rsp(struct srp_event_struct *evt_struct)
 			hostdata->host->sg_tablesize = MAX_INDIRECT_BUFS;
 		}
 
-		if (be32_to_cpu(hostdata->madapter_info.os_type) == 3) {
+		if (be32_to_cpu(hostdata->madapter_info.os_type) == SRP_MAD_OS_AIX) {
 			enable_fast_fail(hostdata);
 			return;
 		}
diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
index 3d20851..d0f689b 100644
--- a/drivers/scsi/ibmvscsi/viosrp.h
+++ b/drivers/scsi/ibmvscsi/viosrp.h
@@ -221,7 +221,10 @@ struct mad_adapter_info_data {
 	char srp_version[8];
 	char partition_name[96];
 	__be32 partition_number;
+#define SRP_MAD_VERSION_1 1
 	__be32 mad_version;
+#define SRP_MAD_OS_LINUX 2
+#define SRP_MAD_OS_AIX 3
 	__be32 os_type;
 	__be32 port_max_txu[8];	/* per-port maximum transfer */
 };
-- 
2.5.0
