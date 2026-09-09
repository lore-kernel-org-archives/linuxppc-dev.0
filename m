Return-Path: <linuxppc-dev+bounces-26873-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A9DC79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:18:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrGZ4DvPz2y2J;
	Wed, 09 Sep 2026 16:18:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934710;
	cv=none; b=Q0eFwXwkg4MHt2FZEI5c6SWe8dMyvZF9hDTyxkNaH13XWlvQX5tBRbLCyqdpaoCSQCYuSjqCxPJ/oprOAmyuguTjiRYQKF4yL3BIwLqUxEA5yCH9tTGTrBz7KPpQtzJBuMtn+TdBABg9nwQ5bFfBlJAl4U6lH08ZvoJihnLchBVLJb5V+dXM86ok/giCYE0mwG5bDCABHL2WCpObkLAU5qWLAdUXyMqDGgwVvRkG6ITTQvmuRjUPq8Tki9rAiCMU283JJxZk5VU78nq/mj9RcNH0stkb+00P4uQq3R8uNPU70a76/c7wJO5OrERj7jRErZZrBaL3Pamvgt9oNEI1tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934710; c=relaxed/relaxed;
	bh=rInJq93q8bp86+FABX6sKwnqHmHaaP7HxP4K2/hdR9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfV6tcw1loijpVbIY57oTd/trOi5x+d6odWvbKXsXzeYY5gE6WWSMU01ZLE5HoAUH1KravTEhT06JY4HLeeat64jxbmIilFPYCKpyiTs1Doj7W7CWr78XBOWAcn/FjaK+7n+u0uY3KBLSQpRaCnYtt+xpvOsUj+b/O06lO+NjAv+5VGT1fYcjx0X5olvMiQr0zh+2gji+xkDH6JvWeBPfcT2vWjc162ywdAOyH1SsChKBHo0RKGHRz/Pq+CJDKTjINv7F/7nClpGkbrxpbH3vh/S7gXu/+SesxxX+iAbl9VHlNmr0ZYl5NDSCg0vtdAhjdaCZudu6IfCJaW/zpT67Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rUWXvh4z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rUWXvh4z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrGY2FGbz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:28 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1VxT2126097;
	Wed, 9 Sep 2026 06:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rInJq9
	3q8bp86+FABX6sKwnqHmHaaP7HxP4K2/hdR9o=; b=rUWXvh4z0Y2zDVBkG8nkQO
	mYdQgZEzA31Qonr5vRxwBuJ+r2YGK0j0N+bTuRLOBJc14wuXdzchMIYAbxdxPRhr
	d4ufvHd+ygI/DC2ZwPno6z8dzKipq0fQjoevrrdoX0IUKBunQWmc45oPYNwsoXBV
	ZVUwJZwi2q/7OmiqFrf4JjNSzOl85nJXyodBzO/HtaRCoVi9eFzuFkcTUt9wHsiU
	uGm0jV6CoemMuCOSI82VpMEzhcgWpFYErDdWqbAQUnNLkW8RuVes1fRJTFU+cZcs
	VDJIC3C4d/DKmMvoh8pGprYtVmYQpvY64sS/iY2gaaiKxFrJdkzI4TWCS5Sf74ow
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8bpvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BFRG029551;
	Wed, 9 Sep 2026 06:18:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk0mn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IEPu13500860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:14 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3247B20043;
	Wed,  9 Sep 2026 06:18:14 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12E0720040;
	Wed,  9 Sep 2026 06:18:12 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:11 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Subject: Re: [PATCH] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
Date: Wed,  9 Sep 2026 11:48:10 +0530
Message-ID: <178893459274.174069.12728922895140522776.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818035037.613186-1-maddy@linux.ibm.com>
References: <20260818035037.613186-1-maddy@linux.ibm.com>
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
X-Proofpoint-GUID: ae_OdZWfHO4aNoVzteDDXH_4ZeJmVHO-
X-Proofpoint-ORIG-GUID: tzpsSlO_Nd0AriJ0UCBw35j1N3FUq8P9
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa0fa29 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=Lqsuioe8rBiY4fJThLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX3FDQZcFW8g3c
 pspN4YKhCIETh9Pub3IbcHN/G55xFC4JTZ/vTMPSmURUVgtalv8naILBtBR/nNVylzVCD3lVjwU
 YVPxxETqn3x+INg2cN/ndcfwFrEjX9I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX6xH0Ty4qCkxr
 RLW4tfA/AD3Oittfj8CEG1f8bnCJ1FTh4RLbipJj/WCYPvCfNagCb1e6i2shkTl20Xqz/YvvK50
 KS7/mLBQZRiQVNR/vR9WL6YCHZntrMkTsitdAEVTv4OOrqhcINHPDgJJoJ7/lcofGoOS6D/zLg/
 wHRaV7bN0RTkP22dv5fw0vVjyWBYUAa5hezboaqzid8NpncsK408sz6CCBcLvqp7o6NetEMNbES
 qalzsWwkof+obSpWkqkQ7TILaTHhO0r6lOm+OoPIzl/IuAouYvujnHAXWP/hEO2xepIV011Q9lY
 6Hx3Dt62RO8+wrWukZoV61W+CnUzwhS5V3DHK+CGB7xXkCGl+NdyMiBPXm8nOvUgd6udCkFZiTN
 V+KfPUSq2gNqW6uPsivLOYvfoOTUqxUn3yJqqu87K/s/x4iL9/Z26YW/h5WAP+8u3zeDS8OLpVS
 XOwZo6UQWdREoAjjH4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Tue, 18 Aug 2026 09:20:37 +0530, Madhavan Srinivasan wrote:
> Ritesh and Shrikanth has been helping in the powerpc mailing list
> patch reviews, adding them as reviewers.
> 
> 

Applied to powerpc/fixes.

[1/1] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
      https://git.kernel.org/powerpc/c/45a5f7285f835adb3b74c9344c09a7bd2c4fb664

cheers

