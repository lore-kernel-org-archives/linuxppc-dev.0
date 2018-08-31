Return-Path: <ran.wang_1@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421m044703zF37x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Aug 2018 14:02:12 +1000 (AEST)
From: Ran Wang <ran.wang_1@nxp.com>
To: Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Date: Fri, 31 Aug 2018 11:52:17 +0800
Message-Id: <20180831035219.31619-1-ran.wang_1@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This driver is to provide a independent framework for PM service
provider and consumer to configure system level wake up feature. For
example, RCPM driver could register a callback function on this
platform first, and Flex timer driver who want to enable timer wake
up feature, will call generic API provided by this platform driver,
and then it will trigger RCPM driver to do it. The benefit is to
isolate the user and service, such as flex timer driver will not have
to know the implement details of wakeup function it require. Besides,
it is also easy for service side to upgrade its logic when design is
changed and remain user side unchanged.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/soc/fsl/Kconfig   |   14 +++++
 drivers/soc/fsl/Makefile  |    1 +
 drivers/soc/fsl/plat_pm.c |  144 +++++++++++++++++++++++++++++++++++++++++++++
 include/soc/fsl/plat_pm.h |   22 +++++++
 4 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 drivers/soc/fsl/plat_pm.c
 create mode 100644 include/soc/fsl/plat_pm.h

diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
index 7a9fb9b..6517412 100644
--- a/drivers/soc/fsl/Kconfig
+++ b/drivers/soc/fsl/Kconfig
@@ -16,3 +16,17 @@ config FSL_GUTS
 	  Initially only reading SVR and registering soc device are supported.
 	  Other guts accesses, such as reading RCW, should eventually be moved
 	  into this driver as well.
+
+config FSL_PLAT_PM
+	bool "Freescale platform PM framework"
+	help
+	  This driver is to provide a independent framework for PM service
+	  provider and consumer to configure system level wake up feature. For
+	  example, RCPM driver could register a callback function on this
+	  platform first, and Flex timer driver who want to enable timer wake
+	  up feature, will call generic API provided by this platform driver,
+	  and then it will trigger RCPM driver to do it. The benefit is to
+	  isolate the user and service, such as  flex timer driver will not
+	  have to know the implement details of wakeup function it require.
+	  Besides, it is also easy for service side to upgrade its logic when
+	  design changed and remain user side unchanged.
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
index 44b3beb..8f9db23 100644
--- a/drivers/soc/fsl/Makefile
+++ b/drivers/soc/fsl/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 += qbman/
 obj-$(CONFIG_QUICC_ENGINE)		+= qe/
 obj-$(CONFIG_CPM)			+= qe/
 obj-$(CONFIG_FSL_GUTS)			+= guts.o
+obj-$(CONFIG_FSL_PLAT_PM)	+= plat_pm.o
diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c
new file mode 100644
index 0000000..19ea14e
--- /dev/null
+++ b/drivers/soc/fsl/plat_pm.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// plat_pm.c - Freescale platform PM framework
+//
+// Copyright 2018 NXP
+//
+// Author: Ran Wang <ran.wang_1@nxp.com>,
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <soc/fsl/plat_pm.h>
+
+
+struct plat_pm_t {
+	struct list_head node;
+	fsl_plat_pm_handle handle;
+	void *handle_priv;
+	spinlock_t	lock;
+};
+
+static struct plat_pm_t plat_pm;
+
+// register_fsl_platform_wakeup_source - Register callback function to plat_pm
+// @handle: Pointer to handle PM feature requirement
+// @handle_priv: Handler specific data struct
+//
+// Return 0 on success other negative errno
+int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
+		void *handle_priv)
+{
+	struct plat_pm_t *p;
+	unsigned long	flags;
+
+	if (!handle) {
+		pr_err("FSL plat_pm: Handler invalid, reject\n");
+		return -EINVAL;
+	}
+
+	p = kmalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	p->handle = handle;
+	p->handle_priv = handle_priv;
+
+	spin_lock_irqsave(&plat_pm.lock, flags);
+	list_add_tail(&p->node, &plat_pm.node);
+	spin_unlock_irqrestore(&plat_pm.lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);
+
+// Deregister_fsl_platform_wakeup_source - deregister callback function
+// @handle_priv: Handler specific data struct
+//
+// Return 0 on success other negative errno
+int deregister_fsl_platform_wakeup_source(void *handle_priv)
+{
+	struct plat_pm_t *p, *tmp;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&plat_pm.lock, flags);
+	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {
+		if (p->handle_priv == handle_priv) {
+			list_del(&p->node);
+			kfree(p);
+		}
+	}
+	spin_unlock_irqrestore(&plat_pm.lock, flags);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);
+
+// fsl_platform_wakeup_config - Configure wakeup source by calling handlers
+// @dev: pointer to user's device struct
+// @flag: to tell enable or disable wakeup source
+//
+// Return 0 on success other negative errno
+int fsl_platform_wakeup_config(struct device *dev, bool flag)
+{
+	struct plat_pm_t *p;
+	int ret;
+	bool success_handled;
+	unsigned long	flags;
+
+	success_handled = false;
+
+	// Will consider success if at least one callback return 0.
+	// Also, rest handles still get oppertunity to be executed
+	spin_lock_irqsave(&plat_pm.lock, flags);
+	list_for_each_entry(p, &plat_pm.node, node) {
+		if (p->handle) {
+			ret = p->handle(dev, flag, p->handle_priv);
+			if (!ret)
+				success_handled = true;
+			else if (ret != -ENODEV) {
+				pr_err("FSL plat_pm: Failed to config wakeup source:%d\n", ret);
+				return ret;
+			}
+		} else
+			pr_warn("FSL plat_pm: Invalid handler detected, skip\n");
+	}
+	spin_unlock_irqrestore(&plat_pm.lock, flags);
+
+	if (success_handled == false) {
+		pr_err("FSL plat_pm: Cannot find the matchhed handler for wakeup source config\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+// fsl_platform_wakeup_enable - Enable wakeup source
+// @dev: pointer to user's device struct
+//
+// Return 0 on success other negative errno
+int fsl_platform_wakeup_enable(struct device *dev)
+{
+	return fsl_platform_wakeup_config(dev, true);
+}
+EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);
+
+// fsl_platform_wakeup_disable - Disable wakeup source
+// @dev: pointer to user's device struct
+//
+// Return 0 on success other negative errno
+int fsl_platform_wakeup_disable(struct device *dev)
+{
+	return fsl_platform_wakeup_config(dev, false);
+}
+EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);
+
+static int __init fsl_plat_pm_init(void)
+{
+	spin_lock_init(&plat_pm.lock);
+	INIT_LIST_HEAD(&plat_pm.node);
+	return 0;
+}
+
+core_initcall(fsl_plat_pm_init);
diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h
new file mode 100644
index 0000000..bbe151e
--- /dev/null
+++ b/include/soc/fsl/plat_pm.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// plat_pm.h - Freescale platform PM Header
+//
+// Copyright 2018 NXP
+//
+// Author: Ran Wang <ran.wang_1@nxp.com>,
+
+#ifndef __FSL_PLAT_PM_H
+#define __FSL_PLAT_PM_H
+
+typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,
+		void *handle_priv);
+
+int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
+		void *handle_priv);
+int deregister_fsl_platform_wakeup_source(void *handle_priv);
+int fsl_platform_wakeup_config(struct device *dev, bool flag);
+int fsl_platform_wakeup_enable(struct device *dev);
+int fsl_platform_wakeup_disable(struct device *dev);
+
+#endif	// __FSL_PLAT_PM_H
-- 
1.7.1
