Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 079B61A0494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:48 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Tue, 16 Sep 2014 10:25:48 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 608F93578048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8G01li16029356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:01:47 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8G0PieH007526
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:25:45 +1000
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/pseries: fix bugs in RTAS mobility code
Date: Tue, 16 Sep 2014 10:25:28 +1000
Message-Id: <1410827128-6876-3-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1410827128-6876-1-git-send-email-cyril.bur@au1.ibm.com>
References: <1410827128-6876-1-git-send-email-cyril.bur@au1.ibm.com>
Cc: Cyril Bur <cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Running this code on a little endian machine has exposed some very unlikely
corner cases. Most of these oversights will lead to a buffer overflow.

Reworked some of the error pathes. It seems more sane to stop trying to parse
a buffer on errors. Attempting to continue opens up the possibility of
overflows and/or garbage reads.

Don't warn about failed allcations when the amount was taken from the buffer,
assume the value was incorrect, don't needlessly concern the user.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 95 +++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 09bef23..00bd939 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -68,62 +68,45 @@ static int delete_dt_node(u32 phandle)
 }
 
 static int update_dt_property(struct device_node *dn, struct property **prop,
-			      const char *name, u32 vd, char *value)
+			      const char *name, int length, char *value)
 {
 	struct property *new_prop = *prop;
-	int more = 0;
-
-	/* A negative 'vd' value indicates that only part of the new property
-	 * value is contained in the buffer and we need to call
-	 * ibm,update-properties again to get the rest of the value.
-	 *
-	 * A negative value is also the two's compliment of the actual value.
-	 */
-	if (vd & 0x80000000) {
-		vd = ~vd + 1;
-		more = 1;
-	}
 
 	if (new_prop) {
 		/* partial property fixup */
-		char *new_data = kzalloc(new_prop->length + vd, GFP_KERNEL);
+		char *new_data = kzalloc(new_prop->length + length, GFP_KERNEL | __GFP_NOWARN);
 		if (!new_data)
 			return -ENOMEM;
 
 		memcpy(new_data, new_prop->value, new_prop->length);
-		memcpy(new_data + new_prop->length, value, vd);
+		memcpy(new_data + new_prop->length, value, length);
 
 		kfree(new_prop->value);
 		new_prop->value = new_data;
-		new_prop->length += vd;
+		new_prop->length += length;
 	} else {
 		new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
 		if (!new_prop)
 			return -ENOMEM;
 
-		new_prop->name = kstrdup(name, GFP_KERNEL);
+		new_prop->name = kstrdup(name, GFP_KERNEL | __GFP_NOWARN);
 		if (!new_prop->name) {
 			kfree(new_prop);
 			return -ENOMEM;
 		}
 
-		new_prop->length = vd;
-		new_prop->value = kzalloc(new_prop->length, GFP_KERNEL);
+		new_prop->length = length;
+		new_prop->value = kzalloc(new_prop->length, GFP_KERNEL | __GFP_NOWARN);
 		if (!new_prop->value) {
 			kfree(new_prop->name);
 			kfree(new_prop);
 			return -ENOMEM;
 		}
 
-		memcpy(new_prop->value, value, vd);
+		memcpy(new_prop->value, value, length);
 		*prop = new_prop;
 	}
 
-	if (!more) {
-		of_update_property(dn, new_prop);
-		*prop = NULL;
-	}
-
 	return 0;
 }
 
@@ -196,21 +179,52 @@ static int update_dt_node(u32 phandle, s32 scope)
 				break;
 
 			default:
+				/* A negative 'vd' value indicates that only part of the new property
+				 * value is contained in the buffer and we need to call
+				 * ibm,update-properties again to get the rest of the value.
+				 *
+				 * A negative value is also the two's compliment of the actual value.
+				 */
+
 				rc = update_dt_property(dn, &prop, prop_name,
-							vd, prop_data);
+							vd & 0x80000000 ? ~vd + 1 : vd, prop_data);
 				if (rc) {
-					printk(KERN_ERR "Could not update %s"
-					       " property\n", prop_name);
+					printk(KERN_ERR "Could not update %s property\n",
+					       prop_name);
+					/* Could try to continue but if the failure was for a section
+					 * of a node it gets too easy to mess up the device tree.
+					 * Plus, ENOMEM likely means we have bigger problems than a
+					 * failed device tree update */
+					if (prop) {
+						kfree(prop->name);
+						kfree(prop->value);
+						kfree(prop);
+						prop = NULL;
+					}
+					i = upwa.nprops - 1; /* Break */
+				}
+
+				if (prop && !(vd & 0x80000000)) {
+					of_update_property(dn, prop);
+					prop = NULL;
 				}
+				prop_data += vd & 0x80000000 ? ~vd + 1 : vd;
+			}
 
-				prop_data += vd;
+			if (prop_data - (char *)rtas_buf >= RTAS_DATA_BUF_SIZE) {
+				printk(KERN_ERR "Device tree property"
+				       " length exceeds rtas buffer\n");
+				rc = -EOVERFLOW;
+				goto update_dt_node_err;
 			}
 		}
 	} while (rtas_rc == 1);
 
+	rc = rtas_rc;
 	of_node_put(dn);
+update_dt_node_err:
 	kfree(rtas_buf);
-	return 0;
+	return rc;
 }
 
 static int add_dt_node(u32 parent_phandle, u32 drc_index)
@@ -264,9 +278,17 @@ int pseries_devicetree_update(s32 scope)
 			int node_count = node & NODE_COUNT_MASK;
 
 			for (i = 0; i < node_count; i++) {
-				u32 phandle = be32_to_cpu(*data++);
+				u32 phandle;
 				u32 drc_index;
 
+				if (data + 1 - rtas_buf >= RTAS_DATA_BUF_SIZE) {
+					printk(KERN_ERR "Device tree property"
+					       " length exceeds rtas buffer\n");
+					rc = -EOVERFLOW;
+					goto pseries_devicetree_update_err;
+				}
+				phandle = be32_to_cpu(*data++);
+
 				switch (action) {
 				case DELETE_DT_NODE:
 					delete_dt_node(phandle);
@@ -278,12 +300,23 @@ int pseries_devicetree_update(s32 scope)
 					drc_index = be32_to_cpu(*data++);
 					add_dt_node(phandle, drc_index);
 					break;
+				default:
+					/* Bogus action */
+					i = node_count - 1; /* Break */
+					data += node_count;
 				}
 			}
+			if (data - rtas_buf >= RTAS_DATA_BUF_SIZE) {
+				printk(KERN_ERR "Number of device tree update "
+				       "nodes exceeds rtas buffer length\n");
+				rc = -EOVERFLOW;
+				goto pseries_devicetree_update_err;
+			}
 			node = be32_to_cpu(*data++);
 		}
 	} while (rc == 1);
 
+pseries_devicetree_update_err:
 	kfree(rtas_buf);
 	return rc;
 }
-- 
1.9.1
