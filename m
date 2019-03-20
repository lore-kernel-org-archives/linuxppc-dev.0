Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D350C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:12:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B874F2183E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B874F2183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PFMj30ThzDqFC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 14:12:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PF3x5D3ZzDqFM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K2tYXZ005648
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:35 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rbd5pg2ku-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:35 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 20 Mar 2019 02:58:27 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 02:58:25 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K2wU5T48169032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40CB3A4040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A07C6A4051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:29 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:29 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 372FEA03C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:27 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] powerpc/eeh: Remove eeh_probe_devices() and
 eeh_addr_cache_build()
Date: Wed, 20 Mar 2019 13:58:27 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-0020-0000-0000-000003255FE7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-0021-0000-0000-000021777C18
Message-Id: <f43eac2b2adf92848afc3304cabd770c9bc976ce.1553050609.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-20_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903200018
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that EEH support for all devices (on PowerNV and pSeries) is
provided by the pcibios bus add device hooks, eeh_probe_devices() and
eeh_addr_cache_build() are redundant and can be removed.

Note that previously on pSeries, useless EEH sysfs files were created
for some devices that did not have EEH support and this change
prevents them from being created.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  6 ----
 arch/powerpc/kernel/eeh.c                    | 13 --------
 arch/powerpc/kernel/eeh_cache.c              | 32 --------------------
 arch/powerpc/platforms/powernv/eeh-powernv.c |  5 ++-
 arch/powerpc/platforms/pseries/pci.c         |  3 +-
 5 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 791b9e6fcc45..f1eca1757cbc 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -290,13 +290,11 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
 struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
 void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
 void eeh_show_enabled(void);
-void eeh_probe_devices(void);
 int __init eeh_ops_register(struct eeh_ops *ops);
 int __exit eeh_ops_unregister(const char *name);
 int eeh_check_failure(const volatile void __iomem *token);
 int eeh_dev_check_failure(struct eeh_dev *edev);
 void eeh_addr_cache_init(void);
-void eeh_addr_cache_build(void);
 void eeh_add_device_early(struct pci_dn *);
 void eeh_add_device_tree_early(struct pci_dn *);
 void eeh_add_device_late(struct pci_dev *);
@@ -347,8 +345,6 @@ static inline bool eeh_phb_enabled(void)
 	return false;
 }
 
-static inline void eeh_probe_devices(void) { }
-
 static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
 {
 	return NULL;
@@ -365,8 +361,6 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
 
 static inline void eeh_addr_cache_init(void) { }
 
-static inline void eeh_addr_cache_build(void) { }
-
 static inline void eeh_add_device_early(struct pci_dn *pdn) { }
 
 static inline void eeh_add_device_tree_early(struct pci_dn *pdn) { }
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 217e14bb1fb6..cd2abbe41497 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1166,19 +1166,6 @@ static struct notifier_block eeh_reboot_nb = {
 	.notifier_call = eeh_reboot_notifier,
 };
 
-void eeh_probe_devices(void)
-{
-	struct pci_controller *hose, *tmp;
-	struct pci_dn *pdn;
-
-	/* Enable EEH for all adapters */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pdn = hose->pci_data;
-		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
-	}
-	eeh_show_enabled();
-}
-
 /**
  * eeh_init - EEH initialization
  *
diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
index f93dd5cf6a39..c40078d036af 100644
--- a/arch/powerpc/kernel/eeh_cache.c
+++ b/arch/powerpc/kernel/eeh_cache.c
@@ -278,38 +278,6 @@ void eeh_addr_cache_init(void)
 	spin_lock_init(&pci_io_addr_cache_root.piar_lock);
 }
 
-/**
- * eeh_addr_cache_build - Build a cache of I/O addresses
- *
- * Build a cache of pci i/o addresses.  This cache will be used to
- * find the pci device that corresponds to a given address.
- * This routine scans all pci busses to build the cache.
- * Must be run late in boot process, after the pci controllers
- * have been scanned for devices (after all device resources are known).
- */
-void eeh_addr_cache_build(void)
-{
-	struct pci_dn *pdn;
-	struct eeh_dev *edev;
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev) {
-		pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
-		if (!pdn)
-			continue;
-
-		edev = pdn_to_eeh_dev(pdn);
-		if (!edev)
-			continue;
-
-		dev->dev.archdata.edev = edev;
-		edev->pdev = dev;
-
-		eeh_addr_cache_insert_dev(dev);
-		eeh_sysfs_add_device(dev);
-	}
-}
-
 static int eeh_addr_cache_show(struct seq_file *s, void *v)
 {
 	struct pci_io_addr_range *piar;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 81b0923cc55f..6a08f4fab255 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -240,9 +240,7 @@ int pnv_eeh_post_init(void)
 	struct pnv_phb *phb;
 	int ret = 0;
 
-	/* Probe devices & build address cache */
-	eeh_probe_devices();
-	eeh_addr_cache_build();
+	eeh_show_enabled();
 
 	/* Register OPAL event notifier */
 	eeh_event_irq = opal_event_request(ilog2(OPAL_EVENT_PCI_ERROR));
@@ -360,6 +358,7 @@ static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
 	return 0;
 }
 
+
 /**
  * pnv_eeh_probe - Do probe on PCI device
  * @pdn: PCI device node
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 7be80882c08d..7c781b04fb15 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -242,8 +242,7 @@ void __init pSeries_final_fixup(void)
 
 	pSeries_request_regions();
 
-	eeh_probe_devices();
-	eeh_addr_cache_build();
+	eeh_show_enabled();
 #ifdef CONFIG_EEH
 	if (eeh_enabled())
 		eeh_add_flag(EEH_PHB_ENABLED);
-- 
2.19.0.2.gcad72f5712

