Return-Path: <linuxppc-dev+bounces-29256-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B7ECA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3D5W09bKz3bqh;
	Mon, 12 Oct 2026 21:21:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791800478;
	cv=none; b=KNj2j4ZUxAAg/iT4lWsWKLziYSvKul5QfTI4Dv/WnjC6GoN8MTtogMCi8Yws/nNAKFPCx+piDtDpofuHlNknZ5O+qgpaIhu0R4xEiHAiXOt2aAgsERogVAvOIj5HNRMmdd2vvs9PisYsOxxHpCemk/CcsMJpUWL++X/4ymEZZbRvgR3NMwtQHV9Bl3Kvzd1hCjUOUf0G40z0pBmbQTwjqvOU9AkQUzAHwQ7m4GIWhQSzZtXVMYkYS1GaNoKk4QIei0yhy280b9wWEhC93EBFF9q9+O2EQYgBNmwAA721w3gXwgK6W8uo81gQtVzJ7IpRANYbF+KKxxChdxeBa9/W2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791800478; c=relaxed/relaxed;
	bh=xzx8yyTa2N6kW8axf0T5qGy+PahAfVEqrKrf7jTmM0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVUKffWZ4+ci3dObmBI5IVdC56O6Esp/qH7GWYTd1ulU9GQrKOBxMB2S+iSy1MmM5YmDyrDtZd4glB88QnPdzFxe8PQntjfzyHReoXO+7GOSVYU39ywTEVjwi+stGU/jahYaxSpVWcRM7VCsIYvS4YVcDhZAWhR8FM0RKkE709rV4Ce05GqgAshNjW1oLSNJkuKdPdPDFAu8v/h6V8UXJCzDwGC8frkwapFmt6+97mXrGt0QTokmofpOWWs/VxG3zTHilv+MJu5DfU78leztrLBwxrNddbZnb2FJka7b5NRZmzEYK8rl4EcBKZPLuTybywlRSqWm8qxPqS+SRLuZHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k8rY7mMV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k8rY7mMV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3D5V2LvRz3bSw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 21:21:18 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iAFD3917815;
	Mon, 12 Oct 2026 10:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xzx8yyTa2N6kW8axf
	0T5qGy+PahAfVEqrKrf7jTmM0k=; b=k8rY7mMVHFMmFsMQpvCuVbAteIS7UIfWk
	S27lvueGLvwr1LpfivHufVF5ioxpYksGfHd340iIKGhVdIa6NDuV3tuehts7u89u
	4WmSlUk6Gj5OBPyYIx8JiT/a8ZpXRPjJ2uUTzdyeXXJnhtEMh3ipembHvaybpZbg
	AfyLunugQ30getrsbVdQp6S9GTsEH8VA2HbFKBhp3vcBbTvmTjygMTr9CicaZm3+
	9Z2q1OXE9pEIeOvBUhvC2vD65KkDzqa6lhTkrlJiLxW3Wvocv5C/F+kNwHfwWAle
	3pWzEMbb1wAblXzUqbyOzjFSDHw8w7mR9ZSkJ9dcEgYHrQ6RlV7dA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv38b08-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:21:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K0de1013351;
	Mon, 12 Oct 2026 10:21:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cycdre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 10:20:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CAKuq352494756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 10:20:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE962004E;
	Mon, 12 Oct 2026 10:20:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C3920043;
	Mon, 12 Oct 2026 10:20:51 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.215.77])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 10:20:51 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH 2/4] powerpc/topology: Add docs for llc_override
Date: Mon, 12 Oct 2026 15:50:35 +0530
Message-ID: <20261012102037.2477378-3-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: D00o8eQo1I5r_OUBgNR4TM6igOoIh_zm
X-Proofpoint-ORIG-GUID: cue31ZNCDUOhHaSWz9uV0JPq7rXszquz
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accb48d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=goSn6fUrnbwpz7W_l2oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX9aWDIc4qItRz
 RpkRNHG86foXdlPfCig8dgD/nchbdOTCiK90hxrnwZIH7LTdCgPgJEkl4MfgzIiKzeHSw5+bvEM
 Knj52vhenh549ZA0vrRtrhEoN2K8Nlk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MCBTYWx0ZWRfX59MHEgoRBjbx
 iYlLp5V+uM219zBggafAzsj7YVA+tLuNQtWmIxkEgDpeE7k6jlBVf7AibbsXZIH4tqdlLB3QKi4
 0oUKqo71ImeYzpreCMK1GnThC259dr/gNWani5my6jMrCVgTG5XIn4gzjSFaNk8D++0ENpPxLPJ
 XcMJ+wHy+udeO5Fp8Ph2a/5udwQBuXiwlzzeRQvmboAqTSqKuvlL256nbyChbPAa0XkFUSKEeyM
 XQd0i/2+Rl0tLDhS78gxcjq/ZrdaLU6uux8FjGxpNfTb/WhPTUmHTeXccT5mTPbIFRbmUXG6C6d
 jtmivh+m+v+FMz7yzNa7tvUaeOsmIhUGR5zLFBXAl4U7oipr8auQ0BUxjGo+LkiSLdI8AoAaDgp
 NwQ3lcRBDDB9FJrE6gTTSTRBcAlDj+NfxI+E1IVeF2R9T9m/03HmJ7tfp06xHyXZkyWB/rABERb
 jAedTmoHBdHuGyySTMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120040

Provide documentation for the newly introduced debug knob
named as llc_override.

This may help one if they want to experiment with cache aware
scheduling.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/arch/powerpc/index.rst    |  1 +
 Documentation/arch/powerpc/topology.rst | 27 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/arch/powerpc/topology.rst

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 40419bea8e10..0f4caf50a9e7 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -33,6 +33,7 @@ powerpc
     qe_firmware
     syscall64-abi
     transactional_memory
+    topology
     ultravisor
     vas-api
     vcpudispatch_stats
diff --git a/Documentation/arch/powerpc/topology.rst b/Documentation/arch/powerpc/topology.rst
new file mode 100644
index 000000000000..9ed3cf7ade69
--- /dev/null
+++ b/Documentation/arch/powerpc/topology.rst
@@ -0,0 +1,27 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _topology:
+
+
+llc_override
+==============
+
+Override the scheduler-visible LLC domain on PowerPC.
+
+Having LLC(last level cache) at MC/PKG helps to experiment with new
+scheduler feature called cache aware scheduling which expects LLC to have
+at least more than 1 core. Scheduler uses notion of LLC for wakeup and
+load balancing decisions.
+
+Accepted values are:
+
+  0    Disable the override and use the platform default.
+  smt  LLC will be at SMT domain.
+  mc   LLC will be at MC domain, including at SMT domains.
+  pkg  LLC will be at PKG domain, including at MC and SMT domains,
+
+Writing a new value rebuilds the scheduler domains. One can check the
+domain flags and look for SD_SHARE_LLC to confirm if it took effect.
+
+Note that this doesn't change HW cache topology. It is only a debug knob
+to experiment with scheduler related functionalities. So set it to sensible
+values. Also note that there is no performance guarantees across the values.
-- 
2.52.0


