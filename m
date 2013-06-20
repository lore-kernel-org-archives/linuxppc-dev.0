Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6CDE2C037E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:43 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 23:21:41 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2C6441FF0020
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:16:25 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5Ldmg155912
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5LdTI020443
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:39 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/31] powerpc/eeh: I/O chip EEH state retrieval
Date: Thu, 20 Jun 2013 13:21:09 +0800
Message-Id: <1371705681-24632-20-git-send-email-shangw@linux.vnet.ibm.com>
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

The patch adds I/O chip backend to retrieve the state for the
indicated PE. While the PE state is temperarily unavailable,
the upper layer (powernv platform) should return default delay
(1 second).

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c |   99 ++++++++++++++++++++++++++++-
 1 files changed, 98 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 744eb9e..a76870b 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -116,10 +116,107 @@ static int ioda_eeh_set_option(struct eeh_pe *pe, int option)
 	return ret;
 }
 
+/**
+ * ioda_eeh_get_state - Retrieve the state of PE
+ * @pe: EEH PE
+ *
+ * The PE's state should be retrieved from the PEEV, PEST
+ * IODA tables. Since the OPAL has exported the function
+ * to do it, it'd better to use that.
+ */
+static int ioda_eeh_get_state(struct eeh_pe *pe)
+{
+	s64 ret = 0;
+	u8 fstate;
+	u16 pcierr;
+	u32 pe_no;
+	int result;
+	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb = hose->private_data;
+
+	/*
+	 * Sanity check on PE address. The PHB PE address should
+	 * be zero.
+	 */
+	if (pe->addr < 0 || pe->addr >= phb->ioda.total_pe) {
+		pr_err("%s: PE address %x out of range [0, %x] "
+		       "on PHB#%x\n",
+		       __func__, pe->addr, phb->ioda.total_pe,
+		       hose->global_number);
+		return EEH_STATE_NOT_SUPPORT;
+	}
+
+	/* Retrieve PE status through OPAL */
+	pe_no = pe->addr;
+	ret = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
+			&fstate, &pcierr, NULL);
+	if (ret) {
+		pr_err("%s: Failed to get EEH status on "
+		       "PHB#%x-PE#%x\n, err=%lld\n",
+		       __func__, hose->global_number, pe_no, ret);
+		return EEH_STATE_NOT_SUPPORT;
+	}
+
+	/* Check PHB status */
+	if (pe->type & EEH_PE_PHB) {
+		result = 0;
+		result &= ~EEH_STATE_RESET_ACTIVE;
+
+		if (pcierr != OPAL_EEH_PHB_ERROR) {
+			result |= EEH_STATE_MMIO_ACTIVE;
+			result |= EEH_STATE_DMA_ACTIVE;
+			result |= EEH_STATE_MMIO_ENABLED;
+			result |= EEH_STATE_DMA_ENABLED;
+		}
+
+		return result;
+	}
+
+	/* Parse result out */
+	result = 0;
+	switch (fstate) {
+	case OPAL_EEH_STOPPED_NOT_FROZEN:
+		result &= ~EEH_STATE_RESET_ACTIVE;
+		result |= EEH_STATE_MMIO_ACTIVE;
+		result |= EEH_STATE_DMA_ACTIVE;
+		result |= EEH_STATE_MMIO_ENABLED;
+		result |= EEH_STATE_DMA_ENABLED;
+		break;
+	case OPAL_EEH_STOPPED_MMIO_FREEZE:
+		result &= ~EEH_STATE_RESET_ACTIVE;
+		result |= EEH_STATE_DMA_ACTIVE;
+		result |= EEH_STATE_DMA_ENABLED;
+		break;
+	case OPAL_EEH_STOPPED_DMA_FREEZE:
+		result &= ~EEH_STATE_RESET_ACTIVE;
+		result |= EEH_STATE_MMIO_ACTIVE;
+		result |= EEH_STATE_MMIO_ENABLED;
+		break;
+	case OPAL_EEH_STOPPED_MMIO_DMA_FREEZE:
+		result &= ~EEH_STATE_RESET_ACTIVE;
+		break;
+	case OPAL_EEH_STOPPED_RESET:
+		result |= EEH_STATE_RESET_ACTIVE;
+		break;
+	case OPAL_EEH_STOPPED_TEMP_UNAVAIL:
+		result |= EEH_STATE_UNAVAILABLE;
+		break;
+	case OPAL_EEH_STOPPED_PERM_UNAVAIL:
+		result |= EEH_STATE_NOT_SUPPORT;
+		break;
+	default:
+		pr_warning("%s: Unexpected EEH status 0x%x "
+			   "on PHB#%x-PE#%x\n",
+			   __func__, fstate, hose->global_number, pe_no);
+	}
+
+	return result;
+}
+
 struct pnv_eeh_ops ioda_eeh_ops = {
 	.post_init		= ioda_eeh_post_init,
 	.set_option		= ioda_eeh_set_option,
-	.get_state		= NULL,
+	.get_state		= ioda_eeh_get_state,
 	.reset			= NULL,
 	.get_log		= NULL,
 	.configure_bridge	= NULL,
-- 
1.7.5.4
