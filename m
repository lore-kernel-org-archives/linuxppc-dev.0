Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9577C1A0292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:17:05 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 03:17:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2902A2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:17:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AHGpnP46858386
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:17:00 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AHGQVq029356
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:16:26 +1100
Subject: [PATCH 1/2] opal: Fix the overflow of message notifiers head array
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 22:44:01 +0530
Message-ID: <20150210171245.28320.53659.stgit@localhost.localdomain>
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

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index f10b9ec..2651e22 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -305,16 +305,12 @@ void opal_notifier_disable(void)
 int opal_message_notifier_register(enum OpalMessageType msg_type,
 					struct notifier_block *nb)
 {
-	if (!nb) {
-		pr_warning("%s: Invalid argument (%p)\n",
-			   __func__, nb);
-		return -EINVAL;
-	}
-	if (msg_type > OPAL_MSG_TYPE_MAX) {
-		pr_warning("%s: Invalid message type argument (%d)\n",
+	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
+		pr_warning("%s: Invalid arguments, msg_type:%d\n",
 			   __func__, msg_type);
 		return -EINVAL;
 	}
+
 	return atomic_notifier_chain_register(
 				&opal_msg_notifier_head[msg_type], nb);
 }
@@ -351,7 +347,7 @@ static void opal_handle_message(void)
 	type = be32_to_cpu(msg.msg_type);
 
 	/* Sanity check */
-	if (type > OPAL_MSG_TYPE_MAX) {
+	if (type >= OPAL_MSG_TYPE_MAX) {
 		pr_warning("%s: Unknown message type: %u\n", __func__, type);
 		return;
 	}
