Return-Path: <sbobroff@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bT7J3c8mzF2Rl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:35:56 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w426Y7mU047327
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 02:35:54 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hq6gx3qwp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:35:53 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 2 May 2018 07:35:52 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w426ZnG95898618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 May 2018 06:35:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8130211C058
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:25 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE48811C052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:24 +0100 (BST)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 07:27:24 +0100 (BST)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B139EA01B8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 16:35:46 +1000 (AEST)
Date: Wed, 2 May 2018 16:35:45 +1000
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/13] powerpc/eeh: Strengthen types of eeh traversal functions
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1525242772.git.sbobroff@linux.ibm.com>
Message-Id: <4d86d04e2c48a80e604e790c48d6a608c5d45498.1525242772.git.sbobroff@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The traversal functions eeh_pe_traverse() and eeh_pe_dev_traverse()
both provide their first argument as void * but every single user casts
it to the expected type.

Change the type of the first parameter from void * to the appropriate
type, and clean up all uses.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |  7 ++++---
 arch/powerpc/kernel/eeh.c        | 13 +++++--------
 arch/powerpc/kernel/eeh_driver.c | 30 ++++++++++--------------------
 arch/powerpc/kernel/eeh_pe.c     | 19 +++++++------------
 4 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c2266ca61853..f02e0400e6f2 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -262,7 +262,8 @@ static inline bool eeh_state_active(int state)
 	== (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE);
 }
 
-typedef void *(*eeh_traverse_func)(void *data, void *flag);
+typedef void *(*eeh_edev_traverse_func)(struct eeh_dev *edev, void *flag);
+typedef void *(*eeh_pe_traverse_func)(struct eeh_pe *pe, void *flag);
 void eeh_set_pe_aux_size(int size);
 int eeh_phb_pe_create(struct pci_controller *phb);
 struct eeh_pe *eeh_phb_pe_get(struct pci_controller *phb);
@@ -272,9 +273,9 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev);
 int eeh_rmv_from_parent_pe(struct eeh_dev *edev);
 void eeh_pe_update_time_stamp(struct eeh_pe *pe);
 void *eeh_pe_traverse(struct eeh_pe *root,
-		eeh_traverse_func fn, void *flag);
+		      eeh_pe_traverse_func fn, void *flag);
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
-		eeh_traverse_func fn, void *flag);
+			  eeh_edev_traverse_func fn, void *flag);
 void eeh_pe_restore_bars(struct eeh_pe *pe);
 const char *eeh_pe_loc_get(struct eeh_pe *pe);
 struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bc640e4c5ca5..f82dade4fb9a 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -263,9 +263,8 @@ static size_t eeh_dump_dev_log(struct eeh_dev *edev, char *buf, size_t len)
 	return n;
 }
 
-static void *eeh_dump_pe_log(void *data, void *flag)
+static void *eeh_dump_pe_log(struct eeh_pe *pe, void *flag)
 {
-	struct eeh_pe *pe = data;
 	struct eeh_dev *edev, *tmp;
 	size_t *plen = flag;
 
@@ -686,9 +685,9 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
 	return rc;
 }
 
-static void *eeh_disable_and_save_dev_state(void *data, void *userdata)
+static void *eeh_disable_and_save_dev_state(struct eeh_dev *edev,
+					    void *userdata)
 {
-	struct eeh_dev *edev = data;
 	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
 	struct pci_dev *dev = userdata;
 
@@ -714,9 +713,8 @@ static void *eeh_disable_and_save_dev_state(void *data, void *userdata)
 	return NULL;
 }
 
-static void *eeh_restore_dev_state(void *data, void *userdata)
+static void *eeh_restore_dev_state(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = data;
 	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 	struct pci_dev *pdev = eeh_dev_to_pci_dev(edev);
 	struct pci_dev *dev = userdata;
@@ -856,11 +854,10 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
  * the indicated device and its children so that the bunch of the
  * devices could be reset properly.
  */
-static void *eeh_set_dev_freset(void *data, void *flag)
+static void *eeh_set_dev_freset(struct eeh_dev *edev, void *flag)
 {
 	struct pci_dev *dev;
 	unsigned int *freset = (unsigned int *)flag;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 
 	dev = eeh_dev_to_pci_dev(edev);
 	if (dev)
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index ca9a73fe9cc5..188d15c4fe3a 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -149,9 +149,8 @@ static bool eeh_dev_removed(struct eeh_dev *edev)
 	return false;
 }
 
-static void *eeh_dev_save_state(void *data, void *userdata)
+static void *eeh_dev_save_state(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = data;
 	struct pci_dev *pdev;
 
 	if (!edev)
@@ -184,9 +183,8 @@ static void *eeh_dev_save_state(void *data, void *userdata)
  * merge the device driver responses. Cumulative response
  * passed back in "userdata".
  */
-static void *eeh_report_error(void *data, void *userdata)
+static void *eeh_report_error(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
@@ -231,9 +229,8 @@ static void *eeh_report_error(void *data, void *userdata)
  * are now enabled. Collects up and merges the device driver responses.
  * Cumulative response passed back in "userdata".
  */
-static void *eeh_report_mmio_enabled(void *data, void *userdata)
+static void *eeh_report_mmio_enabled(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
@@ -273,9 +270,8 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
  * some actions, usually to save data the driver needs so that the
  * driver can work again while the device is recovered.
  */
-static void *eeh_report_reset(void *data, void *userdata)
+static void *eeh_report_reset(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	enum pci_ers_result rc, *res = userdata;
 	struct pci_driver *driver;
@@ -310,9 +306,8 @@ static void *eeh_report_reset(void *data, void *userdata)
 	return NULL;
 }
 
-static void *eeh_dev_restore_state(void *data, void *userdata)
+static void *eeh_dev_restore_state(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = data;
 	struct pci_dev *pdev;
 
 	if (!edev)
@@ -348,9 +343,8 @@ static void *eeh_dev_restore_state(void *data, void *userdata)
  * could resume so that the device driver can do some initialization
  * to make the recovered device work again.
  */
-static void *eeh_report_resume(void *data, void *userdata)
+static void *eeh_report_resume(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	bool was_in_error;
 	struct pci_driver *driver;
@@ -397,9 +391,8 @@ static void *eeh_report_resume(void *data, void *userdata)
  * This informs the device driver that the device is permanently
  * dead, and that no further recovery attempts will be made on it.
  */
-static void *eeh_report_failure(void *data, void *userdata)
+static void *eeh_report_failure(struct eeh_dev *edev, void *userdata)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct pci_driver *driver;
 
@@ -457,10 +450,9 @@ static void *eeh_add_virt_device(void *data, void *userdata)
 	return NULL;
 }
 
-static void *eeh_rmv_device(void *data, void *userdata)
+static void *eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 {
 	struct pci_driver *driver;
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	struct eeh_rmv_data *rmv_data = (struct eeh_rmv_data *)userdata;
 	int *removed = rmv_data ? &rmv_data->removed : NULL;
@@ -532,9 +524,8 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	return NULL;
 }
 
-static void *eeh_pe_detach_dev(void *data, void *userdata)
+static void *eeh_pe_detach_dev(struct eeh_pe *pe, void *userdata)
 {
-	struct eeh_pe *pe = (struct eeh_pe *)data;
 	struct eeh_dev *edev, *tmp;
 
 	eeh_pe_for_each_dev(pe, edev, tmp) {
@@ -555,9 +546,8 @@ static void *eeh_pe_detach_dev(void *data, void *userdata)
  * PE reset (for 3 times), we try to clear the frozen state
  * for 3 times as well.
  */
-static void *__eeh_clear_pe_frozen_state(void *data, void *flag)
+static void *__eeh_clear_pe_frozen_state(struct eeh_pe *pe, void *flag)
 {
-	struct eeh_pe *pe = (struct eeh_pe *)data;
 	bool clear_sw_state = *(bool *)flag;
 	int i, rc = 1;
 
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index ee5a67d57aab..38a4bcd8ed13 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -173,7 +173,7 @@ static struct eeh_pe *eeh_pe_next(struct eeh_pe *pe,
  * to be traversed.
  */
 void *eeh_pe_traverse(struct eeh_pe *root,
-		      eeh_traverse_func fn, void *flag)
+		      eeh_pe_traverse_func fn, void *flag)
 {
 	struct eeh_pe *pe;
 	void *ret;
@@ -196,7 +196,7 @@ void *eeh_pe_traverse(struct eeh_pe *root,
  * PE and its child PEs.
  */
 void *eeh_pe_dev_traverse(struct eeh_pe *root,
-		eeh_traverse_func fn, void *flag)
+			  eeh_edev_traverse_func fn, void *flag)
 {
 	struct eeh_pe *pe;
 	struct eeh_dev *edev, *tmp;
@@ -235,9 +235,8 @@ struct eeh_pe_get_flag {
 	int config_addr;
 };
 
-static void *__eeh_pe_get(void *data, void *flag)
+static void *__eeh_pe_get(struct eeh_pe *pe, void *flag)
 {
-	struct eeh_pe *pe = (struct eeh_pe *)data;
 	struct eeh_pe_get_flag *tmp = (struct eeh_pe_get_flag *) flag;
 
 	/* Unexpected PHB PE */
@@ -551,9 +550,8 @@ void eeh_pe_update_time_stamp(struct eeh_pe *pe)
  * PE. Also, the associated PCI devices will be put into IO frozen
  * state as well.
  */
-static void *__eeh_pe_state_mark(void *data, void *flag)
+static void *__eeh_pe_state_mark(struct eeh_pe *pe, void *flag)
 {
-	struct eeh_pe *pe = (struct eeh_pe *)data;
 	int state = *((int *)flag);
 	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
@@ -595,9 +593,8 @@ void eeh_pe_state_mark(struct eeh_pe *pe, int state)
 }
 EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
 
-static void *__eeh_pe_dev_mode_mark(void *data, void *flag)
+static void *__eeh_pe_dev_mode_mark(struct eeh_dev *edev, void *flag)
 {
-	struct eeh_dev *edev = data;
 	int mode = *((int *)flag);
 
 	edev->mode |= mode;
@@ -625,9 +622,8 @@ void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode)
  * given PE. Besides, we also clear the check count of the PE
  * as well.
  */
-static void *__eeh_pe_state_clear(void *data, void *flag)
+static void *__eeh_pe_state_clear(struct eeh_pe *pe, void *flag)
 {
-	struct eeh_pe *pe = (struct eeh_pe *)data;
 	int state = *((int *)flag);
 	struct eeh_dev *edev, *tmp;
 	struct pci_dev *pdev;
@@ -858,9 +854,8 @@ static void eeh_restore_device_bars(struct eeh_dev *edev)
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
  */
-static void *eeh_restore_one_device_bars(void *data, void *flag)
+static void *eeh_restore_one_device_bars(struct eeh_dev *edev, void *flag)
 {
-	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dn *pdn = eeh_dev_to_pdn(edev);
 
 	/* Do special restore for bridges */
-- 
2.16.1.74.g9b0b1f47b
