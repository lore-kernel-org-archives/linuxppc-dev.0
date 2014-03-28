Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF5C714009B
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:44 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 28 Mar 2014 12:36:42 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 41A6A3578057
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:41 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s2S2aRaW7995798
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:27 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s2S2aeMK015020
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2014 13:36:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] powerpc/powernv: Add opal_notifier_unregister() and
 export to modules
Date: Fri, 28 Mar 2014 13:36:31 +1100
Message-Id: <1395974192-820-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
References: <1395974192-820-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

opal_notifier_register() is missing a pending "unregister" variant
and should be exposed to modules.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/opal.h       |  2 ++
 arch/powerpc/platforms/powernv/opal.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ffafab0..1dd3f9b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -891,6 +891,8 @@ extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
 extern int opal_notifier_register(struct notifier_block *nb);
+extern int opal_notifier_unregister(struct notifier_block *nb);
+
 extern int opal_message_notifier_register(enum OpalMessageType msg_type,
 						struct notifier_block *nb);
 extern void opal_notifier_enable(void);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index e92f2f6..7835d5b 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -180,6 +180,20 @@ int opal_notifier_register(struct notifier_block *nb)
 	atomic_notifier_chain_register(&opal_notifier_head, nb);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(opal_notifier_register);
+
+int opal_notifier_unregister(struct notifier_block *nb)
+{
+	if (!nb) {
+		pr_warning("%s: Invalid argument (%p)\n",
+			   __func__, nb);
+		return -EINVAL;
+	}
+
+	atomic_notifier_chain_unregister(&opal_notifier_head, nb);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(opal_notifier_unregister);
 
 static void opal_do_notifier(uint64_t events)
 {
-- 
1.8.3.2
