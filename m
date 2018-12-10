Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B34C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:10:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4738204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4738204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDht0XXHzDqRS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:10:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=naveen.n.rao@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DB7g5TDrzDqmY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 05:15:11 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBAIDdSk127545
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:15:09 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9tjggsnt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:15:09 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.ibm.com>;
 Mon, 10 Dec 2018 18:15:07 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 18:15:05 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBAIF3dm2556298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 18:15:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 74C8652067;
 Mon, 10 Dec 2018 18:15:03 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.77.81.204])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6306F52054;
 Mon, 10 Dec 2018 18:15:02 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 2/2] powerpc/pseries: Add debugfs interface to retrieve
 VPHN info
Date: Mon, 10 Dec 2018 23:44:47 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
References: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121018-0020-0000-0000-000002F518BE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121018-0021-0000-0000-000021453B3B
Message-Id: <e308130fe45a8930743cec9aba83d4885ac8d30d.1544459267.git.naveen.n.rao@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100163
X-Mailman-Approved-At: Tue, 11 Dec 2018 06:55:18 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add debugfs interface to retrieve associativity information for lpar
vcpus (debugfs/vphn/lpar) and the hypervisor cpus (debugfs/vphn/hyp).
This information is useful to derive various metrics, including the vcpu
dispatch statistics in a SPLPAR environment.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 105 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 6677a578f18d..f0b0e87016e6 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -40,6 +40,7 @@
 #include <asm/setup.h>
 #include <asm/vdso.h>
 #include <asm/drmem.h>
+#include <asm/debugfs.h>
 
 static int numa_enabled = 1;
 
@@ -1089,6 +1090,107 @@ static long hcall_vphn(unsigned long cpu, u64 flags, __be32 *associativity)
 	return rc;
 }
 
+#ifdef CONFIG_DEBUG_FS
+static ssize_t vphn_lpar_cpu_file_read(struct file *filp, char __user *buf,
+		size_t len, loff_t *pos)
+{
+	int cpu = (long)filp->private_data;
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	int hwcpu = get_hard_smp_processor_id(cpu);
+	long int rc;
+
+	if (len != sizeof(associativity))
+		return -EINVAL;
+
+	rc = hcall_vphn(hwcpu, 1, associativity);
+	if (rc)
+		return -EFAULT;
+
+	rc = copy_to_user(buf, &associativity, sizeof(associativity));
+	if (rc)
+		return -EFAULT;
+
+	return sizeof(associativity);
+}
+
+static ssize_t vphn_hyp_cpu_file_read(struct file *filp, char __user *buf,
+		size_t len, loff_t *pos)
+{
+	int cpu = (long)filp->private_data;
+	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
+	long int rc;
+
+	if (len != sizeof(associativity))
+		return -EINVAL;
+
+	rc = hcall_vphn(cpu, 2, associativity);
+	if (rc)
+		return -EFAULT;
+
+	rc = copy_to_user(buf, &associativity, sizeof(associativity));
+	if (rc)
+		return -EFAULT;
+
+	return sizeof(associativity);
+}
+
+static const struct file_operations vphn_lpar_cpu_fops = {
+	.open		= simple_open,
+	.read		= vphn_lpar_cpu_file_read,
+	.llseek		= no_llseek,
+};
+
+static const struct file_operations vphn_hyp_cpu_fops = {
+	.open		= simple_open,
+	.read		= vphn_hyp_cpu_file_read,
+	.llseek		= no_llseek,
+};
+
+static int debug_init_vphn_entries(void)
+{
+	struct dentry *vphn_dir, *vphn_lpar_dir, *vphn_hyp_dir;
+	struct dentry *vphn_lpar_cpu_file, *vphn_hyp_cpu_file;
+	long cpu;
+	char name[10];
+
+	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
+		return 0;
+
+	vphn_dir = debugfs_create_dir("vphn", powerpc_debugfs_root);
+	if (!vphn_dir) {
+		pr_warn("%s: can't create vphn debugfs root dir\n", __func__);
+		return -ENOMEM;
+	}
+
+	vphn_lpar_dir = debugfs_create_dir("lpar", vphn_dir);
+	vphn_hyp_dir = debugfs_create_dir("hyp", vphn_dir);
+	if (!vphn_lpar_dir || !vphn_hyp_dir) {
+		pr_warn("%s: can't create vphn dir\n", __func__);
+		goto err_remove_dir;
+	}
+
+	for_each_possible_cpu(cpu) {
+		sprintf(name, "cpu-%ld", cpu);
+		vphn_lpar_cpu_file = debugfs_create_file(name, 0400,
+				vphn_lpar_dir, (void *)cpu, &vphn_lpar_cpu_fops);
+		vphn_hyp_cpu_file = debugfs_create_file(name, 0400,
+				vphn_hyp_dir, (void *)cpu, &vphn_hyp_cpu_fops);
+		if (!vphn_lpar_cpu_file || !vphn_hyp_cpu_file) {
+			pr_warn("%s: can't create vphn cpu file\n", __func__);
+			goto err_remove_dir;
+		}
+	}
+
+	return 0;
+
+err_remove_dir:
+	debugfs_remove_recursive(vphn_dir);
+	return -ENOMEM;
+}
+#else
+static int debug_init_vphn_entries(void) { return 0; }
+#endif /* CONFIG_DEBUG_FS */
+
 /*
  * Change polling interval for associativity changes.
  */
@@ -1619,6 +1721,9 @@ static int topology_update_init(void)
 	if (!proc_create("powerpc/topology_updates", 0644, NULL, &topology_ops))
 		return -ENOMEM;
 
+	if (!debug_init_vphn_entries())
+		return -ENOMEM;
+
 	topology_inited = 1;
 	return 0;
 }
-- 
2.19.2

