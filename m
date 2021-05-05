Return-Path: <SRS0=ixLW=KA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A93C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 19:17:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA81961166
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 May 2021 19:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA81961166
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fb60F2hKQz3022
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 May 2021 05:17:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oA+9YzPz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=oA+9YzPz; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fb5zj1LjVz2yyK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 May 2021 05:16:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 145J3Mhc104219; Wed, 5 May 2021 15:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wj/JFiXenkQ9cFj2JUGEFwnBmXSeGZ+OhsKC1KJBkZo=;
 b=oA+9YzPz+yz/ZHsOBueT8AMdaOSAnKdHwj3ArAUuUjNKEC2oKbp7MtqmAAVMgHgop0lN
 +h14siT/EeBeX6Q4+GzolHfwMMzWTSBlez7PHFu0Yn7a0Vko+zhYMJlrcunsRTk65bj6
 mWKooomHpg2Cvuar9DF1FKDFNg/rcUD04ecQHel1OIBi37JoOkp7Qs85ovOLQissOng+
 P0k+ihynP42LHKCu/6B5edSCeN9mYzvhClAiVt+taNVhFMcuUrCi/v+6ls9V3oOBW8X9
 bUviRHqJosEe4aaOBz2vySGEFzKKLNH6NIFYTyEotQuo1ryxImSERwYHuowzyc7uyjWe +w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0b-001b2d01.pphosted.com with ESMTP id 38byd23bg8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 May 2021 15:16:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 145Ir5dZ023694;
 Wed, 5 May 2021 19:16:14 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by ppma06ams.nl.ibm.com with ESMTP id 38bee58fqs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 May 2021 19:16:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 145JGBs422413798
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 May 2021 19:16:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8057DA405C;
 Wed,  5 May 2021 19:16:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 94FC2A4054;
 Wed,  5 May 2021 19:16:08 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.85.88.241])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Wed,  5 May 2021 19:16:08 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Thu, 06 May 2021 00:46:07 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org
Subject: [PATCH v2] powerpc/papr_scm: Reduce error severity if nvdimm stats
 inaccessible
Date: Thu,  6 May 2021 00:46:06 +0530
Message-Id: <20210505191606.51666-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FWfRU6zLQIivcPLGwQkLKWWdVqqED2k5
X-Proofpoint-GUID: FWfRU6zLQIivcPLGwQkLKWWdVqqED2k5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-05_09:2021-05-05,
 2021-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050130
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
Cc: Santosh Sivaraj <santosh@fossix.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently drc_pmem_qeury_stats() generates a dev_err in case
"Enable Performance Information Collection" feature is disabled from
HMC or performance stats are not available for an nvdimm. The error is
of the form below:

papr_scm ibm,persistent-memory:ibm,pmemory@44104001: Failed to query
	 performance stats, Err:-10

This error message confuses users as it implies a possible problem
with the nvdimm even though its due to a disabled/unavailable
feature. We fix this by explicitly handling the H_AUTHORITY and
H_UNSUPPORTED errors from the H_SCM_PERFORMANCE_STATS hcall.

In case of H_AUTHORITY error an info message is logged instead of an
error, saying that "Permission denied while accessing performance
stats". Also '-EACCES' error is return instead of -EPERM.

In case of H_UNSUPPORTED error we return a -EPERM error back from
drc_pmem_query_stats() indicating that performance stats-query
operation is not supported on this nvdimm.

Fixes: 2d02bf835e57('powerpc/papr_scm: Fetch nvdimm performance stats from PHYP')
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
Changelog

v2:
* Updated the message logged in case of H_AUTHORITY error [ Ira ]
* Switched from dev_warn to dev_info in case of H_AUTHORITY error.
* Instead of -EPERM return -EACCESS for H_AUTHORITY error.
* Added explicit handling of H_UNSUPPORTED error.
---
 arch/powerpc/platforms/pseries/papr_scm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index ef26fe40efb0..12f1513f0fca 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -310,6 +310,13 @@ static ssize_t drc_pmem_query_stats(struct papr_scm_priv *p,
 		dev_err(&p->pdev->dev,
 			"Unknown performance stats, Err:0x%016lX\n", ret[0]);
 		return -ENOENT;
+	} else if (rc == H_AUTHORITY) {
+		dev_info(&p->pdev->dev,
+			 "Permission denied while accessing performance stats");
+		return -EACCES;
+	} else if (rc == H_UNSUPPORTED) {
+		dev_dbg(&p->pdev->dev, "Performance stats unsupported\n");
+		return -EPERM;
 	} else if (rc != H_SUCCESS) {
 		dev_err(&p->pdev->dev,
 			"Failed to query performance stats, Err:%lld\n", rc);
-- 
2.31.1

