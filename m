Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D37606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Oct 2026 07:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AOFdrDC3
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9vxg29qnz2ySk;
	Fri, 23 Oct 2026 18:37:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792741063;
	cv=none; b=fLLLZ0ZpEQXMLBVwYG/UAqlqqio1h2tp+M0O0RB2C/oHwSOg64N2US5t7UaQsK5JZA0s1VzWc22W/IEo+1tQjPKm4bY2EGc238F9Og94Qhp2JHmEKAMLln+/TNGoTFHkoA7M+QaRmiYqDQnmOlcERYK6OxcLPBTYEiNPE9/GamWg1DqAnDoB+QI75jw+kPEQOtHkY8Qhc/8ZhiZ8xeThul3fwoBQeVVIG2XKCYNfWF5tLT3BH4cgQZUubwAEjdeHEv+47ClqrGm5KzHSs05nWgLBj6Fb9K2DcvAIKTyCYt5z+UhpU0CVZZv0MK0DeXZACJprahwq/ZW+D2/dJ+PVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792741063; c=relaxed/relaxed;
	bh=GM89tMdk9siOAWooh4MhWDqK8n1u0qgE7IynxMa4zxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwLBOqy11Gf3oqq5DXJnQndQyxoNoVI5NoC4Jk0XXhnEeR7E3fMCQmjXUEKTo/8w0I+XK6a3tSNneGfE11bvUIcdnmA6KOsxEaOlR/gjNIfzKAvtYMvlTPln19T0a7xfnA12e36wiNI5TNDiYbkvPk4aXBg20ikk+irRkec8UGXDs4s90d/I0PWTZOxRgXlyTAKL6oabi3Bmih4pHPay3wU/kuWrG+4I6uye9dH/WD/x2QbMCazlUXS2UxsrLltNyi2W4nIJR0/w5PYNwYacNDlkmc9SQo8qwQW8Ly5A3AT0NsPl4KIFQ3Hyg2nqyNpzxP14SA+dx38Y+mDtMuohoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AOFdrDC3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AOFdrDC3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9vxf2BZRz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 18:37:42 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7EiqT2248189;
	Fri, 23 Oct 2026 07:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GM89tMdk9siOAWooh
	4MhWDqK8n1u0qgE7IynxMa4zxk=; b=AOFdrDC324ZOz3SoKg5503l33G4RF0xIh
	v2irI+n7Z33LD0AmnREhDycqwuyjU7rwgzsaCqNV6ZWi6Nf3P+p6MMCBUvDOuWtD
	jvMqVRtP+Rf032J78RijOzMFnsMeNYlrOqUAQ8vIDLYtaeGkE4y+B2ICR1Iow6pY
	83M7BOEzIsM/SeTIb1jm1OiH3jqTwb4LeFFxqnTgzNJjHUIAHRN75ZmNvnEt+47b
	wvNFG3wS33ItrJ+q9VT97Bn1LDZiCPwHRdE3bpvIyNiuqnLrP6l6WPvXP3FDlvb2
	aIuNk7mDraSkG6LxgbdIox8Uup0ZjTxDG5A0x+9pHLNfjOWSaCjAw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5akt2p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7JsBO1759238;
	Fri, 23 Oct 2026 07:37:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hfj1x43t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 07:37:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69N7bRdD31851128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Oct 2026 07:37:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6791020043;
	Fri, 23 Oct 2026 07:37:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8C1420040;
	Fri, 23 Oct 2026 07:37:23 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.18.128])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Oct 2026 07:37:23 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v6 3/5] powerpc/pseries/eeh: Implement RTAS-based EEH error injection
Date: Fri, 23 Oct 2026 13:06:40 +0530
Message-ID: <20261023073642.59657-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX0cVJgrqYdSJ0
 tPZwNVrcZGuGX2pBD+Umv4EIgpBQ6TeK5A0V2wCW8yJCSQ2PtaqNWSMMPZ+aBi8y85AOmMuX/aU
 rDgCc7j7S+QFb3RjG9SCB8vSSBiRwzE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAyOCBTYWx0ZWRfX/0b1szXHohQd
 WVc7gNlzGBT4DXD0rNomWKsls82qWChCXNo12XS+DyocM99JctHFBaqsuv7ifv7CylWV4p44hEa
 ZhItGlgdkzlKUEmB6J7tUkU9/tPeErDLQgtnA05Y3k0okAR5Sq9ieITR19y1WVdQ2CoafYZE1eT
 CxT1M0M0poeV6eHzw+sENtGoQvLSFyZQHfwXT3vcL3pISqIna5buqeRYVlQgZ9UXqqp8gBzve52
 aoSD34g3qKRZBxrwoYH/8CWC4GhcEx9WRCWq3iwy3ILzscY5gSZKbh7/mC2AVspWF3xR+kuPDeD
 Dmovf6gYhOjJ1/0V+G2O+1jtHXIndlde34rHIec62XatmqRx/EjlUOMhcmYfNfS6WoA+8DjkLZq
 eXNkXP3UIMCYJBJQ7Cz8AzGrkNh6AVcoXhUzPO6D6/vaD0xJCXmbtl5IWTJ9XQYfx1wilboho3G
 eCuc7pyTV1ZcjWCtXlQ==
X-Proofpoint-GUID: ZPydPwPtrXVz3gSti4hPKFVbskrgrnbc
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6adb0ebc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=J95Ynn5qFrUfkVdwNpAA:9
X-Proofpoint-ORIG-GUID: PKgeJbscttaDuUmwHXs92Mm6ZAwuHZjB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230028
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the legacy MMIO stub in pseries_eeh_err_inject() with a full
PAPR-compliant RTAS error injection path.

Serialize each ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
session with errinjct_mutex because RTAS maintains state between these
calls.

Once ibm,open-errinjct succeeds, ibm,close-errinjct is attempted
after parameter preparation or ibm,errinjct failures.  The RTAS work
area is allocated after a successful open to avoid holding it while
waiting for the mutex or if open fails.

VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
the generic EEH error types to RTAS ibm,errinjct encodings via
pseries_eeh_type_to_rtas().  EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are
unchanged; their values are defined in arch/powerpc/include/uapi/asm/eeh.h
and are not renumbered.

The RTAS work-area allocator guarantees that returned memory is within
the range accessible by RTAS (below min(ppc64_rma_size,
RTAS_INSTANTIATE_MAX), which is at most RTAS_INSTANTIATE_MAX = 1 GiB),
so the physical address fits in the 32-bit RTAS argument without
truncation.

Remove eeh_pe_inject_mmio_error() and its declaration; this patch
removes its only caller.  The only remaining caller of
eeh_break_device() is eeh_dev_break_write() inside CONFIG_DEBUG_FS,
so move eeh_break_device() back inside the CONFIG_DEBUG_FS block to
avoid an unused-function warning when CONFIG_DEBUG_FS=n.

Also introduce validate_errinjct_args() and prepare_errinjct_buffer()
here alongside their callers, so each intermediate commit builds
cleanly with CONFIG_WERROR.

The addr argument to ibm,errinjct is function-dependent.  Memory and IO
load/store functions (EEH_ERR_FUNC_LD/ST_MEM_* and EEH_ERR_FUNC_LD/ST_IO_*)
target BAR-backed PCI bus addresses; these are validated against the PE
via validate_addr_mask_in_pe().  Config-space functions carry PCI config
register offsets and DMA functions carry IOVA/TCE addresses; addr for
these functions is passed directly to RTAS without BAR membership
validation.

For the 32-bit RTAS encoding (RTAS_ERR_TYPE_IOA_BUS_ERROR), addr and
mask are checked to fit in 32 bits before buffer encoding.  This is an
RTAS format constraint independent of function type.

Tested with corresponding QEMU patches:
https://lore.kernel.org/all/20251029150618.186803-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   2 -
 arch/powerpc/kernel/eeh.c                    |  10 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 246 +++++++++++++++++--
 3 files changed, 228 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b7ebb4ac2c71..083ac58e7eb7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -310,8 +310,6 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
 int eeh_pe_configure(struct eeh_pe *pe);
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 		      unsigned long addr, unsigned long mask);
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
-
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
  *
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..bae7ca2bd399 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1571,6 +1571,8 @@ static int proc_eeh_show(struct seq_file *m, void *v)
 }
 #endif /* CONFIG_PROC_FS */
 
+#ifdef CONFIG_DEBUG_FS
+
 static int eeh_break_device(struct pci_dev *pdev)
 {
 	struct resource *bar = NULL;
@@ -1664,14 +1666,6 @@ static int eeh_break_device(struct pci_dev *pdev)
 	return 0;
 }
 
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev)
-{
-	return eeh_break_device(pdev);
-}
-
-#ifdef CONFIG_DEBUG_FS
-
-
 static struct pci_dev *eeh_debug_lookup_pdev(struct file *filp,
 					     const char __user *user_buf,
 					     size_t count, loff_t *ppos)
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 28b1fd19e8bc..2a2ec1a237e6 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -35,6 +35,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
+#include <asm/rtas-work-area.h>
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -915,48 +916,253 @@ static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
 	pci_unlock_rescan_remove();
 
 	if (!found)
-		pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of any device in PE\n",
-		       addr, mask);
+		pr_debug("addr=0x%lx mask=0x%lx not within any PCI bus BAR of any device in PE\n",
+			 addr, mask);
 	return found ? 0 : -EINVAL;
 }
 
 /**
- * pseries_eeh_err_inject - Inject specified error to the indicated PE
- * @pe: the indicated PE
- * @type: error type
- * @func: specific error type
- * @addr: address
- * @mask: address mask
- * The routine is called to inject specified error, which is
- * determined by @type and @func, to the indicated PE
+ * validate_errinjct_args - Top-level validation for RTAS error injection arguments
+ * @pe:   EEH PE for the target device
+ * @type: generic EEH error type
+ * @func: error function selector
+ * @addr: address argument (type-dependent, may be zero)
+ * @mask: mask argument (type-dependent, may be zero)
+ *
+ * Validates all parameters before opening an RTAS injection session.
+ * Returns Linux errno values; does not return raw RTAS status codes.
+ *
+ * Return: 0 if all parameters are valid, negative errno otherwise.
  */
-static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
+static int validate_errinjct_args(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
+	if (!pe || !pe->phb)
+		return -EINVAL;
+
+	if (pseries_eeh_type_to_rtas(type) < 0)
+		return -EINVAL;
 
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
+	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
 		return -EINVAL;
 
+	return 0;
+}
+
+/*
+ * pseries_eeh_func_needs_bar_addr - return true for error functions whose
+ * addr argument is a BAR-backed PCI MMIO or IO address.
+ *
+ * Memory and IO load/store functions target specific BAR addresses and
+ * require PCI bus address validation against the PE.  Config-space
+ * functions carry PCI config register offsets and DMA functions carry
+ * IOVA/TCE addresses; neither is a BAR address.
+ */
+static bool pseries_eeh_func_needs_bar_addr(int func)
+{
 	switch (func) {
 	case EEH_ERR_FUNC_LD_MEM_ADDR:
 	case EEH_ERR_FUNC_LD_MEM_DATA:
+	case EEH_ERR_FUNC_LD_IO_ADDR:
+	case EEH_ERR_FUNC_LD_IO_DATA:
 	case EEH_ERR_FUNC_ST_MEM_ADDR:
 	case EEH_ERR_FUNC_ST_MEM_DATA:
-		/* injects a MMIO error for all pdev's belonging to PE */
-		pci_lock_rescan_remove();
-		list_for_each_entry(pdev, &pe->edevs, entry)
-			eeh_pe_inject_mmio_error(pdev->pdev);
-		pci_unlock_rescan_remove();
+	case EEH_ERR_FUNC_ST_IO_ADDR:
+	case EEH_ERR_FUNC_ST_IO_DATA:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/**
+ * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
+ * @buf: RTAS error-injection work buffer
+ * @pe: EEH PE associated with the injection target
+ * @rtas_err_type: RTAS firmware error-injection type
+ * @func: Error function selector
+ * @addr: Address argument interpreted according to @func:
+ *        MEM/IO functions: BAR-backed PCI bus address;
+ *        CFG functions: PCI configuration-space offset;
+ *        DMA functions: DMA/IOVA/TCE address.
+ * @mask: Address mask passed to firmware
+ *
+ * Zeroes @buf and populates it according to the PAPR layout for the
+ * selected IOA bus-error injection type.
+ *
+ * BAR membership validation is performed only for MEM/IO functions
+ * whose @addr is a BAR-backed PCI bus address.  CFG and DMA function
+ * addresses are encoded directly without BAR lookup.
+ *
+ * The caller provides an exclusive per-call RTAS work-area buffer.
+ * Firmware session serialization is handled by pseries_eeh_err_inject().
+ *
+ * Return: 0 on success or a negative errno on invalid input.
+ */
+static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
+				   int rtas_err_type, int func,
+				   unsigned long addr, unsigned long mask)
+{
+	__be64 *buf64 = (__be64 *)buf;
+	__be32 *buf32 = (__be32 *)buf;
+	int rc;
+
+	if (!buf || !pe || !pe->phb)
+		return -EINVAL;
+
+	memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
+
+	switch (rtas_err_type) {
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+		/*
+		 * 32-bit RTAS format: addr and mask must fit in 32 bits.
+		 * This is an RTAS encoding constraint, not BAR validation.
+		 */
+		if (upper_32_bits(addr) || upper_32_bits(mask))
+			return -EINVAL;
+
+		if (pseries_eeh_func_needs_bar_addr(func)) {
+			rc = validate_addr_mask_in_pe(pe, addr, mask);
+			if (rc)
+				return rc;
+		}
+
+		buf32[0] = cpu_to_be32((u32)addr);
+		buf32[1] = cpu_to_be32((u32)mask);
+		buf32[2] = cpu_to_be32(pe->addr);
+		buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[5] = cpu_to_be32(func);
+		break;
+
+	case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+		if (pseries_eeh_func_needs_bar_addr(func)) {
+			rc = validate_addr_mask_in_pe(pe, addr, mask);
+			if (rc)
+				return rc;
+		}
+
+		buf64[0] = cpu_to_be64(addr);
+		buf64[1] = cpu_to_be64(mask);
+		buf32[4] = cpu_to_be32(pe->addr);
+		buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
+		buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
+		buf32[7] = cpu_to_be32(func);
 		break;
+
 	default:
-		return -ERANGE;
+		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_err_type);
+		return -EINVAL;
 	}
 
+	pr_debug("errinjct buffer ready: rtas_err_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
+		 rtas_err_type, func, addr, mask);
 	return 0;
 }
 
+/* Serializes the open/inject/close RTAS error injection session */
+static DEFINE_MUTEX(errinjct_mutex);
+
+/**
+ * pseries_eeh_err_inject - Inject specified error to the indicated PE
+ * @pe: the indicated PE
+ * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
+ * @func: specific error function
+ * @addr: address argument (type-dependent, may be zero)
+ * @mask: address mask (type-dependent, may be zero)
+ *
+ * Implements PAPR-compliant error injection using:
+ *   ibm,open-errinjct -> ibm,errinjct -> ibm,close-errinjct
+ *
+ * errinjct_mutex serializes the open/inject/close session sequence
+ * because RTAS maintains state between these calls.  A short-lived
+ * RTAS work area is allocated after a successful open and freed before
+ * close.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
+				  unsigned long addr, unsigned long mask)
+{
+	struct rtas_work_area *area;
+	phys_addr_t area_phys;
+	void *buf;
+	int open_token, errinjct_token, close_token;
+	int session_token;
+	int rtas_err_type;
+	int close_rc;
+	int rc;
+
+	rc = validate_errinjct_args(pe, type, func, addr, mask);
+	if (rc)
+		return rc;
+
+	rtas_err_type = pseries_eeh_type_to_rtas(type);
+	if (rtas_err_type < 0)
+		return -EINVAL;
+
+	open_token = rtas_function_token(RTAS_FN_IBM_OPEN_ERRINJCT);
+	errinjct_token = rtas_function_token(RTAS_FN_IBM_ERRINJCT);
+	close_token = rtas_function_token(RTAS_FN_IBM_CLOSE_ERRINJCT);
+
+	if (open_token == RTAS_UNKNOWN_SERVICE ||
+	    errinjct_token == RTAS_UNKNOWN_SERVICE ||
+	    close_token == RTAS_UNKNOWN_SERVICE)
+		return -ENODEV;
+
+	mutex_lock(&errinjct_mutex);
+
+	do {
+		rc = rtas_call(open_token, 0, 2, &session_token);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,open-errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+		goto out_unlock;
+	}
+
+	area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
+	buf = rtas_work_area_raw_buf(area);
+	area_phys = rtas_work_area_phys(area);
+
+	rc = prepare_errinjct_buffer(buf, pe, rtas_err_type, func, addr, mask);
+	if (rc)
+		goto out_free_area;
+
+	/*
+	 * RTAS work areas are allocated below RTAS_INSTANTIATE_MAX, so
+	 * area_phys fits in the 32-bit RTAS argument.
+	 */
+	do {
+		rc = rtas_call(errinjct_token, 3, 1, NULL,
+			       rtas_err_type, session_token,
+			       (u32)area_phys);
+	} while (rtas_busy_delay(rc));
+
+	if (rc) {
+		pr_err("ibm,errinjct failed: status=%d\n", rc);
+		rc = rtas_error_rc(rc);
+	}
+
+out_free_area:
+	rtas_work_area_free(area);
+
+	do {
+		close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
+	} while (rtas_busy_delay(close_rc));
+
+	if (close_rc) {
+		pr_warn("ibm,close-errinjct failed: status=%d\n", close_rc);
+		if (!rc)
+			rc = rtas_error_rc(close_rc);
+	}
+
+out_unlock:
+	mutex_unlock(&errinjct_mutex);
+	return rc;
+}
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.probe			= pseries_eeh_probe,
-- 
2.54.0


