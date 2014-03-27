Return-Path: <anton@samba.org>
Date: Fri, 28 Mar 2014 09:17:37 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, neelegup@linux.vnet.ibm.com,
 sbhat@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc/powernv: Fix endian issues with OPAL async code
Message-ID: <20140328091737.6cb02f7d@kryten>
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


Byteswap struct opal_msg in one place instead of requiring all the
callers to do it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/include/asm/opal.h
===================================================================
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -421,6 +421,12 @@ enum OpalSysparamPerm {
 	OPAL_SYSPARAM_RW        = (OPAL_SYSPARAM_READ | OPAL_SYSPARAM_WRITE),
 };
 
+struct raw_opal_msg {
+	__be32 msg_type;
+	__be32 reserved;
+	__be64 params[8];
+};
+
 struct opal_msg {
 	uint32_t msg_type;
 	uint32_t reserved;
Index: b/arch/powerpc/platforms/powernv/opal.c
===================================================================
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -288,9 +288,11 @@ static void opal_handle_message(void)
 	 * TODO: pre-allocate a message buffer depending on opal-msg-size
 	 * value in /proc/device-tree.
 	 */
+	static struct raw_opal_msg raw_msg;
 	static struct opal_msg msg;
+	int i;
 
-	ret = opal_get_msg(__pa(&msg), sizeof(msg));
+	ret = opal_get_msg(__pa(&raw_msg), sizeof(raw_msg));
 	/* No opal message pending. */
 	if (ret == OPAL_RESOURCE)
 		return;
@@ -302,6 +304,11 @@ static void opal_handle_message(void)
 		return;
 	}
 
+	msg.msg_type = be32_to_cpu(raw_msg.msg_type);
+	msg.reserved = be32_to_cpu(raw_msg.reserved);
+	for (i = 0; i < ARRAY_SIZE(raw_msg.params); i++)
+		msg.params[i] = be64_to_cpu(raw_msg.params[i]);
+
 	/* Sanity check */
 	if (msg.msg_type > OPAL_MSG_TYPE_MAX) {
 		pr_warning("%s: Unknown message type: %u\n",
