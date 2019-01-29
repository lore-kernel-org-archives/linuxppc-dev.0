Return-Path: <SRS0=r5zj=QF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4FBC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:07:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A012086C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Jan 2019 17:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A012086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ptGV5Rs4zDqKv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 04:07:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ptBs47cjzDqPj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 04:04:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x0TGwpwG047388
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 12:04:19 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qasgb5758-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jan 2019 12:04:18 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 29 Jan 2019 17:04:17 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 29 Jan 2019 17:04:14 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x0TH4DBk21299390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Jan 2019 17:04:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD6CDBE054;
 Tue, 29 Jan 2019 17:04:13 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 644B9BE051;
 Tue, 29 Jan 2019 17:04:13 +0000 (GMT)
Received: from oc8380061452.ibm.com (unknown [9.53.179.224])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 29 Jan 2019 17:04:13 +0000 (GMT)
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20190129165514.14612.16201.stgit@ltcalpine2-lp20.aus.stglabs.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [REPOST PATCH v07 3/5] migration/memory: Add hotplug READD_MULTIPLE
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 mQENBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAG0LU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPokBOAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/UrkBDQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABiQEfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Tue, 29 Jan 2019 11:04:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19012917-0036-0000-0000-00000A82AD10
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010499; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153538; UDB=6.00601408; IPR=6.00933904; 
 MB=3.00025341; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-29 17:04:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012917-0037-0000-0000-00004A86A664
Message-Id: <d66dda98-7c57-a0c3-52f3-c6ea93aa4905@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-01-29_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=949 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290127
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
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.vnet.ibm.com>
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
index 2b796da..9c76345 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -507,6 +507,19 @@ static int dlpar_memory_remove_by_index(u32 drc_index)
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
@@ -519,12 +532,7 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
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
@@ -541,6 +549,23 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
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
@@ -641,6 +666,10 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
 {
 	return -EOPNOTSUPP;
 }
+static int dlpar_memory_readd_multiple(void)
+{
+	return -EOPNOTSUPP;
+}
 
 static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 {
@@ -918,6 +947,9 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
 		drc_index = hp_elog->_drc_u.drc_index;
 		rc = dlpar_memory_readd_by_index(drc_index);
 		break;
+	case PSERIES_HP_ELOG_ACTION_READD_MULTIPLE:
+		rc = dlpar_memory_readd_multiple();
+		break;
 	default:
 		pr_err("Invalid action (%d) specified\n", hp_elog->action);
 		rc = -EINVAL;

