Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463AFC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 18:58:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8D1214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 18:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8D1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lT0Y50KXzDqSk
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 04:58:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nathanl@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lSyc0X3VzDqSB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 04:57:08 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3IIjh2c077602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 14:57:06 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rxups1rr6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 14:57:05 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nathanl@linux.ibm.com>;
 Thu, 18 Apr 2019 19:57:04 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 18 Apr 2019 19:57:02 +0100
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x3IIv05q36044892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Apr 2019 18:57:00 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03173124052;
 Thu, 18 Apr 2019 18:57:00 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0B86124054;
 Thu, 18 Apr 2019 18:56:59 +0000 (GMT)
Received: from localhost (unknown [9.85.201.6])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 18 Apr 2019 18:56:59 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/numa: improve control of topology updates
Date: Thu, 18 Apr 2019 13:56:57 -0500
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190418185658.29751-1-nathanl@linux.ibm.com>
References: <20190418185658.29751-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041818-0064-0000-0000-000003CD381F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010951; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01190966; UDB=6.00624129; IPR=6.00971764; 
 MB=3.00026504; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-18 18:57:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041818-0065-0000-0000-00003D1E4E90
Message-Id: <20190418185658.29751-2-nathanl@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-18_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=966 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904180116
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
Cc: srikar.dronamraju@in.ibm.com, mmc@linux.ibm.com, mwb@linux.ibm.com,
 julietk@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When booted with "topology_updates=no", or when "off" is written to
/proc/powerpc/topology_updates, NUMA reassignments are inhibited for
PRRN and VPHN events. However, migration and suspend unconditionally
re-enable reassignments via start_topology_update(). This is
incoherent.

Check the topology_updates_enabled flag in
start/stop_topology_update() so that callers of those APIs need not be
aware of whether reassignments are enabled. This allows the
administrative decision on reassignments to remain in force across
migrations and suspensions.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f976676004ad..48c9a97eb2c3 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1498,6 +1498,9 @@ int start_topology_update(void)
 {
 	int rc = 0;
 
+	if (!topology_updates_enabled)
+		return 0;
+
 	if (firmware_has_feature(FW_FEATURE_PRRN)) {
 		if (!prrn_enabled) {
 			prrn_enabled = 1;
@@ -1531,6 +1534,9 @@ int stop_topology_update(void)
 {
 	int rc = 0;
 
+	if (!topology_updates_enabled)
+		return 0;
+
 	if (prrn_enabled) {
 		prrn_enabled = 0;
 #ifdef CONFIG_SMP
@@ -1588,11 +1594,13 @@ static ssize_t topology_write(struct file *file, const char __user *buf,
 
 	kbuf[read_len] = '\0';
 
-	if (!strncmp(kbuf, "on", 2))
+	if (!strncmp(kbuf, "on", 2)) {
+		topology_updates_enabled = true;
 		start_topology_update();
-	else if (!strncmp(kbuf, "off", 3))
+	} else if (!strncmp(kbuf, "off", 3)) {
 		stop_topology_update();
-	else
+		topology_updates_enabled = false;
+	} else
 		return -EINVAL;
 
 	return count;
@@ -1607,9 +1615,7 @@ static const struct file_operations topology_ops = {
 
 static int topology_update_init(void)
 {
-	/* Do not poll for changes if disabled at boot */
-	if (topology_updates_enabled)
-		start_topology_update();
+	start_topology_update();
 
 	if (vphn_enabled)
 		topology_schedule_update();
-- 
2.20.1

