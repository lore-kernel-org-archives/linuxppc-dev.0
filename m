Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 613542C0098
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 18:44:38 +1000 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 8 Sep 2012 04:44:35 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AC5736E8041
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2012 04:44:32 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q888iWVF142372
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 04:44:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q888iVeg002491
 for <linuxppc-dev@ozlabs.org>; Sat, 8 Sep 2012 05:44:32 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/22] ppc/eeh: introduce global mutex
Date: Sat,  8 Sep 2012 16:44:06 +0800
Message-Id: <1347093863-6319-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1347093863-6319-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 2 files changed, 18 insertions(+), 0 deletions(-)

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
1.7.5.4
