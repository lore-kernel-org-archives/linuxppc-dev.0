Return-Path: <linuxppc-dev+bounces-17973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E65EB1070
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 15:28:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVd841mFXz3bjb;
	Wed, 11 Mar 2026 02:28:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773156532;
	cv=none; b=K8g7GNyf3HG5+gpX58JCaxU84qLWAAt+703nXDSc2DW1QJjDVu34a+KP5tgBvlWdSO6+LRNUC5iSrTgn92m+lUKEnRX1O1BthiBT9nMvFwaZ8vowr6JmFcfzR3ch92lgnsQjkmD0KPXiyvQ+/Gmz8Dgy6nfw3k1WB1YSPzjjfnEGTiNphjw2ihou5C/BPiI0nbKQRaFYnubvhZbjAnvMXkFZb8aY3HL6jvkn6IXVS91hbNsK3zfK1ri2JZp2B1ainsTMtnRavRJJYji6cNDfvi209p75UK4v0SHqnA8ndaLAO+viVg9vtkKYyhAA7R6xLYLliR2BOm1KMeafXfkbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773156532; c=relaxed/relaxed;
	bh=VoS5VdqWpdJCS2AVm6kQCi4KjrYiIfwmUfteJw1vaOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2yFp9xYxrzO2rKCe/HFm1al6I1GIToXSpDW1qNS6oxwZuVl3tTvboJZTiI6tuLBsAC6zD5KbbDXiEM+9LBJzMFg7UYakupr6AUPrzofI7oHB4gI95nn+vGpR8YY0xULa37HBOdU/VaGKSytEl99yQswa1yFRswvk7pJMJ3sNJCcY01/I9WaZmBkHIa3zeNAAc4XGp9yyhBXpQMcACvaZxqm2QNN5bGMdqKTvlfAWhQlZ/EVzf8elsdeRviz5IEPWefa1euZ9BEOQTXtNQa6hUMP8jBYgnnlNGQHKUnewFEAHeAm/FhWYpwCE0RZa8XZexLYUeLKmV8rHe7TaL3XDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VmHS65R3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VmHS65R3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVd830z5cz30Lw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 02:28:50 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A75pKG1561657;
	Tue, 10 Mar 2026 15:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VoS5VdqWpdJCS2AVm6kQCi4KjrYiIfwmUfteJw1va
	OU=; b=VmHS65R3R7lMQeCiZ+mU6DzhpFMxtYyPrrDLU7nVxCtBWJyAidEITrP+9
	pp2IdVsCOevttKTsqAXgGR0JYq5PUCIfi/ZOuMVNnCWkBKmOE3cURPsVm9UqYi9N
	RQGyxddeaJtZzCfHLL9FKChhczLOcAjmcTEbq7bCd3PCtQfoI5isRjkACk8/eRum
	Oi6HRVDQi52YCpelOOJPMRsaaxJLedueMFalH82I+RLf72L+9k89YuRfNWsmDn37
	Gk6pRzwRevDm1xoHHi3MQDcw0WpvEt5tzQNjHuT5D2CFxFxhAoAG9yMqwID8trxW
	A0cIZcxrNnrQ/EtDP8AhE0Xq+nC3w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmbka0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 15:28:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABV4EH023013;
	Tue, 10 Mar 2026 15:28:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng2m9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 15:28:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AFSdYS32637270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 15:28:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EA882004E;
	Tue, 10 Mar 2026 15:28:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC032004B;
	Tue, 10 Mar 2026 15:28:37 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.21.172])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 15:28:37 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, chleroy@kernel.org, nysal@linux.ibm.com,
        mkchauras@linux.ibm.com, rafael@kernel.org, daniel.lezcano@kernel.org,
        christian.loehle@arm.com
Subject: [PATCH] cpuidle: powerpc: avoid double clear when breaking snooze
Date: Tue, 10 Mar 2026 20:58:11 +0530
Message-ID: <20260310152811.1131119-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
X-Proofpoint-GUID: xxrWStqe6qlRhXSyzHLhMuvNKGsiNv5p
X-Proofpoint-ORIG-GUID: xxrWStqe6qlRhXSyzHLhMuvNKGsiNv5p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfXx3JMAEJQJC6s
 skgMFuHF62v8cujvCbeio3o6VptK5tZXRJ3emFe4PtFOYdtjh6KEtgE9av5JW1pMUvsj0WNAgZ6
 C1GJwDMADr+fVd0MzdW01PZve1MKy2Z0uZPB8DFctOtJPSduSeAqhWUPmb+Mvd/NlF3/QqvCAKu
 6jk7813h+B6//SZCGzFhPweNcR5aaK9/G9CBOztFt8djhrpQZaskQKF2jPFxY9f1/lfM6x7+R/o
 sruflTzolJeRoJXn1LH+dYtLX/XvH7gkUgz89BKfg5anF2Sodkqg4FrxslVshG7ipUJg11lIvsf
 6UvoJKFRy4af0teOOafV/b6LvJGmwZX325E3gzmFucvUZ0AkfkEJa2CesmyLL5198Da7IzZT2JW
 7isnOKDzKVHc2aL0+ixURmqVqaTeXHkM89wmmz1JXA9xmUIbdl8ME/TfBAXCuCMXIEN2FCW6fpL
 rg9t9CqjN6Po1yq2qvA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b038ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=cpfb22mzQ2lXxqSQ9ucA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131

snooze_loop is done often in any system which has fair bit of
idle time. So it qualifies for even micro-optimizations. 

When breaking the snooze due to timeout, TIF_POLLING_NRFLAG is cleared
twice. Clearing the bit invokes atomics. Avoid double clear and thereby
avoid one atomic write.

dev->poll_time_limit indicates whether the loop was broken due to
timeout. Use that instead of defining a new variable.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 5 ++++-
 drivers/cpuidle/cpuidle-pseries.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9ebedd972df0..b89e7111e7b8 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -95,7 +95,10 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	HMT_medium();
 	ppc64_runlatch_on();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+	/* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_disable();
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index f68c65f1d023..864dd5d6e627 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -64,7 +64,10 @@ int snooze_loop(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	}
 
 	HMT_medium();
-	clear_thread_flag(TIF_POLLING_NRFLAG);
+
+       /* Avoid double clear when breaking */
+	if (!dev->poll_time_limit)
+		clear_thread_flag(TIF_POLLING_NRFLAG);
 
 	raw_local_irq_disable();
 
-- 
2.43.0


