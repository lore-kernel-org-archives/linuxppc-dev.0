Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A362606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kedTehSW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZPJJ6Mzkz2xpt;
	Thu, 26 Nov 2026 02:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795621792;
	cv=none; b=VBM/SMSLzDn33MhabARFVEf3HJK+TmfDaf0E1IvjWBBPREvnQoSjGKp4ci41YTPFRe2Jn8t9/mkQulzEqJtMbAgs5oS4bUwbs4wDGg5cex5WWgY1Th0IutJTZ34LpEhkkehBTlJ4zhrZBK1jZNn51T4HXz2nb7c/+6mOruUb7XDUWXiF2wvax9cxDuM/s4QOjxXD8PRD8/IBCtphueQYyJaHLRTmFIIOlqFpqo7BEIgYCBOjbw7sLtm8TpXZFkzSMaYhBtPFZixnAvw2/IZ4r8y7jRUmecJEimDDMjHKPhjesXR0GuxYmHctV9T68NQDu8nnhxhy6ZxUe39j/iMlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795621792; c=relaxed/relaxed;
	bh=HzcAMToS4VrRcrH4TKkO/AAbJxnB0tOnNrCWssv7Zng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lzz0q3+MLPNBMl6s9E0RddSUnMsbq8HK9jkZb7xcLSFOmtNVuXQ3tHaxfiMxSuonFTBjWQtiA83/kZzXenRDFoCn5vXlm1xl59uoH8PXeSq3F1uxmIsTg2SJ+ils1nMb0E81zfLxcfv6JpJ7TexzqMH4QTsXVWzsFdM77xfYGb6twNV4iTuVFbe5L4py84wLzA54LQr97gPBCwPvr2jtu7uzvmlJMqV77XnOTthg3AXT3ScuqrbJz2bEdBj6sh5rCZpmLM6j04Pp18aNXOHuUs1l/1RbRXbIki3tYMzGoPJ9oU0ilI4zcCAMDqJKbs7DNldl9eWJnPIst6t1N81FDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kedTehSW; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kedTehSW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZPJH6d4wz2xGg
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 02:49:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEYxGe1554329;
	Wed, 25 Nov 2026 15:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=HzcAMToS4VrRcrH4TKkO/
	AAbJxnB0tOnNrCWssv7Zng=; b=kedTehSWaS9wKOU2oN3jOd6sgFCYn8mq0Ya0v
	jWScGwU+RV3g/KnFhqqhfFo94S2jFoL945QSD/lR9g2ULZzumTkyWd7B7AhgQjvi
	8Zu6jEwWh1Pw2dtoGWsESxX1UmoY3aggKaJr5VpUkTotdPkuNIdIIovZmtBQ0qpW
	GD//uGCrrUXa7bZkP25lKeNFHWcdVNCNzW+cB1GvN+UC7aQAx/ss9U5ZmNurBkwY
	VnNvQg3pUKajN/P4pGkYNDG2CU6XoNnoxGfoyyzoyyufABK3/v+E8PxtH9oKv6jq
	i6uC7/09dYQDNzISHD9gT7qGKfsZxMbaj+dx0V05cEnBuAcEA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvcs5h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:49:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKLBY810390;
	Wed, 25 Nov 2026 15:49:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5axkvdxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:49:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APFnIJC39780796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 15:49:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C92120043;
	Wed, 25 Nov 2026 15:49:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB81020040;
	Wed, 25 Nov 2026 15:49:16 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 25 Nov 2026 15:49:16 +0000 (GMT)
Date: Wed, 25 Nov 2026 21:19:16 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, chleroy@kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] powerpc/numa: Enable coregroup support for shared
 LPARs
Message-ID: <awcDfKYFXE5PnT8g@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261016110412.1380298-1-srikar@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20261016110412.1380298-1-srikar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b070383 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=cLZJDPjSj-JHP7X_EOMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MiBTYWx0ZWRfX83Ufs+jM9w1y
 ExEJWurIsREy9e+I3sicIZKB3fFgUTgqGAUu+Sbxd1820qdYYTMy/SnL7TYBdOQRcmVx9tKtk/8
 4umru4Y5gUMpXHXl3e6kvMeOaiZIsdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MiBTYWx0ZWRfX+OQp+YK9oJkS
 jo23RAnuR5ZgqemIiHaif1eCaIMUqO7myFgWpOF0RljwtEJMNUHtiTcfzcCb/buzqhZ68GFWmoB
 7NBNO7BjuN9kB8yiHRMqXbhDHvVzYvx6BXgDp2r7OvNkVFIBJAcPvDxnlGHOabfWVnZHQU1fiW8
 gqt1j7ehcQ5VPLSKnoqrR6ukM8/GluB39ifRvObHgBklisjF/RkgmAcaqmeWExVhV2mcZ4pVTKq
 43piMrQK/QhRfJO1N7WLudHjsz1IIW/0uhhjpI/f1JiWShu7vvv5mG+k7SAPV7y4vbFxE+5pU9h
 o2CSdoUJE113HWJ7GAjNV7VVPlK3w+yReiYnqvFwRD1e9sWaCFpV6/eyX51E1gh6J/UVIxoVc5M
 JvFKD6fAp3mfDMJK6vngO9Efy1ils/D5V6gmERM0znGjIHAd3Mj8FPWmLpeHBrkcLaJtm7KtNp9
 gCah7TFYBijIu0+W3Nw==
X-Proofpoint-ORIG-GUID: yHCNmU_841g_QdozevFzWgBgRmpYfOAF
X-Proofpoint-GUID: th5fT9aRIX_xd3J2ZJi6ukSmY4y-mnm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250062
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Srikar Dronamraju <srikar@linux.ibm.com> [2026-10-16 16:34:05]:

> Coregroup topology is currently disabled for shared LPARs even when
> coregroup information is available through the associativity hierarchy.
> 
> The associativity hierarchy differs between shared and dedicated LPARs.
> For dedicated LPARs, a coregroup level is present when the hierarchy
> extends beyond primary_domain_index + 1. For shared LPARs, the hierarchy
> has one fewer level and coregroup information is available when it
> extends beyond primary_domain_index.
> 

Hi Maddy,

Did you get a chance to look into this?

-- 
Thanks and Regards
Srikar Dronamraju

