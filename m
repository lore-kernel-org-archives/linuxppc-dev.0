Return-Path: <linuxppc-dev+bounces-19480-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA950FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:31:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97z1G8Rz2ypW;
	Wed, 08 Apr 2026 14:29:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622575;
	cv=none; b=eZEutDVkos8jvF6aTflTpQEYjjwiKPrcI1nodt1l9d8pDYErMFU57qiDj81TwSIDJh/NXo5P6bQ5wkSnJGEJ1L+9Kw98zdZ8MOPlUj/HugZVKdD+jZiXnzPXHqp21M93sj92WjlnLmxnsngIGJhUReteQevqzQVjVeDYJF4QqmSBmvWDR9fY4/WwkUkJEKz/yApXJyzsHqRQb+131iyZmPrn0d1niwOkgJfW0S6zhT2zC+0rjG2AScmDVRIeHOmyY+hkEa7z39v/cDGHR7ctJMudGYQ5jMiWH71BOyhc3y9aZOSWIOl21ZuhVgww/7NNTXUbc3ZE3IQFlor/hzE9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622575; c=relaxed/relaxed;
	bh=bEPAFQQ/DmsauVFue/UQmeqyT8bctkqC8bnaU2y5qVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjiZ3CadRzmfdzDDwfDMsjACPactIms9kGcNRRhvED5VYhV4Q8EK9lw3j7T0+ciYZYPPRPvL3/iZRC8HTxUxfj2OTuHvItK1+CI0Cx0SBRBDFnSN4Ich14sGDkaWWI6hvpTjl9AV1G4FaeQUjlcz9OGBq9vJXvBpsiYOfv/FrB9GlZXGItmaDmDyDniyOlM7A26G8xjB6DKzNrUJ4zxNmsEmQQ6HqrbNTmfDk4km2K4LPU7os11xYfmm91ukO0mtbQeRCW4xBX2aKe2rCgsbUu0bYk7lwm1eZ4g475uzv74jkCDgSfZMwcMIJ3vTRULYakbGygqHLTbhQ6kDrXmwEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTQ/GPg5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cTQ/GPg5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97y46fHz3bjb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:34 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637F02DL2301635;
	Wed, 8 Apr 2026 04:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bEPAFQ
	Q/DmsauVFue/UQmeqyT8bctkqC8bnaU2y5qVE=; b=cTQ/GPg5gNcq8x71vL4liQ
	UNmSgMMWn8e2UbuQNi34Zk4ytc3f2B74O22+eMzCt+fdipXaJ6QjBOXASq/aP+c8
	xoNKeruQRVcyVZsG9aqYLTMjWlZXXIANCw3PiM7O0lQ0t/itTg891zMi5Sik9Ive
	u31Yqe5VO5GL5FNfxtoDmurZqWmjtpyijQ6xfgi3RiEK5V8oxT5gR3Wt7M3YGrAg
	ajvTxcerokRdPCm1UhvO1xB7a53oT6kpTM62eIvZxH+zIbvbNu77Y20Ct9o/4qzb
	TJQW4LJn0dTQv0H0c6K5r8OlaiJXY1u9rRwOytL6dZishU3Hm8gx6hBAjO9jo7yQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe796-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63800PoO013855;
	Wed, 8 Apr 2026 04:29:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf46084-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384TJov29360706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E56120043;
	Wed,  8 Apr 2026 04:29:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF0720040;
	Wed,  8 Apr 2026 04:29:16 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:16 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Nam Cao <namcao@linutronix.de>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] powerpc/xive: rework xive_find_target_in_mask()
Date: Wed,  8 Apr 2026 09:59:15 +0530
Message-ID: <177562236420.1381144.8638668034024786193.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319033647.881246-1-ynorov@nvidia.com>
References: <20260319033647.881246-1-ynorov@nvidia.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXyHpBMfH8s/zn
 niCMxjDtlBHqWUSMsdXBDofukL3GZKUpzwr8091qMP5xf2qdItHsuGyBaIj/EAaFKehIcQNqXR6
 V5cxtKCxtU4AI17OtmT0KfrcHCu2wGscxP8d2ky1kAzidmj1xvOAI+4LWtMY3+HeLZdM1nOVFvP
 4E+wvDd17J9ZzvISE40i2XuJu3478Ko6h/0E73n39wHjJPa3SCUBORx9ZdWr8xLDfWGZKl+qFD3
 oTrYIajYO+LIp1lK4idSBEsu60gCH/60MNSsm3rfiHqNtNwb2ucZsO5ki9YWh6qvqCCLcRRmLKU
 ZyoKlZeM+SbFS39QdNC1QA/tv+EmBpIvUz53kZTaDtGqtfuS2AAyVOHoXaEG1JYSFGDKTj5AN35
 Vkj4vwmMGpCchlBiFwODMaTNjOOc1zwXSqC2mVVbiUUzALmDcbuk97PEs5V6trgvJDAOLOEgO2a
 RLKT8LREKtzsyPaLXTg==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d9a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=NQQim6ZJmpafYmGHHx4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 75b_DdTh1n7xGOPUtVcZXZ6HE5HkXZxq
X-Proofpoint-GUID: Xhjlo3qEtJt7Kr0GCTfDkq9Wr6kWbZJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 18 Mar 2026 23:36:44 -0400, Yury Norov wrote:
> Simplify the function by switching to using a modern cpumask API.
> 
> Yury Norov (2):
>   Revert "powerpc/xive: Fix the size of the cpumask used in
>     xive_find_target_in_mask()"
>   powerpc/xive: rework xive_find_target_in_mask()
> 
> [...]

Applied to powerpc/next.

[1/2] Revert "powerpc/xive: Fix the size of the cpumask used in xive_find_target_in_mask()"
      https://git.kernel.org/powerpc/c/cad2a72c29e037f1ade0079f7e4b925508680e20
[2/2] powerpc/xive: rework xive_find_target_in_mask()
      https://git.kernel.org/powerpc/c/ce7c43b0871989b4c665cceb9720d79b933c1818

cheers

