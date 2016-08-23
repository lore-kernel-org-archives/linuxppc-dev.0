Return-Path: <haokexin@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJDNF4SKlzDrcT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 12:07:25 +1000 (AEST)
Received: by mail-yw0-x243.google.com with SMTP id r9so4420971ywg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 19:07:25 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	devicetree@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] of/platform: introduce a generic way to declare a
 platform bus
Date: Tue, 23 Aug 2016 10:06:57 +0800
Message-Id: <1471918019-19472-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
References: <1471918019-19472-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The specific buses which need to be probed at boot time are different
between platforms. Instead of put all the buses into the default
of_default_bus_match_table[] match tables, this patch introduces a
general way to declare a platform bus.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/of/platform.c             | 12 +++++++++++-
 include/asm-generic/vmlinux.lds.h |  2 ++
 include/linux/of.h                | 22 ++++++++++++++++++++++
 include/linux/of_platform.h       |  5 +++++
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 6aaa1438c9cd..a7bfe8504caa 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -488,11 +488,21 @@ int of_platform_populate(struct device_node *root,
 }
 EXPORT_SYMBOL_GPL(of_platform_populate);
 
+static const struct of_device_id __bus_of_table_sentinel
+	__used __section(__bus_of_table_end);
+
 int of_platform_default_populate(struct device_node *root,
 				 const struct of_dev_auxdata *lookup,
 				 struct device *parent)
 {
-	return of_platform_populate(root, of_default_bus_match_table, lookup,
+	const struct of_device_id *matches;
+
+	if (__bus_of_table != &__bus_of_table_sentinel)
+		matches = __bus_of_table;
+	else
+		matches = of_default_bus_match_table;
+
+	return of_platform_populate(root, matches, lookup,
 				    parent);
 }
 EXPORT_SYMBOL_GPL(of_platform_default_populate);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 24563970ff7b..43aa725e86fa 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -179,6 +179,7 @@
 #define RESERVEDMEM_OF_TABLES()	OF_TABLE(CONFIG_OF_RESERVED_MEM, reservedmem)
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
+#define BUS_OF_TABLES()		OF_TABLE(CONFIG_OF, bus)
 
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
@@ -542,6 +543,7 @@
 	IOMMU_OF_TABLES()						\
 	CPU_METHOD_OF_TABLES()						\
 	CPUIDLE_METHOD_OF_TABLES()					\
+	BUS_OF_TABLES()							\
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
diff --git a/include/linux/of.h b/include/linux/of.h
index 3d9ff8e9d803..3a53c898cde9 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1002,12 +1002,28 @@ static inline int of_get_available_child_count(const struct device_node *np)
 		__used __section(__##table##_of_table)			\
 		 = { .compatible = compat,				\
 		     .data = (fn == (fn_type)NULL) ? fn : fn  }
+
+#define __OF_DECLARE_ALL(table, entry, _name, _type, _compat, _data)	\
+	static const struct of_device_id __of_table_##entry		\
+		__used __section(__##table##_of_table)			\
+		= { .name = _name,					\
+		    .type = _type,					\
+		    .compatible = _compat,				\
+		    .data = _data }
 #else
 #define _OF_DECLARE(table, name, compat, fn, fn_type)			\
 	static const struct of_device_id __of_table_##name		\
 		__attribute__((unused))					\
 		 = { .compatible = compat,				\
 		     .data = (fn == (fn_type)NULL) ? fn : fn }
+
+#define __OF_DECLARE_ALL(table, entry, _name, _type, _compat, _data)	\
+	static const struct of_device_id __of_table_##_name		\
+		__attribute__((unused))					\
+		= { .name = _name,					\
+		    .type = _type,					\
+		    .compatible = _compat,				\
+		    .data = _data }
 #endif
 
 typedef int (*of_init_fn_2)(struct device_node *, struct device_node *);
@@ -1020,6 +1036,12 @@ typedef void (*of_init_fn_1)(struct device_node *);
 		_OF_DECLARE(table, name, compat, fn, of_init_fn_1_ret)
 #define OF_DECLARE_2(table, name, compat, fn) \
 		_OF_DECLARE(table, name, compat, fn, of_init_fn_2)
+#define OF_DECLARE_COMPAT(table, name, compat) \
+		__OF_DECLARE_ALL(table, name, "", "", compat, NULL)
+#define OF_DECLARE_TYPE(table, name, type) \
+		__OF_DECLARE_ALL(table, name, "", type, "", NULL)
+#define OF_DECLARE_NAME(table, name, node_name) \
+		__OF_DECLARE_ALL(table, name, node_name, "", "", NULL)
 
 /**
  * struct of_changeset_entry	- Holds a changeset entry
diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 02cf1fdaa3d0..35c5b66f61f0 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -17,6 +17,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#define BUS_OF_DECLARE_COMPAT(name, compat) OF_DECLARE_COMPAT(bus, name, compat)
+#define BUS_OF_DECLARE_TYPE(name, type) OF_DECLARE_TYPE(bus, name, type)
+#define BUS_OF_DECLARE_NAME(name, node_name) OF_DECLARE_NAME(bus, name, node_name)
+
 /**
  * struct of_dev_auxdata - lookup table entry for device names & platform_data
  * @compatible: compatible value of node to match against node
@@ -52,6 +56,7 @@ struct of_dev_auxdata {
 	  .platform_data = _pdata }
 
 extern const struct of_device_id of_default_bus_match_table[];
+extern const struct of_device_id __bus_of_table[];
 
 /* Platform drivers register/unregister */
 extern struct platform_device *of_device_alloc(struct device_node *np,
-- 
2.5.5
