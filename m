Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 05A302C04AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 09:33:19 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Thu, 7 Mar 2013 15:33:14 -0700
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 6C04E1FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 15:28:17 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r27MXAkb316466
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Mar 2013 15:33:10 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r27MX9fY010589
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Mar 2013 15:33:09 -0700
Date: Thu, 7 Mar 2013 14:33:03 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] pseries/iommu: close DDW race between functions of adapter
Message-ID: <20130307223302.GA13208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: miltonm@bga.com, paulus@samba.org, rlary@us.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Given a PCI device with multiple functions in a DDW capable slot, the
following situation can be encountered: When the first function sets a
64-bit DMA mask, enable_ddw() will be called and we can fail to properly
configure DDW (the most common reason being the new DMA window's size is
not large enough to map all of an LPAR's memory). With the recent
changes to DDW, we remove the base window in order to determine if the
new window is of sufficient size to cover an LPAR's memory. We correctly
replace the base window if we find that not to be the case. However,
once we go through and re-configured 32-bit DMA via the IOMMU, the next
function of the adapter will go through the same process. And since DDW
is a characteristic of the slot itself, we are most likely going to fail
again. But to determine we are going to fail the second slot, we again
remove the base window -- but that is now in-use by the first
function/driver, which might be issuing I/O already.

To close this window, keep a list of all the failed struct device_nodes
that have failed to configure DDW. If the current device_node is in that
list, just fail out immediately and fall back to 32-bit DMA without
doing any DDW manipulation.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---

This is pretty ugly, but I couldn't immediately see a better solution.
In particular, I'm not sure there is much we can do if the kzalloc
fails, so I just have it return as normal.

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 1b2a174..86ae364 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -924,6 +924,13 @@ static void restore_default_window(struct pci_dev *dev,
 	__restore_default_window(pci_dev_to_eeh_dev(dev), ddw_restore_token);
 }
 
+struct failed_ddw_pdn {
+	struct device_node *pdn;
+	struct list_head list;
+};
+
+static LIST_HEAD(failed_ddw_pdn_list);
+
 /*
  * If the PE supports dynamic dma windows, and there is space for a table
  * that can map all pages in a linear offset, then setup such a table,
@@ -951,6 +958,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	struct dynamic_dma_window_prop *ddwprop;
 	const void *dma_window = NULL;
 	unsigned long liobn, offset, size;
+	struct failed_ddw_pdn *fpdn;
 
 	mutex_lock(&direct_window_init_mutex);
 
@@ -959,6 +967,18 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 		goto out_unlock;
 
 	/*
+	 * If we already went through this for a previous function of
+	 * the same device and failed, we don't want to muck with the
+	 * DMA window again, as it will race with in-flight operations
+	 * and can lead to EEHs. The above mutex protects access to the
+	 * list.
+	 */
+	list_for_each_entry(fpdn, &failed_ddw_pdn_list, list) {
+		if (!strcmp(fpdn->pdn->full_name, pdn->full_name))
+			goto out_unlock;
+	}
+
+	/*
 	 * the ibm,ddw-applicable property holds the tokens for:
 	 * ibm,query-pe-dma-window
 	 * ibm,create-pe-dma-window
@@ -1114,6 +1134,12 @@ out_restore_window:
 	if (ddw_restore_token)
 		restore_default_window(dev, ddw_restore_token);
 
+	fpdn = kzalloc(sizeof(*fpdn), GFP_KERNEL);
+	if (!fpdn)
+		goto out_unlock;
+	fpdn->pdn = pdn;
+	list_add(&fpdn->list, &failed_ddw_pdn_list);
+
 out_unlock:
 	mutex_unlock(&direct_window_init_mutex);
 	return dma_addr;
