Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1BEF82C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:04:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:04:10 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 797CCC90044
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:37 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93b5e25624656
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93bUP009659
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:37 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 25/27] powerpc/eeh: Register OPAL notifier for PCI error
Date: Sat, 15 Jun 2013 17:03:16 +0800
Message-Id: <1371286998-2842-26-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
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
will be invoked to handle that in turn.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-err.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-err.c b/arch/powerpc/platforms/powernv/pci-err.c
index e54135b..9b5c4ae 100644
--- a/arch/powerpc/platforms/powernv/pci-err.c
+++ b/arch/powerpc/platforms/powernv/pci-err.c
@@ -425,6 +425,13 @@ static void pci_err_process(struct pci_controller *hose,
 	}
 }
 
+static void pci_err_event(u64 event)
+{
+	/* Notify kthread to process error */
+	if (event & OPAL_EVENT_PCI_ERROR)
+		up(&pci_err_int_sem);
+}
+
 static int pci_err_handler(void *dummy)
 {
 	struct pnv_phb *phb;
@@ -513,6 +520,16 @@ static int __init pci_err_init(void)
 		return ret;
 	}
 
+	/* Register OPAL event notifier */
+	ret = opal_notifier_register(OPAL_EVENT_PCI_ERROR, pci_err_event);
+	if (ret) {
+		kthread_stop(pci_err_thread);
+		free_page((unsigned long)pci_err_diag);
+		pr_err("%s: Failed to register OPAL notifier, rc=%d\n",
+		        __func__, ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
1.7.5.4
