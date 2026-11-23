Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925FC606A68C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i3FyWkIB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY02G6wyhz2ylm;
	Mon, 23 Nov 2026 19:47:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795423670;
	cv=none; b=O2C6BEYxnMAsEbMI0L/v5WbzDDM7Qs5uMDAoWte15xuFeJeBVe7EzKZsIJyReRQGXrLZ3lkcbWJjPbXeKOEI6FVaRV7XRik/yRL6mJHR79HxLPPG9M3pQkiWfiMyaTr6guCSFtw5yt6NMEtTNk88ONIDHtLH5htevGLTsEIB4qo1eWdo32Z7oEpxL2miAxp6tMBCpyJjGDlXntXGBZFB+lVI/5YggUSBLw+W/OKXG+QMD8XbOH2qvvoGfhD5u9Bv7CLfon7RWXnQPBTc4jAlO4diHMhRUGolRiQVlFyBnQPkpB51VHJLm7mR3/+V/RWx2P2Qil+TFgAZ0IYMb5bMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795423670; c=relaxed/relaxed;
	bh=STJNmQF8MmoNoyb0xS/Wfci/XJ6MVx3kwSNucWIBo1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nofklX41VU716zpgxmSZbtStAa2yEhK6c+PuEe6Bofak+1XxPzN8OUXmmYC920NHNzOHdOTEvwwMygOqv9FNwKzS5Lr7G9OugYkGL43qMU/xsKG8kPJlgeYAel4ixifxm8QrShRRxlEIEfYeLQ9jrKiSrzeR6VbXwsKre3zYf5dGnaKFJDE3PZxKlwAWARSfQZG9qJbVb3aMb9gzKE2ldhlA1PtScnRW1BA/pMO71fllKvFoJIlk/95dmlyjl1TUduxJfjqhkHr9kWZdFqSpenoG2VXn8iJtlh6BVyCozOJPKFSR0KuvlYJEAfjQl+h2CH5jumPovKXwYtEbB3EY2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i3FyWkIB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i3FyWkIB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY02F4qV9z2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 19:47:49 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN559NF982537;
	Mon, 23 Nov 2026 08:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=STJNmQF8MmoNoyb0x
	S/Wfci/XJ6MVx3kwSNucWIBo1E=; b=i3FyWkIB4eTJ9bvir72TQw1mi585TrhRt
	5eIZY0XcGufOAoSMvj37KgzNbLz+di7nLrBWICGLb9I6dMSppWBfvp7Pn4AAznVG
	dCVLibOLgWW0FZ4voiu3TZPKPwRBlpEs7JdOJwhCYkj7GDb1lzcN09wm5kp+1cdU
	R6R/YJv9mbbfDyn1/TSu8EK70B0DF3+Wg3ArPLJW/XoqPiBj7RGc5E5joc4KU1C9
	wopnRblKbapr4hhUKSi2itCZg20B4SzqxeCzCAnjYj3hKrODLao7s7A7SpT574wq
	IKpWxh2re0oG4wveiJ+gwUU6RCRcU4jLd/Huzm9mKwF2DhxEx3ZVw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g329cm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54V1G2487738;
	Mon, 23 Nov 2026 08:47:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h5x99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 08:47:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN8lMHD52035886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 08:47:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B99522005A;
	Mon, 23 Nov 2026 08:47:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C082620040;
	Mon, 23 Nov 2026 08:47:19 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 08:47:19 +0000 (GMT)
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
Subject: [PATCH v7 2/4] powerpc/pseries/eeh: Implement RTAS-based EEH error injection
Date: Mon, 23 Nov 2026 14:17:00 +0530
Message-ID: <20261123084658.61330-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com> (raw)
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03fda1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1Ikmz3f0NeihYkZ13NQA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXzhgpm8ccqChG
 +4MKHyb/GSt1Z2a0yq4IQXuv2O5pRbwmAgdkYKQxbxiqvKVjsHlSEsmJNsoL2uicHAt4DpoTbbP
 upuoCkr4nDt7n9MVsEWlBjNTeaAjURQ=
X-Proofpoint-ORIG-GUID: X_pbWN_BxETmEV9R3IY_hLoiHbdZ6lCD
X-Proofpoint-GUID: 00CCWlBs_1_tYA_-zyrH9e9Uhf23rpeW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzNCBTYWx0ZWRfXwefw09T4qHwf
 SLDv0XUqbvN2832tG4DtPQp7CGa68Orb0aWLjpJxkYn7p0AR7x0ih0f1NvG8fySS4jLUA75IKCH
 bJ8Ac7UnvUylgpv36SlgTBAX6pJmPE7feXJTscRHXP3jtd5kIU1mXFvlu/1TAxWCYhODQUEyrt4
 hZyPLO4KcNCFgWpYDr2GHKxArIpLBpeOmZMRq/kPaD4rdA3gQXve4W/LE/knVkqJXSW/x/+gZy1
 Lr/5Y7yXzqP26zeMEWZI/u+P8IWzoZ1e4oIN++VYf1xGtZxs8OSg7jgoNkDNwoj9auppZEn4ti/
 HPR+k2z8jVh1eRd2MTPrKSPxKPRADdGAj56+ThywUdHjVEJZssM8+XV5T/zh/LAWDJeOkPeF89/
 +rlIosmYN9RCCt0w1viVT2P5Cq5KVj5sTok11uA/3W5siK7HbtfFoqkKHsIwDRgEnrThwP+Y2Mk
 FEJ4CTDORQPtV7JHe5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230034
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pseries_eeh_err_inject() only emulates MMIO errors in software and
ignores the address and mask.  Use the PAPR RTAS services
ibm,open-errinjct, ibm,errinjct and ibm,close-errinjct instead, so the
platform raises the error for a given IOA bus address.

EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 select the ioa-bus-error and
ioa-bus-error-64 classes and the matching parameter buffer layout.  The
class token is read from the "ibm,errinjct-tokens" property of /rtas; if
the class is not advertised the request fails with -EOPNOTSUPP.  The
buffer comes from the RTAS work area allocator, and the session is closed
on every exit path after a successful open.  A mutex serializes sessions
started through this backend.  Statuses specific to these services, such
as "already open", are mapped to errno locally; rtas_error_rc() is
unchanged.

For memory and I/O load/store functions the address must be a PCI bus
address within an assigned standard BAR (BAR0-BAR5) of the matching type,
memory or I/O, of a device in the PE.  pci_lock_rescan_remove() protects
the PE device list walk and snapshots the PE address and BUID before
releasing the lock and opening the RTAS session.  Config-space and DMA
functions, and requests with address and mask both zero, are not checked.
The mask is passed to firmware unchanged.

Remove eeh_pe_inject_mmio_error().  eeh_break_device() is now used only by
debugfs, so build it only with CONFIG_DEBUG_FS.

Firmware without the ERRINJCT services or class token no longer gets the
software-emulated injection; the request fails with -ENODEV or
-EOPNOTSUPP.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  26 +-
 arch/powerpc/kernel/eeh.c                    |  10 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 334 +++++++++++++++++--
 3 files changed, 338 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b7ebb4ac2c71..f7743dcf75a4 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -9,6 +9,7 @@
 #ifdef __KERNEL__
 
 #include <linux/init.h>
+#include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/string.h>
 #include <linux/time.h>
@@ -310,7 +311,30 @@ int eeh_pe_reset(struct eeh_pe *pe, int option, bool include_passed);
 int eeh_pe_configure(struct eeh_pe *pe);
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 		      unsigned long addr, unsigned long mask);
-int eeh_pe_inject_mmio_error(struct pci_dev *pdev);
+
+/*
+ * Return the resource type (IORESOURCE_MEM or IORESOURCE_IO) of the BAR that
+ * error function @func addresses, or 0 if it does not take a BAR address.
+ * Config-space functions take a config register offset and DMA functions
+ * take a DMA address.
+ */
+static inline unsigned long eeh_err_func_to_res_type(int func)
+{
+	switch (func) {
+	case EEH_ERR_FUNC_LD_MEM_ADDR:
+	case EEH_ERR_FUNC_LD_MEM_DATA:
+	case EEH_ERR_FUNC_ST_MEM_ADDR:
+	case EEH_ERR_FUNC_ST_MEM_DATA:
+		return IORESOURCE_MEM;
+	case EEH_ERR_FUNC_LD_IO_ADDR:
+	case EEH_ERR_FUNC_LD_IO_DATA:
+	case EEH_ERR_FUNC_ST_IO_ADDR:
+	case EEH_ERR_FUNC_ST_IO_DATA:
+		return IORESOURCE_IO;
+	default:
+		return 0;
+	}
+}
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 2d7898ef6b8c..d4c018849787 100644
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
index b12ef382fec7..c8466017d1e4 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -17,13 +17,17 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/proc_fs.h>
 #include <linux/rbtree.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
 #include <linux/crash_dump.h>
 
 #include <asm/eeh.h>
@@ -32,6 +36,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/rtas.h>
+#include <asm/rtas-work-area.h>
 
 /* RTAS tokens */
 static int ibm_set_eeh_option;
@@ -786,41 +791,324 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 }
 #endif
 
+/* Size of the ibm,errinjct work buffer */
+#define RTAS_ERRINJCT_BUF_SIZE			SZ_1K
+
+/*
+ * Look up the ibm,errinjct class token for a generic EEH error type in the
+ * "ibm,errinjct-tokens" property of the /rtas node.  The property is a
+ * packed list of (NUL-terminated class name, big-endian 32-bit token)
+ * entries, so tokens are not necessarily aligned.
+ *
+ * rtas.dev holds a reference on the /rtas node for the life of the system,
+ * so none is taken here.
+ *
+ * Return: 0 and *@token set on success, -EINVAL for an unsupported @type,
+ * -EOPNOTSUPP if firmware does not advertise the class, -EIO if the
+ * property is malformed.
+ */
+static int pseries_eeh_get_errinjct_token(int type, u32 *token)
+{
+	const char *name, *p;
+	size_t namelen, remaining;
+	int len;
+
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		name = "ioa-bus-error";
+		break;
+	case EEH_ERR_TYPE_64:
+		name = "ioa-bus-error-64";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	p = of_get_property(rtas.dev, "ibm,errinjct-tokens", &len);
+	if (!p)
+		return -EOPNOTSUPP;
+
+	for (remaining = len; remaining; ) {
+		namelen = strnlen(p, remaining);
+
+		/* Need the NUL terminator and a whole token after it. */
+		if (namelen == remaining ||
+		    remaining - namelen - 1 < sizeof(u32)) {
+			pr_warn_once("EEH: malformed ibm,errinjct-tokens\n");
+			return -EIO;
+		}
+
+		if (!strcmp(p, name)) {
+			*token = get_unaligned_be32(p + namelen + 1);
+			return 0;
+		}
+
+		namelen += 1 + sizeof(u32);
+		p += namelen;
+		remaining -= namelen;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Return true if @addr, a PCI bus address, lies within an assigned, enabled
+ * standard BAR (BAR0-BAR5) of @pdev whose resource type is @res_type.
+ * Expansion ROM, SR-IOV resources and bridge windows are not supported.
+ *
+ * On pseries, unassigned BARs are zero-based and flagged IORESOURCE_UNSET,
+ * so they would otherwise translate to a bus range starting at zero.
+ */
+static bool addr_in_pdev_bars(struct pci_dev *pdev, unsigned long res_type,
+			      unsigned long addr)
+{
+	struct pci_bus_region region;
+	struct resource *res;
+	resource_size_t len;
+	int bar;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		res = &pdev->resource[bar];
+
+		if (resource_type(res) != res_type)
+			continue;
+
+		if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
+			continue;
+
+		len = pci_resource_len(pdev, bar);
+		if (!len)
+			continue;
+
+		pcibios_resource_to_bus(pdev->bus, &region, res);
+		if (addr >= region.start && addr - region.start < len)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Check that @addr, a PCI bus address, lies within a standard BAR of type
+ * @res_type of a device in @pe. Must be called with pci_lock_rescan_remove()
+ * held to protect PE device list traversal and PCI resource consistency.
+ */
+static int validate_addr_in_pe(struct eeh_pe *pe, unsigned long res_type,
+			       unsigned long addr)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dev *pdev;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdev = eeh_dev_to_pci_dev(edev);
+		if (pdev && addr_in_pdev_bars(pdev, res_type, addr))
+			return 0;
+	}
+
+	pr_debug("EEH: addr 0x%lx is not within any matching BAR of the PE\n",
+		 addr);
+	return -EINVAL;
+}
+
+/*
+ * Fill the ibm,errinjct work buffer.  The layout depends on the generic EEH
+ * error type, not on the firmware class token.  @addr is a PCI bus address
+ * and @mask is passed to firmware unchanged.  Word layouts are defined by
+ * PAPR for ioa-bus-error and ioa-bus-error-64.
+ */
+static void prepare_errinjct_buffer(void *buf, u32 pe_addr, u64 buid, int type,
+				    int func, unsigned long addr,
+				    unsigned long mask)
+{
+	__be64 *buf64 = buf;
+	__be32 *buf32 = buf;
+
+	memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
+
+	switch (type) {
+	case EEH_ERR_TYPE_32:
+		buf32[0] = cpu_to_be32((u32)addr);
+		buf32[1] = cpu_to_be32((u32)mask);
+		buf32[2] = cpu_to_be32(pe_addr);
+		buf32[3] = cpu_to_be32(BUID_HI(buid));
+		buf32[4] = cpu_to_be32(BUID_LO(buid));
+		buf32[5] = cpu_to_be32(func);
+		break;
+	case EEH_ERR_TYPE_64:
+		buf64[0] = cpu_to_be64(addr);
+		buf64[1] = cpu_to_be64(mask);
+		buf32[4] = cpu_to_be32(pe_addr);
+		buf32[5] = cpu_to_be32(BUID_HI(buid));
+		buf32[6] = cpu_to_be32(BUID_LO(buid));
+		buf32[7] = cpu_to_be32(func);
+		break;
+	}
+
+	pr_debug("EEH: errinjct buffer: type=%d func=%d addr=0x%lx mask=0x%lx\n",
+		 type, func, addr, mask);
+}
+
+/*
+ * PAPR allows only one open ERRINJCT session: while one is open,
+ * ibm,open-errinjct returns -4 ("already open") to any other caller.  Hold
+ * this mutex across open/inject/close so concurrent requests through this
+ * backend run one after another instead of failing.  It does not exclude
+ * direct sys_rtas() users of the same facility, who still get the firmware
+ * status.
+ */
+static DEFINE_MUTEX(errinjct_mutex);
+
+/*
+ * Map an ibm,{open,errinjct,close}-errinjct status to an errno.  rtas_error_rc()
+ * does not know the statuses specific to these services, so the mapping is
+ * local.  A -1 may be a firmware hardware error or a kernel lockdown denial,
+ * which rtas_call() does not distinguish, so it is reported as -EIO.
+ */
+static int pseries_errinjct_errno(const char *op, int rc, bool is_open)
+{
+	pr_debug("EEH: %s failed: status=%d\n", op, rc);
+
+	switch (rc) {
+	case RTAS_HARDWARE_ERROR:
+		return -EIO;
+	case RTAS_INVALID_PARAMETER:
+		return -EINVAL;
+	case -4:
+		/* open: already open; others: not the opener, or not open */
+		return is_open ? -EBUSY : -EIO;
+	case -5:
+		/* open: PCI error injection is not available */
+		if (is_open)
+			return -EOPNOTSUPP;
+		fallthrough;
+	default:
+		pr_warn_ratelimited("EEH: %s failed: unexpected status %d\n",
+				    op, rc);
+		return -ERANGE;
+	}
+}
+
 /**
  * pseries_eeh_err_inject - Inject specified error to the indicated PE
  * @pe: the indicated PE
- * @type: error type
- * @func: specific error type
- * @addr: address
- * @mask: address mask
- * The routine is called to inject specified error, which is
- * determined by @type and @func, to the indicated PE
+ * @type: generic EEH error type (EEH_ERR_TYPE_32 or EEH_ERR_TYPE_64)
+ * @func: error function (EEH_ERR_FUNC_*)
+ * @addr: address; its meaning depends on @func
+ * @mask: address mask, passed to firmware unchanged
+ *
+ * Inject the error using the RTAS ibm,open-errinjct, ibm,errinjct and
+ * ibm,close-errinjct sequence, with the ibm,errinjct class token taken from
+ * the "ibm,errinjct-tokens" property.
+ *
+ * For memory and I/O load/store functions @addr is a PCI bus address within
+ * a standard BAR (BAR0-BAR5) of the matching resource type (memory or I/O)
+ * of a device in the PE; otherwise -EINVAL is returned. Expansion ROM,
+ * SR-IOV resources and bridge windows are not supported. This includes @addr
+ * of zero with a non-zero @mask. Config-space and DMA functions pass @addr
+ * through unchanged. A request with @addr and @mask both zero carries no
+ * address and is passed through. EEH_ERR_TYPE_32 uses 32-bit address and
+ * mask words and EEH_ERR_TYPE_64 uses 64-bit ones.
+ *
+ * pci_lock_rescan_remove() is held while validating device BARs and
+ * snapshotting PE configuration parameters, but is released before
+ * acquiring errinjct_mutex and entering RTAS to avoid holding the global
+ * rescan/remove lock across firmware latency.
+ *
+ * Return: 0 on success, negative errno on failure.
  */
 static int pseries_eeh_err_inject(struct eeh_pe *pe, int type, int func,
 				  unsigned long addr, unsigned long mask)
 {
-	struct	eeh_dev	*pdev;
+	int open_token, errinjct_token, close_token;
+	struct rtas_work_area *area;
+	unsigned long res_type;
+	int session_token;
+	u32 class_token;
+	u32 pe_addr;
+	u64 buid;
+	int close_rc;
+	int rc;
 
-	/* Check on PCI error type */
-	if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
+	if (!pe || !pe->phb)
 		return -EINVAL;
 
-	switch (func) {
-	case EEH_ERR_FUNC_LD_MEM_ADDR:
-	case EEH_ERR_FUNC_LD_MEM_DATA:
-	case EEH_ERR_FUNC_ST_MEM_ADDR:
-	case EEH_ERR_FUNC_ST_MEM_DATA:
-		/* injects a MMIO error for all pdev's belonging to PE */
-		pci_lock_rescan_remove();
-		list_for_each_entry(pdev, &pe->edevs, entry)
-			eeh_pe_inject_mmio_error(pdev->pdev);
-		pci_unlock_rescan_remove();
-		break;
-	default:
-		return -ERANGE;
+	if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
+		return -EINVAL;
+
+	rc = pseries_eeh_get_errinjct_token(type, &class_token);
+	if (rc)
+		return rc;
+
+	/* The 32-bit buffer format carries 32-bit address and mask words. */
+	if (type == EEH_ERR_TYPE_32 &&
+	    (upper_32_bits(addr) || upper_32_bits(mask)))
+		return -EINVAL;
+
+	res_type = eeh_err_func_to_res_type(func);
+
+	pci_lock_rescan_remove();
+	if (res_type && (addr || mask)) {
+		rc = validate_addr_in_pe(pe, res_type, addr);
+		if (rc) {
+			pci_unlock_rescan_remove();
+			return rc;
+		}
 	}
 
-	return 0;
+	pe_addr = pe->addr;
+	buid = pe->phb->buid;
+	pci_unlock_rescan_remove();
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
+		rc = pseries_errinjct_errno("ibm,open-errinjct", rc, true);
+		goto out_unlock;
+	}
+
+	/* ibm,errinjct takes the physical address of a 1KB work buffer. */
+	area = rtas_work_area_alloc(RTAS_ERRINJCT_BUF_SIZE);
+	prepare_errinjct_buffer(rtas_work_area_raw_buf(area), pe_addr, buid,
+				type, func, addr, mask);
+
+	do {
+		rc = rtas_call(errinjct_token, 3, 1, NULL, class_token,
+			       session_token, rtas_work_area_phys(area));
+	} while (rtas_busy_delay(rc));
+
+	if (rc)
+		rc = pseries_errinjct_errno("ibm,errinjct", rc, false);
+
+	rtas_work_area_free(area);
+
+	/* Always close the session; keep the injection status if it failed. */
+	do {
+		close_rc = rtas_call(close_token, 1, 1, NULL, session_token);
+	} while (rtas_busy_delay(close_rc));
+
+	if (close_rc) {
+		close_rc = pseries_errinjct_errno("ibm,close-errinjct",
+						  close_rc, false);
+		if (!rc)
+			rc = close_rc;
+	}
+
+out_unlock:
+	mutex_unlock(&errinjct_mutex);
+	return rc;
 }
 
 static struct eeh_ops pseries_eeh_ops = {
-- 
2.54.0


