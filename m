Return-Path: <SRS0=8l9v=3G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0610DC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 13:14:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90223206E6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 13:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90223206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47zhNZ6V17zDqsD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jan 2020 00:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=kjain@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47zgnQ194czDqqY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 23:47:21 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00HClF1L045288
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 07:47:16 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qrm1x9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 07:47:16 -0500
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kjain@linux.ibm.com>;
 Fri, 17 Jan 2020 12:47:14 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 17 Jan 2020 12:47:07 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00HCl6fo58785796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2020 12:47:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48C9BAE04D;
 Fri, 17 Jan 2020 12:47:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 75DABAE051;
 Fri, 17 Jan 2020 12:47:01 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.44.232])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 17 Jan 2020 12:47:01 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [RFC 6/6] perf/tools/pmu-events/powerpc: Add hv_24x7 socket/chip
 level metric events
Date: Fri, 17 Jan 2020 18:16:20 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200117124620.26094-1-kjain@linux.ibm.com>
References: <20200117124620.26094-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011712-0016-0000-0000-000002DE4358
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011712-0017-0000-0000-00003340DF2F
Message-Id: <20200117124620.26094-7-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-17_03:2020-01-16,
 2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170102
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
Cc: ravi.bangoria@linux.ibm.com, maddy@linux.vnet.ibm.com, jmario@redhat.com,
 mpetlan@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
 anju@linux.vnet.ibm.com, jolsa@kernel.org, kjain@linux.ibm.com,
 namhyung@kernel.org, mingo@kernel.org, kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The hv_24×7 feature in IBM® POWER9™ processor-based servers provide the
facility to continuously collect large numbers of hardware performance
metrics efficiently and accurately.
This patch adds hv_24x7 json metric file for different Socket/chip
resources.

Result:

power9 platform:

command:# ./perf stat --metric-only -M Memory_RD_BW_Chip? -C 0
	   -I 1000 sleep 1

time MB       Memory_RD_BW_Chip_0 MB   Memory_RD_BW_Chip_1 MB
1.000192635                      0.4                      0.0
1.001695883                      0.0                      0.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../arch/powerpc/power9/hv_24x7_metrics.json  | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
new file mode 100644
index 000000000000..52d0116e61c2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power9/hv_24x7_metrics.json
@@ -0,0 +1,64 @@
+[
+    {
+        "MetricExpr": "(hv_24x7@PM_MCS01_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_RD_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_RD_DISP_PORT23\\,chip\\=?@)",
+        "MetricName": "Memory_RD_BW_Chip?",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_MCS01_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS01_128B_WR_DISP_PORT23\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT01\\,chip\\=?@ + hv_24x7@PM_MCS23_128B_WR_DISP_PORT23\\,chip\\=?@ )",
+        "MetricName": "Memory_WR_BW_Chip?",
+        "MetricGroup": "Memory_BW",
+        "ScaleUnit": "1.6e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK0_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK0_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS0_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK1_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK1_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS1_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_DATA_THRUPUT?",
+        "ScaleUnit": "6.5e-2MB"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_DATA_COUNT\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_DATA_COUNT\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_DATA_UTILIZATION?",
+        "ScaleUnit": "53.125%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_XLINK2_OUT_ODD_TOTAL_UTIL\\,chip\\=?@ + hv_24x7@PM_XLINK2_OUT_EVEN_TOTAL_UTIL\\,chip\\=?@ )",
+        "MetricName": "XBUS2_OUT_TOTAL_UTILIZATION?",
+        "ScaleUnit": "50%"
+    },
+    {
+    "MetricExpr": "(hv_24x7@PM_PB_CYC\\,chip\\=?@ )",
+        "MetricName": "PowerBUS_Frequency?",
+        "ScaleUnit": "2.56e-7GHz"
+    }
+]
-- 
2.18.1

