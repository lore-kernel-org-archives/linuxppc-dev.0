Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1040E1A0330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:18:04 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 03:18:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A6B9C2CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:18:00 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1AHHq9s35455008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:18:00 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1AHHQ2a008444
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 04:17:27 +1100
Subject: [PATCH 2/2] opal: Add message notifier unregister function
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Tue, 10 Feb 2015 22:45:02 +0530
Message-ID: <20150210171425.28320.76626.stgit@localhost.localdomain>
In-Reply-To: <20150210171245.28320.53659.stgit@localhost.localdomain>
References: <20150210171245.28320.53659.stgit@localhost.localdomain>
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

Provide an unregister interface for the opal message notifiers
to be called when not needed like during driver unload/remove.

Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Reviewed-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h       |    2 ++
 arch/powerpc/platforms/powernv/opal.c |    7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index eb95b67..70eb45f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -940,6 +940,8 @@ extern int opal_notifier_unregister(struct notifier_block *nb);
 
 extern int opal_message_notifier_register(enum OpalMessageType msg_type,
 						struct notifier_block *nb);
+extern int opal_message_notifier_unregister(enum OpalMessageType msg_type,
+					    struct notifier_block *nb);
 extern void opal_notifier_enable(void);
 extern void opal_notifier_disable(void);
 extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2651e22..6c108ce 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -315,6 +315,13 @@ int opal_message_notifier_register(enum OpalMessageType msg_type,
 				&opal_msg_notifier_head[msg_type], nb);
 }
 
+int opal_message_notifier_unregister(enum OpalMessageType msg_type,
+				     struct notifier_block *nb)
+{
+	return atomic_notifier_chain_unregister(
+			&opal_msg_notifier_head[msg_type], nb);
+}
+
 static void opal_message_do_notify(uint32_t msg_type, void *msg)
 {
 	/* notify subscribers */
