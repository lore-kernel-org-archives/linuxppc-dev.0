Return-Path: <SRS0=vHfa=DC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB60C4363D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 10:36:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FC3421D91
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 10:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HYLg4BGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FC3421D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BySxP2NKyzDqlB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2020 20:35:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0b-001b2d01.pphosted.com; envelope-from=ganeshgr@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=HYLg4BGg; dkim-atps=neutral
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BySt66gcwzDqk9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2020 20:33:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08PAVfqt153204; Fri, 25 Sep 2020 06:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OMnoVKNJtcQL6qsnqZApgydNzVsMREy33ZpQw+sWYOo=;
 b=HYLg4BGgwVYnkFv9Z7wlE9q6Xt6Z3vHg5piBF2MZATSnHv6TjVPrfMP9mrgVZxbmmUHQ
 n5KIqSl4eKGlECvFSGvPDs9IKECMvJEXWjXDLK0cAMqa57+cy3gzLaH8amajRzfIMQUW
 EI7/Or9T43Xy2dMvc0Oc4ptG8fGrdN3P1+1m2DjJselQykxqMUpU8dS1VR79RkBqtT8a
 dEUuYmoXZwEA8XW5lrzBHheMol12sNKBaUzzmabK2EO6s0z0gr6Z7klb+X4GAjGVsF9n
 7+uH++TZguFZMd+zcIAKm0exfRIBj7HAIQFwoVJZVpAuYVjBx+mL3bPiYosZ/QASiZag LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sedj8ym2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 06:32:57 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08PAW3aR154554;
 Fri, 25 Sep 2020 06:32:56 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com with ESMTP id 33sedj8yke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 06:32:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08PAWoDD008260;
 Fri, 25 Sep 2020 10:32:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com
 (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
 by ppma06ams.nl.ibm.com with ESMTP id 33n98gx6qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2020 10:32:54 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08PAWpIH19268000
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2020 10:32:52 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D24C842049;
 Fri, 25 Sep 2020 10:32:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDC7B42042;
 Fri, 25 Sep 2020 10:32:49 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.77.205.231])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2020 10:32:49 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v2 3/3] selftests/lkdtm: Enable selftest for SLB multihit
Date: Fri, 25 Sep 2020 16:01:23 +0530
Message-Id: <20200925103123.21102-4-ganeshgr@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200925103123.21102-1-ganeshgr@linux.ibm.com>
References: <20200925103123.21102-1-ganeshgr@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-25_04:2020-09-24,
 2020-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009250068
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
Cc: msuchanek@suse.de, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 keescook@chromium.org, npiggin@gmail.com, mahesh@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add PPC_SLB_MULTIHIT to lkdtm selftest framework.

Signed-off-by: Ganesh Goudar <ganeshgr@linux.ibm.com>
---
 tools/testing/selftests/lkdtm/tests.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 9d266e79c6a2..7eb3cf91c89e 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -70,3 +70,4 @@ USERCOPY_KERNEL
 USERCOPY_KERNEL_DS
 STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
 CFI_FORWARD_PROTO
+PPC_SLB_MULTIHIT Recovered
-- 
2.26.2

