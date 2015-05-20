Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB31D1A0377
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 13:23:38 +1000 (AEST)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/3 v2] powerpc/powernv: Expose OPAL APIs required by PRD
 interface
Message-Id: <1432092213.629846.100592494939.2.gpush@pablo>
In-Reply-To: <1432092213.629456.385035345144.1.gpush@pablo>
To: linuxppc-dev@lists.ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 20 May 2015 11:23:33 +0800
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The (upcoming) opal-prd driver needs to access the message notifier and
xscom code, so add EXPORT_SYMBOL_GPL macros for these.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/powernv/opal.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index b03ac9e..b40624d 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -317,6 +317,7 @@ int opal_message_notifier_register(enum opal_msg_type msg_type,
 	return atomic_notifier_chain_register(
 				&opal_msg_notifier_head[msg_type], nb);
 }
+EXPORT_SYMBOL_GPL(opal_message_notifier_register);
 
 int opal_message_notifier_unregister(enum opal_msg_type msg_type,
 				     struct notifier_block *nb)
@@ -324,6 +325,7 @@ int opal_message_notifier_unregister(enum opal_msg_type msg_type,
 	return atomic_notifier_chain_unregister(
 			&opal_msg_notifier_head[msg_type], nb);
 }
+EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
 
 static void opal_message_do_notify(uint32_t msg_type, void *msg)
 {
@@ -867,6 +869,8 @@ void opal_shutdown(void)
 
 /* Export this so that test modules can use it */
 EXPORT_SYMBOL_GPL(opal_invalid_call);
+EXPORT_SYMBOL_GPL(opal_xscom_read);
+EXPORT_SYMBOL_GPL(opal_xscom_write);
 EXPORT_SYMBOL_GPL(opal_ipmi_send);
 EXPORT_SYMBOL_GPL(opal_ipmi_recv);
 EXPORT_SYMBOL_GPL(opal_flash_read);
