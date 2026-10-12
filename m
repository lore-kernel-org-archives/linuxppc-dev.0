Return-Path: <linuxppc-dev+bounces-29257-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B2CA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3D5k51B3z30DY;
	Mon, 12 Oct 2026 21:21:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791800490;
	cv=none; b=ZLmAVDGepTg1Mf7S89kL3pMkq/FDb4xjNLo/hoz64x8RSeyO3Wff9yruXjNJ4CjzwmOuAiu5tXA8kJ2dWOKJ/KHTHgahBwfzlmcYG3C6LtPWJwhF/SdkTCCmWJ2XkZ9coHn3ZYsRWjxh5MQgTn2cqNh8zeHblHoflm9ke0p+HqBag2S8XbMo83JiH+2JgzmTkKPLJbf8vOjtKbQgTKekVNJYVlI2xH84avOizcFlrISnzidxWumWPGFBxkT8tD/dQrAVIKCivyHd3rjZ5oV6gdohvWl63uYZ7fdCxa8mAyePcdHMCaUXOBBdJNoXS3MzbpHrF7GjbqmZodnx5hvEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791800490; c=relaxed/relaxed;
	bh=OKt43nUGy6+rdipgQqPi4PhGSSle6SI2iNz6e78gMqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX3QpSnGl+cK2NuAfEAWDqqC96d7yrsCETvf0SBcnUGuf94Wa/vYuXMeoLUR/jWsnLQUb/1UhvVTD4o5ZF7nua5amXyNaPVNfL0PZFFAmEyYGBckRBLSwAVp+LZPKmVblBZynw8tBplFrRsa1FRzFVZL0Cv0+JYlKq5m4qHKGhhLEhdikkirXAM3GC+8gNWx8lANrNsx0YHiBRQz3EVWKM9kmdzCdrLMb9zq2K4FFaPL3VpT70UvGWyBkfwSK6wPOFgUxqI33cvfm6yftpAoI9N+l5qU2IsAYbPa2hiLsNEMLXteR8biIdj1UhOf1v7OPOngSOVjgcwNOfSiUkzwoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlgBVWJh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PlgBVWJh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3D5j5RF5z30Tm
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:21:29 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iQn93968445;
	Mon, 12 Oct 2026 10:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OKt43nUGy6+rdipgQ
	qPi4PhGSSle6SI2iNz6e78gMqI=; b=PlgBVWJhrRC7eVto+z+9nMq9fCqA8uKw9
	1F/ME0d3j3TBnIx0WeumxQq61c0Vz0f7DOrAgBSpIQFkXj564SeBTYX658cQCYV1
	JMEnzmBqNocjwRvZv2cCXH6j1HozJimy2MiyGRlQMZUKMk4S6NQAs49SBqEhU02g
	+1uIlB51dpsKpDPWbcZ9UCkDuWWhhagOHytM1ESg0xNU0DGg5R0xsSxCuGGtOhQa
	vSeHyyltDkMdY0U/cFoaXgtXqfTgFhpxxSFAUseFBdRQc9hgGDpk1aOFCXisys4/
	F8LI6h1ssJkaHC/qG/DphotzCluVtbecDBFlND94nwJIvBXXjZa7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w00dn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:21:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K079964559;
	Mon, 12 Oct 2026 10:21:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppmtyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:21:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CAL1v130146832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 10:21:01 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B63D20040;
	Mon, 12 Oct 2026 10:21:01 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0AFE2004B;
	Mon, 12 Oct 2026 10:20:56 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.215.77])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 10:20:56 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH 3/4] powerpc/topology: Update mc/pkg flags based on llc_override
Date: Mon, 12 Oct 2026 15:50:36 +0530
Message-ID: <20261012102037.2477378-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012102037.2477378-1-sshegde@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXz2RF04lXDzzZ
 QboL2M4XwEA8WwDDY/z+K2nNjV5hbyO04ximYVgdtlBSsbL0+GDwVy+YyxBMN5cgjYqpuvJIqm9
 n4XIWT0QiihsCnBRTcxT37/e2nXeNV8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfXzj0fdkm9XAOS
 olazDlj2sslvWDITiVp0xgmLVyygY826zte+tw8Q2My7p4B0k5VrXrEx29Z2dJJOH9z96KdH7p6
 rDUaUMjKi9+4qSzriH7NadASfOfjoOFHSJ51h3VU1lUuoR6uounzfI+lj+sl+MIGuQvRvTkv1Vu
 mWtiyjwAEPe0UCQeCi7W9U/peY4g60FqHgV+0CoYTkjDptb9wpuylg/CPWcvUnXpZGgWaLGxNSr
 e7SdE9S7rRuxilD1HwDN3D51PYaSTNHBgcMQXD2MqeF2cLTaj3xps/qF/ecaQtfnNigdf12QIm7
 1wDy8nHQh8AKF14Q4MbyYikVvLDj+u6ANJXEaRbbVdLX7yc5hRnGw6t0TaTIpYn1F4E0Tujphbh
 7hX4uyD6Cldfl6dsLLyNsdkffxV/ZVyM3/qtsKK4/PUI1f2XON55wM7cCtJxhgIK5exuIcxndLh
 FImgV7JpRGicRMfnwuQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6accb492 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=XpzEG_ADxOFJZZFOhUYA:9
X-Proofpoint-ORIG-GUID: 2B0avF2aNIbRhpKQVidRoRIpP8m88ZtN
X-Proofpoint-GUID: 3jVEwJ-BniKGkx4JeQw_VSQ905Dsguap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120040

Update the flags passed for building the scheduler topology.

SD_SHARE_LLC is used to determine the highest domain where the LLC is.
Also when set at a particular domain, all the child domains are expected
to have it set as well.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/kernel/smp.c | 63 +++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 433757511adb..4b6512d25f73 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -141,6 +141,24 @@ volatile unsigned int cpu_callin_map[NR_CPUS];
 
 int smt_enabled_at_boot = 1;
 
+enum llc_override_values {
+	LLC_OVERRIDE_DISABLED,
+	LLC_OVERRIDE_SMT,
+	LLC_OVERRIDE_MC,
+	LLC_OVERRIDE_PKG,
+};
+
+static int llc_override;
+static int llc_override_changed;
+static DEFINE_MUTEX(llc_override_mutex);
+
+static const char * const llc_override_str[] = {
+	[LLC_OVERRIDE_DISABLED]	= "0",
+	[LLC_OVERRIDE_SMT]	= "smt",
+	[LLC_OVERRIDE_MC]	= "mc",
+	[LLC_OVERRIDE_PKG]	= "pkg",
+};
+
 /*
  * Returns 1 if the specified cpu should be brought up during boot.
  * Used to inhibit booting threads if they've been disabled or
@@ -1022,14 +1040,31 @@ static int powerpc_shared_cache_flags(void)
 	return SD_SHARE_LLC;
 }
 
-static int powerpc_shared_proc_flags(void)
+static int powerpc_mc_flags(void)
 {
+	int flags = 0;
+
 	if (static_branch_unlikely(&splpar_asym_pack))
-		return SD_ASYM_PACKING;
+		flags |= SD_ASYM_PACKING;
 
-	return 0;
+	if (READ_ONCE(llc_override) >= LLC_OVERRIDE_MC)
+		flags |= SD_SHARE_LLC;
+
+	return flags;
 }
 
+static int powerpc_pkg_flags(void)
+{
+	int flags = 0;
+
+	if (static_branch_unlikely(&splpar_asym_pack))
+		flags |= SD_ASYM_PACKING;
+
+	if (READ_ONCE(llc_override) >= LLC_OVERRIDE_PKG)
+		flags |= SD_SHARE_LLC;
+
+	return flags;
+}
 /*
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
@@ -1737,10 +1772,10 @@ static void __init build_sched_topology(void)
 
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =
-			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
+			SDTL_INIT(tl_mc_mask, powerpc_mc_flags, MC);
 	}
 
-	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags, PKG);
+	powerpc_topology[i++] = SDTL_INIT(tl_pkg_mask, powerpc_pkg_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
@@ -1828,24 +1863,6 @@ void __noreturn arch_cpu_idle_dead(void)
 
 #endif
 
-enum llc_override_values {
-	LLC_OVERRIDE_DISABLED,
-	LLC_OVERRIDE_SMT,
-	LLC_OVERRIDE_MC,
-	LLC_OVERRIDE_PKG,
-};
-
-static int llc_override;
-static int llc_override_changed;
-static DEFINE_MUTEX(llc_override_mutex);
-
-static const char * const llc_override_str[] = {
-	[LLC_OVERRIDE_DISABLED]	= "0",
-	[LLC_OVERRIDE_SMT]	= "smt",
-	[LLC_OVERRIDE_MC]	= "mc",
-	[LLC_OVERRIDE_PKG]	= "pkg",
-};
-
 static ssize_t llc_override_get(struct file *file, char __user *ubuf,
 				size_t count, loff_t *ppos)
 {
-- 
2.52.0


