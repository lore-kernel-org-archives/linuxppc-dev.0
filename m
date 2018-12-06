Return-Path: <SRS0=TW6C=OP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05220C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 11:34:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80944214DB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 11:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80944214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 439YR569T8zDqtV
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Dec 2018 22:34:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=ego@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 439YNS32R4zDr9Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Dec 2018 22:32:07 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB6BSrxH124842
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Dec 2018 06:32:05 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p72dn1q94-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Dec 2018 06:32:05 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 6 Dec 2018 11:32:04 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
 by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 6 Dec 2018 11:32:02 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB6BW1cQ7733502
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Dec 2018 11:32:01 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BF43C6206;
 Thu,  6 Dec 2018 11:32:01 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 13E71C61F4;
 Thu,  6 Dec 2018 11:32:00 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.35.115])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu,  6 Dec 2018 11:32:00 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
 id 4F0772E4BE4; Thu,  6 Dec 2018 17:01:57 +0530 (IST)
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH] pseries/hotplug: Add more delay in pseries_cpu_die while
 waiting for rtas-stop
Date: Thu,  6 Dec 2018 17:01:48 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18120611-0016-0000-0000-0000096051F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010181; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01127780; UDB=6.00585813; IPR=6.00907911; 
 MB=3.00024484; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-06 11:32:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120611-0017-0000-0000-0000414F91C1
Message-Id: <1544095908-2414-1-git-send-email-ego@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-06_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812060103
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
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently running DLPAR offline/online operations in a loop on a
POWER9 system with SMT=off results in the following crash:

[  223.321032] cpu 112 (hwid 112) Ready to die...
[  223.355963] Querying DEAD? cpu 113 (113) shows 2
[  223.356233] cpu 114 (hwid 114) Ready to die...
[  223.356236] cpu 113 (hwid 113) Ready to die...
[  223.356241] Bad kernel stack pointer 1faf6ca0 at 1faf6d50
[  223.356243] Oops: Bad kernel stack pointer, sig: 6 [#1]
[  223.356244] LE SMP NR_CPUS=2048 NUMA pSeries
[  223.356247] Modules linked in:
[  223.356255] CPU: 114 PID: 0 Comm: swapper/114 Not tainted 4.20.0-rc3 #39
[  223.356258] NIP:  000000001faf6d50 LR: 000000001faf6d50 CTR: 000000001ec6d06c
[  223.356259] REGS: c00000001e5cbd30 TRAP: 0700   Not tainted  (4.20.0-rc3)
[  223.356260] MSR:  8000000000081000 <SF,ME>  CR: 28000004  XER: 00000020
[  223.356263] CFAR: 000000001ec98590 IRQMASK: 8000000000009033
               GPR00: 000000001faf6d50 000000001faf6ca0 000000001ed1c448 00000267e6a273c3
               GPR04: 0000000000000000 00000000000000e0 000000000000dfe8 000000001faf6d30
               GPR08: 000000001faf6d28 00000267e6a273c3 000000001ec1b108 0000000000000000
               GPR12: 0000000001b6d998 c00000001eb55080 c0000003a1b8bf90 000000001eea3f40
               GPR16: 0000000000000000 c0000006fda85100 c00000000004c8b0 c0000000013d5300
               GPR20: c0000006fda85300 0000000000000008 c0000000019d2cf8 c0000000013d6888
               GPR24: 0000000000000072 c0000000013d688c 0000000000000002 c0000000013d688c
               GPR28: c0000000019cecf0 0000000000000390 0000000000000000 000000001faf6ca0
[  223.356281] NIP [000000001faf6d50] 0x1faf6d50
[  223.356281] LR [000000001faf6d50] 0x1faf6d50
[  223.356282] Call Trace:
[  223.356283] Instruction dump:
[  223.356285] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[  223.356286] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
[  223.356290] ---[ end trace f46a4e046b564d1f ]---

This is due to multiple offlined CPUs (CPU 113 and CPU 114 above)
concurrently (within 3us) trying to make the rtas-call with the
"stop-self" token, something that is prohibited by the PAPR.

The concurrent calls can happen as follows.

  o In dlpar_offline_cpu() we prod an offline CPU X (offline due to
    SMT=off) and loop for 25 tries in pseries_cpu_die() querying if
    the target CPU X has been stopped in RTAS. After 25 tries, we
    prints the message "Querying DEAD? cpu X (X) shows 2" and return
    to dlpar_offline_cpu(). Note that at this point CPU X has not yet
    called rtas with the "stop-self" token, but can do so anytime now.

  o Back in dlpar_offline_cpu(), we prod the next offline CPU Y. CPU Y
    promptly wakes up and calls RTAS with the "stop-self" token.

  o Before RTAS can stop CPU Y, CPU X also calls RTAS with the
    "stop-self" token.

The problem occurs due to the short number of tries (25) in
pseries_cpu_die() which covers 90% of the cases. For the remaining 10%
of the cases, it was observed that we would need to loop for a few
hundred iterations before the target CPU calls rtas with "stop-self"
token.Experiments show that each try takes roughly ~25us.

In this patch we fix the problem by increasing the number of tries
from 25 to 4000 (which roughly corresponds to 100ms) before bailing
out and declaring that we have failed to observe the target CPU call
rtas-stop-self. This provides sufficient serialization to ensure that
there no concurrent rtas calls with "stop-self" token.

Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index 2f8e621..c913c44 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -214,14 +214,25 @@ static void pseries_cpu_die(unsigned int cpu)
 			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
+		int max_tries = 4000; /* Roughly corresponds to 100ms */
+		u64 tb_before = mftb();
 
-		for (tries = 0; tries < 25; tries++) {
+		for (tries = 0; tries < max_tries; tries++) {
 			cpu_status = smp_query_cpu_stopped(pcpu);
 			if (cpu_status == QCSS_STOPPED ||
 			    cpu_status == QCSS_HARDWARE_ERROR)
 				break;
 			cpu_relax();
 		}
+
+		if (tries == max_tries) {
+			u64 time_elapsed_us = div_u64(mftb() - tb_before,
+						      tb_ticks_per_usec);
+
+			pr_warn("Offlined CPU %d isn't stopped by RTAS after %llu us\n",
+				cpu, time_elapsed_us);
+			WARN_ON(1);
+		}
 	}
 
 	if (cpu_status != 0) {
-- 
1.8.3.1

