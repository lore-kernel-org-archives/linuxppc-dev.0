Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF30C43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 16:32:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B8B20861
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 16:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B8B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431hfm68vJzDqXD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 03:32:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431hcQ36zxzDqWr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 03:30:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wANGStJ6010877
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:30:11 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nxkmk43mu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Nov 2018 11:30:11 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Fri, 23 Nov 2018 16:30:09 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
 by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 23 Nov 2018 16:30:07 -0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wANGU65n41091104
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Nov 2018 16:30:06 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 10FC9AE064;
 Fri, 23 Nov 2018 16:30:06 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FFA6AE05C;
 Fri, 23 Nov 2018 16:30:04 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.85.195.104])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 23 Nov 2018 16:30:04 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/pseries/cpuidle: Fix preempt warning
Date: Fri, 23 Nov 2018 14:30:11 -0200
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18112316-0040-0000-0000-000004974ACC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010106; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01121657; UDB=6.00577119; IPR=6.00901777; 
 MB=3.00024297; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-23 16:30:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112316-0041-0000-0000-000008A05D7D
Message-Id: <1542990611-17149-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-23_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=969 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811230137
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
Cc: Breno Leitao <leitao@debian.org>, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When booting a pseries kernel with PREEMPT enabled, it dumps the following
warning:

   BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
   caller is pseries_processor_idle_init+0x5c/0x22c
   CPU: 13 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc3-00090-g12201a0128bc-dirty #828
   Call Trace:
   [c000000429437ab0] [c0000000009c8878] dump_stack+0xec/0x164 (unreliable)
   [c000000429437b00] [c0000000005f2f24] check_preemption_disabled+0x154/0x160
   [c000000429437b90] [c000000000cab8e8] pseries_processor_idle_init+0x5c/0x22c
   [c000000429437c10] [c000000000010ed4] do_one_initcall+0x64/0x300
   [c000000429437ce0] [c000000000c54500] kernel_init_freeable+0x3f0/0x500
   [c000000429437db0] [c0000000000112dc] kernel_init+0x2c/0x160
   [c000000429437e20] [c00000000000c1d0] ret_from_kernel_thread+0x5c/0x6c

This happens because the code calls get_lppaca() which calls get_paca() and
it checks if preemption is disabled through check_preemption_disabled().

Preemption should be disabled because the per CPU variable may make no
sense if there is a preemption (and a CPU switch) after it reads the per
CPU data and when it is used.

At this device driver specifically, it is not a problem, because this code
just need to have access to one lppaca struct, and it does not matter if it
is the current per CPU lppaca struct or not (i.e. when there is a
preemption and a CPU migration).

That said, the most appropriated fix seems to be related to avoiding the
debug_smp_processor_id() call at get_paca(), instead of calling
preempt_disable() before get_paca().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 9e56bc411061..63f70e2c1f13 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -247,7 +247,12 @@ static int pseries_idle_probe(void)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (lppaca_shared_proc(get_lppaca())) {
+		/* Using local_paca instead of get_lppaca() since
+		 * preemption is not disabled, and it is not required in
+		 * fact, since lppaca_ptr does not need to be the value
+		 * associated to the current CPU, it could be from any CPU.
+		 */
+		if (lppaca_shared_proc(local_paca->lppaca_ptr)) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
2.19.0

