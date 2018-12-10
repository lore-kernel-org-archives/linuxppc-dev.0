Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4D7C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1582082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1582082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDfH0QD9zDq8D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:08:23 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DB7d24d4zDqmQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 05:15:09 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBAIDaTE025234
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:15:07 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9vh525eh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:15:06 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.ibm.com>;
 Mon, 10 Dec 2018 18:15:04 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 18:15:02 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBAIF1Q112189730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 18:15:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0451A52052;
 Mon, 10 Dec 2018 18:15:01 +0000 (GMT)
Received: from naverao1-tp.ibm.com (unknown [9.77.81.204])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E72A052054;
 Mon, 10 Dec 2018 18:14:59 +0000 (GMT)
From: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v1 1/2] powerpc/pseries: Generalize hcall_vphn()
Date: Mon, 10 Dec 2018 23:44:46 +0530
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
References: <cover.1544459267.git.naveen.n.rao@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18121018-0020-0000-0000-000002F518BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121018-0021-0000-0000-000021453B38
Message-Id: <89849f82d51056ad1a39f7649ddde9c46892b114.1544459267.git.naveen.n.rao@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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

H_HOME_NODE_ASSOCIATIVITY hcall can take two different flags and return
different associativity information in each case. Generalize the
existing hcall_vphn() function to take flags as an argument and to
return the result. Update the only existing user to pass the proper
arguments.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
---
 arch/powerpc/mm/numa.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 87f0dd004295..6677a578f18d 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1078,6 +1078,17 @@ static void reset_topology_timer(void);
 static int topology_timer_secs = 1;
 static int topology_inited;
 
+static long hcall_vphn(unsigned long cpu, u64 flags, __be32 *associativity)
+{
+	long rc;
+	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+
+	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, cpu);
+	vphn_unpack_associativity(retbuf, associativity);
+
+	return rc;
+}
+
 /*
  * Change polling interval for associativity changes.
  */
@@ -1156,25 +1167,13 @@ static int update_cpu_associativity_changes_mask(void)
  * Retrieve the new associativity information for a virtual processor's
  * home node.
  */
-static long hcall_vphn(unsigned long cpu, __be32 *associativity)
-{
-	long rc;
-	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
-	u64 flags = 1;
-	int hwcpu = get_hard_smp_processor_id(cpu);
-
-	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	vphn_unpack_associativity(retbuf, associativity);
-
-	return rc;
-}
-
 static long vphn_get_associativity(unsigned long cpu,
 					__be32 *associativity)
 {
 	long rc;
+	int hwcpu = get_hard_smp_processor_id(cpu);
 
-	rc = hcall_vphn(cpu, associativity);
+	rc = hcall_vphn(hwcpu, 1, associativity);
 
 	switch (rc) {
 	case H_FUNCTION:
-- 
2.19.2

