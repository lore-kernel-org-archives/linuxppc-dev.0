Return-Path: <SRS0=kVu9=TQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE526C04E84
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 02:41:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382E620862
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 02:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382E620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 454Fzs5rgbzDqd9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 12:41:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tyreld@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 454FwX0GwCzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2019 12:38:35 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4G2bGXx113114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 22:38:33 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2sgxyx0hdk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 22:38:33 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.ibm.com>;
 Thu, 16 May 2019 03:38:33 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 16 May 2019 03:38:26 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x4G2bAE431457388
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 May 2019 02:37:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D20D928059;
 Thu, 16 May 2019 02:37:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CDF42805A;
 Thu, 16 May 2019 02:37:09 +0000 (GMT)
Received: from ltcalpine2-lp11.aus.stglabs.ibm.com (unknown [9.40.195.194])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Thu, 16 May 2019 02:37:09 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 2/3] powerpc/pseries: Disable PRRN memory device tree trigger
Date: Wed, 15 May 2019 21:37:05 -0500
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190516023706.50118-1-tyreld@linux.ibm.com>
References: <20190516023706.50118-1-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051602-0040-0000-0000-000004F058E5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011104; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01203940; UDB=6.00631989; IPR=6.00984869; 
 MB=3.00026909; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-16 02:38:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051602-0041-0000-0000-000008FC6832
Message-Id: <20190516023706.50118-2-tyreld@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-16_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=790 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905160017
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
Cc: nathanl@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, mingming.cao@ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Memory affintiy updates as currently implemented have proved unstable.

This patch comments out the PRRN hook for the time being while we
investigate how to either stablize the current implementation or find a
better approach.

Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/mobility.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 88925f8ca8a0..660a2dbc43d7 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -242,13 +242,15 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
 
 static void prrn_update_node(__be32 phandle)
 {
+	/* PRRN Memory Updates have proved unstable. Disable for the time being.
+	 *
 	struct pseries_hp_errorlog hp_elog;
 	struct device_node *dn;
 
-	/*
+	 *
 	 * If a node is found from a the given phandle, the phandle does not
 	 * represent the drc index of an LMB and we can ignore.
-	 */
+	 *
 	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
 	if (dn) {
 		of_node_put(dn);
@@ -261,6 +263,7 @@ static void prrn_update_node(__be32 phandle)
 	hp_elog._drc_u.drc_index = phandle;
 
 	handle_dlpar_errorlog(&hp_elog);
+	*/
 }
 
 int pseries_devicetree_update(s32 scope)
-- 
2.18.1

