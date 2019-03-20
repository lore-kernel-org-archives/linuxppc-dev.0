Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CC4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:05:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D93020857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 03:05:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D93020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PFCX15jhzDqHH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 14:05:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=sbobroff@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PF3w6QvrzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:36 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2K2s9ne103201
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:34 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rbcas9yrc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 22:58:34 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Wed, 20 Mar 2019 02:58:26 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Mar 2019 02:58:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2K2wSgm57475218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA2334203F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3631D42042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 02:58:28 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2BB8CA0321
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 13:58:27 +1100 (AEDT)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/8] powerpc/eeh: Convert PNV_PHB_FLAG_EEH to global flag
Date: Wed, 20 Mar 2019 13:58:22 +1100
X-Mailer: git-send-email 2.19.0.2.gcad72f5712
In-Reply-To: <cover.1553050609.git.sbobroff@linux.ibm.com>
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032002-4275-0000-0000-0000031D0E4C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032002-4276-0000-0000-0000382B9073
Message-Id: <17f0dc9c30a139f19dceefd09689d34c3ad01a17.1553050609.git.sbobroff@linux.ibm.com>
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

The PHB flag, PNV_PHB_FLAG_EEH, is set (on PowerNV) individually on
each PHB once the EEH subsystem is ready. It is the only use of the
flags member of the phb struct.

However there is no need to store this separately on each PHB, so
convert it to a global flag. For symmetry, the flag is now also set
for pSeries; although it is currently unused it may be useful in the
future.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               | 11 +++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++-----------
 arch/powerpc/platforms/powernv/pci.c         |  7 +++----
 arch/powerpc/platforms/powernv/pci.h         |  2 --
 arch/powerpc/platforms/pseries/pci.c         |  4 ++++
 5 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 3613a56281f2..fe4cf7208890 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -43,6 +43,7 @@ struct pci_dn;
 #define EEH_VALID_PE_ZERO	0x10	/* PE#0 is valid		     */
 #define EEH_ENABLE_IO_FOR_LOG	0x20	/* Enable IO for log		     */
 #define EEH_EARLY_DUMP_LOG	0x40	/* Dump log immediately		     */
+#define EEH_PHB_ENABLED		0x80	/* PHB recovery uses EEH	     */
 
 /*
  * Delay for PE reset, all in ms
@@ -245,6 +246,11 @@ static inline bool eeh_enabled(void)
 	return eeh_has_flag(EEH_ENABLED) && !eeh_has_flag(EEH_FORCE_DISABLED);
 }
 
+static inline bool eeh_phb_enabled(void)
+{
+	return eeh_has_flag(EEH_PHB_ENABLED);
+}
+
 static inline void eeh_serialize_lock(unsigned long *flags)
 {
 	raw_spin_lock_irqsave(&confirm_error_lock, *flags);
@@ -332,6 +338,11 @@ static inline bool eeh_enabled(void)
         return false;
 }
 
+static inline bool eeh_phb_enabled(void)
+{
+	return false;
+}
+
 static inline void eeh_probe_devices(void) { }
 
 static inline void *eeh_dev_init(struct pci_dn *pdn, void *data)
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 6fc1a463b796..f0a95f663810 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -264,22 +264,14 @@ int pnv_eeh_post_init(void)
 		return ret;
 	}
 
-	if (!eeh_enabled())
+	if (eeh_enabled())
+		eeh_add_flag(EEH_PHB_ENABLED);
+	else
 		disable_irq(eeh_event_irq);
 
 	list_for_each_entry(hose, &hose_list, list_node) {
 		phb = hose->private_data;
 
-		/*
-		 * If EEH is enabled, we're going to rely on that.
-		 * Otherwise, we restore to conventional mechanism
-		 * to clear frozen PE during PCI config access.
-		 */
-		if (eeh_enabled())
-			phb->flags |= PNV_PHB_FLAG_EEH;
-		else
-			phb->flags &= ~PNV_PHB_FLAG_EEH;
-
 		/* Create debugfs entries */
 #ifdef CONFIG_DEBUG_FS
 		if (phb->has_dbgfs || !phb->dbgfs)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 307181fd8a17..d2b50f3bf6b1 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -717,10 +717,9 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = NULL;
-	struct pnv_phb *phb = pdn->phb->private_data;
 
 	/* EEH not enabled ? */
-	if (!(phb->flags & PNV_PHB_FLAG_EEH))
+	if (!eeh_phb_enabled())
 		return true;
 
 	/* PE reset or device removed ? */
@@ -761,7 +760,7 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 
 	ret = pnv_pci_cfg_read(pdn, where, size, val);
 	phb = pdn->phb->private_data;
-	if (phb->flags & PNV_PHB_FLAG_EEH && pdn->edev) {
+	if (eeh_phb_enabled() && pdn->edev) {
 		if (*val == EEH_IO_ERROR_VALUE(size) &&
 		    eeh_dev_check_failure(pdn->edev))
                         return PCIBIOS_DEVICE_NOT_FOUND;
@@ -789,7 +788,7 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 
 	ret = pnv_pci_cfg_write(pdn, where, size, val);
 	phb = pdn->phb->private_data;
-	if (!(phb->flags & PNV_PHB_FLAG_EEH))
+	if (!eeh_phb_enabled())
 		pnv_pci_config_check_eeh(pdn);
 
 	return ret;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8e36da379252..eb0add61397b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -85,8 +85,6 @@ struct pnv_ioda_pe {
 	struct list_head	list;
 };
 
-#define PNV_PHB_FLAG_EEH	(1 << 0)
-
 struct pnv_phb {
 	struct pci_controller	*hose;
 	enum pnv_phb_type	type;
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 37a77e57893e..7be80882c08d 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -244,6 +244,10 @@ void __init pSeries_final_fixup(void)
 
 	eeh_probe_devices();
 	eeh_addr_cache_build();
+#ifdef CONFIG_EEH
+	if (eeh_enabled())
+		eeh_add_flag(EEH_PHB_ENABLED);
+#endif
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_sriov_enable = pseries_pcibios_sriov_enable;
-- 
2.19.0.2.gcad72f5712

