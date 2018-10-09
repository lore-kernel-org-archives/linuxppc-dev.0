Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C80BC64EB0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:47:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53DD213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 20:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53DD213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V8Rn4d5WzF323
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 07:47:17 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V8DS0QXwzF31T
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 07:37:27 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w99KSlEW129160
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Oct 2018 16:37:26 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n11vam0w4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 16:37:26 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 9 Oct 2018 16:37:25 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 9 Oct 2018 16:37:22 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w99KbLt81245692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Oct 2018 20:37:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 443BFB205F;
 Tue,  9 Oct 2018 16:35:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E91CB2064;
 Tue,  9 Oct 2018 16:35:24 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (unknown [9.40.195.192])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  9 Oct 2018 16:35:24 -0400 (EDT)
Received: from ltcalpine2-lp9.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltcalpine2-lp9.aus.stglabs.ibm.com (Postfix) with ESMTP id F01F4283621F;
 Tue,  9 Oct 2018 15:37:20 -0500 (CDT)
Subject: [PATCH v04 4/4] migration/memory: Support 'ibm,dynamic-memory-v2'
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mwb@linux.vnet.ibm.com
Date: Tue, 09 Oct 2018 15:37:20 -0500
In-Reply-To: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
References: <20181009203520.26091.86781.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100920-0060-0000-0000-000002BE12DB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009849; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01100294; UDB=6.00569266; IPR=6.00880342; 
 MB=3.00023685; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-09 20:37:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100920-0061-0000-0000-000046C9E7D4
Message-Id: <20181009203708.26091.68681.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-09_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=997 adultscore=0 classifier=spam adjust=0 reason=mlx
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

migration/memory: This patch adds recognition for changes to the
associativity of memory blocks described by 'ibm,dynamic-memory-v2'.
If the associativity of an LMB has changed, it should be readded to
the system in order to update local and general kernel data structures.
This patch builds upon previous enhancements that scan the device-tree
"ibm,dynamic-memory" properties using the base LMB array, and a copy
derived from the updated properties.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index a7ca22e..233ef02 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -1180,7 +1180,8 @@ static int pseries_memory_notifier(struct notifier_block *nb,
 		err = pseries_remove_mem_node(rd->dn);
 		break;
 	case OF_RECONFIG_UPDATE_PROPERTY:
-		if (!strcmp(rd->prop->name, "ibm,dynamic-memory")) {
+		if (!strcmp(rd->prop->name, "ibm,dynamic-memory") ||
+		    !strcmp(rd->prop->name, "ibm,dynamic-memory-v2")) {
 			struct drmem_lmb_info *dinfo =
 				drmem_lmbs_init(rd->prop);
 			if (!dinfo)

