Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50AEA2C02C8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:34:55 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 03:34:53 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 7A059C90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 03:34:50 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r557Yorg299874
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 03:34:50 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r557Yo4D025178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 04:34:50 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 22/27] powerpc/eeh: Allow to check fenced PHB proactively
Date: Wed,  5 Jun 2013 15:34:23 +0800
Message-Id: <1370417668-16832-23-git-send-email-shangw@linux.vnet.ibm.com>
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

It's meaningless to handle frozen PE if we already had fenced PHB.
The patch intends to check the PHB state before checking PE. If the
PHB has been put into fenced state, we need take care of that firstly.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c |   61 ++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index a42b410..1daff1e 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -269,6 +269,59 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 	return pa | (token & (PAGE_SIZE-1));
 }
 
+/*
+ * On PowerNV platform, we might already have fenced PHB there.
+ * For that case, it's meaningless to recover frozen PE. Intead,
+ * We have to handle fenced PHB firstly.
+ */
+static int eeh_phb_check_failure(struct eeh_pe *pe, int flag)
+{
+	struct eeh_pe *phb_pe;
+	unsigned long flags;
+	int ret;
+
+	if (!eeh_probe_mode_dev())
+		return -EPERM;
+
+	/* Find the PHB PE */
+	raw_spin_lock_irqsave(&confirm_error_lock, flags);
+	phb_pe = eeh_phb_pe_get(pe->phb);
+	if (!phb_pe) {
+		pr_warning("%s Can't find PE for PHB#%d\n",
+			__func__, pe->phb->global_number);
+		ret = -EEXIST;
+		goto out;
+	}
+
+	/* If the PHB has been in problematic state */
+	if (phb_pe->state & EEH_PE_ISOLATED) {
+		ret = 2;
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
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+	eeh_send_failure_event(phb_pe, flag);
+
+	WARN(1, "EEH: PHB failure detected\n");
+
+	return 1;
+out:
+	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
+	return ret;
+}
+
 /**
  * eeh_dev_check_failure - Check if all 1's data is due to EEH slot freeze
  * @edev: eeh device
@@ -320,6 +373,14 @@ int eeh_dev_check_failure(struct eeh_dev *edev, int flag)
 		return 0;
 	}
 
+	/*
+	 * On PowerNV platform, we might already have fenced PHB
+	 * there and we need take care of that firstly.
+	 */
+	ret = eeh_phb_check_failure(pe, flag);
+	if (ret > 0)
+		return ret;
+
 	/* If we already have a pending isolation event for this
 	 * slot, we know it's bad already, we don't need to check.
 	 * Do this checking under a lock; as multiple PCI devices
-- 
1.7.5.4
