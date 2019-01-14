Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7403DC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 04:14:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E6620659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 04:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E6620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dKqK5MFgzDqQY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 15:14:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ravi.bangoria@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dKnd66d0zDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 15:12:53 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 x0E45MMZ103905
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 23:12:50 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2q0hk4jn52-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 23:12:50 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Mon, 14 Jan 2019 04:12:48 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Jan 2019 04:12:45 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0E4Cicl61276278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 04:12:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 344B0A4053;
 Mon, 14 Jan 2019 04:12:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C9D9A4051;
 Mon, 14 Jan 2019 04:12:41 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.56.2])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 14 Jan 2019 04:12:41 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: acme@kernel.org
Subject: [PATCH] perf mem/c2c: Fix perf_mem_events to support powerpc
Date: Mon, 14 Jan 2019 09:44:02 +0530
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011404-0016-0000-0000-000002450CD8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011404-0017-0000-0000-0000329F1BBF
Message-Id: <20190114041402.14033-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-14_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140034
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
Cc: dzickus@redhat.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, fowles@inreach.com,
 linux-kernel@vger.kernel.org, jmario@redhat.com, namhyung@kernel.org,
 jolsa@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Powerpc hw does not have inbuilt latency filter (--ldlat) for mem-load
event and, perf_mem_events by default includes ldlat=30 which is
causing failure on powerpc. Refactor code to support perf mem/c2c on
powerpc.

This patch depends on kernel side changes done my Madhavan:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-December/182596.html

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/Documentation/perf-c2c.txt | 16 ++++++++++++----
 tools/perf/Documentation/perf-mem.txt |  2 +-
 tools/perf/arch/x86/util/Build        |  1 +
 tools/perf/arch/x86/util/mem-events.c | 25 +++++++++++++++++++++++++
 tools/perf/util/mem-events.c          | 26 ++++----------------------
 tools/perf/util/mem-events.h          |  2 ++
 6 files changed, 45 insertions(+), 27 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/mem-events.c

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 095aebd..4e12551 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -19,8 +19,11 @@ C2C stands for Cache To Cache.
 The perf c2c tool provides means for Shared Data C2C/HITM analysis. It allows
 you to track down the cacheline contentions.
 
-The tool is based on x86's load latency and precise store facility events
-provided by Intel CPUs. These events provide:
+On x86, the tool is based on load latency and precise store facility events
+provided by Intel CPUs. On PowerPC, the tool uses random instruction sampling
+with thresholding feature.
+
+These events provide:
   - memory address of the access
   - type of the access (load and store details)
   - latency (in cycles) of the load access
@@ -46,7 +49,7 @@ RECORD OPTIONS
 
 -l::
 --ldlat::
-	Configure mem-loads latency.
+	Configure mem-loads latency. (x86 only)
 
 -k::
 --all-kernel::
@@ -119,11 +122,16 @@ Following perf record options are configured by default:
   -W,-d,--phys-data,--sample-cpu
 
 Unless specified otherwise with '-e' option, following events are monitored by
-default:
+default on x86:
 
   cpu/mem-loads,ldlat=30/P
   cpu/mem-stores/P
 
+and following on PowerPC:
+
+  cpu/mem-loads/P
+  cpu/mem-stores/P
+
 User can pass any 'perf record' option behind '--' mark, like (to enable
 callchains and system wide monitoring):
 
diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index f8d2167..199ea0f 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -82,7 +82,7 @@ RECORD OPTIONS
 	Be more verbose (show counter open errors, etc)
 
 --ldlat <n>::
-	Specify desired latency for loads event.
+	Specify desired latency for loads event. (x86 only)
 
 In addition, for report all perf report options are valid, and for record
 all perf record options.
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 844b8f3..9827240 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ libperf-y += perf_regs.o
 libperf-y += group.o
 libperf-y += machine.o
 libperf-y += event.o
+libperf-y += mem-events.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
new file mode 100644
index 0000000..5b4dcfe
--- /dev/null
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "mem-events.h"
+
+struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+	PERF_MEM_EVENT("ldlat-loads", "cpu/mem-loads,ldlat=%u/P", "mem-loads"),
+	PERF_MEM_EVENT("ldlat-stores", "cpu/mem-stores/P", "mem-stores"),
+};
+
+static char mem_loads_name[100];
+static bool mem_loads_name__init;
+
+char *perf_mem_events__name(int i)
+{
+	if (i == PERF_MEM_EVENTS__LOAD) {
+		if (!mem_loads_name__init) {
+			mem_loads_name__init = true;
+			scnprintf(mem_loads_name, sizeof(mem_loads_name),
+				  perf_mem_events[i].name,
+				  perf_mem_events__loads_ldlat);
+		}
+		return mem_loads_name;
+	}
+
+	return (char *)perf_mem_events[i].name;
+}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 93f74d8..1ffefd3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -15,31 +15,13 @@
 
 unsigned int perf_mem_events__loads_ldlat = 30;
 
-#define E(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
-
-struct perf_mem_event perf_mem_events[PERF_MEM_EVENTS__MAX] = {
-	E("ldlat-loads",	"cpu/mem-loads,ldlat=%u/P",	"mem-loads"),
-	E("ldlat-stores",	"cpu/mem-stores/P",		"mem-stores"),
+struct perf_mem_event __weak perf_mem_events[PERF_MEM_EVENTS__MAX] = {
+	PERF_MEM_EVENT("ldlat-loads", "cpu/mem-loads/P", "mem-loads"),
+	PERF_MEM_EVENT("ldlat-stores", "cpu/mem-stores/P", "mem-stores"),
 };
-#undef E
-
-#undef E
-
-static char mem_loads_name[100];
-static bool mem_loads_name__init;
 
-char *perf_mem_events__name(int i)
+char * __weak perf_mem_events__name(int i)
 {
-	if (i == PERF_MEM_EVENTS__LOAD) {
-		if (!mem_loads_name__init) {
-			mem_loads_name__init = true;
-			scnprintf(mem_loads_name, sizeof(mem_loads_name),
-				  perf_mem_events[i].name,
-				  perf_mem_events__loads_ldlat);
-		}
-		return mem_loads_name;
-	}
-
 	return (char *)perf_mem_events[i].name;
 }
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index a889ec2..4cb6935 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -16,6 +16,8 @@ struct perf_mem_event {
 	const char	*sysfs_name;
 };
 
+#define PERF_MEM_EVENT(t, n, s) { .tag = t, .name = n, .sysfs_name = s }
+
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
-- 
1.8.3.1

