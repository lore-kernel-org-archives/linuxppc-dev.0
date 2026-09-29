Return-Path: <linuxppc-dev+bounces-28496-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08B3CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 13:06:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvJNW2Z1nz30Vn;
	Tue, 29 Sep 2026 23:06:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790687211;
	cv=none; b=QFBO5as6PQ2qcK006KwTBfaIJTFZ4OwxG0AyUT3dA1JE/gJfhq0GkL3dp+t7c6+wMejxxoitNnLlch7febBxMYZolehW0SZVNo1qdVxusKH/+EWcAHz/USpopPZ6X6fSbozRO6TVTlAUZx/WPAK8cLbp2ZDBUUwK1uX22GSm0bhAEQ7XvqyCaCGdL4ZgIjImnijhbwIXp7l7dkDkM+mixXXYLfwICQcut1b8BlAzxd2inOll+JDB2zthuV1ERM2LpD9cWGQiuOAv9kC+rzqREpAdfCkHyM6GtgFWa1tlcjdbZMN7cvKHDDuGxphSvxVcUKvNyOHn7Blmy5P5ZypIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790687211; c=relaxed/relaxed;
	bh=hv/+emkRWO9iPBjIN6Wh7WU3+msKu56KfxliaDemn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPSpFSk7IDmZi7MjDk8AnXrzG0hETBIXt4lXulTrwshXEpTJ2aGQ0aXhESsWZ+RaTMjIAQKehdaPK8+ImCgwWmj4mvNMiyHCq6Osu7IlIxN36v4wubuhI5GeN16cMvFRFzTWCUeSsiTGVxQh8ChwZBfv/xujDcU2yPbRyvVptWkcEHznUXScXTWBGiyUlSduaalv3H/qkCN6PIsvBsroq6w2rmxe/A1f31PecO2BkWa2eloUg5SjEWkcMB0DW9wQLq+BLSRq5TGP4O3wCyYlWEj1kVL5RnKc7j3MjKahxgSiQr/y/pb0HzlJVS0lTjuAldwl9V+Gih4rZS0+2jaKjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiZRMLd+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GiZRMLd+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvJNV4pBvz30V6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 23:06:50 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5XPq3836621;
	Tue, 29 Sep 2026 11:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hv/+em
	kRWO9iPBjIN6Wh7WU3+msKu56KfxliaDemn2I=; b=GiZRMLd+wW/ixZwyv+3lNt
	tzM2cQ8miXfD9XYvYQFFhc0L30y+MMwt2L7X1hz5/dbKBsf1F8JKuh+sQmcgMtSa
	0FEc/98PJwt7AxfxKbbw6Twxf2d2MTnxjrNW2QN4V2Jok8ve+r2pUISk4pePcdel
	I48jvk4+EBLgBBRyc4ISzlbbVksL3AZ4ZTny49EGw27pvGmnjCUAdGFAQFXI9Aby
	amVmtX6Uz8EIgbzSTP+zoB6gB7VM3cDPTrBkQa0eXatQx6MImZWqqA5aeqvWb3qx
	C7fDaEeSzYKAfn/ZkZz17nnREeY0yIvZCtFNevK3Hv4w6wTIoEuAIfJahAk4JDng
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fk6bk5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlXQO1607717;
	Tue, 29 Sep 2026 11:30:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsck9f7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUok932309996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C80C220043;
	Tue, 29 Sep 2026 11:30:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C14E720040;
	Tue, 29 Sep 2026 11:30:47 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:47 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] powerpc: 512x: Convert ADS7845 touchscreen on PDM360NG to device tree
Date: Tue, 29 Sep 2026 17:00:46 +0530
Message-ID: <179066556648.265207.5394340720095923336.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
References: <20260719-ads7846-pdm360ng-v2-0-1198bd108502@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: esyysZ8nb_dssoUcnUVJpjiGBXktWRrM
X-Proofpoint-GUID: elWxVTT45i9DCla6CZzhpgA9ouIOqIzq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX0LqpBqYRWpP8
 /78EM6W1bWtRezeBCdam+JlOQS4qjHjL96Y8DUsZujF13x8tmYFHFiTMSOKHQqvzDO0yzOLHUnq
 PPN4eWJU1iuwttxTNGr2OAWMIy70xvQ=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abba16d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=ymJX2-ASNZfWrTgWY5YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX2v2PBokA1Q8v
 AwfMESEHvPihUkMvYIeW5B20uHs0KaGHmXfiJ5Ncz43ImLJHy8qdInA6fEKhouTAGT8wfnagqww
 XzCegI0rkxa3b857McLoo7QbETGcOiMwTnZh7LyezteHhgG72SX5E4hXzKk2/yTWMpGykUmpd5N
 5T6HA+ohfaPNdllnEhuujTY3/YnOT09uoqZdxRw2SehXdj07zfbfG8ECrCBoKd71Pmx/W7RF3CM
 xEJe86EPX+/pnUMjpKv4SA/DZSlB0k3QoFG5HD0hqPQU6EgPFcv5jr6A5tZsvSfTz+7mBRLYIz1
 C9LfiLjMNQiMg4Q5Cuz6hb//xI1monMPmVtqXkw/2q546H/MQDBy0CclBqH7xbnkfh0SYeML94g
 MSrPdxNgzaogeR+FEG3g+4YkgXXlRcHjHhlrFGkRejJuCmSC0hlPn2dzpDCJanKLUCG9dSSmGYs
 y/hfrMvt18II7ytEYoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Sun, 19 Jul 2026 22:37:15 -0700, Dmitry Torokhov wrote:
> The reason for this series is to remove support for platform data in the
> ads7846 touchscreen driver, as pdm360ng is the last user of legacy
> platform data in the kernel for this driver.
> 
> This series converts the ADS7845 touchscreen on the PDM360NG board to use
> Device Tree bindings instead of legacy platform data callbacks:
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/dts: mpc5121: Move GPIO controller properties to SoC dtsi
      https://git.kernel.org/powerpc/c/dcc3091bde54bbf870b56edb3c91a420c1bcdb29
[2/3] powerpc/dts: pdm360ng: Convert ADS7845 touchscreen to DT bindings
      https://git.kernel.org/powerpc/c/4e3187c830221460f1a7d9389c3e8662ad28d4f4
[3/3] powerpc/512x: Remove pdm360ng platform setup in favor of mpc512x_generic
      https://git.kernel.org/powerpc/c/5e78442b76844e4d46b9cac5ed123b76807f30db

cheers

