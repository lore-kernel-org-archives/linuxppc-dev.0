Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C891C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 15:00:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D072205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 15:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D072205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZJQK4ZRLzF3XV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 02:00:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=srikar@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZJN41L6gzF3Jx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 01:58:27 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9GEsi3P074887
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 10:58:25 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n5f7ehh77-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 10:58:24 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 16 Oct 2018 15:58:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 16 Oct 2018 15:58:19 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9GEwIrA5964200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 16 Oct 2018 14:58:18 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D5F752051;
 Tue, 16 Oct 2018 14:58:18 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.199.58.212])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09B3C5204E;
 Tue, 16 Oct 2018 14:58:16 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] powerpc/topology: Update numa mask when cpu node mapping
 changes
Date: Tue, 16 Oct 2018 20:28:01 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18101614-0008-0000-0000-000002804B64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101614-0009-0000-0000-000021E9AC1F
Message-Id: <1539701881-8652-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-16_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810160125
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Bringmann <mbringm@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 2ea626306810 ("powerpc/topology: Get topology for shared
processors at boot") will update the cpu node topology for shared lpars
on PowerVM.

However shared lpars on PowerVM also support VPHN and PRRN events.
On receiving a VPHN, PRRN events, cpu to node mapping might change.

Scheduler maintains sched_domains_numa_masks[], which is currently not
updated on cpu to node mapping changes. This can lead to machine
hangs or performance hit.

Fix numa_update_cpu_topology() to update sched_domains_numa_masks[].

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog: v1->v2:
- Updated changelog.
- Updated comments to refer to topology_inited.

 arch/powerpc/mm/numa.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3ea5b05ee6be..767c363ebafa 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -29,6 +29,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/sched/hotplug.h>
 #include <asm/cputhreads.h>
 #include <asm/sparsemem.h>
 #include <asm/prom.h>
@@ -1424,6 +1425,20 @@ int numa_update_cpu_topology(bool cpus_locked)
 		changed = 1;
 	}
 
+	/*
+	 * Scheduler maintains a sched_domain_numa_masks table that needs to
+	 * be updated whenever cpu-node mapping changes. Cpu-node mapping
+	 * changes only with VPHN and PRRN. 'topology_inited' indicates if
+	 * cpu-hotplug infrastructure is initialized and good to use.
+	 */
+	if (!(topology_inited && (vphn_enabled || prrn_enabled)))
+		goto out;
+
+	for_each_cpu(cpu, &updated_cpus) {
+		sched_cpu_deactivate(cpu);
+		sched_cpu_activate(cpu);
+	}
+
 out:
 	kfree(updates);
 	topology_update_needed = 0;
-- 
2.12.3

