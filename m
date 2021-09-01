Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBFCC432BE
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 18:04:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3525561059
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Sep 2021 18:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3525561059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0Bl7572xz2ynS
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 04:04:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R0jFXYBo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=farosas@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=R0jFXYBo; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0BkG3SGnz2xYd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Sep 2021 04:03:17 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 181HYBUm004424; Wed, 1 Sep 2021 14:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nuRGRIafp+9LlGWX+0lAT9GdEHKasiLAohx0VnUPcW8=;
 b=R0jFXYBovuwh9cSlTgwqGFAdvebNK5LrHlsIxA7PYHYVbVp3PRE4nKWdYkHpaidbXHX4
 9JAQG93S2j68foAu4gM+hVgAoPthuaoxyNWShAlyqLBoBh34Q5ZWIj/sbmm1Hzj1iPNH
 xrzZ/utdIk8A4JRpQHGZWHNHYjg1E3YdwKArJ1QdnzxshlSt6HwCT22XatemGjolc6cI
 QnfyadyErBKX8HyyC/ZL0RxoPkd2dQSz4axwT1yxzi/AJN+vAr0ZwSHO8pFq9Wl2HCTC
 2HcKt2GcGTqP/qDw5mqKpNWw1g+79/vD8mWiL21GaOTMPYC6PKjab0PMsYC1LZ1TtUZd yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3atbb35yp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Sep 2021 14:03:11 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 181HacAT019397;
 Wed, 1 Sep 2021 14:03:11 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3atbb35xje-17
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Sep 2021 14:03:10 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 181HVoD0019765;
 Wed, 1 Sep 2021 17:34:08 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma01dal.us.ibm.com with ESMTP id 3atdxw041c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Sep 2021 17:34:08 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 181HY74219333816
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Sep 2021 17:34:07 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEADE7805F;
 Wed,  1 Sep 2021 17:34:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E9D27806D;
 Wed,  1 Sep 2021 17:34:05 +0000 (GMT)
Received: from farosas.linux.ibm.com.com (unknown [9.211.58.54])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed,  1 Sep 2021 17:34:05 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 2/5] KVM: PPC: Book3S HV: Delay setting of kvm ops
Date: Wed,  1 Sep 2021 14:33:54 -0300
Message-Id: <20210901173357.3183658-3-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210901173357.3183658-1-farosas@linux.ibm.com>
References: <20210901173357.3183658-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1FoGjfHrBIwxiDCdauZO17Qn7ZRh8Nr1
X-Proofpoint-ORIG-GUID: yyFWE6tOSdYQLO9Ej2OGhpZda2Q4PzUZ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-09-01_05:2021-09-01,
 2021-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 mlxlogscore=998 clxscore=1015 phishscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010100
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
 david@gibson.dropbear.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Delay the setting of kvm_hv_ops until after all init code has
completed. This avoids leaving the ops still accessible if the init
fails.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 4cdf2e6e1cf5..fe20074faa61 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5985,9 +5985,6 @@ static int kvmppc_book3s_init_hv(void)
 	}
 #endif
 
-	kvm_ops_hv.owner = THIS_MODULE;
-	kvmppc_hv_ops = &kvm_ops_hv;
-
 	init_default_hcalls();
 
 	init_vcore_lists();
@@ -6003,10 +6000,15 @@ static int kvmppc_book3s_init_hv(void)
 	}
 
 	r = kvmppc_uvmem_init();
-	if (r < 0)
+	if (r < 0) {
 		pr_err("KVM-HV: kvmppc_uvmem_init failed %d\n", r);
+		return r;
+	}
 
-	return r;
+	kvm_ops_hv.owner = THIS_MODULE;
+	kvmppc_hv_ops = &kvm_ops_hv;
+
+	return 0;
 }
 
 static void kvmppc_book3s_exit_hv(void)
-- 
2.29.2

