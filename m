Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0130C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 09:22:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470C3217D4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 09:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470C3217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bDqT1R4xzDqSG
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 20:22:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=huntbag@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bDjY0gYlzDqRJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2019 20:17:20 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x359Bnn9132131
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2019 05:17:18 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rp2yym4by-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Apr 2019 05:17:18 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Fri, 5 Apr 2019 10:17:16 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 5 Apr 2019 10:17:14 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x359HDh959375746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 5 Apr 2019 09:17:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98C6B5204E;
 Fri,  5 Apr 2019 09:17:13 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5A53D52050;
 Fri,  5 Apr 2019 09:17:12 +0000 (GMT)
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: [PATCH v2 2/2] cpuidle : Add auto-promotion flag to cpuidle flags
Date: Fri,  5 Apr 2019 04:16:47 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
References: <20190405091647.4169-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19040509-0020-0000-0000-0000032C9111
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040509-0021-0000-0000-0000217EA863
Message-Id: <20190405091647.4169-3-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-04-05_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=791 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904050068
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
Cc: Abhishek Goel <huntbag@linux.vnet.ibm.com>, daniel.lezcano@linaro.org,
 rjw@rjwysocki.net, ego@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch sets up flags for the state which needs to be auto-promoted. On
POWERNV system, only lite states need to be autopromoted. We identify lite
states by those which do not lose user context. That information has been
used to set the flag for lite states.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h |  1 +
 drivers/cpuidle/Kconfig             |  4 ++++
 drivers/cpuidle/cpuidle-powernv.c   | 13 +++++++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 870fb7b23..735dec731 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -226,6 +226,7 @@
  */
 
 #define OPAL_PM_TIMEBASE_STOP		0x00000002
+#define OPAL_PM_LOSE_USER_CONTEXT	0x00001000
 #define OPAL_PM_LOSE_HYP_CONTEXT	0x00002000
 #define OPAL_PM_LOSE_FULL_CONTEXT	0x00004000
 #define OPAL_PM_NAP_ENABLED		0x00010000
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 8caccbbd7..9b8e9b96a 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,6 +35,10 @@ config CPU_IDLE_GOV_TEO
 config DT_IDLE_STATES
 	bool
 
+config CPU_IDLE_AUTO_PROMOTION
+	bool
+	default y if PPC_POWERNV
+
 menu "ARM CPU Idle Drivers"
 depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 84b1ebe21..0dd767270 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -299,6 +299,7 @@ static int powernv_add_idle_states(void)
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		bool lose_user_context = false;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
@@ -324,6 +325,9 @@ static int powernv_add_idle_states(void)
 		if (has_stop_states && !(state->valid))
 				continue;
 
+		if (state->flags & OPAL_PM_LOSE_USER_CONTEXT)
+			lose_user_context = true;
+
 		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
@@ -332,12 +336,17 @@ static int powernv_add_idle_states(void)
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
+		} else if (has_stop_states && !lose_user_context) {
+			add_powernv_state(nr_idle_states, state->name,
+					  CPUIDLE_FLAG_AUTO_PROMOTION,
+					  stop_loop, target_residency,
+					  exit_latency, state->psscr_val,
+					  state->psscr_mask);
 		} else if (has_stop_states && !stops_timebase) {
 			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
-					  state->psscr_val,
-					  state->psscr_mask);
+					  state->psscr_val, state->psscr_mask);
 		}
 
 		/*
-- 
2.17.1

