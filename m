Return-Path: <SRS0=4G4N=V5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77961C433FF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 23:13:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D32206B8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 23:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D32206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4605gH4JQ9zDqwJ
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Aug 2019 09:12:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leonardo@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4605dH54C8zDql9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2019 09:11:15 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x71N7CLB013624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Aug 2019 19:11:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u49btgbpf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Aug 2019 19:11:10 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leonardo@linux.ibm.com>;
 Fri, 2 Aug 2019 00:11:10 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 2 Aug 2019 00:11:06 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x71NB5nl44826960
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Aug 2019 23:11:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1857BC606E;
 Thu,  1 Aug 2019 23:11:05 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CE5AC6073;
 Thu,  1 Aug 2019 23:11:02 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  1 Aug 2019 23:11:01 +0000 (GMT)
From: Leonardo Bras <leonardo@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] pseries/hotplug-memory.c: Change rc variable to bool
Date: Thu,  1 Aug 2019 20:10:55 -0300
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19080123-0016-0000-0000-000009D75B29
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240745; UDB=6.00654301; IPR=6.01022169; 
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 23:11:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080123-0017-0000-0000-000044429749
Message-Id: <20190801231055.19603-1-leonardo@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-01_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=793 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010244
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
Cc: Rob Herring <robh@kernel.org>, David Hildenbrand <david@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 YueHaibing <yuehaibing@huawei.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Leonardo Bras <leonardo@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Changes the return variable to bool (as the return value) and
avoids doing a ternary operation before returning.

Also, since rc will always be true, there is no need to do
rc &= bool, as (true && X) will result in X.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 8e700390f3d6..392deb4855e5 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -338,7 +338,7 @@ static int pseries_remove_mem_node(struct device_node *np)
 static bool lmb_is_removable(struct drmem_lmb *lmb)
 {
 	int i, scns_per_block;
-	int rc = 1;
+	bool rc = true;
 	unsigned long pfn, block_sz;
 	u64 phys_addr;
 
@@ -363,11 +363,11 @@ static bool lmb_is_removable(struct drmem_lmb *lmb)
 		if (!pfn_present(pfn))
 			continue;
 
-		rc &= is_mem_section_removable(pfn, PAGES_PER_SECTION);
+		rc = is_mem_section_removable(pfn, PAGES_PER_SECTION);
 		phys_addr += MIN_MEMORY_BLOCK_SIZE;
 	}
 
-	return rc ? true : false;
+	return rc;
 }
 
 static int dlpar_add_lmb(struct drmem_lmb *);
-- 
2.20.1

