Return-Path: <anton@samba.org>
Date: Fri, 28 Mar 2014 16:33:33 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, neelegup@linux.vnet.ibm.com,
 sbhat@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc/powernv: Fix endian issues with OPAL async code
Message-ID: <20140328163333.4b1d3df4@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


OPAL defines opal_msg as a big endian struct so we have to
byte swap it on little endian builds.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -422,9 +422,9 @@ enum OpalSysparamPerm {
 };
 
 struct opal_msg {
-	uint32_t msg_type;
-	uint32_t reserved;
-	uint64_t params[8];
+	__be32 msg_type;
+	__be32 reserved;
+	__be64 params[8];
 };
 
 struct opal_machine_check_event {
Index: b/arch/powerpc/platforms/powernv/opal-async.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -125,14 +125,15 @@ static int opal_async_comp_event(struct
 {
 	struct opal_msg *comp_msg = msg;
 	unsigned long flags;
+	uint64_t token;
 
 	if (msg_type != OPAL_MSG_ASYNC_COMP)
 		return 0;
 
-	memcpy(&opal_async_responses[comp_msg->params[0]], comp_msg,
-			sizeof(*comp_msg));
+	token = be64_to_cpu(comp_msg->params[0]);
+	memcpy(&opal_async_responses[token], comp_msg, sizeof(*comp_msg));
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	__set_bit(comp_msg->params[0], opal_async_complete_map);
+	__set_bit(token, opal_async_complete_map);
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
 
 	wake_up(&opal_async_wait);
Index: b/arch/powerpc/platforms/powernv/opal-sensor.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -53,7 +53,7 @@ int opal_get_sensor_data(u32 sensor_hndl
 		goto out_token;
 	}
 
-	ret = msg.params[1];
+	ret = be64_to_cpu(msg.params[1]);
 
 out_token:
 	mutex_unlock(&opal_sensor_mutex);
Index: b/arch/powerpc/platforms/powernv/opal-sysparam.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal-sysparam.c
+++ b/arch/powerpc/platforms/powernv/opal-sysparam.c
@@ -64,7 +64,7 @@ static int opal_get_sys_param(u32 param_
 		goto out_token;
 	}
 
-	ret = msg.params[1];
+	ret = be64_to_cpu(msg.params[1]);
 
 out_token:
 	opal_async_release_token(token);
@@ -98,7 +98,7 @@ static int opal_set_sys_param(u32 param_
 		goto out_token;
 	}
 
-	ret = msg.params[1];
+	ret = be64_to_cpu(msg.params[1]);
 
 out_token:
 	opal_async_release_token(token);
Index: b/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -289,6 +289,7 @@ static void opal_handle_message(void)
 	 * value in /proc/device-tree.
 	 */
 	static struct opal_msg msg;
+	u32 type;
 
 	ret = opal_get_msg(__pa(&msg), sizeof(msg));
 	/* No opal message pending. */
@@ -302,13 +303,14 @@ static void opal_handle_message(void)
 		return;
 	}
 
+	type = be32_to_cpu(msg.msg_type);
+
 	/* Sanity check */
-	if (msg.msg_type > OPAL_MSG_TYPE_MAX) {
-		pr_warning("%s: Unknown message type: %u\n",
-				__func__, msg.msg_type);
+	if (type > OPAL_MSG_TYPE_MAX) {
+		pr_warning("%s: Unknown message type: %u\n", __func__, type);
 		return;
 	}
-	opal_message_do_notify(msg.msg_type, (void *)&msg);
+	opal_message_do_notify(type, (void *)&msg);
 }
 
 static int opal_message_notify(struct notifier_block *nb,
