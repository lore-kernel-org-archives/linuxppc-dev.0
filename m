Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zhXqY6Z3RzF1Fp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 08:39:37 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1ELd4U9131401
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:39:36 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g4r9r42at-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:39:35 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Wed, 14 Feb 2018 16:39:34 -0500
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH] DEBUG: shortcut mobility fixup/migration store,
 and abuse no_rfi_flush
Date: Wed, 14 Feb 2018 19:39:25 -0200
In-Reply-To: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
References: <1518644021-17037-1-git-send-email-mauricfo@linux.vnet.ibm.com>
Message-Id: <1518644365-17584-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/setup_64.c            | 8 ++++++++
 arch/powerpc/platforms/pseries/mobility.c | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index d692f71..a05b9f4 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -892,6 +892,9 @@ static bool init_fallback_flush(void)
 
 void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 {
+	if (no_rfi_flush)
+		types = L1D_FLUSH_NONE;
+
 	if (types & L1D_FLUSH_FALLBACK) {
 		if (init_fallback_flush())
 			pr_info("rfi-flush: Using fallback displacement flush\n");
@@ -911,6 +914,11 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
 
 	if (!no_rfi_flush)
 		rfi_flush_enable(enable);
+
+	if (no_rfi_flush) {
+		pr_info("rfi-flush: re-enabled\n");
+		no_rfi_flush = 0;
+	}
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 8a8033a..201710e 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -326,6 +326,7 @@ int pseries_devicetree_update(s32 scope)
 
 void post_mobility_fixup(void)
 {
+#if 0
 	int rc;
 	int activate_fw_token;
 
@@ -347,6 +348,7 @@ void post_mobility_fixup(void)
 	if (rc)
 		printk(KERN_ERR "Post-mobility device tree update "
 			"failed: %d\n", rc);
+#endif
 
 	/* Possibly switch to a new RFI flush type */
 	pseries_setup_rfi_flush();
@@ -358,6 +360,7 @@ static ssize_t migration_store(struct class *class,
 			       struct class_attribute *attr, const char *buf,
 			       size_t count)
 {
+#if 0
 	u64 streamid;
 	int rc;
 
@@ -373,6 +376,7 @@ static ssize_t migration_store(struct class *class,
 
 	if (rc)
 		return rc;
+#endif
 
 	post_mobility_fixup();
 	return count;
-- 
2.7.4
