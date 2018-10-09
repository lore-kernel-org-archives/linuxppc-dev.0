Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46B2C64EB0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:43:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DCB213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DCB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V8M93QklzF2Fb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 07:43:17 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V8Cm66kDzF31T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 07:36:52 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w99KSk7M129084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Oct 2018 16:36:50 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n11vam07e-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:36:50 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 16:36:49 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
 by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Oct 2018 16:36:47 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w99KakIU36045012
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Oct 2018 20:36:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0D7A2805A;
 Tue,  9 Oct 2018 16:34:16 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87C6228058;
 Tue,  9 Oct 2018 16:34:16 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  9 Oct 2018 16:34:16 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id 34C53283621F;
 Tue,  9 Oct 2018 15:36:46 -0500 (CDT)
Subject: [PATCH v04 3/5] migration/memory: Add hotplug READD_MULTIPLE
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Tue, 09 Oct 2018 15:36:46 -0500
In-Reply-To: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100920-0072-0000-0000-000003B2304A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009849; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100294; UDB=6.00569266; IPR=6.00880342; 
 MB=3.00023685; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 20:36:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100920-0073-0000-0000-000049B2F935
Message-Id: <20181009203635.26091.67563.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-09_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=935 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810090194
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
Changes in v04:
  -- Move init of 'lmb->internal_flags' in init_drmem_v2_lmbs to
     previous patch.
  -- Pull in implementation of dlpar_memory_readd_multiple() to go
     with operation flag.
---
 arch/powerpc/include/asm/rtas.h                 |    1 +
 arch/powerpc/platforms/pseries/hotplug-memory.c |   31 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

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
index 9a15d39..bf2420a 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -546,6 +546,30 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
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
+			rc = dlpar_remove_lmb(lmb);
+
+			if (!rc) {
+				rc = dlpar_add_lmb(lmb);
+				if (rc)
+					dlpar_release_drc(lmb->drc_index);
+			}
+
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
@@ -646,6 +670,10 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
 }
+static int dlpar_memory_readd_multiple(void)
+{
+	return -EOPNOTSUPP;
+}
 
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
@@ -923,6 +951,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		drc_index = hp_elog->_drc_u.drc_index;
 		rc = dlpar_memory_readd_by_index(drc_index);
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD_MULTIPLE:
+		rc = dlpar_memory_readd_multiple();
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;

