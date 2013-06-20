Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 16E3B2C0385
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:22:08 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 01:22:06 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 60DA36E8044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:22:01 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5LZaI65667160
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 01:21:35 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LYei003567
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 02:21:34 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/31] powerpc/eeh: Export confirm_error_lock
Date: Thu, 20 Jun 2013 13:21:03 +0800
Message-Id: <1371705681-24632-14-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An EEH event is created and queued to the event queue for each
ingress EEH error. When there're mutiple EEH errors, we need serialize
the process to keep consistent PE state (flags). The spinlock
"confirm_error_lock" was introduced for the purpose. We'll inject
EEH event upon error reporting interrupts on PowerNV platform. So
we export the spinlock for that to use for consistent PE state.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h |   11 +++++++++++
 arch/powerpc/kernel/eeh.c      |   10 ++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e1109fd..0c0ac93 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -150,6 +150,7 @@ struct eeh_ops {
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
 extern struct mutex eeh_mutex;
+extern raw_spinlock_t confirm_error_lock;
 extern int eeh_probe_mode;
 
 #define EEH_PROBE_MODE_DEV	(1<<0)	/* From PCI device	*/
@@ -180,6 +181,16 @@ static inline void eeh_unlock(void)
 	mutex_unlock(&eeh_mutex);
 }
 
+static inline void eeh_serialize_lock(unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&confirm_error_lock, *flags);
+}
+
+static inline void eeh_serialize_unlock(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+}
+
 /*
  * Max number of EEH freezes allowed before we consider the device
  * to be permanently disabled.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 777ecc0..81cd031 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -107,7 +107,7 @@ int eeh_probe_mode;
 DEFINE_MUTEX(eeh_mutex);
 
 /* Lock to avoid races due to multiple reports of an error */
-static DEFINE_RAW_SPINLOCK(confirm_error_lock);
+DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
 /* Buffer for reporting pci register dumps. Its here in BSS, and
  * not dynamically alloced, so that it ends up in RMO where RTAS
@@ -325,7 +325,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * in one slot might report errors simultaneously, and we
 	 * only want one error recovery routine running.
 	 */
-	raw_spin_lock_irqsave(&confirm_error_lock, flags);
+	eeh_serialize_lock(&flags);
 	rc = 1;
 	if (pe->state & EEH_PE_ISOLATED) {
 		pe->check_count++;
@@ -374,7 +374,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	 * bridges.
 	 */
 	eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
-	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+	eeh_serialize_unlock(flags);
 
 	eeh_send_failure_event(pe);
 
@@ -386,7 +386,7 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 	return 1;
 
 dn_unlock:
-	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+	eeh_serialize_unlock(flags);
 	return rc;
 }
 
@@ -702,8 +702,6 @@ int __init eeh_init(void)
 		return ret;
 	}
 
-	raw_spin_lock_init(&confirm_error_lock);
-
 	/* Initialize EEH event */
 	ret = eeh_event_init();
 	if (ret)
-- 
1.7.5.4
