Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1D6C1A054F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 17:29:20 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 11:59:17 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 95422E0056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 12:00:49 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1B6TEii66256914
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:59:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1B6TEma031160
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:59:14 +0530
Subject: [PATCH v2 1/2] opal: Fix the overflow of message notifiers head array
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 11:57:06 +0530
Message-ID: <20150211062616.3279.71632.stgit@localhost.localdomain>
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

Fixes the condition check of incoming message type which can
otherwise shoot beyond the message notifiers head array.

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
