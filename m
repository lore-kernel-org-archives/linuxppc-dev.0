Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C2F51A0BFE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:25:17 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 10:25:16 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 413293578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 11:25:13 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u240P5gh10682872
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:25:13 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u240Oe9x022346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 11:24:41 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/eeh: Fix build error caused by pci_dn
Date: Fri,  4 Mar 2016 11:23:39 +1100
Message-Id: <1457051025-9718-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

eeh.h could be included when we have following condition. Then we
run into build error as below: (CONFIG_PPC64 && !CONFIG_EEH) ||
(!CONFIG_PPC64 && !CONFIG_EEH)

In file included from arch/powerpc/kernel/of_platform.c:30:0:
./arch/powerpc/include/asm/eeh.h:344:48: error: ‘struct pci_dn’ \
declared inside parameter list [-Werror]
    :
In file included from arch/powerpc/mm/hash_utils_64.c:49:0:
./arch/powerpc/include/asm/eeh.h:344:48: error: ‘struct pci_dn’ \
declared inside parameter list [-Werror]

This fixes the issue by replacing those empty inline functions
with macro so that we don't rely on @pci_dn when CONFIG_EEH is
disabled.

Fixes: ff57b45 ("powerpc/eeh: Do probe on pci_dn")
Cc: stable@vger.kernel.org # v4.1+
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index fb9f376..e9fee82 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -341,19 +341,13 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
 
 #define eeh_dev_check_failure(x) (0)
 
-static inline void eeh_addr_cache_build(void) { }
-
-static inline void eeh_add_device_early(struct pci_dn *pdn) { }
-
-static inline void eeh_add_device_tree_early(struct pci_dn *pdn) { }
-
-static inline void eeh_add_device_late(struct pci_dev *dev) { }
-
-static inline void eeh_add_device_tree_late(struct pci_bus *bus) { }
-
-static inline void eeh_add_sysfs_files(struct pci_bus *bus) { }
-
-static inline void eeh_remove_device(struct pci_dev *dev) { }
+#define eeh_addr_cache_build()
+#define eeh_add_device_early(pdn)
+#define eeh_add_device_tree_early(pdn)
+#define eeh_add_device_late(pdev)
+#define eeh_add_device_tree_late(pbus)
+#define eeh_add_sysfs_files(pbus)
+#define eeh_remove_device(pdev)
 
 #define EEH_POSSIBLE_ERROR(val, type) (0)
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
-- 
2.1.0
