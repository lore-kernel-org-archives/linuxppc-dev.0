Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492D9C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 11:52:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21F72083C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 11:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21F72083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZDFW50L8zF3Vf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 22:52:31 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZDBw6PYdzF3LW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 22:50:16 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9GBibOG054807
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:50:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2n5dywc426-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:50:13 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Tue, 16 Oct 2018 07:50:13 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 07:50:10 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9GBo9nP57278598
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 11:50:09 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EBC1112062;
 Tue, 16 Oct 2018 07:49:29 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CBBC112066;
 Tue, 16 Oct 2018 07:49:27 -0400 (EDT)
Received: from [127.0.1.1] (unknown [9.85.71.130])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 16 Oct 2018 07:49:26 -0400 (EDT)
Subject: [PATCH v3] powerpc/pseries: Export raw per-CPU VPA data via debugfs
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Tue, 16 Oct 2018 17:20:05 +0530
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101611-0060-0000-0000-000002C1669F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009885; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01103471; UDB=6.00571176; IPR=6.00883523; 
 MB=3.00023776; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-16 11:50:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101611-0061-0000-0000-000046DD6261
Message-Id: <153969060579.20425.17023211720854729638.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160102
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

This patch exports the raw per-CPU VPA data via debugfs.
A per-CPU file is created which exports the VPA data of
that CPU to help debug some of the VPA related issues or
to analyze the per-CPU VPA related statistics.

v3: Removed offline CPU check.

v2: Included offline CPU check and other review comments.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c |   54 +++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index d3992ce..1c757a4 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -48,6 +48,7 @@
 #include <asm/kexec.h>
 #include <asm/fadump.h>
 #include <asm/asm-prototypes.h>
+#include <asm/debugfs.h>
 
 #include "pseries.h"
 
@@ -1028,3 +1029,56 @@ static int __init reserve_vrma_context_id(void)
 	return 0;
 }
 machine_device_initcall(pseries, reserve_vrma_context_id);
+
+#ifdef CONFIG_DEBUG_FS
+/* debugfs file interface for vpa data */
+static ssize_t vpa_file_read(struct file *filp, char __user *buf, size_t len,
+			      loff_t *pos)
+{
+	int cpu = (long)filp->private_data;
+	struct lppaca *lppaca = &lppaca_of(cpu);
+
+	return simple_read_from_buffer(buf, len, pos, lppaca,
+				sizeof(struct lppaca));
+}
+
+static const struct file_operations vpa_fops = {
+	.open		= simple_open,
+	.read		= vpa_file_read,
+	.llseek		= default_llseek,
+};
+
+static int __init vpa_debugfs_init(void)
+{
+	char name[16];
+	long i;
+	static struct dentry *vpa_dir;
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return 0;
+
+	vpa_dir = debugfs_create_dir("vpa", powerpc_debugfs_root);
+	if (!vpa_dir) {
+		pr_warn("%s: can't create vpa root dir\n", __func__);
+		return -ENOMEM;
+	}
+
+	/* set up the per-cpu vpa file*/
+	for_each_possible_cpu(i) {
+		struct dentry *d;
+
+		sprintf(name, "cpu-%ld", i);
+
+		d = debugfs_create_file(name, 0400, vpa_dir, (void *)i,
+					&vpa_fops);
+		if (!d) {
+			pr_warn("%s: can't create per-cpu vpa file\n",
+					__func__);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+machine_arch_initcall(pseries, vpa_debugfs_init);
+#endif /* CONFIG_DEBUG_FS */

