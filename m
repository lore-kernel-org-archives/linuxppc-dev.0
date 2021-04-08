Return-Path: <SRS0=7qm+=JF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D0C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 14:08:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A926112F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Apr 2021 14:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A926112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FGNQf6h0tz3cGq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Apr 2021 00:08:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=muhjuOlQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=muhjuOlQ; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FGNNk2F6Lz30D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Apr 2021 00:06:45 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 138E4Q3Q007179; Thu, 8 Apr 2021 10:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wglNIu32AFxspMSONSPePtdThonNQ5Rx1/Dek6B8RNI=;
 b=muhjuOlQ7VKfDdrgDHxGHUKb674ilSLLi+GOPxoF42NF8RPxV8DuOQiJSWiiDtfPC2fe
 OFkV9B8hLCqdzBvH4gjdi0t3AfsWyC1Q8kMmbo796LqQpGI8yJqzwnHCLJpJpM9Keksj
 liijVi+rbQhYCMceJ2nh/eQ7nDgf6PXKTVKUugI6fBvYvVQ14HdD9YYEF4TZx+CprxFX
 lVYPv0WWkwA0IleU3uVTk6MvoCx7yS88ptcEAAt0gGuh7QOIb5xUmrXwYg0u7kLpHXk+
 EnXmZ4/VK+EvxJ8u5HdBBBs97AbnM3J6JSgl0xUqgolpJjGn7KXy0k/R9sFPfmrtLa4V DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37rvunthjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Apr 2021 10:06:41 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 138E56hN011985;
 Thu, 8 Apr 2021 10:06:38 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 37rvunthfr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Apr 2021 10:06:38 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 138E1jo2016007;
 Thu, 8 Apr 2021 14:06:35 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by ppma04dal.us.ibm.com with ESMTP id 37rvc48s3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Apr 2021 14:06:35 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 138E6Xk032244140
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Apr 2021 14:06:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 809BEC606C;
 Thu,  8 Apr 2021 14:06:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68BBCC6059;
 Thu,  8 Apr 2021 14:06:33 +0000 (GMT)
Received: from localhost (unknown [9.211.35.170])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  8 Apr 2021 14:06:33 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] powerpc/rtas: move syscall filter setup into separate
 function
Date: Thu,  8 Apr 2021 09:06:29 -0500
Message-Id: <20210408140630.205502-5-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408140630.205502-1-nathanl@linux.ibm.com>
References: <20210408140630.205502-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 47L7UOsj3Qg-kTn--zayR5lLuJz-xQ63
X-Proofpoint-ORIG-GUID: I3nYK35V4vPq5A1kXu6hqdDOJHAUUs7U
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-08_03:2021-04-08,
 2021-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 clxscore=1015 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104080099
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
Cc: tyreld@linux.ibm.com, ajd@linux.ibm.com, aik@ozlabs.ru,
 aneesh.kumar@linux.ibm.com, npiggin@gmail.com, brking@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reduce conditionally compiled sections within rtas_initialize() by
moving the filter table initialization into its own function already
guarded by CONFIG_PPC_RTAS_FILTER. No behavior change intended.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/kernel/rtas.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 60fcf7f7b0b8..24dc7bc463a8 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -1051,6 +1051,14 @@ static bool block_rtas_call(int token, int nargs,
 	return true;
 }
 
+static void __init rtas_syscall_filter_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rtas_filters); i++)
+		rtas_filters[i].token = rtas_token(rtas_filters[i].name);
+}
+
 #else
 
 static bool block_rtas_call(int token, int nargs,
@@ -1059,6 +1067,10 @@ static bool block_rtas_call(int token, int nargs,
 	return false;
 }
 
+static void __init rtas_syscall_filter_init(void)
+{
+}
+
 #endif /* CONFIG_PPC_RTAS_FILTER */
 
 /* We assume to be passed big endian arguments */
@@ -1162,9 +1174,6 @@ void __init rtas_initialize(void)
 	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
 	u32 base, size, entry;
 	int no_base, no_size, no_entry;
-#ifdef CONFIG_PPC_RTAS_FILTER
-	int i;
-#endif
 
 	/* Get RTAS dev node and fill up our "rtas" structure with infos
 	 * about it.
@@ -1203,11 +1212,7 @@ void __init rtas_initialize(void)
 	rtas_last_error_token = rtas_token("rtas-last-error");
 #endif
 
-#ifdef CONFIG_PPC_RTAS_FILTER
-	for (i = 0; i < ARRAY_SIZE(rtas_filters); i++) {
-		rtas_filters[i].token = rtas_token(rtas_filters[i].name);
-	}
-#endif
+	rtas_syscall_filter_init();
 }
 
 int __init early_init_dt_scan_rtas(unsigned long node,
-- 
2.30.2

