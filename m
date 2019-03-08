Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67414C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 15:35:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B54208E4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 15:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B54208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44GBQk1RYRzDqHL
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Mar 2019 02:35:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44GBNn2WsxzDqJ3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2019 02:33:44 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x28FT6EI026216
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2019 10:33:42 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2r3s366x0a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Mar 2019 10:33:41 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 8 Mar 2019 15:33:41 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 8 Mar 2019 15:33:38 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x28FXb4025100504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Mar 2019 15:33:37 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87FAFC6057;
 Fri,  8 Mar 2019 15:33:37 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38402C6059;
 Fri,  8 Mar 2019 15:33:37 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.1.126])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  8 Mar 2019 15:33:37 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 560D92E2D49; Fri,  8 Mar 2019 21:03:34 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH] pseries/energy: Use OF accessor functions to read ibm,
 drc-indexes
Date: Fri,  8 Mar 2019 21:03:24 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19030815-0036-0000-0000-00000A95EEC4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010727; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01171437; UDB=6.00612311; IPR=6.00952080; 
 MB=3.00025893; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-08 15:33:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030815-0037-0000-0000-00004AF751AD
Message-Id: <1552059204-18626-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-08_13:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903080108
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
Cc: "Pavithra R. Prakash" <pavrampu@in.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In cpu_to_drc_index() in the case when FW_FEATURE_DRC_INFO is absent,
we currently use of_read_property() to obtain the pointer to the array
corresponding to the property "ibm,drc-indexes". The elements of this
array are of type __be32, but are accessed without any conversion to
the OS-endianness, which is buggy on a Little Endian OS.

Fix this by using of_property_read_u32_index() accessor function to
safely read the elements of the array.

Fixes: commit e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
Cc: <stable@vger.kernel.org> #v4.16+
Reported-by: Pavithra R. Prakash <pavrampu@in.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/pseries_energy.c | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 6ed2212..1c4d1ba 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -77,18 +77,27 @@ static u32 cpu_to_drc_index(int cpu)
 
 		ret = drc.drc_index_start + (thread_index * drc.sequential_inc);
 	} else {
-		const __be32 *indexes;
-
-		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-		if (indexes == NULL)
-			goto err_of_node_put;
+		u32 nr_drc_indexes, thread_drc_index;
 
 		/*
-		 * The first element indexes[0] is the number of drc_indexes
-		 * returned in the list.  Hence thread_index+1 will get the
-		 * drc_index corresponding to core number thread_index.
+		 * The first element of ibm,drc-indexes array is the
+		 * number of drc_indexes returned in the list.  Hence
+		 * thread_index+1 will get the drc_index corresponding
+		 * to core number thread_index.
 		 */
-		ret = indexes[thread_index + 1];
+		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
+						0, &nr_drc_indexes);
+		if (rc)
+			goto err_of_node_put;
+
+		WARN_ON(thread_index > nr_drc_indexes);
+		rc = of_property_read_u32_index(dn, "ibm,drc-indexes",
+						thread_index + 1,
+						&thread_drc_index);
+		if (rc)
+			goto err_of_node_put;
+
+		ret = thread_drc_index;
 	}
 
 	rc = 0;
-- 
1.9.4

