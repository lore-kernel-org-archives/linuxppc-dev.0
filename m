Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D5C80B7003
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:54:16 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 10:54:14 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0F5E219D8730
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:02:13 +0000 (WET)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG27Ku082000
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:08 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG21NM023273
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:04 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/21] ppc/eeh: introduce global mutex
Date: Thu, 28 Jun 2012 00:01:35 +0800
Message-Id: <1340812911-6793-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces global mutex for EEH so that the core data
structures can be protected by that. Also, 2 inline functions
are exported for that: eeh_lock() and eeh_unlock().

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |   15 +++++++++++++++
 arch/powerpc/platforms/pseries/eeh.c |    3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index f77b6d7..248b3d9 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -146,6 +146,17 @@ struct eeh_ops {
 
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
+extern struct mutex eeh_mutex;
+
+static inline void eeh_lock(void)
+{
+	mutex_lock(&eeh_mutex);
+}
+
+static inline void eeh_unlock(void)
+{
+	mutex_unlock(&eeh_mutex);
+}
 
 /*
  * Max number of EEH freezes allowed before we consider the device
@@ -206,6 +217,10 @@ static inline void eeh_add_device_tree_early(struct device_node *dn) { }
 static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
 
 static inline void eeh_remove_bus_device(struct pci_dev *dev) { }
+
+static inline void eeh_lock(void) { }
+static inline void eeh_unlock(void) { }
+
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index e819448..0ba7e3b 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -92,6 +92,9 @@ struct eeh_ops *eeh_ops = NULL;
 int eeh_subsystem_enabled;
 EXPORT_SYMBOL(eeh_subsystem_enabled);
 
+/* Global EEH mutex */
+DEFINE_MUTEX(eeh_mutex);
+
 /* Lock to avoid races due to multiple reports of an error */
 static DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
-- 
1.7.9.5
