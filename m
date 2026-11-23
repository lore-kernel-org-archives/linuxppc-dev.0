Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C5B606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TY03hpiD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY5Mp65R1z2y7p;
	Mon, 23 Nov 2026 23:48:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795438102;
	cv=none; b=P22S6HfOzeXm6uXp7B5zYvig7nhHkoJvDic5nMErTuGb9vq67vc9FHI1kNEzIa0fKykcC4BmLgALLr5t5hyi48afWHiVe1TDz5VsmwpJYViiHPG70KKLmgHNwG6UThE+cqW2W6ETnNCDyDHVUGigNgA5SrAPNIpPY/kc0uQ3XykWMq2su9mAF+QJF02nk2u2TaWnVPLu159UNqAGfvZ8gqwZS7edsaxRBviu2Inx7sj4bxcBrn32wNEjcS8rDtcWCa4j/vAS3w5yqBkp5zJ0St50kBux8K2j143Gg83C7K3qEPDWZULhAZxcpVeHAWWnWti/piF5HHaNG5if3/5QUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795438102; c=relaxed/relaxed;
	bh=izRW27saToQHuIbXyjMQrZy5seL6a5k0ATCNInZpa7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xazl6CGT4/jkOqIzwvyQl1uv2v0dTVpwi7hKyQgOh8RXKppqfN0k7jOLtnOabpQkySddA1hlvh/s8G9WELwIX4PtHqly6JXzHGEQ90tcE4cb5UFgtiBXGpXkM+G+qVLRX6PVCcKP2vMTUKWDIn7d0r4rs80jYo7ootN3iMj8kBNUU0A+XbHxKt8yZOrzgKT4MryzNo7oLXvD52fMrAMvYEMEcznVULVMl+P3eCbRe5xnxNqHezq/Yu5zw76/DqaF7/lmRV8BsMQhQzYBYTKGo4SKZuBhbpe8V8x/hIqmRq4POfvQz/1iWaDlQaH4EnJ+wKvskAMjrv3deZ0PGtkHDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TY03hpiD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TY03hpiD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY5Mp0MGVz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 23:48:21 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCZJmR2363250;
	Mon, 23 Nov 2026 12:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=izRW27saToQHuIbXy
	jMQrZy5seL6a5k0ATCNInZpa7Y=; b=TY03hpiDhfLWdnsrzTQpi8mlnJqXaMWnj
	nCd+Nvz3Anizaz2jg0kZpXbpvEO7MEkTefJ6i2/+mcbu4XH/BxrXjQH3W7Rs/IkC
	/+hMm24wb9N4197YsXt15OgT5B+9uB8p5z3vbNcqmXKV+q9NIJWb+zhRrzs2cW+l
	pBbGZi19tC0xT2VTr6npN3A2cDUhyzjdcZIEVpHRHugu93xNoobzoec/eDtVSuKE
	v+tWI5w1w3ayk5lt71UmpBPQGhmhLk0MDVY7fyLSt0tAscYSsSa1IN6fpKmNxWjr
	TIufAz+px8rlsxl3Bqmb6W6Vz5sXcibV5fon4P9fypov/LSL3Ud/w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4arrv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:48:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANCJRiO2967112;
	Mon, 23 Nov 2026 12:48:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4h6rat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 12:48:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANCltxX53740012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 12:47:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6C602004D;
	Mon, 23 Nov 2026 12:47:55 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5113420040;
	Mon, 23 Nov 2026 12:47:51 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.24.192])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 12:47:50 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, peterz@infradead.org,
        tim.c.chen@linux.intel.com
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, srikar@linux.ibm.com, npiggin@gmail.com,
        mpe@ellerman.id.au
Subject: [PATCH v3 3/4] Documentation/powerpc: Add details about llc_override
Date: Mon, 23 Nov 2026 18:17:29 +0530
Message-ID: <20261123124730.1466978-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123124730.1466978-1-sshegde@linux.ibm.com>
References: <20261123124730.1466978-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX+GNRAKsrxxRa
 xfPqfm/fB8OGI79+875QePLLe8DG9P1SELeQY+vOl3XCBttjulE/rzssJiqmth3+pHIB9y2qEfC
 agNbJIw2JIsuF2o8fJjGRWxxiRf0dVo=
X-Proofpoint-GUID: pKrA0lgHnh8ql6Lewb6FyGoWW1MhcO_-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1MCBTYWx0ZWRfX5XzzJseluHfx
 V5tSLg8w5Mxwkl+7vQenjZroeqQG39P12ODjRZoIibYpSRXK2NgCpaOM27qhck0uLu8ESQyRbsg
 fIiD3iVHTtrb7UCceOnqjz2MV2P5YulDyMu5bV1/zolIDsH/5dHi8CwBCHGVQFyi/jH7XKpT5ZZ
 197U3AARkCL4QzyZ0eJMovq1hUZ0WCEwE/NXBsGds8uGmZeHqMDbLrFXp6gmQ1MAPHWskGDnPC/
 YEAud8QnFXa8DDwHk7CEl/gA0WunKtOHSWY9I7ZkfqYhPTdYQYTe2L7JanS5FbASsgw4Rmjowje
 ggd75DRbSj+LpQ6o8WL9Q6gFaVajVwVuhJcOvtogGrbpcKcKbmGwkPZ26Bev2d5FR9+oqmO7xSC
 r0blYktS20+5MnbkrwOcAq2ILIDUjP9v4Js3McEZzyiQ+0eeimyAYjqFhYy90BsrldaBFJ1aIY7
 QvMFAoK6t4zoDY+0moA==
X-Proofpoint-ORIG-GUID: xgB8P-_eYQ75zvsmB7B4dr_Egu39Vvlm
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b043601 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=NXvIAa5lxLtqlz6HxwAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230050
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide documentation for the newly introduced llc_override kernel
parameter.

This may help one if they want to experiment with cache aware
scheduling on powerpc.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..6e5e9879f56c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3583,6 +3583,21 @@ Kernel parameters
 			Enable Live Update Orchestrator (LUO).
 			Default: off.
 
+	llc_override=	[PPC] Override the scheduler-visible LLC domain.
+			Format: { mc | pkg }
+
+			Use the specified topology domain as the LLC domain
+			for scheduler decisions. This is intended for
+			experimenting with Cache Aware Scheduling.
+
+			mc	Use the MC domain as the LLC domain.
+			pkg	Use the package domain as the LLC domain.
+
+			If unset, use the platform-provided LLC topology.
+
+			This is a debug option only. It does not change the
+			hardware cache topology.
+
 	lockd.nlm_grace_period=P  [NFS] Assign grace period.
 			Format: <integer>
 
-- 
2.52.0


