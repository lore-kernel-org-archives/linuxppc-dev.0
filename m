Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 225C21A0C3C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 10:29:19 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 3 Feb 2016 16:29:18 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 50A3319D804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 16:17:14 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13NTF9n25428014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:15 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13NTEIu029871
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Feb 2016 16:29:14 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: JBottomley@odin.com
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, hare@suse.de,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: [PATCH 4/6] ibmvscsi: Use of_root to access OF device tree root node
Date: Wed,  3 Feb 2016 17:28:32 -0600
Message-Id: <1454542114-1797-5-git-send-email-tyreld@linux.vnet.ibm.com>
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

The root node of the OF device tree is exported as of_root. No need
to look up the root by path name. Instead just get a reference
directly via of_root.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 7e51615..47cfe33 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -248,25 +248,23 @@ static void ibmvscsi_task(void *data)
 
 static void gather_partition_info(void)
 {
-	struct device_node *rootdn;
-
 	const char *ppartition_name;
 	const __be32 *p_number_ptr;
 
 	/* Retrieve information about this partition */
-	rootdn = of_find_node_by_path("/");
-	if (!rootdn) {
+	if (!of_root)
 		return;
-	}
 
-	ppartition_name = of_get_property(rootdn, "ibm,partition-name", NULL);
+	of_node_get(of_root);
+
+	ppartition_name = of_get_property(of_root, "ibm,partition-name", NULL);
 	if (ppartition_name)
 		strncpy(partition_name, ppartition_name,
 				sizeof(partition_name));
-	p_number_ptr = of_get_property(rootdn, "ibm,partition-no", NULL);
+	p_number_ptr = of_get_property(of_root, "ibm,partition-no", NULL);
 	if (p_number_ptr)
 		partition_number = of_read_number(p_number_ptr, 1);
-	of_node_put(rootdn);
+	of_node_put(of_root);
 }
 
 static void set_adapter_info(struct ibmvscsi_host_data *hostdata)
-- 
2.5.0
