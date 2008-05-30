Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 30 May 2008 13:39:12 +1000
Subject: [PATCH] [POWERPC] Fix rpadlpar pci hotplug driver sysfs usage
Message-Id: <20080530034134.E2D81DDEE1@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When Greg "fixed" the sysfs usage of that driver a while back, he seem
to have introduced a bug where the quotes are added around the name of
our specific sysfs files, thus breaking the user space tool.

This fixes it. Tested DLPAR operations on a POWER6 machine successfully.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/pci/hotplug/rpadlpar_sysfs.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-work.orig/drivers/pci/hotplug/rpadlpar_sysfs.c	2008-05-30 13:21:06.000000000 +1000
+++ linux-work/drivers/pci/hotplug/rpadlpar_sysfs.c	2008-05-30 13:21:58.000000000 +1000
@@ -18,8 +18,12 @@
 #include "rpadlpar.h"
 
 #define DLPAR_KOBJ_NAME       "control"
-#define ADD_SLOT_ATTR_NAME    "add_slot"
-#define REMOVE_SLOT_ATTR_NAME "remove_slot"
+
+/* Those two have no quotes because they are passed to __ATTR() which
+ * stringifies the argument (yuck !)
+ */
+#define ADD_SLOT_ATTR_NAME    add_slot
+#define REMOVE_SLOT_ATTR_NAME remove_slot
 
 #define MAX_DRC_NAME_LEN 64
 
