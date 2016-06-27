Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRYW0NzWzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:29:50 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/38] dt: Add of_device_compatible_match()
Date: Mon, 27 Jun 2016 21:28:59 +1000
Message-Id: <1467026976-7974-2-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This provides an equivalent of of_fdt_match() for non-flat trees.

This is more practical than matching an array of of_device_id structs
when converting a bunch of existing users of of_fdt_match().

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ebf84e3..429c594 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -493,6 +493,28 @@ int of_device_is_compatible(const struct device_node *device,
 }
 EXPORT_SYMBOL(of_device_is_compatible);
 
+/** Checks if the device is compatible with any of the entries in
+ *  a NULL terminated array of strings. Returns the best match
+ *  score or 0.
+ */
+int of_device_compatible_match(struct device_node *device,
+			       const char *const *compat)
+{
+	unsigned int tmp, score = 0;
+
+	if (!compat)
+		return 0;
+
+	while (*compat) {
+		tmp = of_device_is_compatible(device, *compat);
+		if (tmp && (score == 0 || (tmp < score)))
+			score = tmp;
+		compat++;
+	}
+
+	return score;
+}
+
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
diff --git a/include/linux/of.h b/include/linux/of.h
index 74eb28c..33c184d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -324,6 +324,8 @@ extern int of_property_read_string_helper(const struct device_node *np,
 					      const char **out_strs, size_t sz, int index);
 extern int of_device_is_compatible(const struct device_node *device,
 				   const char *);
+extern int of_device_compatible_match(struct device_node *device,
+				      const char *const *compat);
 extern bool of_device_is_available(const struct device_node *device);
 extern bool of_device_is_big_endian(const struct device_node *device);
 extern const void *of_get_property(const struct device_node *node,
-- 
2.7.4
