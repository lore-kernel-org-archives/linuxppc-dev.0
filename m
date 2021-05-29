Return-Path: <SRS0=DHJf=KY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7D4C4708E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 07:41:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBC361205
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 07:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBC361205
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FsYQD50wqz3bsg
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 May 2021 17:41:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FCB2QLim;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=FCB2QLim; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FsYN63xv4z2yRJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 May 2021 17:39:18 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14T7YTwZ135401; Sat, 29 May 2021 03:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PVnZSToWmacChqjMvLKy6QaTTMDLulv8rh8Iy0VDxUk=;
 b=FCB2QLim71/sbJHuGHKlrdeAGgcnFi3dEw47w+IEWhYsjzj1iBhY4l8QY8uajqZvB/R8
 Bu/2ClvrrEW2LM8M1T0wU07paLvGLlHuvOspQt+fvv6Bg1Da8QXfg/b1rRfw1HRQJWa8
 VtGLkTb1EzxtGIyD6427dSEdZzBL7ihyl+tjCHORz4TAy0Z/Evn10MFXy5JcOs2d0/r9
 Od4/pN4SNIZllUsZxToBFXWODs1Z8z57QagBVwrzqMosvHgPVlrExB8DTaA6yiUIQDsd
 Tk9DsNuD+fL4VaWruXDfbC3zEqN6V+8dTqJPp7W8gQKB59cLAtbHQ0zw6wh6weF3T4Cn SA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 38ufrmtb5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 May 2021 03:38:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 14T7cnGK001849;
 Sat, 29 May 2021 07:38:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma03ams.nl.ibm.com with ESMTP id 38ud88825x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 29 May 2021 07:38:49 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 14T7ckQ128246490
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 29 May 2021 07:38:46 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A4C74C046;
 Sat, 29 May 2021 07:38:46 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8DD734C040;
 Sat, 29 May 2021 07:38:42 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.45.117])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Sat, 29 May 2021 07:38:42 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: [RFC v3 1/4] drivers/nvdimm: Add nvdimm pmu structure
Date: Sat, 29 May 2021 13:08:25 +0530
Message-Id: <20210529073828.1542292-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210529073828.1542292-1-kjain@linux.ibm.com>
References: <20210529073828.1542292-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6BDZKzp0WaBS2IrrcAkDuugpaCOohIQu
X-Proofpoint-ORIG-GUID: 6BDZKzp0WaBS2IrrcAkDuugpaCOohIQu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-29_03:2021-05-27,
 2021-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105290058
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
Cc: santosh@fossix.org, maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
 aneesh.kumar@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
 vaibhav@linux.ibm.com, dan.j.williams@intel.com, ira.weiny@intel.com,
 tglx@linutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A structure is added called nvdimm_pmu for performance
stats reporting support of nvdimm devices. It can be used to add
nvdimm pmu data such as supported events and pmu event functions
like event_init/add/read/del with cpu hotplug support.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 include/linux/nd.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/linux/nd.h b/include/linux/nd.h
index ee9ad76afbba..3baeeb7c3c41 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -8,6 +8,8 @@
 #include <linux/ndctl.h>
 #include <linux/device.h>
 #include <linux/badblocks.h>
+#include <linux/platform_device.h>
+#include <linux/perf_event.h>
 
 enum nvdimm_event {
 	NVDIMM_REVALIDATE_POISON,
@@ -23,6 +25,43 @@ enum nvdimm_claim_class {
 	NVDIMM_CCLASS_UNKNOWN,
 };
 
+/* Event attribute array index */
+#define NVDIMM_PMU_FORMAT_ATTR		0
+#define NVDIMM_PMU_EVENT_ATTR		1
+#define NVDIMM_PMU_CPUMASK_ATTR		2
+#define NVDIMM_PMU_NULL_ATTR		3
+
+/**
+ * struct nvdimm_pmu - data structure for nvdimm perf driver
+ *
+ * @name: name of the nvdimm pmu device.
+ * @pmu: pmu data structure for nvdimm performance stats.
+ * @dev: nvdimm device pointer.
+ * @functions(event_init/add/del/read): platform specific pmu functions.
+ * @attr_groups: data structure for events, formats and cpumask
+ * @cpu: designated cpu for counter access.
+ * @node: node for cpu hotplug notifier link.
+ * @cpuhp_state: state for cpu hotplug notification.
+ */
+struct nvdimm_pmu {
+	const char *name;
+	struct pmu pmu;
+	struct device *dev;
+	int (*event_init)(struct perf_event *event);
+	int  (*add)(struct perf_event *event, int flags);
+	void (*del)(struct perf_event *event, int flags);
+	void (*read)(struct perf_event *event);
+	/*
+	 * Attribute groups for the nvdimm pmu. Index 0 used for
+	 * format attribute, index 1 used for event attribute,
+	 * index 2 used for cpusmask attribute and index 3 kept as NULL.
+	 */
+	const struct attribute_group *attr_groups[4];
+	int cpu;
+	struct hlist_node node;
+	enum cpuhp_state cpuhp_state;
+};
+
 struct nd_device_driver {
 	struct device_driver drv;
 	unsigned long type;
-- 
2.27.0

