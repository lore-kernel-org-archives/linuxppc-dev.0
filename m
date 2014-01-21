Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3365D2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jan 2014 10:02:56 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 21 Jan 2014 16:02:53 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 3C14019D8042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:42 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0LL0QwF4260340
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 22:00:26 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0LN2opk012232
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 16:02:51 -0700
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/pseries: Device tree should only be updated once
 after suspend/migrate
Date: Tue, 21 Jan 2014 17:55:47 -0500
Message-Id: <1390344949-3983-2-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1390344949-3983-1-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1390344949-3983-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
