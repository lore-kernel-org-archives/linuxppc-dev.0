Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 20D351A0FAF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:29:17 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 16:29:16 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DCF2419D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 16:17:13 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13NTEoJ25100464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:14 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13NTEkK029816
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:14 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 3/6] ibmvscsi: Replace magic values in set_adpater_info() with
 defines
Date: Wed,  3 Feb 2016 17:28:31 -0600
Message-Id: <1454542114-1797-4-git-send-email-tyreld@linux.vnet.ibm.com>
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

Add defines for mad version and mad os_type, and replace the magic
numbers in set_adapter_info() accordingly.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 4 ++--
 drivers/scsi/ibmvscsi/viosrp.h   | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 176260d..7e51615 100644
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
diff --git a/drivers/scsi/ibmvscsi/viosrp.h b/drivers/scsi/ibmvscsi/viosrp.h
index 17f2de0..da9bb29 100644
--- a/drivers/scsi/ibmvscsi/viosrp.h
+++ b/drivers/scsi/ibmvscsi/viosrp.h
@@ -38,6 +38,8 @@
 #define SRP_VERSION "16.a"
 #define SRP_MAX_IU_LEN	256
 #define SRP_MAX_LOC_LEN 32
+#define SRP_MAD_VERSION_1 1
+#define SRP_MAD_OS_LINUX 2
 
 union srp_iu {
 	struct srp_login_req login_req;
-- 
2.5.0
