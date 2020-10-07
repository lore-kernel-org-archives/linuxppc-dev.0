Return-Path: <SRS0=XBts=DO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198CFC4727E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 18:47:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 179662176B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 18:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A+sdUs5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179662176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C63Gl1W4KzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2020 05:47:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=linux.vnet.ibm.com (client-ip=148.163.158.5;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.vnet.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256
 header.s=pp1 header.b=A+sdUs5s; dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C634t1Rj6zDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2020 05:38:37 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 097IZN2e108827; Wed, 7 Oct 2020 14:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AY22FVfPfFKBMfcnqIqcEzZAAvdAONNRre6c/0i+Noc=;
 b=A+sdUs5sp6xiSeM2C4evu8Ozh8ViUQcjHHZe7HDnmH2Ftr6U2CGGpUzsBj2T0OIY7p/j
 kyp/ZquPTLJ9b2ofzBFJKGJ6UayUEfV4wQw3Z6Vj82AE5N4YkuTY911FoOTTlQg3yHWy
 XF8rL7PBcLzrSs206eHIfwT41EIFM4tS9PtF+e7sSU9u3yjdze5pqInhjWEZ+9fAI7QF
 LQoER+LbuF8Ig0l3km/FGwWppi0ihkNUAQGokZFP6O4yU5aQ7/zVWAQyn75+Zl+3rqWM
 15iyvLtjT0PFxZHHhA0lM7jUT8u73N9PVcmHeFLbf8E6Ziib2mihOMZejHRGLVhP58jR xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341j3psugv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 14:38:28 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 097IZadr109838;
 Wed, 7 Oct 2020 14:38:28 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0b-001b2d01.pphosted.com with ESMTP id 341j3psufu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 14:38:28 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 097ISM6P015534;
 Wed, 7 Oct 2020 18:38:26 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma02fra.de.ibm.com with ESMTP id 33xgx8acat-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 07 Oct 2020 18:38:26 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 097IcOYR21299630
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Oct 2020 18:38:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C3D9A405F;
 Wed,  7 Oct 2020 18:38:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA0DCA405B;
 Wed,  7 Oct 2020 18:38:20 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.85.90.101])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Oct 2020 18:38:20 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v3 04/11] powerpc/smp: Optimize remove_cpu_from_masks
Date: Thu,  8 Oct 2020 00:07:53 +0530
Message-Id: <20201007183800.27415-5-srikar@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201007183800.27415-1-srikar@linux.vnet.ibm.com>
References: <20201007183800.27415-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_10:2020-10-07,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070116
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
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>, Qian Cai <cai@redhat.com>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

While offlining a CPU, system currently iterate through all the CPUs in
the DIE to clear sibling, l2_cache and smallcore maps. However if there
are more cores in a DIE, system can end up spending more time iterating
through CPUs which are completely unrelated.

Optimize this by only iterating through smaller but relevant cpumap.
If shared_cache is set, cpu_l2_cache_map should be relevant else
cpu_sibling_map would be relevant.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Nathan Lynch <nathanl@linux.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Qian Cai <cai@redhat.com>
---
 arch/powerpc/kernel/smp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8c095fe237b2..2e61a81aad88 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1263,14 +1263,21 @@ static bool update_mask_by_l2(int cpu, struct cpumask *(*mask_fn)(int))
 #ifdef CONFIG_HOTPLUG_CPU
 static void remove_cpu_from_masks(int cpu)
 {
+	struct cpumask *(*mask_fn)(int) = cpu_sibling_mask;
 	int i;
 
-	for_each_cpu(i, cpu_cpu_mask(cpu)) {
+	if (shared_caches)
+		mask_fn = cpu_l2_cache_mask;
+
+	for_each_cpu(i, mask_fn(cpu)) {
 		set_cpus_unrelated(cpu, i, cpu_l2_cache_mask);
 		set_cpus_unrelated(cpu, i, cpu_sibling_mask);
 		if (has_big_cores)
 			set_cpus_unrelated(cpu, i, cpu_smallcore_mask);
-		if (has_coregroup_support())
+	}
+
+	if (has_coregroup_support()) {
+		for_each_cpu(i, cpu_coregroup_mask(cpu))
 			set_cpus_unrelated(cpu, i, cpu_coregroup_mask);
 	}
 }
-- 
2.17.1

