Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2E0C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:25:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B025C20835
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 10:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B025C20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VVbQ5yk6zF1QT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 21:25:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aravinda@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VVYB5rxMzF1RD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 21:23:09 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9AAMdqB007434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 06:23:07 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n1fksg1qa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 06:23:06 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 04:23:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 04:23:03 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9AAN3xo35127318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 03:23:03 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06664BE053;
 Wed, 10 Oct 2018 04:23:03 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83B62BE04F;
 Wed, 10 Oct 2018 04:23:01 -0600 (MDT)
Received: from [127.0.1.1] (unknown [9.124.35.214])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 04:23:01 -0600 (MDT)
Subject: [PATCH] powerpc/pseries: Export maximum memory value
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Wed, 10 Oct 2018 15:52:59 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101010-0004-0000-0000-0000149B8505
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009853; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100569; UDB=6.00569431; IPR=6.00880617; 
 MB=3.00023693; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-10 10:23:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101010-0005-0000-0000-0000891B17D8
Message-Id: <153916697991.21165.5694207762066031403.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-10_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=745 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810100107
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
Cc: nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 aravinda@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch exports the maximum possible amount of memory
configured on the system via /proc/powerpc/lparcfg.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lparcfg.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 7c872dc..aa82f55 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/hugetlb.h>
 #include <asm/lppaca.h>
 #include <asm/hvcall.h>
 #include <asm/firmware.h>
@@ -36,6 +37,7 @@
 #include <asm/vio.h>
 #include <asm/mmu.h>
 #include <asm/machdep.h>
+#include <asm/drmem.h>
 
 #include "pseries.h"
 
@@ -433,6 +435,16 @@ static void parse_em_data(struct seq_file *m)
 		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
 }
 
+static void maxmem_data(struct seq_file *m)
+{
+	unsigned long maxmem = 0;
+
+	maxmem += drmem_info->n_lmbs * drmem_info->lmb_size;
+	maxmem += hugetlb_total_pages() * PAGE_SIZE;
+
+	seq_printf(m, "MaxMem=%ld\n", maxmem);
+}
+
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
@@ -491,6 +503,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
 #endif
 	parse_em_data(m);
+	maxmem_data(m);
 
 	return 0;
 }

