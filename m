Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B34752C04C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 18:45:20 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 18 Jun 2013 02:34:33 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2D3A838C8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:30 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5I8YUWk66387978
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5I8YSdx018030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 04:34:30 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 26/31] powerpc/eeh: Allow to check fenced PHB proactively
Date: Tue, 18 Jun 2013 16:33:50 +0800
Message-Id: <1371544435-4943-27-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371544435-4943-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's meaningless to handle frozen PE if we already had fenced PHB.
The patch intends to check the PHB state before checking PE. If the
PHB has been put into fenced state, we need take care of that firstly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 81cd031..7c567be 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -269,6 +269,58 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+/*
+ * On PowerNV platform, we might already have fenced PHB there.
+ * For that case, it's meaningless to recover frozen PE. Intead,
+ * We have to handle fenced PHB firstly.
+ */
+static int eeh_phb_check_failure(struct eeh_pe *pe)
+{
+	struct eeh_pe *phb_pe;
+	unsigned long flags;
+	int ret;
+
+	if (!eeh_probe_mode_dev())
+		return -EPERM;
+
+	/* Find the PHB PE */
+	phb_pe = eeh_phb_pe_get(pe->phb);
+	if (!phb_pe) {
+		pr_warning("%s Can't find PE for PHB#%d\n",
+			   __func__, pe->phb->global_number);
+		return -EEXIST;
+	}
+
+	/* If the PHB has been in problematic state */
+	eeh_serialize_lock(&flags);
+	if (phb_pe->state & (EEH_PE_ISOLATED | EEH_PE_PHB_DEAD)) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Check PHB state */
+	ret = eeh_ops->get_state(phb_pe, NULL);
+	if ((ret < 0) ||
+	    (ret == EEH_STATE_NOT_SUPPORT) ||
+	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
+	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Isolate the PHB and send event */
+	eeh_pe_state_mark(phb_pe, EEH_PE_ISOLATED);
+	eeh_serialize_unlock(flags);
+	eeh_send_failure_event(phb_pe);
+
+	WARN(1, "EEH: PHB failure detected\n");
+
+	return 1;
+out:
+	eeh_serialize_unlock(flags);
+	return ret;
+}
+
 /**
  * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
  * @edev: eeh device
@@ -319,6 +371,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev)
 		return 0;
 	}
 
+	/*
+	 * On PowerNV platform, we might already have fenced PHB
+	 * there and we need take care of that firstly.
+	 */
+	ret = eeh_phb_check_failure(pe);
+	if (ret > 0)
+		return ret;
+
 	/* If we already have a pending isolation event for this
 	 * slot, we know it's bad already, we don't need to check.
 	 * Do this checking under a lock; as multiple PCI devices
-- 
1.7.5.4
