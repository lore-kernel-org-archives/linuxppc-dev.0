Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC7741A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 17:29:36 +1100 (AEDT)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Wed, 11 Feb 2015 11:59:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0E3673940048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:59:32 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1B6TVgN63766568
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:59:31 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1B6TVh2025692
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 11:59:31 +0530
Subject: [PATCH 2/2] opal: Add message notifier unregister function
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Wed, 11 Feb 2015 11:57:23 +0530
Message-ID: <20150211062712.3279.93469.stgit@localhost.localdomain>
In-Reply-To: <20150211062616.3279.71632.stgit@localhost.localdomain>
References: <20150211062616.3279.71632.stgit@localhost.localdomain>
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
