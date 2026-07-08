Return-Path: <linuxppc-dev+bounces-23812-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B7C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:52:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwFKT2lTGz307v;
	Wed, 08 Jul 2026 20:52:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783507933;
	cv=none; b=F8k1eTnJ5z4Gz2gbXeXhdcBEFUq0QS61pbyvZNeLe3jTo3iJOc1mlVFtxqB9QBYHiW9sJExSG2VT0n96BuNYqO2qgFwIX1Wi5qdQUwdQlFkKlNhsNgBMKtT85O7TIvQZQb+ZHUmCoJ7YWTbLdF4eUIHw+Ty+JHI+a36bquTeTH4PLBNORMQj9zpHCX4mzGf8wGqNx5Fe6sHVNXX9LnBGuV8qzS8UzP99WT+l5o9ZmX3DPJ0Z5WhJjU7Xw74uEv7hKbs4+PhOZzpnAJ5AnpoGvQXamCq907inhti0nAJQEDHbOqeGgB5k+p9MfhcEyFu8WibeElTc/iuPrCsMNaPWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783507933; c=relaxed/relaxed;
	bh=UodIreQE8qHt8550xsUq5VuxDg0b0zqTfU62eY5ynhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JB27T35tStgmcJpa2TznGWTop6geli9ivggYO9TeiUcogeCvVQyIwsHeyCWiB/YTlsBZtpNbzOsybvDmw3Jn0w9WSZPnrJYahLLanLUlck9oQ0OSoSPnALGLFjQlEnmZCtCRk8Et6nYEn3t3EILoAxlYCF5Nl13mkQtu6qQYGy4w1ZqKnslRlX7lsdPyAzvhHfqRVL6jrTAfa+9rJnTxE0hB/2a7ODmXlFASw5hvCenC9CuROc6jXdFK00IwS9hZ3/6MF4eTSMBBSJ9Tk1+74w083hCmo/9BZGYhGPcwmfuGLQbZyHJlfKXVw6p6NSD8xgbonVj+RpA1HeEmHmncJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bzbNeiZ+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bzbNeiZ+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rathc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwFKS2wdZz306S
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:52:12 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IXZk1830649;
	Wed, 8 Jul 2026 10:52:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UodIreQE8qHt8550x
	sUq5VuxDg0b0zqTfU62eY5ynhw=; b=bzbNeiZ+f75fX6ofnaoS3qp2XYK1mbfJK
	yJ+4Q7VbsRsVbi8YTI+TwqSPB6Im2MybdrYA4Z/o9nXF/gb6Ok2jg/XEzRWILG/A
	YySyfw+g3GAr7jEJ4fIdObfs6EBw4Q8GXXru0Ex4vK+smdw1UurNxTlGKR7zgMbl
	5czgJdAC6zyWRSCYWbgequv57I0zNX53BqhlaHjIMB53yv0Z2Ue26STC0zxobNvz
	k/vlCZNh1MxdrEezsXT4dGXDD9fKf5bFbKpbxD5hA7/2ugUPdtK+3y+0fblTi90Y
	ZbgefjL4Tf6WkcYCvd2Td6EUdxKEb0/6cLgmj+ZBIOhVw0MUuZIwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsvc55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668Ank7I011282;
	Wed, 8 Jul 2026 10:52:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw7ta9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 10:52:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668Aq3Ef44892646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:52:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D67020043;
	Wed,  8 Jul 2026 10:52:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB33420040;
	Wed,  8 Jul 2026 10:51:59 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown [9.39.26.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jul 2026 10:51:59 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: thuth@redhat.com
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, lvivier@redhat.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Chinmay Rath <rathc@linux.ibm.com>
Subject: [kvm-unit-tests PATCH 5/6] scripts/arch-run.bash: Fix run_panic() success exit status
Date: Wed,  8 Jul 2026 16:21:21 +0530
Message-ID: <20260708105122.1177210-6-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708105122.1177210-1-rathc@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: IehxzkGrU0yZUuCCJcyM1V7gr5iXLsnd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX7X+D7ps6KleP
 BS6ht6vTqswS93DZFOYlKaWX/hC3WnNBz/yadBzqH2KLZpxW6VMQvC66N89QeVbrcTH4iOsm1Cg
 HGmFuUNWEhQ0R+8CMEikjHVbE/xU1dg=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4e2bd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9Q_qCks6ew66Kax-6aoA:9
X-Proofpoint-GUID: 2gxqlzuPFVrap4u7uE0ywCjQI1bwUeXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDEwNSBTYWx0ZWRfX2dAysjch/8Ab
 gfoYTG6oK7K1062YyFamYipnTNBXZGbFpyB24pIJaRl9F1MnJXOBmW5v9r7L5R+g8EvVbtjn9Op
 8mixkqG6jWgjwuEViYWT1TEwhjgTqVzt8tHYiFCThOIFLtSoiWRtcn2RP6PScsefmrBdl03M3xf
 4uRygS8i2WRktTExTZ9j2okczLnPafKcnBndkY2O67kgrGR7B7Lepo+uaqNfNaZedeZ99rAa6us
 xBUEQstrFDpqO9Ss8/ujIKB1wN5c8sEAK1JoyVMFHRkvEpQxEyO40hS/tq4dSiKcBeLzSbHCHXr
 bjyR5yA8NWCuRd9I7Z/pbboHEubBtcx3fiNDItKIcKW7ZZwcC5tlJJN/zy4aLXsN/+Y05aGa5qA
 3gwziXspL560APbk0af+t0hf2JIWkHb/DK5OeQnl1dB01AAHEYVEiUD6LeF0wOchLQCfC8B+DzJ
 TX9iSocDMZu3UhvlSOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080105

From: Nicholas Piggin <npiggin@gmail.com>

run_qemu_status() looks for "EXIT: STATUS=%d" if the harness command
returned 1, to determine the final status of the test. In the case of
panic tests, QEMU should terminate before successful exit status is
known, so the run_panic() command must produce the "EXIT: STATUS" line.

With this change, running a panic test returns 0 on success (panic),
and the run_test.sh unit test correctly displays it as PASS rather than
FAIL.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Andrew Jones <andrew.jones@linux.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 scripts/arch-run.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 01cc1ff2..41a903e4 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -313,6 +313,7 @@ run_panic ()
 	else
 		# some QEMU versions report multiple panic events
 		echo "PASS: guest panicked"
+		echo "EXIT: STATUS=1"
 		ret=1
 	fi
 
-- 
2.53.0


