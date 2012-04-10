Return-Path: <key@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AF96EB70AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 01:08:43 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 09:08:37 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EB5ED3E40058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:30 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AF7GwI263318
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:22 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AF7iS8031003
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:44 -0600
Message-ID: <1334070500.16827.5.camel@key-ThinkPad-W510>
Subject: [PATCH v2 02/17] powerpc: Add pseries update notifier for OFDT prop
 changes
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2012 10:08:20 -0500
In-Reply-To: <1334070249.16827.1.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds an update notifier mechanism for changes to properties in the
device tree.  One use of this would be a device driver that needs to act
on changes to it's properties in the device tree after a live migration
or a dynamic activation that is triggered by updates to ofdt properties.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pSeries_reconfig.h |   12 ++++++++++++
 arch/powerpc/platforms/pseries/reconfig.c   |    7 +++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pSeries_reconfig.h b/arch/powerpc/include/asm/pSeries_reconfig.h
index 23cd6cc..c07edfe 100644
--- a/arch/powerpc/include/asm/pSeries_reconfig.h
+++ b/arch/powerpc/include/asm/pSeries_reconfig.h
@@ -13,6 +13,18 @@
 #define PSERIES_RECONFIG_REMOVE		0x0002
 #define PSERIES_DRCONF_MEM_ADD		0x0003
 #define PSERIES_DRCONF_MEM_REMOVE	0x0004
+#define PSERIES_UPDATE_PROPERTY		0x0005
+
+/**
+ * pSeries_reconfig_notify - Notifier value structure for OFDT property updates
+ *
+ * @node: Device tree node which owns the property being updated
+ * @property: Updated property
+ */
+struct pSeries_reconfig_prop_update {
+	struct device_node *node;
+	struct property *property;
+};
 
 #ifdef CONFIG_PPC_PSERIES
 extern int pSeries_reconfig_notifier_register(struct notifier_block *);
diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
index 168651a..7b3bf76 100644
--- a/arch/powerpc/platforms/pseries/reconfig.c
+++ b/arch/powerpc/platforms/pseries/reconfig.c
@@ -103,11 +103,13 @@ int pSeries_reconfig_notifier_register(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&pSeries_reconfig_chain, nb);
 }
+EXPORT_SYMBOL_GPL(pSeries_reconfig_notifier_register);
 
 void pSeries_reconfig_notifier_unregister(struct notifier_block *nb)
 {
 	blocking_notifier_chain_unregister(&pSeries_reconfig_chain, nb);
 }
+EXPORT_SYMBOL_GPL(pSeries_reconfig_notifier_unregister);
 
 int pSeries_reconfig_notify(unsigned long action, void *p)
 {
@@ -426,6 +428,7 @@ static int do_remove_property(char *buf, size_t bufsize)
 static int do_update_property(char *buf, size_t bufsize)
 {
 	struct device_node *np;
+	struct pSeries_reconfig_prop_update upd_value;
 	unsigned char *value;
 	char *name, *end, *next_prop;
 	int rc, length;
@@ -454,6 +457,10 @@ static int do_update_property(char *buf, size_t bufsize)
 		return -ENODEV;
 	}
 
+	upd_value.node = np;
+	upd_value.property = newprop;
+	pSeries_reconfig_notify(PSERIES_UPDATE_PROPERTY, &upd_value);
+
 	rc = prom_update_property(np, newprop, oldprop);
 	if (rc)
 		return rc;
-- 
1.7.1
