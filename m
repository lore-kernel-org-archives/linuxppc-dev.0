Return-Path: <linuxppc-dev+bounces-27207-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ED0C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:21:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxQv69sXz30hp;
	Mon, 14 Sep 2026 17:21:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370487;
	cv=none; b=gpVp7ORFkg/zNi+aojVsBlV1mMOtOTStWxuH8fGsJ3JzcyvwtvAiLWJyoWILCdl6wmmBfNH4itU0Yco2MJ5qnKnbL+hNQ1OB7CVX2wbsQVJvm/RrnDgCGDFy9NjBirqxy914/m+yPMfQuviqlVOGJwU9T6RdapIq7d/3Qb0euFWIADVl+00U/pfBBBXLwy0IQQK4rpyA3ZqciJ1wtA+WaCXi+79OmEcq7Vrpxx97eoUb0+tdHXLVWPKCAeT+YyR4gC+/7l/sIee7Kacy+hmLW0CiO9mzigy42LQsXobwSpf5irJOx7ZZSfBde1G6DowCwLr0Ip1z9023JbBsV4LGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370487; c=relaxed/relaxed;
	bh=cmqwSJYMvilChS8IzIt2ftdb7PJaTwou7TsNMuscwWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JU1B96WLp/QK4Rb/k96/8SCEbl1izI/7/mUYCmWiNpyTwGJg/fQRbShWrt+g7Lkzru3PccTcJFtVh9edWkUiu6QQoAzaXdLl0Z8Y9oeIUhitATq27yRBnNQqaaYQ25Zm72T2d3CoIGruNZwOm93kZoyETMa8bjtT2IbeJsc/cmEEiAq8k+QN+c1T6k/Acwd6FNxKdbGi5XkqrjLDWgOXu+PRonzx7345Wym5h7cTS+E0ARVw1+IGVIG3az47LMRtRuY0AXOBD+d9HmOakfzCQEdwLZofVfbPC5CdRloZkcXrjI8P7YRhQZVjo+VRJD6vQNw5L6uFv+TiI8XXz/dwoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bu1nwOtU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Bu1nwOtU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQv11WFz30hg
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:26 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61ZUR1242982;
	Mon, 14 Sep 2026 07:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cmqwSJ
	YMvilChS8IzIt2ftdb7PJaTwou7TsNMuscwWI=; b=Bu1nwOtU9+WuuvpiDkgw74
	//5nUaPiNhrVn/GMVa+wemh48CJDMau8F8wyIf5e0phCBRUYFhXHXbn4au9px47R
	BgIeaC1TZ/odHR1bEi4x93VaAyZvzsAgXoUGT5thstIesE75yGieLQ1Z9uz4za5M
	bIwg/Qk5htEvYXgOXl+7GaZn2QjJlyxF+c15cIdppIFe/glvoMR0pL7EwuIHbxAX
	fqgqpM8417p9jzOxD1FXojzbmJWE4Uc5UqwvdV8Niq/Cc/KPbKOC0CxeuBGJKPiH
	1mMg6uRT9TUlnFyKXupgbSnNW67l8KBrPgbFlxubD+QpNP7JhecNuKSxTwl2vYTw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcuqk9t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o6TL1787513;
	Mon, 14 Sep 2026 07:21:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnjjgmfx0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:21:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7LD6O47383024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:21:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 178492004B;
	Mon, 14 Sep 2026 07:21:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DD7220043;
	Mon, 14 Sep 2026 07:21:11 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:21:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/kexec_file: print configured kernel command line
Date: Mon, 14 Sep 2026 12:51:09 +0530
Message-ID: <178919368040.441103.5494854066059638880.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20250725124438.327593-1-sourabhjain@linux.ibm.com>
References: <20250725124438.327593-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX73rQIHSqyDy8
 pvp9x1dl3cnyGvfqU45vCicNBtAQ1ZHEZJdQwfmXx5u8e8qLsYWBeAxF6ADPtQkWjFgak0fTTfp
 HaMPh9F/25y8EztRPdhL4ZQ66q3wveQ=
X-Proofpoint-ORIG-GUID: n8ey73Hsw0MIu1ilINmym2Uzl4WXFEHk
X-Proofpoint-GUID: n8ey73Hsw0MIu1ilINmym2Uzl4WXFEHk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX9sNx+Dhg+lsm
 hnLHI9vxUOd/t7fa1U9miAnZFG9VJnAoEJ6j4U8Rs8wQ3bNfziSjyzah6lzQAaSqRMJf/oKjrpx
 6hKgGNdO6mlFcccOt2oKLxIq/U7DA75Ss3DVw5cm38zMC2zh2/Le34LfYk/6wQJ02YU/OMSBBcB
 ze10LtlCppMQAHdrEuWEz8RwanuP87dfWZuag/BULZyudy6xj3HT0AKqlxfmM/7M8G/CEQ4y6CH
 ClmAMoB6i9n2w57lAJR4+fLH3cCgPd2FqQVbYJ4G2S+JP5Pug6XxXf+jfHanHOxQLisgUfASu8R
 HCh5Wzf3BAoII2Zzl2F+NN2ng1jXYWkw2WVattudWvqyNkzJkGMsXodj9uMxg5/dVp96/EGEsnf
 oBqXBMzVy4Gu5s5P4i5qMLTBrVtIKqv8vYxdoVur6dsN2sE4Bke0Y0O93MKu5YbfsgNIiYxI79f
 brpnvG060EthxLMiqBw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aa7a06e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=MYERxeiKC65ivbI7FBsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140098

On Fri, 25 Jul 2025 18:14:38 +0530, Sourabh Jain wrote:
> Kexec with the -d option prints extra logs about the kexec/kdump kernel
> that help debug kexec and kdump. For example, it shows what kexec
> segments are loaded, their locations, and sizes.
> 
> One key piece of information still missing is the kernel command line
> configured for the kexec/kdump kernel.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kexec_file: print configured kernel command line
      https://git.kernel.org/powerpc/c/e58b9d90973e09f1908d2cd00ca2336a8232b9f8

cheers

