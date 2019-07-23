Return-Path: <SRS0=YPWW=VU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5206EC76186
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jul 2019 03:49:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D514821E70
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jul 2019 03:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514821E70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45t4H84pZzzDqXr
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jul 2019 13:49:40 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 45t49B5rBlzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2019 13:44:30 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6N3hYAE046208
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 23:44:27 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2twrpw3gbp-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 23:44:27 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sbobroff@linux.ibm.com>;
 Tue, 23 Jul 2019 04:44:25 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 23 Jul 2019 04:44:24 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6N3iN5545285440
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jul 2019 03:44:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C6235205F;
 Tue, 23 Jul 2019 03:44:23 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1A21B52052;
 Tue, 23 Jul 2019 03:44:23 +0000 (GMT)
Received: from tungsten.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8A6E9A03BF;
 Tue, 23 Jul 2019 13:44:20 +1000 (AEST)
From: Sam Bobroff <sbobroff@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 8/9] powerpc/eeh: Introduce EEH edev logging macros
Date: Tue, 23 Jul 2019 13:44:19 +1000
X-Mailer: git-send-email 2.22.0.216.g00a2a96fc9
In-Reply-To: <cover.1563853440.git.sbobroff@linux.ibm.com>
References: <cover.1563853440.git.sbobroff@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072303-0016-0000-0000-0000029548A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072303-0017-0000-0000-000032F335EC
Message-Id: <fa19ba9df4a46e5ed72bce1d6eeb786ca0255f8e.1563853440.git.sbobroff@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-23_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=909 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907230030
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
Cc: aik@ozlabs.ru, oohall@gmail.com, tyreld@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Now that struct eeh_dev includes the BDFN of it's PCI device, make use
of it to replace eeh_edev_info() with a set of dev_dbg()-style macros
that only need a struct edev.

With the BDFN available without the struct pci_dev, eeh_pci_name() is
now unnecessary, so remove it.

While only the "info" level function is used here, the others will be
used in followup work.

Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
---
v3 * New in this version.

 arch/powerpc/include/asm/eeh.h   | 11 +++++++++++
 arch/powerpc/kernel/eeh_driver.c | 17 -----------------
 2 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index bbe0798f6624..e1023a556721 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -138,6 +138,17 @@ struct eeh_dev {
 	struct pci_dev *physfn;		/* Associated SRIOV PF		*/
 };
 
+/* "fmt" must be a simple literal string */
+#define EEH_EDEV_PRINT(level, edev, fmt, ...) \
+	pr_##level("PCI %04x:%02x:%02x.%x#%04x: EEH: " fmt, \
+	(edev)->controller->global_number, PCI_BUSNO((edev)->bdfn), \
+	PCI_SLOT((edev)->bdfn), PCI_FUNC((edev)->bdfn), \
+	((edev)->pe ? (edev)->pe_config_addr : 0xffff), ##__VA_ARGS__)
+#define eeh_edev_dbg(edev, fmt, ...) EEH_EDEV_PRINT(debug, (edev), fmt, ##__VA_ARGS__)
+#define eeh_edev_info(edev, fmt, ...) EEH_EDEV_PRINT(info, (edev), fmt, ##__VA_ARGS__)
+#define eeh_edev_warn(edev, fmt, ...) EEH_EDEV_PRINT(warn, (edev), fmt, ##__VA_ARGS__)
+#define eeh_edev_err(edev, fmt, ...) EEH_EDEV_PRINT(err, (edev), fmt, ##__VA_ARGS__)
+
 static inline struct pci_dn *eeh_dev_to_pdn(struct eeh_dev *edev)
 {
 	return edev ? edev->pdn : NULL;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index d6f54840a3a9..29424d5e5fea 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -82,23 +82,6 @@ static const char *pci_ers_result_name(enum pci_ers_result result)
 	}
 };
 
-static __printf(2, 3) void eeh_edev_info(const struct eeh_dev *edev,
-					 const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	printk(KERN_INFO "EEH: PE#%x (PCI %s): %pV\n", edev->pe_config_addr,
-	       edev->pdev ? dev_name(&edev->pdev->dev) : "none", &vaf);
-
-	va_end(args);
-}
-
 static enum pci_ers_result pci_ers_merge_result(enum pci_ers_result old,
 						enum pci_ers_result new)
 {
-- 
2.22.0.216.g00a2a96fc9

