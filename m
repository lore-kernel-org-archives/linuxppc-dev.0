Return-Path: <linuxppc-dev+bounces-21054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563C4CD343F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:43:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmts0Vz4z3byP;
	Mon, 18 May 2026 15:43:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083012;
	cv=none; b=VoX2a15cB730W0OdP7YSFKIn8tD8i1tRbIhGtpHKAlLcNjDh4cd+jINikQy7Je/TFXf3JUhAuYIZUepbXrmRfUZttPK87H0dZ82YTBe1n1wj4R9YtFNo3cgf2YWcenylse/zqEfapNPIrqn1/WiQTXZZD3MafwlpNWeh86yR91E7kC2Jf9FDGR/OIBiV9WTO8mS42q0GUxEfRHE/r5GNkXQ7a4qWZXCnShEyvbAhDFaNqivg1fet2+AXCksGmTJ6AQOC2ven0+Hh/1HaqLOqW8qngj2kbQ4yrzv0rcIDjbUuqw9Y7qfsQh8VhvhGUv7o0warftY81wqnePoEg7wN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083012; c=relaxed/relaxed;
	bh=4/s1oAzdn7hIqROlJApzf4henZ09VVuxK2JY1OK+dFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrZn1kDME3oKDVzriJBl+aDEafm4qwcBzLOCrdtJMJEW6jyLiu/8HCmaafaRFxew2MeGBoAQptfmW2IEJpJW/qNtq2ySBokr0nmtclVeRXnHM7O2HfANSgfirlrtXCm6IIynd+zk3ZS7/nNO4jiXhoBaDvpp7ouLiU4k5wkZv1aMwwPJvBcVnqIpZdN0e4yPReIMNuidEbFox1ILnW3FHMOx06NxUD+4k/YzDOTe6zOQHGACcB76wjFeweNFxV8y4vLf8kHUlmQYIrDiwEyaFp74m+gFzgKhSaFL7jVv8iX6kFBl1sBPq1ht965Lrj1npdmjO0ZnF6UPbqVfDIUYaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F7WOjmRE; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F7WOjmRE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmtq731Nz3byF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:30 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H7TQ8D3469512;
	Mon, 18 May 2026 05:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4/s1oA
	zdn7hIqROlJApzf4henZ09VVuxK2JY1OK+dFg=; b=F7WOjmREqGPBAG8BA+b6AI
	mkaL1B2FfUQFsBwjlmnRWKmLqqomWwqc4//9eYvNza1kzY8ZbvS+H4jeqztnJB6c
	T7IcWMSWGjnLvy80PYQmj+Uks+IF31dEejN/kvYw1f9uCYPYGIcJBCZYP/at4sKl
	SVCAxtqmyvGc24gfYveDkaxivahHX3fyjOS8encCN9K49GbtaPOVcEc8vNmWmIKC
	LmbwLWuPBxq5Bz+2hkGfd83d/eAhwZLGz3tsW0L3c+OHUKwHWJPxPyDdOuVkUMyZ
	BQ8uMMxfC+ii1SZM7pPHU/rnc3EQWMNj880cGIZIs23vq3yrPj//gRQ7TquGm2tg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mebq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5dCiR026282;
	Mon, 18 May 2026 05:43:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dhc9k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hMp633489350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 361DF20043;
	Mon, 18 May 2026 05:43:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05C1320040;
	Mon, 18 May 2026 05:43:20 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:19 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Athira Rajeev <atrajeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/hv-gpci: fix preempt count leak in sysfs show paths
Date: Mon, 18 May 2026 11:13:18 +0530
Message-ID: <177908291163.287704.2170377712631320437.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
References: <20260508041256.3447113-1-aboorvad@linux.ibm.com>
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
X-Proofpoint-GUID: lMTbLtBUJ9ywwMbxM2-EENOObi9hP7O0
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0aa6ff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=YF_Z9ZsKotpSySSdY_sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lMTbLtBUJ9ywwMbxM2-EENOObi9hP7O0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfXxwBkamDtmc+v
 g7YUWIDSR7vdCPfeoQVs91iMgfnCgTUtQwu9PYG+R7X9jEef5fLPgAxHR9kQTk3Bk4LH3jWRb6S
 dEks9cTYiiBqJ+qS2fMKAT/VtNr/0E2PRQ7oK9RZWm/Xm61Kelcx/6IRerK5dN+uMjMXcfTuvhO
 8u46kYYFhlLnwnXgCUTdemzS6P79/CIn2ucOqU7sxPfqGszmseeeZ3BfzVYPSjcrSUSOQQEeWG6
 wdFIfR194YTEuv4Of2hf2uthsxqFV4CziE73abml5o7XHa/x6Y0lfTkLnBcPrA/kkwvRSQfBjeR
 bbZUifKWfz5W/KftT91FYFaWLnB1mppXm06+PV1x2NJSqG/M3hAS8/d+2/urbxLt5gVkGCDxs33
 0U9Ipbsqox9LIXLMeFRtSAQIQEsmTWgtXtaEJBlWaJR/OBsZQNCDp2KFjQYc5o7AqpTcDH+UVFM
 pUBasHMd1HN3F/qJWuw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Fri, 08 May 2026 09:42:56 +0530, Aboorva Devarajan wrote:
> Four sysfs show() callbacks in hv-gpci take get_cpu_var(hv_gpci_reqb)
> (which calls preempt_disable()) but only call the matching put_cpu_var()
> on the error path under the 'out:' label. Every successful read leaks
> one preempt_disable():
> 
>   processor_bus_topology_show()
>   processor_config_show()
>   affinity_domain_via_virtual_processor_show()
>   affinity_domain_via_domain_show()
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/hv-gpci: fix preempt count leak in sysfs show paths
      https://git.kernel.org/powerpc/c/dbc30a57bd8e026995e9fa8e8c31cffd18542c01

cheers

