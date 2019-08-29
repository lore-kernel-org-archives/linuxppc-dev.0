Return-Path: <SRS0=bIL3=WZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199E6C3A59F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 06:36:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D6C2189D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 06:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D6C2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46JtD166GxzDqbc
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 16:36:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jt9q3ydbzDqNw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 16:34:07 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7T6WuOS146285; Thu, 29 Aug 2019 02:34:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2up7uj2mqv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 02:34:00 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7T6XL8L147640;
 Thu, 29 Aug 2019 02:34:00 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2up7uj2mqh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 02:33:59 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7T6TV1H016314;
 Thu, 29 Aug 2019 06:33:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 2unb3t3det-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Aug 2019 06:33:58 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7T6Xv0P59572704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 06:33:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E38EC6055;
 Thu, 29 Aug 2019 06:33:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 63FC8C6057;
 Thu, 29 Aug 2019 06:33:55 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.35.73])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 29 Aug 2019 06:33:55 +0000 (GMT)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/nvdimm: use H_SCM_QUERY hcall on H_OVERLAP error
Date: Thu, 29 Aug 2019 12:03:47 +0530
Message-Id: <20190829063347.13966-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829063347.13966-1-aneesh.kumar@linux.ibm.com>
References: <20190829063347.13966-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-29_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290070
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
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Right now we force an unbind of SCM memory at drcindex on H_OVERLAP error.
This really slows down operations like kexec where we get the H_OVERLAP
error because we don't go through a full hypervisor re init.

H_OVERLAP error for a H_SCM_BIND_MEM hcall indicates that SCM memory at
drc index is already bound. Since we don't specify a logical memory
address for bind hcall, we can use the H_SCM_QUERY hcall to query
the already bound logical address.

Boot time difference with and without patch is:

[    5.583617] IOMMU table initialized, virtual merging enabled
[    5.603041] papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Retrying bind after unbinding
[  301.514221] papr_scm ibm,persistent-memory:ibm,pmemory@44108001: Retrying bind after unbinding
[  340.057238] hv-24x7: read 1530 catalog entries, created 537 event attrs (0 failures), 275 descs

after fix

[    5.101572] IOMMU table initialized, virtual merging enabled
[    5.116984] papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Querying SCM details
[    5.117223] papr_scm ibm,persistent-memory:ibm,pmemory@44108001: Querying SCM details
[    5.120530] hv-24x7: read 1530 catalog entries, created 537 event attrs (0 failures), 275 descs

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 26 ++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 220e595cb579..4b74cfe7b334 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -110,6 +110,27 @@ static void drc_pmem_unbind(struct papr_scm_priv *p)
 	return;
 }
 
+static int drc_pmem_query(struct papr_scm_priv *p)
+{
+	unsigned long ret[PLPAR_HCALL_BUFSIZE];
+	int64_t rc;
+
+
+	rc = plpar_hcall(H_SCM_QUERY_BLOCK_MEM_BINDING, ret,
+			 p->drc_index, 0);
+
+	if (rc) {
+		dev_err(&p->pdev->dev, "Failed to bind SCM");
+		return rc;
+	}
+
+	p->bound_addr = ret[0];
+	dev_dbg(&p->pdev->dev, "bound drc 0x%x to %pR\n", p->drc_index, &p->res);
+
+	return 0;
+}
+
+
 static int papr_scm_meta_get(struct papr_scm_priv *p,
 			     struct nd_cmd_get_config_data_hdr *hdr)
 {
@@ -431,9 +452,8 @@ static int papr_scm_probe(struct platform_device *pdev)
 
 	/* If phyp says drc memory still bound then force unbound and retry */
 	if (rc == H_OVERLAP) {
-		dev_warn(&pdev->dev, "Retrying bind after unbinding\n");
-		drc_pmem_unbind(p);
-		rc = drc_pmem_bind(p);
+		dev_warn(&pdev->dev, "Querying SCM details\n");
+		rc = drc_pmem_query(p);
 	}
 
 	if (rc != H_SUCCESS) {
-- 
2.21.0

