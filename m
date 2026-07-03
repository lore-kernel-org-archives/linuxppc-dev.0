Return-Path: <linuxppc-dev+bounces-23465-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F7EC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 08:01:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs5n95WV3z2xdb;
	Fri, 03 Jul 2026 18:01:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783065709;
	cv=none; b=juLGHqFy6lG++1qh0pEYrLr63VhquOceJm9kZwO2Hqf6CxRmALeCyhYe9gMEeeQe7+SI6zRJb3CDWIUJ8p/T5fC81jQmtljUqIXSvRLzA5B38xd0U4m7J6No20ArB3QVaOfA82x8kLbO2fbBJHsrKdrkxeu3IKrBQTNntFMJAGgI5YRMP1m+VEZ5NqpeU4LIW+wedtfYgX/m0xcmjyKHbhezSIPjcYrVgiHILRUvRk7BFYlYwr6aWJmvCipbdAdBMKr9OWFB6Jev87OLg2B/G6XSXtlWDkWm2E7u+NJdyIVolLMZgTZtDtUvTPJzK8B0vDqnzY/Q0heewKgH+k/5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783065709; c=relaxed/relaxed;
	bh=EHtNGkXBjS/m7GrE1oE5FvRgK6kKG2ZwSsq2xQOBZdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BManpsVW2aCAB3z/ycs9AZSGeB+GfWNpUM2nE0pNVJkzgV/3ZaDfnJbTeInatNnlsDalikDQxGy3U2qHWq8T4RcOvAr06ewi1MVQxPgoBndbEm8FFxsETPYK9FLAx3exNsV3v84fSMItm3tBmCk3rcEayWMAWV3HgZv4jvQKkwARFJIewL0a/UyLUzlTA7n3lD1kWCtWboFiyC0841RAtmDdSHHYe9Xtd4R8v08WokqDLp+apr0wPQ63KJ/SkNiL6GZfmuw9uKiGe18rVFKVxjuOthsp+SHot872vjYuKitD1GYTT15HcK2hNp7ruOYfcNEMV6l8ytwqbOPcIQ6UaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZLnuRaSj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ZLnuRaSj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs5n84cMrz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 18:01:47 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6636IBUH1930356;
	Fri, 3 Jul 2026 08:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=EHtNGkXBjS/m7GrE1oE5FvRgK6kKG2ZwSsq2xQOBZ
	dI=; b=ZLnuRaSj/0enCAMlUYdDA6U5dTRvOrn7Bgle0I8zePDX7ZhLRgzojR+Cj
	LFC9RoMZtEedxRp1fYDCGri7nXZj4YQtixYtM8UxRydGaVb2gyf51cqAXsSzenLE
	GbvS009LrHL9kppRT6cYbSM/RV/27kiZkyRjV4d28LmYgZ9CEfNbKsf8nXR7qdDt
	+EgCuYRr5IiQk7TjOMQuFVo7dGPkCnjlWxduA+OLkUZQLSDg5ufXd1dJUAt23AQo
	i5NoVWKhdO0rdmdgR9xpQNsJcKkRrAq8iqpwfoCPyh6fJuYZOrfDzkb9E39DnrHy
	dSIJgV+zJsU04AiGoMx5IcGHhPN3g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pee6ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:01:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6637YdZ5015771;
	Fri, 3 Jul 2026 08:01:31 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqr2jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jul 2026 08:01:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66381R3L33816856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jul 2026 08:01:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46B2720043;
	Fri,  3 Jul 2026 08:01:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6722004E;
	Fri,  3 Jul 2026 08:01:24 +0000 (GMT)
Received: from ltcd48-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Jul 2026 08:01:24 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Cc: oohall@gmail.com, npiggin@gmail.com, chleroy@kernel.org,
        nnmlinux@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
Subject: [PATCH 1/1] powerpc/eeh: Prevent EEH false positives on PMCSR reads in D3cold
Date: Thu,  2 Jul 2026 23:36:49 -0400
Message-ID: <20260703033649.41633-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VeLq9wx7fTfM78I7wbjuv5YPf_tPwka8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfXxMS+xiSVsrYZ
 VII46PD1TX2xLdHDvki6XwSBhk6PPMlB7kxEMjv78Yp69FXrHzUMSk58BJDd8kIoTIfgPdCJn89
 0Xt7N77CKkioFa8elOOmoHJji0aJ/Lw=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a476c5c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=-mcfluX0F-qhFAC7NC0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3MyBTYWx0ZWRfX1vb4LAe6FBDE
 MzNHKyslTa80YkRuVpIpKC71LeZAW9KS1C2z0KpQAwAGcrEz77lsoS+gQsQjebDQyo5LtCLB3s2
 D+hlmZuG/EsnI0wur//jkFKx156IEwX2XN75YzjRL8781ZbF6q5Dr/Icm0a6GCG8af3yK9A5XNc
 gCCAJyWK2zF98DA9rer/y0l9kxKP6R8TmyqJkDIMcvdgtXIafLJg0SutnW/uZ22G/C2ZQBHTlj1
 FIUak7ftCBrZf7CZ60fjRmq0SLiO4hu0NigC7SwRJiNultPeVPcOnFd+YWBcPwIgJ8My548fwBd
 kq3o/cGg959o6OWvA/VJFGiL+YsA4onSY27VhEEatwUy4ONX4xOjFYBLBrC61YwKbG7/MaHo/+E
 MD9Fb3tzuZNrTgV85JEOw/ZmdI1c6OmHTg0ob2k4JXQa84LZ5ivmkr7HHMknhw3H7Nt8Gb/Ezr8
 JPGo/On0yQftFCZn0ag==
X-Proofpoint-ORIG-GUID: lAy3IuutBfvwWrZB710FhILr3wqtE7Vz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030073

On pseries systems, RTAS-based PCI config space reads can trigger
false EEH events when attempting to read the Power Management Control
Status Register (PMCSR) while a device is in D3cold state. This occurs
because the device is powered off and cannot respond to config space
accesses, causing the platform to report an error condition.

This patch addresses the issue by:

1. Caching PM capability information in struct eeh_dev:
   - pm_cap: Offset of the PM capability structure
   - pmcsr_offset: Absolute config space offset of PMCSR register

2. Synchronizing PM capability data between pci_dev and eeh_dev:
   - During device probe (eeh_probe_device), copy pm_cap from pci_dev
   - During early init (pseries_eeh_init_edev), discover pm_cap via
     firmware before pci_dev exists

3. Intercepting PMCSR reads in D3cold state:
   - In rtas_pci_dn_write_config, detect PMCSR read attempts
   - Check if device is in D3cold via pdev->current_state
   - Return synthetic success value instead of performing RTAS call
   - Prevents hardware access that would trigger false EEH event

The fix handles both early boot (before pci_dev exists) and runtime
scenarios, ensuring PM capability information is always available when
needed. By blocking RTAS reads to PMCSR when devices are in D3cold,
we prevent spurious EEH events while maintaining proper error detection
for genuine hardware failures.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  9 +++++++
 arch/powerpc/kernel/eeh.c                    | 16 ++++++++++++
 arch/powerpc/kernel/rtas_pci.c               | 26 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/eeh_pseries.c | 16 ++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b7ebb4ac2c71..224a3adcd34e 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -139,6 +139,15 @@ struct eeh_dev {
 	int pcie_cap;			/* Saved PCIe capability	*/
 	int aer_cap;			/* Saved AER capability		*/
 	int af_cap;			/* Saved AF capability		*/
+	/*
+	 * Cached PCI PM capability information.
+	 * pm_cap == 0 means the device does not have PCI PM capability
+	 * or it has not been discovered yet.
+	 * pmcsr_offset is the absolute config-space offset of PMCSR:
+	 *     pm_cap + PCI_PM_CTRL
+	 */
+	u8 pm_cap;
+	u16 pmcsr_offset;
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head entry;		/* Membership in eeh_pe.edevs	*/
 	struct list_head rmv_entry;	/* Membership in rmv_list	*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..4402166df8c0 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -997,6 +997,21 @@ int eeh_init(struct eeh_ops *ops)
 	return eeh_event_init();
 }
 
+#ifdef CONFIG_EEH
+static void eeh_sync_pm_cap(struct eeh_dev *edev, struct pci_dev *pdev)
+{
+	if (!edev || !pdev)
+		return;
+
+	/*
+	 * Prefer PCI core cached PM capability once pci_dev exists.
+	 * If pm_cap is zero, clear pmcsr_offset as well.
+	 */
+	edev->pm_cap = pdev->pm_cap;
+	edev->pmcsr_offset = pdev->pm_cap ? pdev->pm_cap + PCI_PM_CTRL : 0;
+}
+#endif
+
 /**
  * eeh_probe_device() - Perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
@@ -1050,6 +1065,7 @@ void eeh_probe_device(struct pci_dev *dev)
 	/* bind the pdev and the edev together */
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
+	eeh_sync_pm_cap(edev, dev);
 	eeh_addr_cache_insert_dev(dev);
 	eeh_sysfs_add_device(dev);
 }
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index fccf96e897f6..9668cd0411e1 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -95,6 +95,24 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 	return ret;
 }
 
+static bool eeh_handle_pmcsr_read(struct eeh_dev *edev, int size,
+				  u32 *val, int *pcibios_ret)
+{
+	struct pci_dev *pdev;
+
+	if (!edev)
+		return false;
+
+	pdev = edev->pdev;
+	if (!pdev || pdev->current_state != PCI_D3cold)
+		return false;
+
+	*val = EEH_IO_ERROR_VALUE(size);
+	*pcibios_ret = PCIBIOS_SUCCESSFUL;
+
+	return true;
+}
+
 int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 {
 	unsigned long buid, addr;
@@ -108,6 +126,14 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
 	if (pdn->edev && pdn->edev->pe &&
 	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
 		return PCIBIOS_SET_FAILED;
+
+	if (unlikely(pdn->edev && pdn->edev->pmcsr_offset &&
+		     size == 2 && where == pdn->edev->pmcsr_offset)) {
+		int pcibios_ret;
+
+		if (eeh_handle_pmcsr_read(pdn->edev, size, &val, &pcibios_ret))
+			return pcibios_ret;
+	}
 #endif
 
 	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..0e7efb4bf2d4 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -351,6 +351,21 @@ static struct eeh_pe *pseries_eeh_pe_get_parent(struct eeh_dev *edev)
 	return NULL;
 }
 
+static void pseries_eeh_init_pm_cap(struct pci_dn *pdn, struct eeh_dev *edev)
+{
+	edev->pm_cap = 0;
+	edev->pmcsr_offset = 0;
+
+	if (!pdn || !edev)
+		return;
+
+	edev->pm_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_PM);
+	if (!edev->pm_cap)
+		return;
+
+	edev->pmcsr_offset = edev->pm_cap + PCI_PM_CTRL;
+}
+
 /**
  * pseries_eeh_init_edev - initialise the eeh_dev and eeh_pe for a pci_dn
  *
@@ -408,6 +423,7 @@ static void pseries_eeh_init_edev(struct pci_dn *pdn)
 	edev->pcix_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
 	edev->pcie_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
 	edev->aer_cap = pseries_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+	pseries_eeh_init_pm_cap(pdn, edev);
 	edev->mode &= 0xFFFFFF00;
 	if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
-- 
2.51.1


