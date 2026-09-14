Return-Path: <linuxppc-dev+bounces-27203-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91112C88E50
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:21:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxQg1zm8z2yjw;
	Mon, 14 Sep 2026 17:21:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370475;
	cv=none; b=Z33Pat0QE6bZg6h9V7KHTEAC6z5S2BTqqDxiRoV6Qzq3+6KiGszXQ97jgDIwIYSquKS/NIVAo+HHLMcVCs2Ko0v9xIhgG+mmpIULOEmKe1+zR/Sx8KXFQnnemnKOrz0LBphIZWiTA95Qw/M9mC0RgEitIYWincyOcDrMwF2QfBGdHy4CznjN0it89aT7EwcpKwyId6BUTVHYJj4CIiV2BoXYDktP2h3/4qVG9ePvQUYB3s744gwOzXkuEZ0yXOzu7czGrMOFGL10PS6g3nW4db5BfyRo7fqn4rni31GGOwTybgqgkRv0dGQpFqSdk8lPtdKpXa04cPiHNBShpgtAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370475; c=relaxed/relaxed;
	bh=Rrsrq1gvEEAUebyWkYRXmAor7uy0bZhljPymPF4n7tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YaikIl5W2FQJOrKhW0IGLbgHbjkP2bpPn3OhUx/YDYOGOpGh7EmFzULX92R7LCIs023ZcyPcUEXLk38OywGlnOHlNt5oJMY80zXrtPmvCrfdEtw44KNXnCKwiWmDW8YbUWmGEf3/Bl+a1R2y2f2LlG+lg/jO4Ui9LE31h0k2eboMyYREZwrW03WvyMbFOjb2WDgyatMAT0JIhTjdEPi+1jun1BW7+QrRaeCx4ryMZo6zKtdzCLy+7dJFuEDDXQMPMzD9VO/77loOwFbODxdEhE5KIzUPmpA0mdPyDW6cTtBqhb9M2CHQukfNQpXfL6HJfWiMoIUjSiOULPoUJWMz6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/r54h2E; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/r54h2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQd6McBz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:21:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61bui1219967;
	Mon, 14 Sep 2026 07:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rrsrq1
	gvEEAUebyWkYRXmAor7uy0bZhljPymPF4n7tw=; b=j/r54h2EPzxhSdfUek8nb8
	a/fR4Tft61zlxId6xG8Wnvk5Ds6wQynhoRWP/fPhG6IB6NXpPoKc1MGWgKwKCcRn
	wEBe4s2L3YApWlH1ym6BbnK0dTXpc3HieD8RJrI3DgHuaJIbYcDQZwaJNraik9AA
	QXCKrXM7+Y+SnKlV9KZ6MDzwaektOv/3Q/Ycv5L8zNJQjiRlntKKqE1aUP1D9gOZ
	QpTel5qKqsFBHV9+MAhVsXWy7+oaOke2Cahlu64YMeINNZm6CSVf2ZOUwBQwChGG
	2+hJe9yILWacWikO0LEH6OhfkPnfN8DtsRLgKUrKZ3b8lT5ltVNLB/ZYTKbcKLEg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4qs0c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:20:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o4qC1775082;
	Mon, 14 Sep 2026 07:20:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnhevvp42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 07:20:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7KoOG40763736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:20:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 991E720040;
	Mon, 14 Sep 2026 07:20:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C3EC2004E;
	Mon, 14 Sep 2026 07:20:47 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:20:46 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, aneesh.kumar@kernel.org,
        Christophe Leroy <chleroy@kernel.org>,
        Naveen N Rao <naveen@kernel.org>, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pasemi: Add a null pointer check to the pas_setup_mce_regs
Date: Mon, 14 Sep 2026 12:50:45 +0530
Message-ID: <178919368045.441103.4497545121257990515.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20240117091706.153431-1-chentao@kylinos.cn>
References: <20240117091706.153431-1-chentao@kylinos.cn>
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
X-Proofpoint-GUID: tBcR-VeGAUNBbq-Kuay96F5Kl2X5plBV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX6H+MbKivV+wd
 iqopI3+hw1t9XoLHpT+pxGn2meds70MUdvztJiVRmgU7adjzj6RE1Ek6XH4Jhfv7uxfLBCLVyel
 hwOcAcZl9hzxnMTHZ3MKVl4qhPZOfFo=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa7a056 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=-w1i4xx_hGGhZ5jEBOAA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: EOz-WbQtdjfuYzg_n1nttKfYkbzlJmo4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX+SoI+2k/zCHs
 8Qrz+Qv/kwKjwjLfgql5wtJOmXDSzEOpZ9CLHw6ey1iswQVgb3orRKwA404mHwTSDXocIfAIwI+
 YoLJ0IytraCbMitK+u2OvJTtOqR2syi2aKi3CBi1KVkVJW4pDs/CeiQ84KDoRsMZRItANsI6BFq
 uYCRnti9Oxo78iG2GglvYo+pnWF/49x3e3Udso/vZm8CKjNW0d3cTO2DfSIbLkIPjrNy6Ec0N0f
 SY7EVMDkIX0VnwC9M2lme2fWuhIRvxJPzqFi+FsZfLlOfKQW5C3bfOFtWie1DqAmftoC4sIkBJz
 tjZImLNsx5FoJkpB2HZaSRhPJpTCSeXrrdv2fTzt6lLeamrRkJWBVMpvJSn6ZAZ8yAKbcPlEljN
 ZyX1J2vOOaFQu7h5FF9mqTAxpTHZ2rvlhYfq0KRsIkek1nsKBOQeDga2lWzXmDxiB+HqKN3S3MK
 UP+CG3DUrqdhTV2rnLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140098

On Wed, 17 Jan 2024 17:17:06 +0800, Kunwu Chan wrote:
> kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pasemi: Add a null pointer check to the pas_setup_mce_regs
      https://git.kernel.org/powerpc/c/9e5c53d75c560a058abef0e4338c5e3e52cb432a

cheers

