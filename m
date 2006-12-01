Return-Path: <maynardj@us.ibm.com>
Message-ID: <45708A0B.6000106@us.ibm.com>
Date: Fri, 01 Dec 2006 14:01:15 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH]Add notification for active Cell SPU tasks
Content-Type: multipart/mixed; boundary="------------040306070403040204060809"
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040306070403040204060809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040306070403040204060809
Content-Type: text/x-diff;
 name="spu-notifier.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="spu-notifier.patch"

Subject: Enable SPU switch notification to detect currently active SPU tasks.

From: Maynard Johnson <maynardj@us.ibm.com>

This patch adds to the capability of spu_switch_event_register to notify the
caller of currently active SPU tasks.  It also exports spu_switch_event_register
and spu_switch_event_unregister.

Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>


Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/spufs/sched.c	2006-11-24 11:34:44.884455680 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/spufs/sched.c	2006-12-01 13:57:21.864583264 -0600
@@ -84,15 +84,37 @@
 			    ctx ? ctx->object_id : 0, spu);
 }
 
+static void notify_spus_active(void)
+{
+	int node;
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		struct spu *spu;
+		mutex_lock(&spu_prio->active_mutex[node]);
+		list_for_each_entry(spu, &spu_prio->active_list[node], list) {
+	 			 struct spu_context *ctx = spu->ctx;
+	 			 blocking_notifier_call_chain(&spu_switch_notifier,
+	 		 			 ctx ? ctx->object_id : 0, spu);
+		}
+		mutex_unlock(&spu_prio->active_mutex[node]);
+	 }
+
+}
+
 int spu_switch_event_register(struct notifier_block * n)
 {
-	return blocking_notifier_chain_register(&spu_switch_notifier, n);
+	int ret;
+	ret = blocking_notifier_chain_register(&spu_switch_notifier, n);
+	if (!ret)
+		notify_spus_active();
+	return ret;
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_register);
 
 int spu_switch_event_unregister(struct notifier_block * n)
 {
 	return blocking_notifier_chain_unregister(&spu_switch_notifier, n);
 }
+EXPORT_SYMBOL_GPL(spu_switch_event_unregister);
 
 
 static inline void bind_context(struct spu *spu, struct spu_context *ctx)

--------------040306070403040204060809--
