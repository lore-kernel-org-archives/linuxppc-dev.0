Return-Path: <toshi.kani@hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C21272C0432
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:00:58 +1100 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org
Subject: [RFC PATCH v2 06/12] ACPI: Add ACPI bus hotplug handlers
Date: Thu, 10 Jan 2013 16:40:24 -0700
Message-Id: <1357861230-29549-7-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-mm@kvack.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added ACPI bus hotplug handlers.  acpi_add_execute() calls
acpi_bus_add() to construct new acpi_device objects for hot-add
operation, and acpi_del_execute() calls acpi_bus_trim() to destruct
them for hot-delete operation.  They are also used for rollback
as well.

acpi_del_commit() calls _EJ0 to eject a target object for hot-delete.

acpi_validate_ost() calls _OST to inform FW that a hot-plug operation
completed with error in case of rollback.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/bus.c |  133 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 1f0d457..31a1911 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -42,6 +42,7 @@
 #include <acpi/apei.h>
 #include <linux/dmi.h>
 #include <linux/suspend.h>
+#include <acpi/sys_hotplug.h>
 
 #include "internal.h"
 
@@ -52,6 +53,9 @@ struct acpi_device *acpi_root;
 struct proc_dir_entry *acpi_root_dir;
 EXPORT_SYMBOL(acpi_root_dir);
 
+static int acpi_add_execute(struct shp_request *req, int rollback);
+static int acpi_del_execute(struct shp_request *req, int rollback);
+
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
 
@@ -859,6 +863,134 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 }
 
 /* --------------------------------------------------------------------------
+			Hot-plug Handling
+   -------------------------------------------------------------------------- */
+
+static int acpi_validate_ost(struct shp_request *req, int rollback)
+{
+	/* If hotplug request failed, inform firmware with error */
+	if (rollback && shp_is_hotplug_op(req->operation))
+		(void) acpi_evaluate_hotplug_ost(req->handle, req->event,
+				ACPI_OST_SC_NON_SPECIFIC_FAILURE, NULL);
+
+	return 0;
+}
+
+static int acpi_add_execute(struct shp_request *req, int rollback)
+{
+	acpi_handle handle = (acpi_handle) req->handle;
+	acpi_handle phandle;
+	struct acpi_device *device = NULL;
+	struct acpi_device *pdev;
+	int ret;
+
+	if (rollback)
+		return acpi_del_execute(req, 0);
+
+	/* only handle hot-plug operation */
+	if (!shp_is_hotplug_op(req->operation))
+		return 0;
+
+	if (acpi_get_parent(handle, &phandle))
+		return -ENODEV;
+
+	if (acpi_bus_get_device(phandle, &pdev))
+		return -ENODEV;
+
+	ret = acpi_bus_add(&device, pdev, handle, ACPI_BUS_TYPE_DEVICE);
+
+	return ret;
+}
+
+static int acpi_add_commit(struct shp_request *req, int rollback)
+{
+	/* Inform firmware that the hotplug operation has completed */
+	(void) acpi_evaluate_hotplug_ost(req->handle, req->event,
+					ACPI_OST_SC_SUCCESS, NULL);
+
+	return 0;
+}
+
+static int acpi_del_execute(struct shp_request *req, int rollback)
+{
+	acpi_handle handle = (acpi_handle) req->handle;
+	struct acpi_device *device;
+
+	if (rollback)
+		return acpi_add_execute(req, 0);
+
+	/* only handle hot-plug operation */
+	if (!shp_is_hotplug_op(req->operation))
+		return 0;
+
+	if (acpi_bus_get_device(handle, &device)) {
+		acpi_handle_err(handle, "Failed to obtain device\n");
+		return -EINVAL;
+	}
+
+	if (acpi_bus_trim(device, 1)) {
+		dev_err(&device->dev, "Removing device failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int acpi_del_commit(struct shp_request *req, int rollback)
+{
+	acpi_handle handle = (acpi_handle) req->handle;
+	acpi_handle temp;
+	struct acpi_object_list arg_list;
+	union acpi_object arg;
+	acpi_status status;
+
+	/* only handle hot-plug operation */
+	if (!shp_is_hotplug_op(req->operation))
+		return 0;
+
+	/* power off device */
+	status = acpi_evaluate_object(handle, "_PS3", NULL, NULL);
+	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND)
+		acpi_handle_warn(handle, "Power-off device failed\n");
+
+	if (ACPI_SUCCESS(acpi_get_handle(handle, "_LCK", &temp))) {
+		arg_list.count = 1;
+		arg_list.pointer = &arg;
+		arg.type = ACPI_TYPE_INTEGER;
+		arg.integer.value = 0;
+		acpi_evaluate_object(handle, "_LCK", &arg_list, NULL);
+	}
+
+	arg_list.count = 1;
+	arg_list.pointer = &arg;
+	arg.type = ACPI_TYPE_INTEGER;
+	arg.integer.value = 1;
+
+	status = acpi_evaluate_object(handle, "_EJ0", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND))
+			acpi_handle_warn(handle, "Eject device failed\n");
+
+	return 0;
+}
+
+static void __init acpi_shp_init(void)
+{
+	shp_register_handler(SHP_ADD_VALIDATE, acpi_validate_ost,
+				SHP_ACPI_BUS_ADD_VALIDATE_ORDER);
+	shp_register_handler(SHP_ADD_EXECUTE, acpi_add_execute,
+				SHP_ACPI_BUS_ADD_EXECUTE_ORDER);
+	shp_register_handler(SHP_ADD_COMMIT, acpi_add_commit,
+				SHP_ACPI_BUS_ADD_COMMIT_ORDER);
+
+	shp_register_handler(SHP_DEL_VALIDATE, acpi_validate_ost,
+				SHP_ACPI_BUS_DEL_VALIDATE_ORDER);
+	shp_register_handler(SHP_DEL_EXECUTE, acpi_del_execute,
+				SHP_ACPI_BUS_DEL_EXECUTE_ORDER);
+	shp_register_handler(SHP_DEL_COMMIT, acpi_del_commit,
+				SHP_ACPI_BUS_DEL_COMMIT_ORDER);
+}
+
+/* --------------------------------------------------------------------------
                              Initialization/Cleanup
    -------------------------------------------------------------------------- */
 
@@ -1103,6 +1235,7 @@ static int __init acpi_init(void)
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
 	acpi_wakeup_device_init();
+	acpi_shp_init();
 	return 0;
 }
 
