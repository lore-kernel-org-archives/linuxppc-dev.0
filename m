Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79C2E2C00A6
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:11:43 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 15 Nov 2013 14:11:28 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 93DAA2CE8053
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:11:17 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAF4B5CH9372090
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:11:05 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAF4BGrF023015
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Nov 2013 15:11:17 +1100
Subject: [RFC PATCH] powerpc/powernv: infrastructure to read opal messages in
 generic format.
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 15 Nov 2013 09:41:07 +0530
Message-ID: <20131115041040.3346.50066.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Opal now has a new messaging infrastructure to push the messages to
linux in a generic format for different type of messages using only one
event bit. The format of the opal message is as below:

struct opal_msg {
        uint32_t msg_type;
	uint32_t reserved;
	uint64_t params[8];
};

This patch allows clients to subscribe for notification for specific
message type. It is upto the subscriber to decipher the messages who showed
interested in receiving specific message type.

The interface to subscribe for notification is:

	int opal_message_notifier_register(enum OpalMessageType msg_type,
                                        struct notifier_block *nb)


The notifier will fetch the opal message when available and notify the
subscriber with message type and the opal message. It is subscribers
responsibility to copy the message data before returning from notifier
callback.

I will post a seperate patch series for fsp memory handling which uses
this new messaging channel to pull fsp memory errors.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                |   23 ++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 +
 arch/powerpc/platforms/powernv/opal.c          |   90 ++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index c5cd728..3de7ac6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -129,6 +129,8 @@ extern int opal_enter_rtas(struct rtas_args *args,
 #define OPAL_LPC_READ				67
 #define OPAL_LPC_WRITE				68
 #define OPAL_RETURN_CPU				69
+#define OPAL_GET_MSG				80
+#define OPAL_CHECK_COMP				81
 
 #ifndef __ASSEMBLY__
 
@@ -208,7 +210,16 @@ enum OpalPendingState {
 	OPAL_EVENT_ERROR_LOG		= 0x40,
 	OPAL_EVENT_EPOW			= 0x80,
 	OPAL_EVENT_LED_STATUS		= 0x100,
-	OPAL_EVENT_PCI_ERROR		= 0x200
+	OPAL_EVENT_PCI_ERROR		= 0x200,
+	OPAL_EVENT_PENDING_MSGS		= 0x400,
+};
+
+enum OpalMessageType {
+	OPAL_MSG_ASYNC_COMP		= 0,
+	OPAL_MSG_MEM_ERR,
+	OPAL_MSG_EPOW,
+	OPAL_MSG_SHUTDOWN,
+	OPAL_MSG_TYPE_MAX,
 };
 
 /* Machine check related definitions */
@@ -353,6 +364,12 @@ enum OpalLPCAddressType {
 	OPAL_LPC_FW	= 2,
 };
 
+struct opal_msg {
+	uint32_t msg_type;
+	uint32_t reserved;
+	uint64_t params[8];
+};
+
 struct opal_machine_check_event {
 	enum OpalMCE_Version	version:8;	/* 0x00 */
 	uint8_t			in_use;		/* 0x01 */
@@ -656,6 +673,8 @@ int64_t opal_lpc_write(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		       uint32_t addr, uint32_t data, uint32_t sz);
 int64_t opal_lpc_read(uint32_t chip_id, enum OpalLPCAddressType addr_type,
 		      uint32_t addr, uint32_t *data, uint32_t sz);
+int64_t opal_get_msg(uint64_t buffer, size_t size);
+int64_t opal_check_completion(uint64_t buffer, size_t size, uint64_t token);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname, int depth, void *data);
@@ -670,6 +689,8 @@ extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
 extern int opal_notifier_register(struct notifier_block *nb);
+extern int opal_message_notifier_register(enum OpalMessageType msg_type,
+						struct notifier_block *nb);
 extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
 extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8f38445..a082d42 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -116,3 +116,5 @@ OPAL_CALL(opal_xscom_write,			OPAL_XSCOM_WRITE);
 OPAL_CALL(opal_lpc_read,			OPAL_LPC_READ);
 OPAL_CALL(opal_lpc_write,			OPAL_LPC_WRITE);
 OPAL_CALL(opal_return_cpu,			OPAL_RETURN_CPU);
+OPAL_CALL(opal_get_msg,				OPAL_GET_MSG);
+OPAL_CALL(opal_check_completion,		OPAL_CHECK_COMP);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2911abe..d3759f7 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -33,6 +33,7 @@ extern u64 opal_mc_secondary_handler[];
 static unsigned int *opal_irqs;
 static unsigned int opal_irq_count;
 static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
+static struct atomic_notifier_head opal_msg_notifier_head[OPAL_MSG_TYPE_MAX];
 static DEFINE_SPINLOCK(opal_notifier_lock);
 static uint64_t last_notified_mask = 0x0ul;
 static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
@@ -162,6 +163,95 @@ void opal_notifier_disable(void)
 	atomic_set(&opal_notifier_hold, 1);
 }
 
+/*
+ * Opal message notifier based on message type. Allow subscribers to get
+ * notified for specific messgae type.
+ */
+int opal_message_notifier_register(enum OpalMessageType msg_type,
+					struct notifier_block *nb)
+{
+	if (!nb) {
+		pr_warning("%s: Invalid argument (%p)\n",
+			   __func__, nb);
+		return -EINVAL;
+	}
+	if (msg_type > OPAL_MSG_TYPE_MAX) {
+		pr_warning("%s: Invalid message type argument (%d)\n",
+			   __func__, msg_type);
+		return -EINVAL;
+	}
+	return atomic_notifier_chain_register(
+				&opal_msg_notifier_head[msg_type], nb);
+}
+
+static void opal_message_do_notify(uint32_t msg_type, void *msg)
+{
+	/* notify subscribers */
+	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
+					msg_type, msg);
+}
+
+static void opal_message_handle_event(void)
+{
+	s64 ret;
+	/*
+	 * TODO: pre-allocate a message buffer depending on opal-msg-size
+	 * value in /proc/device-tree.
+	 */
+	static struct opal_msg msg;
+
+	ret = opal_get_msg(__pa(&msg), sizeof(msg));
+	/* No opal message pending. */
+	if (ret == OPAL_RESOURCE)
+		return;
+
+	/* check for errors. */
+	if (ret) {
+		pr_warning("%s: Failed to retrive opal message, err=%lld\n",
+				__func__, ret);
+		return;
+	}
+
+	/* Sanity check */
+	if (msg.msg_type > OPAL_MSG_TYPE_MAX) {
+		pr_warning("%s: Unknown message type: %u\n",
+				__func__, msg.msg_type);
+		return;
+	}
+	opal_message_do_notify(msg.msg_type, (void *)&msg);
+}
+
+static int opal_message_notify(struct notifier_block *nb,
+			  unsigned long events, void *change)
+{
+	if (events & OPAL_EVENT_PENDING_MSGS)
+		opal_message_handle_event();
+	return 0;
+}
+
+static struct notifier_block opal_message_nb = {
+	.notifier_call	= opal_message_notify,
+	.next		= NULL,
+	.priority	= 0,
+};
+
+static int __init opal_message_init(void)
+{
+	int ret, i;
+
+	for (i = 0; i < OPAL_MSG_TYPE_MAX; i++)
+		ATOMIC_INIT_NOTIFIER_HEAD(&opal_msg_notifier_head[i]);
+
+	ret = opal_notifier_register(&opal_message_nb);
+	if (ret) {
+		pr_err("%s: Can't register OPAL event notifier (%d)\n",
+		       __func__, ret);
+		return ret;
+	}
+	return 0;
+}
+early_initcall(opal_message_init);
+
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	s64 len, rc;
