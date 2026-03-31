Return-Path: <linuxppc-dev+bounces-19057-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80994FF60ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:47:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flMDr6bfJz2ybQ;
	Tue, 31 Mar 2026 19:47:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774946828;
	cv=none; b=ihpluBaToYgVeiZygdeM6Ojx/V4f3Gpw4RHGyUq2OJE46Z3kwy+cSpyMJxXwZb26fOhtE8eRoF9SH0UP5j8/qgYjR/e/bv1pcf41hYcj3RGa3YEhkBcDAjWMigZm6YUNTLmQ5MIQrvbkikqLrEjyXxePE1l2pfswGrlyep62bwdAGf0Px0bgyAniwGi5QMQbPnbicwrcfK5KrvyBVy0hRMxd5Dj4/9ptVEFr4gpEpWMfy9SjFXKmYtni1NO1tTjLaE8uHsQgjfzMtwyZImRaxLiXNo23EIbAx5O9GAIZYzuaUz0fQCPpnrv3ajZ/cW/RI/vhjJhE48f+WiShPDsSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774946828; c=relaxed/relaxed;
	bh=obEuIzQqbn6GkwWr4hGc00g5eh9d9NZKowE8CH0TjBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HmYfSLdg4p0cTBU+uyC5cQeggN5Ymu7TqSCnmYHuNgVYiLk0r214PSJgtZXgiToeyjSXP1KRXvWon7CzV1KhO6YMJR5/QJUunK/vjid8bMxrc23kwmC0LSuU0bh2wtPuzzbyQjtYHpY69SNYJCWfyxjTUoqrMB30dzuxL1hDzwQB5MTYP/S41LOxHJ42GBo5bS6dswnRsE1tBKwZedZI2tSFKcZ/S8djjcqO8KfLUL+VNd3b7aVZCE2Nub4Ta1vWGyYlkkySvU/cjDnu6tC3Dvl+eYQRFq4P2EcREUHGDEEcU3jNOSJ0WPku8sbdfOaBrihNtP3SY0omuQzVRBD7Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CPErm2nB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CPErm2nB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flMDr0xJ6z2xnZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:47:07 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UG8Lrd446369;
	Tue, 31 Mar 2026 08:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=obEuIz
	Qqbn6GkwWr4hGc00g5eh9d9NZKowE8CH0TjBM=; b=CPErm2nBpo58HfeIVsUZ30
	4s2t64nQ1y/O/j1ncTfTJIcgKY/fij6xa/pcR4utZ+L31JdrqWWqav4Co6C42Xh+
	PP9mRsHt51BzJWUleQJZZLIxaEG2TZoGYjplar2OUQeNTAGxgsgUhqsxsr+UJYph
	F0XTewEHJYeJTjK/pjo8fecniXzPqiVxybqZeq+PC9M4ffwaR1nqJ5vyMarebsHC
	R4tFrLpSX/CQJzUXQHFFMcfXDJBtbU0trhQNkS1bs/tdh3z/zvkp1XJ/jn8y2c2f
	r74TDE4C9411AJvONyDEMcd4SMyVuKKk6XWeHLFeNDViKZHdEJ+gXL81kx/I+4vw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms1w3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:47:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V7JrSU013936;
	Tue, 31 Mar 2026 08:47:04 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkg5pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 08:47:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V8l4ru29164274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:47:04 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B89A5813F;
	Tue, 31 Mar 2026 08:47:04 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5675813E;
	Tue, 31 Mar 2026 08:47:02 +0000 (GMT)
Received: from [9.43.68.136] (unknown [9.43.68.136])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 08:47:01 +0000 (GMT)
Message-ID: <011c7f14-89cc-40ab-8a1c-6892e2b347b0@linux.ibm.com>
Date: Tue, 31 Mar 2026 14:17:00 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Add entry for Andrew Donnellan
To: Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Andrew Donnellan <ajd@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20251208-mailmap-v1-1-524d5b9d175b@linux.ibm.com>
 <319bcdb0-1a26-48af-8a6b-3392facb6b62@donnellan.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <319bcdb0-1a26-48af-8a6b-3392facb6b62@donnellan.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cb8a09 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Q3gNrNfZ4n4HIx3YXgAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA3OCBTYWx0ZWRfXy3fU891hHpNy
 3L3M3XXQmuMu0xYxfoLYlHy0D54FokSLPISEPnLaery7q2GLDSMscsktwstT8Wqgbhs8nyw//hM
 v1SGERCsIzFjlG6N/4bm1yZ7ZuOZxh1wM5cYDpctCn8u6zKqroBMRYD1qkVJpjKbrgIY06QMHwf
 muXMZqLqsYU2bv836qLltBO8pX3U5AekjqOUP3H2BQCvKI5DFgW/9ETNnuEKrIiC3erVRRHd4cY
 1sGCPvPG9ogQb3YFYea+ZpzRp46rw8/BOIaWaiDagCcEt8p38dPBmmpCyeKyaviHnX4SHyQ92zf
 hGEV46W/c+eFZ30Mbzbcm7S8FuPWQvA1NgQseAPZRkX2T/bSdWP4vKRv6EFnOoLWy7fBNttUJZk
 yaN1PkoTrKd/GJ/pmF0SA8BYoux+QETfQ/p6KS5Zt2ia8kfu+dIYEm0YKzYw0rB+ggL7hAdguKc
 HQCHdbPwNMufHkSCfww==
X-Proofpoint-GUID: Cf8qgG_hiPfPYh5X91EypeCijjQ8audV
X-Proofpoint-ORIG-GUID: Cf8qgG_hiPfPYh5X91EypeCijjQ8audV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310078


On 3/31/26 2:08 PM, Andrew Donnellan wrote:
> On 12/8/25 16:13, Andrew Donnellan wrote:
>> I'm leaving IBM in January 2026. Add mailmap aliases to switch to 
>> using my
>> personal email for now.
>>
>> (I will send a patch to update MAINTAINERS soon, hopefully after I 
>> can get
>> someone to replace me.)
>>
>> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
>
> Maddy, could this be merged via powerpc? 

yep will do.

Thanks
Maddy


> Thanks,
> Andrew

