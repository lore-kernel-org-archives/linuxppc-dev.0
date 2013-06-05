Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13EBF2C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:58 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 03:34:56 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CF6926E8039
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 03:34:49 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557YqDK57278678
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557YphL002758
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:52 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/27] powerpc/eeh: Register OPAL notifier for PCI error
Date: Wed,  5 Jun 2013 15:34:26 +0800
Message-Id: <1370417668-16832-26-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to register OPAL event notifier and process the
PCI errors from firmware. If we have pending PCI errors, the kthread
will be invoke to handle that in turn.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-err.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-err.c b/arch/powerpc/platforms/powernv/pci-err.c
index bfc95c6..d77dd61 100644
--- a/arch/powerpc/platforms/powernv/pci-err.c
+++ b/arch/powerpc/platforms/powernv/pci-err.c
@@ -64,6 +64,12 @@ static struct semaphore pci_err_int_sem;
 static struct semaphore pci_err_seq_sem;
 static char *pci_err_diag;
 
+static void pci_err_event(u64 event)
+{
+	/* Notify kthread to process error */
+	up(&pci_err_int_sem);
+}
+
 static void pci_err_take(void)
 {
 	down(&pci_err_seq_sem);
@@ -451,6 +457,14 @@ static int __init pci_err_init(void)
 	sema_init(&pci_err_int_sem, 0);
 	sema_init(&pci_err_seq_sem, 1);
 
+	/* Register OPAL event notifier */
+	ret = opal_notifier_register(OPAL_EVENT_PCI_ERROR, pci_err_event);
+	if (ret) {
+		pr_err("%s: Failed to register OPAL notifier, rc=%d\n",
+			__func__, ret);
+		goto out;
+	}
+
 	/* Start kthread */
 	pci_err_thread = kthread_run(pci_err_handler, NULL, "PCI_ERR");
 	if (IS_ERR(pci_err_thread)) {
@@ -459,6 +473,7 @@ static int __init pci_err_init(void)
 			__func__, ret);
 	}
 
+out:
 	free_page((unsigned long)pci_err_diag);
 	return ret;
 }
-- 
1.7.5.4
