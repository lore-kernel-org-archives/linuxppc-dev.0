Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC2C32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 05:42:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B13E2085B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 05:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B13E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W0HJ1qbNzDqBy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 16:42:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W04H5SF5zF35Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 16:33:19 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9B5Sx9C067281
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:33:17 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n1y39u1hr-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 01:33:17 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 10 Oct 2018 23:33:16 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 10 Oct 2018 23:33:12 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9B5XBbj27263052
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Oct 2018 22:33:11 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 293C4BE04F;
 Wed, 10 Oct 2018 23:33:11 -0600 (MDT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D200ABE054;
 Wed, 10 Oct 2018 23:33:10 -0600 (MDT)
Received: from sofia.ibm.com (unknown [9.124.35.51])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 10 Oct 2018 23:33:10 -0600 (MDT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 4D3B62E3D80; Thu, 11 Oct 2018 11:03:09 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Oliver O'Halloran" <oohall@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Anton Blanchard <anton@samba.org>
Subject: [PATCH v10 3/3] powerpc/cacheinfo: Report the correct shared_cpu_map
 on big-cores
Date: Thu, 11 Oct 2018 11:03:03 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1539235983-25259-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1539235983-25259-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18101105-0012-0000-0000-000016C613D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009858; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100952; UDB=6.00569661; IPR=6.00880998; 
 MB=3.00023704; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-11 05:33:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101105-0013-0000-0000-000054B666B1
Message-Id: <1539235983-25259-4-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=823 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110052
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently on POWER9 SMT8 cores systems, in sysfs, we report the
shared_cache_map for L1 caches (both data and instruction) to be the
cpu-ids of the threads in SMT8 cores. This is incorrect since on
POWER9 SMT8 cores there are two groups of threads, each of which
shares its own L1 cache.

This patch addresses this by reporting the shared_cpu_map correctly in
sysfs for L1 caches.

Before the patch
   /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map : 000000ff
   /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map : 000000ff
   /sys/devices/system/cpu/cpu1/cache/index0/shared_cpu_map : 000000ff
   /sys/devices/system/cpu/cpu1/cache/index1/shared_cpu_map : 000000ff

After the patch
   /sys/devices/system/cpu/cpu0/cache/index0/shared_cpu_map : 00000055
   /sys/devices/system/cpu/cpu0/cache/index1/shared_cpu_map : 00000055
   /sys/devices/system/cpu/cpu1/cache/index0/shared_cpu_map : 000000aa
   /sys/devices/system/cpu/cpu1/cache/index1/shared_cpu_map : 000000aa

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/cacheinfo.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index a8f20e5..be57bd0 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -20,6 +20,8 @@
 #include <linux/percpu.h>
 #include <linux/slab.h>
 #include <asm/prom.h>
+#include <asm/cputhreads.h>
+#include <asm/smp.h>
 
 #include "cacheinfo.h"
 
@@ -627,17 +629,48 @@ static ssize_t level_show(struct kobject *k, struct kobj_attribute *attr, char *
 static struct kobj_attribute cache_level_attr =
 	__ATTR(level, 0444, level_show, NULL);
 
+static unsigned int index_dir_to_cpu(struct cache_index_dir *index)
+{
+	struct kobject *index_dir_kobj = &index->kobj;
+	struct kobject *cache_dir_kobj = index_dir_kobj->parent;
+	struct kobject *cpu_dev_kobj = cache_dir_kobj->parent;
+	struct device *dev = kobj_to_dev(cpu_dev_kobj);
+
+	return dev->id;
+}
+
+/*
+ * On big-core systems, each core has two groups of CPUs each of which
+ * has its own L1-cache. The thread-siblings which share l1-cache with
+ * @cpu can be obtained via cpu_smallcore_mask().
+ */
+static const struct cpumask *get_big_core_shared_cpu_map(int cpu, struct cache *cache)
+{
+	if (cache->level == 1)
+		return cpu_smallcore_mask(cpu);
+
+	return &cache->shared_cpu_map;
+}
+
 static ssize_t shared_cpu_map_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
 {
 	struct cache_index_dir *index;
 	struct cache *cache;
-	int ret;
+	const struct cpumask *mask;
+	int ret, cpu;
 
 	index = kobj_to_cache_index_dir(k);
 	cache = index->cache;
 
+	if (has_big_cores) {
+		cpu = index_dir_to_cpu(index);
+		mask = get_big_core_shared_cpu_map(cpu, cache);
+	} else {
+		mask  = &cache->shared_cpu_map;
+	}
+
 	ret = scnprintf(buf, PAGE_SIZE - 1, "%*pb\n",
-			cpumask_pr_args(&cache->shared_cpu_map));
+			cpumask_pr_args(mask));
 	buf[ret++] = '\n';
 	buf[ret] = '\0';
 	return ret;
-- 
1.9.4

