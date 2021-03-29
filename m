Return-Path: <SRS0=Xl/Y=I3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DF7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:31:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5406B617C9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 11:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5406B617C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F89QY4G4Zz30Gw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Mar 2021 22:31:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCVa+tta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=fCVa+tta; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F89Q43WBWz2y8Q
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Mar 2021 22:31:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12TB5Feq025347; Mon, 29 Mar 2021 07:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=frO64+ccnL78OUxeX8hkjQoL/xTSF64D+YxEws4n42c=;
 b=fCVa+tta1mfFS9D3T9dkFyThzzBlo3aiP8k20+jBWupQJpEmKTep6QFnbILU9aJQ2X6l
 ODl5ALYiALs05vZ/O8imJ+KnRB56jX/ylkrcaaeiXRUxbitFRkRC9NWYExlQOWOD2rCP
 BlmKJTZKM7NqKOddkJ2mO2qx6InfXiwwQ8CpiaCirsxPIz8k9GdA2LO789mNu7yA2Ylp
 AuXaO1FCHWP8jgRZ67KuNzvp1n2w4nNhUNpNg/S4/LKrGfKpZUl8AgULGBiWd9Fu+leJ
 XEhasxWUIg/wIeJYQNG0JD2FDM27VfLo3h2u1JF/CoJJWVwNuJ6dbBNt7ulVnumtUmJM YQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37jhsamswg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Mar 2021 07:31:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12TBSw6p029128;
 Mon, 29 Mar 2021 11:31:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 37huyh9rpg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Mar 2021 11:31:13 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 12TBUpt914811414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Mar 2021 11:30:51 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C6E9A405B;
 Mon, 29 Mar 2021 11:31:10 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78DE6A4054;
 Mon, 29 Mar 2021 11:31:07 +0000 (GMT)
Received: from vajain21.in.ibm.com (unknown [9.199.32.234])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon, 29 Mar 2021 11:31:07 +0000 (GMT)
Received: by vajain21.in.ibm.com (sSMTP sendmail emulation);
 Mon, 29 Mar 2021 17:01:06 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/papr_scm: Mark nvdimm as unarmed if needed during
 probe
Date: Mon, 29 Mar 2021 17:01:03 +0530
Message-Id: <20210329113103.476760-1-vaibhav@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xSElMSAwnJ6e2v4DhN7-T3j8gcP8U15O
X-Proofpoint-GUID: xSElMSAwnJ6e2v4DhN7-T3j8gcP8U15O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-29_08:2021-03-26,
 2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 clxscore=1011 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=936
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290086
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
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>, Dan Williams <dan.j.williams@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In case an nvdimm is found to be unarmed during probe then set its
NDD_UNARMED flag before nvdimm_create(). This would enforce a
read-only access to the ndimm region. Presently even if an nvdimm is
unarmed its not marked as read-only on ppc64 guests.

The patch updates papr_scm_nvdimm_init() to force query of nvdimm
health via __drc_pmem_query_health() and if nvdimm is found to be
unarmed then set the nvdimm flag ND_UNARMED for nvdimm_create().

Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 835163f54244..7e8168e19427 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -914,6 +914,15 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	dimm_flags = 0;
 	set_bit(NDD_LABELING, &dimm_flags);
 
+	/*
+	 * Check if the nvdimm is unarmed. No locking needed as we are still
+	 * initializing. Ignore error encountered if any.
+	 */
+	__drc_pmem_query_health(p);
+
+	if (p->health_bitmap & PAPR_PMEM_UNARMED_MASK)
+		set_bit(NDD_UNARMED, &dimm_flags);
+
 	p->nvdimm = nvdimm_create(p->bus, p, papr_nd_attr_groups,
 				  dimm_flags, PAPR_SCM_DIMM_CMD_MASK, 0, NULL);
 	if (!p->nvdimm) {
-- 
2.30.2

