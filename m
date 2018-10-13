Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC9C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:42:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C7920652
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 21:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C7920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XdTq4sSxzF3SY
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 08:42:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XdKd1ysCzF3HF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 08:35:33 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9DLXrG9012578
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n3d7m1qe5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 17:35:31 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Sat, 13 Oct 2018 17:35:29 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 13 Oct 2018 17:35:28 -0400
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9DLZRUc43974906
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 13 Oct 2018 21:35:27 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AD3FFAE05C;
 Sat, 13 Oct 2018 17:33:23 -0400 (EDT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 920E6AE064;
 Sat, 13 Oct 2018 17:33:23 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat, 13 Oct 2018 17:33:23 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 95E5320FBAB7;
 Sat, 13 Oct 2018 16:35:26 -0500 (CDT)
Subject: [PATCH v05 3/5] migration/memory: Add hotplug READD_MULTIPLE
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Sat, 13 Oct 2018 16:35:26 -0500
In-Reply-To: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181013213434.4237.33531.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18101321-0052-0000-0000-000003433664
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009874; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01102233; UDB=6.00570430; IPR=6.00882278; 
 MB=3.00023746; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-13 21:35:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101321-0053-0000-0000-00005E678470
Message-Id: <20181013213519.4237.74654.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-13_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810130202
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
Cc: Juliet Kim <minkim@us.ibm.com>, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

migration/memory: This patch adds a new pseries hotplug action
for CPU and memory operations, PSERIES_HP_ELOG_ACTION_READD_MULTIPLE.
This is a variant of the READD operation which performs the action
upon multiple instances of the resource at one time.  The operation
is to be triggered by device-tree analysis of updates by RTAS events
analyzed by 'migation_store' during post-migration processing.  It
will be used for memory updates, initially.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in v05:
  -- Provide dlpar_memory_readd_helper routine to compress some common code
Changes in v04:
  -- Move init of 'lmb->internal_flags' in init_drmem_v2_lmbs to
     previous patch.
  -- Pull in implementation of dlpar_memory_readd_multiple() to go
     with operation flag.
---
 arch/powerpc/include/asm/rtas.h                 |    1 +
 arch/powerpc/platforms/pseries/hotplug-memory.c |   44 ++++++++++++++++++++---
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
index 0183e95..cc00451 100644
--- a/arch/powerpc/include/asm/rtas.h
+++ b/arch/powerpc/include/asm/rtas.h
@@ -333,6 +333,7 @@ struct pseries_hp_errorlog {
 #define PSERIES_HP_ELOG_ACTION_ADD	1
 #define PSERIES_HP_ELOG_ACTION_REMOVE	2
 #define PSERIES_HP_ELOG_ACTION_READD	3
+#define PSERIES_HP_ELOG_ACTION_READD_MULTIPLE	4
 
 #define PSERIES_HP_ELOG_ID_DRC_NAME	1
 #define PSERIES_HP_ELOG_ID_DRC_INDEX	2
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9a15d39..2b12deb 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -512,6 +512,19 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
 	return rc;
 }
 
+static int dlpar_memory_readd_helper(struct drmem_lmb *lmb)
+{
+	int rc;
+
+	rc = dlpar_remove_lmb(lmb);
+	if (!rc) {
+		rc = dlpar_add_lmb(lmb);
+		if (rc)
+			dlpar_release_drc(lmb->drc_index);
+	}
+	return rc;
+}
+
 static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	struct drmem_lmb *lmb;
@@ -524,12 +537,7 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 	for_each_drmem_lmb(lmb) {
 		if (lmb->drc_index == drc_index) {
 			lmb_found = 1;
-			rc = dlpar_remove_lmb(lmb);
-			if (!rc) {
-				rc = dlpar_add_lmb(lmb);
-				if (rc)
-					dlpar_release_drc(lmb->drc_index);
-			}
+			rc = dlpar_memory_readd_helper(lmb);
 			break;
 		}
 	}
@@ -546,6 +554,23 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 	return rc;
 }
 
+static int dlpar_memory_readd_multiple(void)
+{
+	struct drmem_lmb *lmb;
+	int rc;
+
+	pr_info("Attempting to update multiple LMBs\n");
+
+	for_each_drmem_lmb(lmb) {
+		if (drmem_lmb_update(lmb)) {
+			rc = dlpar_memory_readd_helper(lmb);
+			drmem_remove_lmb_update(lmb);
+		}
+	}
+
+	return rc;
+}
+
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
 	struct drmem_lmb *lmb, *start_lmb, *end_lmb;
@@ -646,6 +671,10 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
 }
+static int dlpar_memory_readd_multiple(void)
+{
+	return -EOPNOTSUPP;
+}
 
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
@@ -923,6 +952,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		drc_index = hp_elog->_drc_u.drc_index;
 		rc = dlpar_memory_readd_by_index(drc_index);
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD_MULTIPLE:
+		rc = dlpar_memory_readd_multiple();
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;

