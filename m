Return-Path: <linuxppc-dev+bounces-20497-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22DFCD3424
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 04:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9MGr5kCJz2xdh;
	Wed, 06 May 2026 14:05:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778040308;
	cv=none; b=Jx548fPJq7KWWr1x7juocau9Z3H7YtlnUoObvfwn9To2avf7hhPsUsMubZ2ArgRpHz2KOz8vOXbvSWxI9FPLWpEd4IAPL95amWECl+EaE2yJIM2dkeKCqjYrayiuhRSipf0tbTs14yfXkpncNg96owth7V0hELZjgez7XuOmuKfCxV1gYxVoklVVsUPgRoiEzLhAy47dXoWfOM8f0Zq5t1JP5JPRmeQ+coZFKztxDK+H59UukJbIIatSCeJo5h1PRCSizx0yoJkmlN3ZDOuIT4NhIl9urrgzqTkZ7klOisU4uYHd14fc4fXq18fFrGyo+s3N0dp93cpKkPo4YDWARA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778040308; c=relaxed/relaxed;
	bh=nI2W8B4GzJgZBNvpH05Kofaqri/uAJ1cyfofJbK/S9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ae3pQ/l7DUgk4BIkb9GSMqwlXSHb0oMaguzojqfBz4Z9Zc7i9YAAPuROCCs3x1SzP9980TiWMtuqhsMzaF1pihsSQNYLpSUCtmPX71UTc7ibzAT7xx3Dc/T7lcIWTIzfsz5AXgl3bKcIQrLwd/pnAyQ2ktYds7Swv7ytTtcSOBDXcZ5Gw3AOeqHk2wvxjQXY4Kvi/9wUrY6iLCMtnWaBHBedRc77zbi+SbrPXds285AeAKhPnavOVyUD5Z422GG7tFGS7kbQ59F6Td2CPVVgOTnK5FmWVBjI/7lEKrv8NUCdNu2KEI6e8l0b+h1E/+AfRX14tnFw76UmP11bt2O/yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jl0DZ4ZK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jl0DZ4ZK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9MGq4Nzsz2xFl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 14:05:06 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645E0EWA2021694
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2026 04:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nI2W8B
	4GzJgZBNvpH05Kofaqri/uAJ1cyfofJbK/S9Y=; b=jl0DZ4ZKgW3e1azE/khBJs
	b3XdVJM2bDv2h313qgcyz6SruoA9JZKnWFOS9h38lyPBXO1lTzE8GWbwL32KzAd5
	E8Ldppr6vxVa9HKRdTLbqsFsrOiUgQKsMdpILW4sVY38tx+QvqrpI3AZVIcVwMgr
	Qy6WPxYXjk+0YWyAt0Bx27ZkrLKkPTMSjYQ3mGcWsEhVxSe4jt6Y4ajPvigxcy/q
	vMcquYJn34g0Oswta75zTjCYD9fAQO+9kyJlusCR9w6GSypg8oDrdwMEKU5g+V+l
	tZazV8MiDxvNMl5nD1D36+EzMLU2t4lHC/xeHylRgdcV0MWd3xvOD/4XXWKvLPSw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7ewek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:05:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6463scJX018895;
	Wed, 6 May 2026 04:05:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukqcsa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 04:05:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646450Uv13173360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 04:05:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F75858051;
	Wed,  6 May 2026 04:05:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B00315805A;
	Wed,  6 May 2026 04:04:55 +0000 (GMT)
Received: from [9.124.209.5] (unknown [9.124.209.5])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 04:04:55 +0000 (GMT)
Message-ID: <36506ccd-5448-4ed6-a1be-aa89d80c4d43@linux.ibm.com>
Date: Wed, 6 May 2026 09:34:53 +0530
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
Subject: Re: [PATCH] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM
 is pre-mapped
Content-Language: en-GB
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        donettom@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20260504205459.39185-1-gbatra@linux.ibm.com>
 <83e821e1-2a71-4d8e-a40a-59ed7b333e95@linux.ibm.com>
 <d8448246-f296-44d1-ac95-a80984e78c7e@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <d8448246-f296-44d1-ac95-a80984e78c7e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfX8RrXt4MvXbod
 Ujk1QFHMR/SgQpKz4vkHD9q6tYpWNWMtWQCaY+OJVel2z7RVEMfeRMi9q3j0ExYe2psrDQv4eZ5
 pCcnX0Q2p70QM4EaYmUAP/E2Q7TPO4+xmN0dcJLnkHQ/u5X4g/+V89jQMwFgI5/gBERx//9WzX7
 VlVP+KqddLg0qtdU8Fm7/M6hAJ8ScbrzHiNz0qA7hmcam4TyAiWYbtKjIsdVcNN2Q0WwlOBHTMh
 LaxEeD+WfTWW7eCS4zkKmUUCXO4++rC9EvRvbFZtw4xX3Zp5NuiDaB3ffnx4YNIoOQr6k2fpmWc
 MAYf63IsDDGekS0/lu0JvasdtU1189UuIg4zWxDdS/mIRfqCaO0ASxxzWqBlVdlZQn29XTRjya6
 SKFGXB4ifzaTha7jtY/U/ZOXXs4SI/TjT7QQPLOSxLKWA3mGxYqtOIAVdM/PAWDi82nxtmH6i3E
 KeF0V1v2N2zR0nGHkCA==
X-Proofpoint-GUID: XmfFKO_oAvaJOBzx8ehHy81OSR7gqTTl
X-Proofpoint-ORIG-GUID: 7PzKTF7I8B135SPJnaJw0Pn84H1CYkHC
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fabdef cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=m7yw0iWS10_1d7RJ39cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032



On 06/05/26 2:31 am, Gaurav Batra wrote:
> 
> On 5/5/26 1:49 PM, Harsh Prateek Bora wrote:
>>
>>
>> On 05/05/26 2:24 am, Gaurav Batra wrote:
>>> @@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct 
>>> notifier_block *nb, unsigned long action,
>>>           spin_lock(&dma_win_list_lock);
>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>> -                ddw_memory_hotplug_max()) {
>>> +                pseries_ddw_max_ram) {
>>>                   ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>>>                           arg->nr_pages, window->prop);
>>
>> I think not only start_pfn, but end_pfn also needs to be within allowed
>> range, which may require clamping arg->nr_pages if crossing the limits.
> The reason to only check for start_pfn is because the range given will 
> either be in the RAM or pmemory. It can never cross the boundary

Usually as an API, we do not trust the caller, hence the check for
start_pfn. However, if at all we need to go ahead with that assumption,
may be document that as a code comment and/or in the commit log also?

>>
>>>               }
>>> @@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct 
>>> notifier_block *nb, unsigned long action,
>>>           spin_lock(&dma_win_list_lock);
>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>> -                ddw_memory_hotplug_max()) {
>>> +                pseries_ddw_max_ram) {
>>>                   ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>>>                           arg->nr_pages, window->prop);
>>>               }
>>


