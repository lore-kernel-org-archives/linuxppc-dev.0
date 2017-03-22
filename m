Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwfp6vD6zDr45
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:49:38 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhairgrove@nvidia.com, shailendras@nvidia.com,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH 1/3] drivers/of/base.c: Add of_property_read_u64_index
Date: Wed, 22 Mar 2017 14:49:31 +1100
Message-Id: <1490154573-22475-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is of_property_read_u32_index but no u64 variant. This patch
adds one similar to the u32 version for u64.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 drivers/of/base.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/of.h |  3 +++
 2 files changed, 34 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d7c4629..0ea16bd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1213,6 +1213,37 @@ int of_property_read_u32_index(const struct device_node *np,
 EXPORT_SYMBOL_GPL(of_property_read_u32_index);
 
 /**
+ * of_property_read_u64_index - Find and read a u64 from a multi-value property.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u64 in the list of values
+ * @out_value:	pointer to return value, modified only if no error.
+ *
+ * Search for a property in a device node and read nth 64-bit value from
+ * it. Returns 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough.
+ *
+ * The out_value is modified only if a valid u64 value can be decoded.
+ */
+int of_property_read_u64_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u64 *out_value)
+{
+	const u64 *val = of_find_property_value_of_size(np, propname,
+					((index + 1) * sizeof(*out_value)),
+					0, NULL);
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	*out_value = be64_to_cpup(((__be64 *)val) + index);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_property_read_u64_index);
+
+/**
  * of_property_read_variable_u8_array - Find and read an array of u8 from a
  * property, with bounds on the minimum and maximum array size.
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 21e6323..d08788d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -292,6 +292,9 @@ extern int of_property_count_elems_of_size(const struct device_node *np,
 extern int of_property_read_u32_index(const struct device_node *np,
 				       const char *propname,
 				       u32 index, u32 *out_value);
+extern int of_property_read_u64_index(const struct device_node *np,
+				       const char *propname,
+				       u32 index, u64 *out_value);
 extern int of_property_read_variable_u8_array(const struct device_node *np,
 					const char *propname, u8 *out_values,
 					size_t sz_min, size_t sz_max);
-- 
2.1.4
