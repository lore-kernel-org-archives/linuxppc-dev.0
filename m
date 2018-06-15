Return-Path: <3hAYkWwMKDAExblhpphmf.dpnmjovyqqd-efwmjtut.p0mbct.psh@flex--wak.bounces.google.com>
Received: from mail-yw0-x24a.google.com (mail-yw0-x24a.google.com
 [IPv6:2607:f8b0:4002:c05::24a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416pzM66TrzF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 04:33:44 +1000 (AEST)
Received: by mail-yw0-x24a.google.com with SMTP id w7-v6so7921316ywf.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 11:33:44 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Jun 2018 11:33:32 -0700
Message-Id: <20180615183332.249253-1-wak@google.com>
Subject: [PATCH] ipmi/powernv: Fix spurious warnings at boot
From: "William A. Kennington III" <wak@google.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "William A. Kennington III" <wak@google.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sometimes we have stale messages showing up in the recv queue that are
being processed by the pollers. We don't want to print out warnings for
these messages not having an outstanding request as they can be expected
when doing a kexec from the petitroot environment or from another
running kernel.

Signed-off-by: William A. Kennington III <wak@google.com>
---
 drivers/char/ipmi/ipmi_powernv.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_powernv.c b/drivers/char/ipmi/ipmi_powernv.c
index e96500372ce20..36b07f26cebd9 100644
--- a/drivers/char/ipmi/ipmi_powernv.c
+++ b/drivers/char/ipmi/ipmi_powernv.c
@@ -31,6 +31,12 @@ struct ipmi_smi_powernv {
 	spinlock_t		msg_lock;
 	struct ipmi_smi_msg	*cur_msg;
 	struct opal_ipmi_msg	*opal_msg;
+
+	/**
+	 * Marker denoting if we should be draining the ipmi queue of any
+	 * outstanding messages
+	 */
+	bool			in_drain;
 };
 
 static int ipmi_powernv_start_processing(void *send_info, ipmi_smi_t intf)
@@ -96,6 +102,7 @@ static void ipmi_powernv_send(void *send_info, struct ipmi_smi_msg *msg)
 
 	if (!rc) {
 		smi->cur_msg = msg;
+		smi->in_drain = false;
 		spin_unlock_irqrestore(&smi->msg_lock, flags);
 		return;
 	}
@@ -121,8 +128,14 @@ static int ipmi_powernv_recv(struct ipmi_smi_powernv *smi)
 	spin_lock_irqsave(&smi->msg_lock, flags);
 
 	if (!smi->cur_msg) {
+		bool in_drain = READ_ONCE(smi->in_drain);
 		spin_unlock_irqrestore(&smi->msg_lock, flags);
-		pr_warn("no current message?\n");
+		/**
+		 * We don't want to print spurious errors if we are draining
+		 * leftover messages prior to sending our first message.
+		 */
+		if (!in_drain)
+			pr_warn("no current message?\n");
 		return 0;
 	}
 
@@ -226,6 +239,11 @@ static int ipmi_powernv_probe(struct platform_device *pdev)
 
 	spin_lock_init(&ipmi->msg_lock);
 
+	/* Our channel may have stale messages from a previous kernel
+	 * let the recv code know we haven't actually sent anything yet
+	 */
+	ipmi->in_drain = true;
+
 	rc = of_property_read_u32(dev->of_node, "ibm,ipmi-interface-id",
 			&prop);
 	if (rc) {
-- 
2.18.0.rc1.244.gcf134e6275-goog
