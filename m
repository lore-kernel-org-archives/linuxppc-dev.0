Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D81C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 20:57:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B5C206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 20:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B5C206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GjXc0CXtzDrQm
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Dec 2018 07:57:04 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GjPP63LSzDr6y
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Dec 2018 07:50:49 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBEKmxPu025281
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 15:50:46 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pchv3n542-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 15:50:46 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Fri, 14 Dec 2018 20:50:45 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 14 Dec 2018 20:50:44 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBEKohn821495810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Dec 2018 20:50:43 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 179BD112067;
 Fri, 14 Dec 2018 20:50:43 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0508011206B;
 Fri, 14 Dec 2018 20:50:43 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 14 Dec 2018 20:50:42 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id A621A40E516A;
 Fri, 14 Dec 2018 14:50:42 -0600 (CST)
Subject: [RFC 2/6] pseries/drcinfo: Fix bug parsing ibm,drc-info
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 14 Dec 2018 14:50:42 -0600
In-Reply-To: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121420-2213-0000-0000-0000032B2A38
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131804; UDB=6.00588226; IPR=6.00911935; 
 MB=3.00024694; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 20:50:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121420-2214-0000-0000-00005C9B8671
Message-Id: <20181214205031.16435.20276.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-14_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=930 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140176
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
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Replace use of of_prop_next_u32() in when parsing 'ibm,drc-info'
structure to simplify and reduce parsing code.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmware feature" -- end of patch series applied to powerpc next)
---
 arch/powerpc/platforms/pseries/of_helpers.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/of_helpers.c b/arch/powerpc/platforms/pseries/of_helpers.c
index 6df192f..0185e50 100644
--- a/arch/powerpc/platforms/pseries/of_helpers.c
+++ b/arch/powerpc/platforms/pseries/of_helpers.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+
 #include <linux/string.h>
 #include <linux/err.h>
 #include <linux/slab.h>
@@ -6,6 +7,9 @@
 #include <asm/prom.h>
 
 #include "of_helpers.h"
+#include "pseries.h"
+
+#define	MAX_DRC_NAME_LEN 64
 
 /**
  * pseries_of_derive_parent - basically like dirname(1)
@@ -65,29 +69,19 @@ int of_read_drc_info_cell(struct property **prop, const __be32 **curval,
 
 	/* Get drc-index-start:encode-int */
 	p2 = (const __be32 *)p;
-	p2 = of_prop_next_u32(*prop, p2, &data->drc_index_start);
-	if (!p2)
-		return -EINVAL;
+	data->drc_index_start = of_read_number(p2++, 1);
 
 	/* Get drc-name-suffix-start:encode-int */
-	p2 = of_prop_next_u32(*prop, p2, &data->drc_name_suffix_start);
-	if (!p2)
-		return -EINVAL;
+	data->drc_name_suffix_start = of_read_number(p2++, 1);
 
 	/* Get number-sequential-elements:encode-int */
-	p2 = of_prop_next_u32(*prop, p2, &data->num_sequential_elems);
-	if (!p2)
-		return -EINVAL;
+	data->num_sequential_elems = of_read_number(p2++, 1);
 
 	/* Get sequential-increment:encode-int */
-	p2 = of_prop_next_u32(*prop, p2, &data->sequential_inc);
-	if (!p2)
-		return -EINVAL;
+	data->sequential_inc = of_read_number(p2++, 1);
 
 	/* Get drc-power-domain:encode-int */
-	p2 = of_prop_next_u32(*prop, p2, &data->drc_power_domain);
-	if (!p2)
-		return -EINVAL;
+	data->drc_power_domain = of_read_number(p2++, 1);
 
 	/* Should now know end of current entry */
 	(*curval) = (void *)p2;

