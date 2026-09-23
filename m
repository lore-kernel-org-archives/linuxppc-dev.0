Return-Path: <linuxppc-dev+bounces-28051-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A7BC98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 18:29:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqlqL4nDlz30Pn;
	Thu, 24 Sep 2026 04:29:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790188158;
	cv=none; b=MbBhMZ1HfqWUYdbdQpZ7nvcqImG7+MHTREceQXFRHdB3YdcS9fqJY17aaa73r/F7PJa6kGimVWBgzk3k4yjYv1975VeyCsfFUpRTw1F+FiV5+HOM54NtcOF9NSpISONjIFjLLuZKm4+mlWM3MVpeilRIMOdgDvAftUyV4UAjs7ZbhfCNfug3/B2YVbZz1BiQHV7E8hpH43HuW/0flcNrTU9QscyjJPpwKfnYQYr7pWu/ZsWIzlzxo7nCsyyLFQ0sX9DnqJVuVrHgz3z6V1pd1lTbZuIQ+Gw0B4TZd52mgbeOjcHSaJ1zJzfdct+ubEFgURcin31zm7nNwW5gGB0VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790188158; c=relaxed/relaxed;
	bh=ywCMTSCyeGAzbgXH5x2KBRyc3ZG46OMv0ToQVSC5CN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6qkv2KLJJ1dl1JYCgEp9VPf9MXfkknld8JL1unCXjVih/WN/gzY28ipwBTpDUNSoSf3xruTwrUb2ceUoScUJWab/m6JS/jU0e7TDeOfb0aRSvdW1DU/WN4EdShW5bA7ul5ILUxpaoRXawvxiXU4Cwtj904NZaC9fiaYS5zBZ9jdKFJPYub5PUWDsfajYgv0WeIrs8gpYUywR+/KqpqbJAQejPgnLyKfK5rKeNID+z2SCfAWuoOMl43KpO4+HKyA3+bLkWQzgm9TXpV+mkGTNVdwArR5CT655WC0Z/aRLjYZKEpAw5dHdxkeq//ZKB8oz6uIgL9nPOAMa9P5sYUULQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dG99u3yp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dG99u3yp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqlqK5DLCz3048
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 04:29:17 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGZUAC2748577;
	Wed, 23 Sep 2026 18:29:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ywCMTSCyeGAzbgXH5
	x2KBRyc3ZG46OMv0ToQVSC5CN8=; b=dG99u3ypLoVjczPELGUEhV6Qfg+/CW5QR
	Z5h0V5APZSjgvGo12d6eIghEFPhblH6LAPDZJBFY5fn4QZF5kqo3tPGGiu38Fejj
	ZuEkYAB75AeQZFFsZJfrSabby9LkrvhnJ7s6rPswZ3fOK4na8TWvSJKjkK8DFxCV
	gS24jq2duN+sBjLTRk008JZtRvSwP7aMB9YBQJaykxUk0LfBIyN762S2Fu1k7hjM
	UFpRtUxu5zRe0NR/+v7UwPQ29u2SYY1ibBZpINq/05VX7e5bQHJXRpYkTJCFTnAp
	GqDXQE2t1WwqxtKA2Y2Rl4Q4X5v99mru8LfHH3Gvd9b2+z7xKud9g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqmc7e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68NGWvGg627784;
	Wed, 23 Sep 2026 18:29:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2t585-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 18:29:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NIT1IM39977254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 18:29:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2185020043;
	Wed, 23 Sep 2026 18:29:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8707C20040;
	Wed, 23 Sep 2026 18:28:55 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.83.254])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 18:28:55 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, nayna@linux.ibm.com, gjoyce@linux.ibm.com,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        linux-kernel@vger.kernel.org, rnsastry@linux.ibm.com,
        ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH 02/12] pseries/plpks: fix error code for wrapping key reads
Date: Wed, 23 Sep 2026 23:58:06 +0530
Message-ID: <20260923182816.151451-3-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923182816.151451-1-ssrish@linux.ibm.com>
References: <20260923182816.151451-1-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab41a71 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NZelvwgA2UR8l0CqTt0A:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX8xBlUSKcUzLT
 /Ot8eOE+EK6KQkyouPcrWN/uP4Ec83dShNCgdJcsSoRPWVSgpQAg7fYUwVzQdOaHxo9Z+mkQkgJ
 xlWWLX0LOiqwxScakxkFFCx4Jx1mDtQ1I3ZqjKnhYDousp6oFO65Ehdm6Dcp/hUllTQ3XKKp/Q5
 u6j9GXYMnBffmuHsJ9oaWzM7C/OEmkU3V9qOIf0dc4cELHsBKze6ZrROZOjLL7zTSkM7ykfZxwP
 jUZUBnxjnP6TMHDy2T+ysQzWNVDqrjTH8OOzMUSD/AyZipdNHgczfIBxOj73ckVsH1/VOjC9XzX
 UwgEo0Ak2PsYzEKuVY1O3DCxo6WTLb8dhHam0+5QPGjUeixUXhIxslOmuE/UpFkd5prcMH8toNW
 nd3fL1HI2Z+FAcqBrii2hqAPbV2Gqi0Kvl9IdDZ9phKJKF6fA7JtFRUTwg3a8zQXI894Xvf0tBO
 GsE33ZsZdlHrMm+rUNg==
X-Proofpoint-ORIG-GUID: S7BzPrRGZtS10uKzJDj2g4kMevZHVlPE
X-Proofpoint-GUID: VowuZ-cfXH1a2eK1HrNdZa7bRnxQLKRV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA3MiBTYWx0ZWRfX4ZCbHVE8Xgvu
 kUOy1XHw3ekRvqAfjknbZBBd88I7/WEX1U/vHKdZwflCpnW19bZ/um4a5dBm72zvLduBVRmaVsa
 fSd2w1DNQFa8PuMfJ9b2JMo7EwYY9og=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230072

PLPKS variables with the PLPKS_WRAPPINGKEY policy bit set are not
readable. Return -EPERM instead of -EINVAL in this case to better
reflect the access restriction being enforced.

Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 7e56b3dcacbc..ccf5765a907b 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -829,7 +829,7 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
 		return -EINVAL;
 
 	if (var->policy & PLPKS_WRAPPINGKEY)
-		return -EINVAL;
+		return -EPERM;
 
 	auth = construct_auth(consumer);
 	if (IS_ERR(auth))
-- 
2.52.0


