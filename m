Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DF8D61A098D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:45 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Thu, 25 Sep 2014 16:41:45 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C6DF2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:42 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P6h6t034275534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:43:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P6faGv020832
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8P6faQb020818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from cyril.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9C327A03CF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:30 +1000 (EST)
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] powerpc/pseries: fix bugs in mobility RTAS calls
Date: Thu, 25 Sep 2014 16:41:30 +1000
Message-Id: <1411627290-20302-4-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These calls use a shared memory buffer to communicate device tree updates and
PAPR specifies that RTAS buffers are to be written in big endian.  Used the
rtas buffer accessor to help solve both endian problems and standard buffer
access problems.

It seems more sane to stop trying to parse a buffer on errors. Attempting to
continue opens up the possibility of overflows and/or garbage reads. Used
of_changesets throughout to avoid leaving the device tree in an inconsitent
state on error.

Don't warn about failed allcations when the amount was taken from the buffer,
assume the value was incorrect, don't needlessly concern the user.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 406 ++++++++++++++++++------------
 1 file changed, 243 insertions(+), 163 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index e7cb6d4..37d16da 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -20,16 +20,11 @@
 
 #include <asm/machdep.h>
 #include <asm/rtas.h>
+
 #include "pseries.h"
 
-static struct kobject *mobility_kobj;
 
-struct update_props_workarea {
-	u32 phandle;
-	u32 state;
-	u64 reserved;
-	u32 nprops;
-} __packed;
+static struct kobject *mobility_kobj;
 
 #define NODE_ACTION_MASK	0xff000000
 #define NODE_COUNT_MASK		0x00ffffff
@@ -40,7 +35,7 @@ struct update_props_workarea {
 
 #define MIGRATION_SCOPE	(1)
 
-static int mobility_rtas_call(int token, char *buf, s32 scope)
+static int mobility_rtas_call(int token, void *buf, s32 scope)
 {
 	int rc;
 
@@ -54,171 +49,193 @@ static int mobility_rtas_call(int token, char *buf, s32 scope)
 	return rc;
 }
 
-static int delete_dt_node(u32 phandle)
+static int create_property(struct rtas_buffer *rtas_buf, struct property **prop,
+                           const char *name, int length)
 {
-	struct device_node *dn;
-
-	dn = of_find_node_by_phandle(phandle);
-	if (!dn)
-		return -ENOENT;
+	void *prop_value;
+	void *new_value;
 
-	dlpar_detach_node(dn);
-	of_node_put(dn);
-	return 0;
-}
+	struct property *working_prop = *prop;
 
-static int update_dt_property(struct device_node *dn, struct property **prop,
-			      const char *name, u32 vd, char *value)
-{
-	struct property *new_prop = *prop;
-	int more = 0;
+	if (!get_rtas_buf_mem(rtas_buf, &prop_value, length))
+		return -EOVERFLOW;
 
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
-
-	if (new_prop) {
-		/* partial property fixup */
-		char *new_data = kzalloc(new_prop->length + vd, GFP_KERNEL);
-		if (!new_data)
-			return -ENOMEM;
-
-		memcpy(new_data, new_prop->value, new_prop->length);
-		memcpy(new_data + new_prop->length, value, vd);
-
-		kfree(new_prop->value);
-		new_prop->value = new_data;
-		new_prop->length += vd;
-	} else {
-		new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
-		if (!new_prop)
-			return -ENOMEM;
-
-		new_prop->name = kstrdup(name, GFP_KERNEL);
-		if (!new_prop->name) {
-			kfree(new_prop);
+	if (!working_prop) {
+		working_prop = kzalloc(sizeof(*working_prop), GFP_KERNEL);
+		if (!working_prop) {
 			return -ENOMEM;
 		}
 
-		new_prop->length = vd;
-		new_prop->value = kzalloc(new_prop->length, GFP_KERNEL);
-		if (!new_prop->value) {
-			kfree(new_prop->name);
-			kfree(new_prop);
+		working_prop->name = kstrdup(name, GFP_KERNEL | __GFP_NOWARN);
+		if (!working_prop->name) {
+			kfree(working_prop);
 			return -ENOMEM;
 		}
-
-		memcpy(new_prop->value, value, vd);
-		*prop = new_prop;
+		*prop = working_prop;
 	}
 
-	if (!more) {
-		of_update_property(dn, new_prop);
+	new_value = krealloc(working_prop->value, working_prop->length + length, GFP_KERNEL | __GFP_NOWARN);
+	if (!new_value) {
+		kfree(working_prop->value);
+		kfree(working_prop->name);
+		kfree(working_prop);
 		*prop = NULL;
+		return -ENOMEM;
 	}
 
+	working_prop->value = new_value;
+	memcpy(working_prop->value + working_prop->length, prop_value, length);
+	working_prop->length += length;
+
 	return 0;
 }
 
-static int update_dt_node(u32 phandle, s32 scope)
+static int parse_ibm_update_properties(struct rtas_buffer *rtas_buf, struct of_changeset *cs,
+                                       struct device_node *dn, struct property **r_prop)
 {
-	struct update_props_workarea *upwa;
-	struct device_node *dn;
+	int i;
+	int rc = 0;
+
 	struct property *prop = NULL;
-	int i, rc, rtas_rc;
-	char *prop_data;
-	char *rtas_buf;
-	int update_properties_token;
+
+	char peek;
+	u32 nprops;
 	u32 vd;
 
-	update_properties_token = rtas_token("ibm,update-properties");
-	if (update_properties_token == RTAS_UNKNOWN_SERVICE)
+	if (!rtas_buf || !cs || !dn || !r_prop)
 		return -EINVAL;
 
-	rtas_buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
-	if (!rtas_buf)
-		return -ENOMEM;
+	/* Advance the buffer by 16 bytes which contain the phandle (4 bytes),
+	 * 4 bytes of state variable and 8 bytes of reserved (zero) bytes.
+	 * As the state variable must be sent on subsequent RTAS calls ensure
+	 * don't touch it so the caller can reuse this buffer.
+	 */
+	if (!advance_rtas_buf(rtas_buf, 16) || !get_rtas_buf_32(rtas_buf, &nprops))
+		return -EOVERFLOW;
 
-	dn = of_find_node_by_phandle(phandle);
-	if (!dn) {
-		kfree(rtas_buf);
-		return -ENOENT;
+	/* On the first call to ibm,update-properties for a node the
+	 * the first property value descriptor contains an empty
+	 * property name, the property value length encoded as u32,
+	 * and the property value is the node path being updated.
+	 *
+	 * Discard this information as the node was looked up by its phandle and
+	 * passed in.
+	 */
+	if (!peek_rtas_buf(rtas_buf, &peek))
+		return -EOVERFLOW;
+	if (peek == '\0') {
+		if (!advance_rtas_buf(rtas_buf, sizeof(u32)) ||
+		    !get_rtas_buf_32(rtas_buf, &vd) ||
+		    !advance_rtas_buf(rtas_buf, vd))
+			return -EOVERFLOW;
+		nprops--;
 	}
 
-	upwa = (struct update_props_workarea *)&rtas_buf[0];
-	upwa->phandle = phandle;
+	for (i = 0; i < nprops; i++) {
+		char *prop_name = NULL;
+		int prop_len;
 
-	do {
-		rtas_rc = mobility_rtas_call(update_properties_token, rtas_buf,
-					scope);
-		if (rtas_rc < 0)
+		if (!get_rtas_buf_str(rtas_buf, &prop_name) ||
+		    !get_rtas_buf_32(rtas_buf, &vd))
+				return -EOVERFLOW;
+
+		switch (vd) {
+		case 0x00000000:
+			/* name only property, nothing to do */
 			break;
 
-		prop_data = rtas_buf + sizeof(*upwa);
-
-		/* On the first call to ibm,update-properties for a node the
-		 * the first property value descriptor contains an empty
-		 * property name, the property value length encoded as u32,
-		 * and the property value is the node path being updated.
-		 */
-		if (*prop_data == 0) {
-			prop_data++;
-			vd = *(u32 *)prop_data;
-			prop_data += vd + sizeof(vd);
-			upwa->nprops--;
+		case 0x80000000:
+			prop = of_find_property(dn, prop_name, NULL);
+			of_changeset_remove_property(cs, dn, prop);
+			prop = NULL;
+			break;
+
+		default:
+			/* A negative 'vd' value indicates that only part of the new property
+			 * value is contained in the buffer and we need to call
+			 * ibm,update-properties again to get the rest of the value.
+			 *
+			 * A negative value is also the two's compliment of the actual value.
+			 */
+			prop_len = vd & 0x80000000 ? ~vd + 1 : vd;
+
+			rc = create_property(rtas_buf, &prop, prop_name, prop_len);
+			if (rc) {
+				printk(KERN_ERR "Could not update %s property\n", prop_name);
+				/* Could try to continue but failure in that function likely means
+				 * we have bigger problems.
+				 */
+				return rc;
+			}
+
+			if (prop && !(vd & 0x80000000)) {
+				of_changeset_update_property(cs, dn, prop);
+				prop = NULL;
+			}
 		}
+	}
 
-		for (i = 0; i < upwa->nprops; i++) {
-			char *prop_name;
+	if (prop)
+		*r_prop = prop;
+	return rc;
+}
 
-			prop_name = prop_data;
-			prop_data += strlen(prop_name) + 1;
-			vd = *(u32 *)prop_data;
-			prop_data += sizeof(vd);
+static int pseries_devicetree_update_props(struct of_changeset *cs, struct device_node *dn,
+                                           s32 scope)
+{
+	int rc;
+	int error;
+	int update_properties_token;
 
-			switch (vd) {
-			case 0x00000000:
-				/* name only property, nothing to do */
-				break;
+	void *buf;
+	struct rtas_buffer rtas_buf;
 
-			case 0x80000000:
-				prop = of_find_property(dn, prop_name, NULL);
-				of_remove_property(dn, prop);
-				prop = NULL;
-				break;
+	struct property *prop = NULL;
 
-			default:
-				rc = update_dt_property(dn, &prop, prop_name,
-							vd, prop_data);
-				if (rc) {
-					printk(KERN_ERR "Could not update %s"
-					       " property\n", prop_name);
-				}
+	if (!cs || !dn)
+		return -EINVAL;
 
-				prop_data += vd;
-			}
+	update_properties_token = rtas_token("ibm,update-properties");
+	if (update_properties_token == RTAS_UNKNOWN_SERVICE)
+		return -EINVAL;
+
+	rc = make_rtas_buf(&rtas_buf, RTAS_DATA_BUF_SIZE);
+	if (rc)
+		return -ENOMEM;
+
+	put_rtas_buf_32(&rtas_buf, dn->phandle, 0);
+
+	buf = get_rtas_buf(&rtas_buf);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	do {
+
+		rc = mobility_rtas_call(update_properties_token, buf, scope);
+		if (rc < 0)
+			goto out;
+
+		error = parse_ibm_update_properties(&rtas_buf, cs, dn, &prop);
+		if (error) {
+			rc = error;
+			goto out;
 		}
-	} while (rtas_rc == 1);
 
-	of_node_put(dn);
-	kfree(rtas_buf);
-	return 0;
+	} while (rc == 1);
+
+out:
+	free_rtas_buf(&rtas_buf);
+	return rc;
 }
 
-static int add_dt_node(u32 parent_phandle, u32 drc_index)
+static int pseries_devicetree_update_node(struct of_changeset *cs, struct device_node *parent_dn,
+                                          u32 drc_index)
 {
 	struct device_node *dn;
-	struct device_node *parent_dn;
 	int rc;
 
-	parent_dn = of_find_node_by_phandle(parent_phandle);
 	if (!parent_dn)
 		return -ENOENT;
 
@@ -230,59 +247,122 @@ static int add_dt_node(u32 parent_phandle, u32 drc_index)
 	if (rc)
 		dlpar_free_cc_nodes(dn);
 
-	of_node_put(parent_dn);
 	return rc;
 }
 
+static int parse_ibm_update_nodes(struct rtas_buffer *rtas_buf, struct of_changeset *cs, s32 scope)
+{
+	u32 node;
+	int rc = 0;
+
+	if (!rtas_buf || !cs)
+		return -EINVAL;
+
+	/* Advance the buffer by 16 bytes which encompases 4 bytes of state
+	 * variable and 12 reserved (zeroed) bytes.
+	 * As the state variable must be sent on subsequent RTAS calls ensure
+	 * don't touch it so the caller can reuse this buffer.
+	 */
+	if (!advance_rtas_buf(rtas_buf, 16) ||
+	    !get_rtas_buf_32(rtas_buf, &node))
+		goto out;
+
+	while (node & NODE_ACTION_MASK) {
+		int i;
+		u32 action = node & NODE_ACTION_MASK;
+		int node_count = node & NODE_COUNT_MASK;
+		struct device_node *dn;
+
+		for (i = 0; i < node_count; i++) {
+			u32 phandle;
+			u32 drc_index;
+
+			if (!get_rtas_buf_32(rtas_buf, &phandle))
+				goto out;
+
+			dn = of_find_node_by_phandle(phandle);
+			if (!dn)
+				return -ENOENT;
+
+			switch (action) {
+			case DELETE_DT_NODE:
+				of_changeset_detach_node(cs, dn);
+				break;
+			case UPDATE_DT_NODE:
+				rc = pseries_devicetree_update_props(cs, dn, scope);
+				break;
+			case ADD_DT_NODE:
+				if (!get_rtas_buf_32(rtas_buf, &drc_index)) {
+					of_node_put(dn);
+					goto out;
+				}
+				rc = pseries_devicetree_update_node(cs, dn, drc_index);
+				break;
+			default:
+				of_node_put(dn);
+				/* Bogus action */
+				return -EINVAL; /* Break */
+			}
+			of_node_put(dn);
+		}
+		if (!get_rtas_buf_32(rtas_buf, &node))
+			goto out;
+	}
+
+	return rc;
+out:
+	printk(KERN_ERR "RTAS buffer length exceeded\n");
+	return -EOVERFLOW;
+}
+
 int pseries_devicetree_update(s32 scope)
 {
-	char *rtas_buf;
-	u32 *data;
+	struct rtas_buffer rtas_buf;
+	struct of_changeset cs;
+	void *buf;
 	int update_nodes_token;
 	int rc;
+	int error;
 
 	update_nodes_token = rtas_token("ibm,update-nodes");
 	if (update_nodes_token == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
-	rtas_buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
-	if (!rtas_buf)
-		return -ENOMEM;
+	of_changeset_init(&cs);
+
+	rc = make_rtas_buf(&rtas_buf, RTAS_DATA_BUF_SIZE);
+	if (rc) {
+		of_changeset_destroy(&cs);
+		return rc;
+	}
+
+	buf = get_rtas_buf(&rtas_buf);
+	if (!buf) {
+		rc = -ENOMEM;
+		goto out;
+	}
 
 	do {
-		rc = mobility_rtas_call(update_nodes_token, rtas_buf, scope);
+		rc = mobility_rtas_call(update_nodes_token, buf, scope);
 		if (rc && rc != 1)
 			break;
 
-		data = (u32 *)rtas_buf + 4;
-		while (*data & NODE_ACTION_MASK) {
-			int i;
-			u32 action = *data & NODE_ACTION_MASK;
-			int node_count = *data & NODE_COUNT_MASK;
-
-			data++;
-
-			for (i = 0; i < node_count; i++) {
-				u32 phandle = *data++;
-				u32 drc_index;
-
-				switch (action) {
-				case DELETE_DT_NODE:
-					delete_dt_node(phandle);
-					break;
-				case UPDATE_DT_NODE:
-					update_dt_node(phandle, scope);
-					break;
-				case ADD_DT_NODE:
-					drc_index = *data++;
-					add_dt_node(phandle, drc_index);
-					break;
-				}
-			}
-		}
+		error = parse_ibm_update_nodes(&rtas_buf, &cs, scope);
+		if (error)
+			break;
+
 	} while (rc == 1);
 
-	kfree(rtas_buf);
+	if (error)
+		rc = error;
+
+	if (rc == 0)
+		rc = of_changeset_apply_locked(&cs);
+
+out:
+	of_changeset_destroy(&cs);
+	free_rtas_buf(&rtas_buf);
+
 	return rc;
 }
 
-- 
1.9.1
