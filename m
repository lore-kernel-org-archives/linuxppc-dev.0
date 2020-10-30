Return-Path: <SRS0=J6Sm=EF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E9EC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 01:51:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91E820731
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 01:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZcqRFRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91E820731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CMlfL3wCWzDr7h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2020 12:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=nathanl@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=iZcqRFRg; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CMkw333TnzDql9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 12:18:27 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 09U11sZ2157889
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2020 21:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=xmbg7sBjW38SR41MLiixlysZseyxv1NbMPSVKo4tn8g=;
 b=iZcqRFRgXbSrK+zqYhzwKSTK2c840rNQNdtSeY8WvyIho4tAtW3KFzEMZmMWbJC28fzX
 Qa+FXpOtvk/mB+YMsCheS8AmY4ZC5gD57NN7mbQT0oIKuBNswWbOw2lPrWYNVhsn7hnt
 TiyLjL39pqQFfyaudaDbMVysfeLgLnF3APkRi+1KBOHITHrA0IokvS3xr3AFnXkq+S1e
 KCEaV3QcRyhSb04JVTDj15DfDgMlKc+Jrb+Wn2Ygqq5qEnz7AeWlj5Ax/DrpJ4JBYvkj
 Ow5EQ+UU+pKsSNyjfYfSkVySjRw4WEM0uDpzHfSv9H6G9PvjEfS7ToxbS7lIvTYO+kt0 Bg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34g3kkh5dr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2020 21:18:24 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09U1HFjK000727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 01:18:24 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 34e1gpc5ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2020 01:18:24 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 09U1INHp49742226
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2020 01:18:23 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A0AFAC05E;
 Fri, 30 Oct 2020 01:18:23 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B300AC059;
 Fri, 30 Oct 2020 01:18:23 +0000 (GMT)
Received: from localhost (unknown [9.65.225.148])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2020 01:18:22 +0000 (GMT)
From: Nathan Lynch <nathanl@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 20/29] powerpc/pseries/hibernation: remove
 pseries_suspend_cpu()
Date: Thu, 29 Oct 2020 20:17:56 -0500
Message-Id: <20201030011805.1224603-21-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201030011805.1224603-1-nathanl@linux.ibm.com>
References: <20201030011805.1224603-1-nathanl@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-10-29_12:2020-10-29,
 2020-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=696
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0
 adultscore=0 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010300001
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
Cc: tyreld@linux.ibm.com, ajd@linux.ibm.com, mmc@linux.vnet.ibm.com,
 cforno12@linux.vnet.ibm.com, drt@linux.vnet.ibm.com, brking@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Since commit 48f6e7f6d948 ("powerpc/pseries: remove cede offline state
for CPUs"), ppc_md.suspend_disable_cpu() is no longer used and all
CPUs (save one) are placed into true offline state as opposed to
H_JOIN. So pseries_suspend_cpu() is effectively unused; remove it.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/suspend.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index 232621f33510..3315d698d5ab 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -48,20 +48,6 @@ static int pseries_suspend_begin(u64 stream_id)
 		       vasi_state);
 		return -EIO;
 	}
-
-	return 0;
-}
-
-/**
- * pseries_suspend_cpu - Suspend a single CPU
- *
- * Makes the H_JOIN call to suspend the CPU
- *
- **/
-static int pseries_suspend_cpu(void)
-{
-	if (atomic_read(&suspending))
-		return rtas_suspend_cpu(&suspend_data);
 	return 0;
 }
 
@@ -235,7 +221,6 @@ static int __init pseries_suspend_init(void)
 	if ((rc = pseries_suspend_sysfs_register(&suspend_dev)))
 		return rc;
 
-	ppc_md.suspend_disable_cpu = pseries_suspend_cpu;
 	ppc_md.suspend_enable_irqs = pseries_suspend_enable_irqs;
 	suspend_set_ops(&pseries_suspend_ops);
 	return 0;
-- 
2.25.4

