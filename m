Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 291F12C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2014 07:06:12 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Wed, 22 Jan 2014 13:06:10 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3FFD43E40055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 13:06:09 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0MK5t4Z6094870
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 21:05:55 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0MK68OQ013280
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 13:06:08 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc/pseries: Device tree should only be updated
 once after suspend/migrate
Date: Wed, 22 Jan 2014 14:58:35 -0500
Message-Id: <1390420717-23907-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1390420717-23907-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Haren Myneni <hbabu@us.ibm.com>

From: Haren Myneni <hbabu@us.ibm.com>

The current code makes rtas calls for update-nodes, activate-firmware and then
update-nodes again. The FW provides the same data for both update-nodes calls.
As a result a proc entry exists error is reported for the second update while
adding device nodes.

This patch makes a single rtas call for update-nodes after activating the FW.
It also add rtas_busy delay for the activate-firmware rtas call.

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index cde4e0a..bde7eba 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -290,13 +290,6 @@ void post_mobility_fixup(void)
 	int rc;
 	int activate_fw_token;
 
-	rc = pseries_devicetree_update(MIGRATION_SCOPE);
-	if (rc) {
-		printk(KERN_ERR "Initial post-mobility device tree update "
-		       "failed: %d\n", rc);
-		return;
-	}
-
 	activate_fw_token = rtas_token("ibm,activate-firmware");
 	if (activate_fw_token == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_ERR "Could not make post-mobility "
@@ -304,16 +297,17 @@ void post_mobility_fixup(void)
 		return;
 	}
 
-	rc = rtas_call(activate_fw_token, 0, 1, NULL);
-	if (!rc) {
-		rc = pseries_devicetree_update(MIGRATION_SCOPE);
-		if (rc)
-			printk(KERN_ERR "Secondary post-mobility device tree "
-			       "update failed: %d\n", rc);
-	} else {
+	do {
+		rc = rtas_call(activate_fw_token, 0, 1, NULL);
+	} while (rtas_busy_delay(rc));
+
+	if (rc)
 		printk(KERN_ERR "Post-mobility activate-fw failed: %d\n", rc);
-		return;
-	}
+
+	rc = pseries_devicetree_update(MIGRATION_SCOPE);
+	if (rc)
+		printk(KERN_ERR "Post-mobility device tree update "
+			"failed: %d\n", rc);
 
 	return;
 }
-- 
1.7.12.4
