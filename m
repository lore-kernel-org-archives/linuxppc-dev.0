Return-Path: <SRS0=QuHT=C7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D192C2D0E2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 08:05:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2983F239A1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 08:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FFkilTeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2983F239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BwYkr3hnlzDqxf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2020 18:05:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=FFkilTeT; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BwYhY5YxGzDqVs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2020 18:03:09 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08M81hpZ128103; Tue, 22 Sep 2020 04:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=edsv3k6tJf1zoU5YfBZTgnm3SvgXsnj5h33EOiVwfsE=;
 b=FFkilTeTpUg7xGH4zKYFhkjY49mhUx1QvA6WTtpze2lqsZ9Fa+RcKe21wcVb+4EhBfji
 RW0kAMtyhwXZd5y5AdQrBUlFe8SDiiUH39nN5mWBYdsLAdqgPCchuHdOMylC30ndEkE5
 LsyudE1f3vT1G1kIdZmP4cVqbSWxYxX3ANEhNw4RNnZV6Mv+/MLoMD7pFVuLWwKGvdiO
 7daneCpSOdwff4ZB5w4RQF6+AsLFBCNenZgizl8AJD18OkI1VhoKNVavUyDbZTxbHZV9
 NcJzlqpxq7jNkd5+Yf32YhMHidug1mAGN33leGiu+qnq7d5OkQb4M6wETylkis0Jvnej og== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 33qbk5uajg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2020 04:03:03 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08M82pEY018593;
 Tue, 22 Sep 2020 08:03:01 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04ams.nl.ibm.com with ESMTP id 33payu9k0f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2020 08:03:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 08M81OS534341244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Sep 2020 08:01:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41EF611C050;
 Tue, 22 Sep 2020 08:02:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF3B611C04A;
 Tue, 22 Sep 2020 08:02:57 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.77.202.225])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 22 Sep 2020 08:02:57 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] cpufreq: powernv: Fix frame-size-overflow in
 powernv_cpufreq_reboot_notifier
Date: Tue, 22 Sep 2020 13:32:54 +0530
Message-Id: <20200922080254.41497-1-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-22_05:2020-09-21,
 2020-09-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220061
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Pratik Rajesh Sampat <psampat@linux.ibm.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch avoids allocating cpufreq_policy on stack hence fixing frame
size overflow in 'powernv_cpufreq_reboot_notifier'

./drivers/cpufreq/powernv-cpufreq.c: In function _powernv_cpufreq_reboot_notifier_:
./drivers/cpufreq/powernv-cpufreq.c:906:1: error: the frame size of 2064 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
 }
 ^
cc1: all warnings being treated as errors
make[3]: *** [./scripts/Makefile.build:316: drivers/cpufreq/powernv-cpufreq.o] Error 1
make[2]: *** [./scripts/Makefile.build:556: drivers/cpufreq] Error 2
make[1]: *** [./Makefile:1072: drivers] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:157: sub-make] Error 2

Fixes: cf30af76 ("cpufreq: powernv: Set the cpus to nominal frequency during reboot/kexec")
Cc: Pratik Rajesh Sampat <psampat@linux.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index a9af15e..e439b43 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -885,12 +885,15 @@ static int powernv_cpufreq_reboot_notifier(struct notifier_block *nb,
 				unsigned long action, void *unused)
 {
 	int cpu;
-	struct cpufreq_policy cpu_policy;
+	struct cpufreq_policy *cpu_policy;
 
 	rebooting = true;
 	for_each_online_cpu(cpu) {
-		cpufreq_get_policy(&cpu_policy, cpu);
-		powernv_cpufreq_target_index(&cpu_policy, get_nominal_index());
+		cpu_policy = cpufreq_cpu_get(cpu);
+		if (!cpu_policy)
+			continue;
+		powernv_cpufreq_target_index(cpu_policy, get_nominal_index());
+		cpufreq_cpu_put(cpu_policy);
 	}
 
 	return NOTIFY_DONE;
-- 
1.8.3.1

