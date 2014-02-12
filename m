Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 78A692C00BF
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 18:25:43 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 12 Feb 2014 00:25:41 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A1A8B1FF001A
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:38 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C7PCFx65143010
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 08:25:17 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C7PHPp025970
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Feb 2014 00:25:18 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/eeh: Disable EEH on reboot
Date: Wed, 12 Feb 2014 15:24:56 +0800
Message-Id: <1392189896-18882-3-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1392189896-18882-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1392189896-18882-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We possiblly detect EEH errors during reboot, particularly in kexec
path, but it's impossible for device drivers and EEH core to handle
or recover them properly.

The patch registers one reboot notifier for EEH and disable EEH
subsystem during reboot. That means the EEH errors is going to be
cleared by hardware reset or second kernel during early stage of
PCI probe.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c                 |   20 ++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-ioda.c |    3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index f22f7b6..e7b76a6 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -28,6 +28,7 @@
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
+#include <linux/reboot.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/export.h>
@@ -747,6 +748,17 @@ int __exit eeh_ops_unregister(const char *name)
 	return -EEXIST;
 }
 
+static int eeh_reboot_notifier(struct notifier_block *nb,
+			       unsigned long action, void *unused)
+{
+	eeh_set_enable(false);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block eeh_reboot_nb = {
+	.notifier_call = eeh_reboot_notifier,
+};
+
 /**
  * eeh_init - EEH initialization
  *
@@ -778,6 +790,14 @@ int eeh_init(void)
 	if (machine_is(powernv) && cnt++ <= 0)
 		return ret;
 
+	/* Register reboot notifier */
+	ret = register_reboot_notifier(&eeh_reboot_nb);
+	if (ret) {
+		pr_warn("%s: Failed to register notifier (%d)\n",
+			__func__, ret);
+		return ret;
+	}
+
 	/* call platform initialization function */
 	if (!eeh_ops) {
 		pr_warning("%s: Platform EEH operation not found\n",
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index fcb79cf..f514743 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -44,7 +44,8 @@ static int ioda_eeh_event(struct notifier_block *nb,
 
 	/* We simply send special EEH event */
 	if ((changed_evts & OPAL_EVENT_PCI_ERROR) &&
-	    (events & OPAL_EVENT_PCI_ERROR))
+	    (events & OPAL_EVENT_PCI_ERROR) &&
+	    eeh_enabled())
 		eeh_send_failure_event(NULL);
 
 	return 0;
-- 
1.7.10.4
