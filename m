Return-Path: <linuxppc-dev+bounces-20531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9115ECD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 19:27:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9llH70kPz2xdL;
	Thu, 07 May 2026 05:27:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778095659;
	cv=none; b=T0Uvzo56qPmHhOAeANx3v4nxQafFFYPclCCpxMT/FdkLDKsq7ZoiUdFU3ZpFk1zaw3ieqdwEstOkfPYvSwtBqHqI6ed3LXvmhXsuMoEYLZiE1OWeIYQiCpCW4vT5h3kp9/5rZu2DMEfKKJIP287MUZAM9fjXutpnMDA1heAWVVyfK5DAzhmJIzYek0GEhXF7mqvuNqFkO3+9V3bsLw5UPcph8Cq1LdLUiR8Y11be5JPPlpA4x4AFbdFPNi+1u/kR7HGcQVo/2qggUFXz38ZhrT59qxFmNp23svnw7/tuSeRXsGO2wyiSlfSTs6tgx4lJPwYB2dRt3zCwHBZZtjqVTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778095659; c=relaxed/relaxed;
	bh=dfYpWS0dkcXpa0dvxNFeP97aeBauBWamtytesFKqmk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCmCetRc94qtlTdpfKGMOPdqBfEMg/BYKJkpTkuJoln29VA6c+mtLApqZEY6RnaWTsZmAuTo0LEaHNdmF4I0U6WgIIonk5jEShtSJSyZ8CNPLQU0hUIteDVPQeVyBbueJuSMNtG34xoc9hyBX7lELQLEFC2hQs/530pLMPfR6FYoZOV/K9QdrUpROtYjkuJ+SK7bwlcHZ8q2y55sOU5pv8KZACH041wUr+Ch6ofbugpycOsTO3Rj4j0aqUiYth85vTg9Wcg0/hfKiDdYK2T4BhhV6UwtqBXAtMtINVLnlRG8kV9dECgmH583+zljbCsFdaztjaP11lZsdQCGnDeoFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R4clpVH7; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R4clpVH7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9llH1YsZz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 05:27:38 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646IYdCk1753528
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 May 2026 19:27:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dfYpWS
	0dkcXpa0dvxNFeP97aeBauBWamtytesFKqmk4=; b=R4clpVH7C65IrstMehUc0k
	gOS7Edxn5b8GVJ5sJ24w/HcfRhxcTRb5n8i8ouE8PpTkhf2JvTRBYrc+PjILExmq
	x/22sPGz+kzaCHzGkO0KoPSjCWn/ZwvnprpCSWqGDGIDeAnAcybF5+hGSRlMqdI2
	6l13IzeMjii62EvWT8pNqLrWCyrc9/gOrJICJzcgdTWSSmg1V07+K5BBQDudSW0j
	vh1k9kSe5Sxb9TMPrfnU4Hc5DEWNIsTu+gz2iT/paBTDLSjtqj0z3STtrnmoiY7q
	Bem6u8QRNQQZBUg4hHhX1w271f1IpDChBk6hRqGd4BBFXsxp8GAkcWXD/W8MnXiw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7jhm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 19:27:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646JOSfI025341;
	Wed, 6 May 2026 19:27:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgfhrw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 19:27:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646JRYae29229716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 19:27:34 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3EBC58055;
	Wed,  6 May 2026 19:27:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16C7C58043;
	Wed,  6 May 2026 19:27:34 +0000 (GMT)
Received: from [9.67.175.186] (unknown [9.67.175.186])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 19:27:33 +0000 (GMT)
Message-ID: <b03c0960-ee22-4de1-94bf-c1c9eec757af@linux.ibm.com>
Date: Wed, 6 May 2026 14:27:33 -0500
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
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        donettom@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20260504205459.39185-1-gbatra@linux.ibm.com>
 <83e821e1-2a71-4d8e-a40a-59ed7b333e95@linux.ibm.com>
 <d8448246-f296-44d1-ac95-a80984e78c7e@linux.ibm.com>
 <36506ccd-5448-4ed6-a1be-aa89d80c4d43@linux.ibm.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <36506ccd-5448-4ed6-a1be-aa89d80c4d43@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfX5GwHuDCGCZ7h
 tOf+BLZbi00DNUilz14x0Ch+chm1NmYX2pFyCku3RwrIgQLoJRsT/c+t/Jm/5inmxX+XozH1qWb
 Ag7VJM5kjIw6IXnI2b0iN+12vJeslntuCelgzllY5K6ZnPaQcMucmxg2mE0OI+PwMgmlmzt1o8Y
 2FIpwoH26bfz2K4qt3JQla7EHDfdenQrGdkFojLItakkJrVYJuNc3O5NvKnI38vQnZSOFtcchHy
 e/DX+N27qdFWd+CDg6oD949CTo8UALis3e3D64QV2rnj2l6rwK4R+ST2ehQxCmzEvggXSAGFreW
 otrvEnEh7Yv6DxHqxYwmSkJPLZ9zwBdmcvUL7QF0R6h+nv7rpt6XoIYczxxwq1hXU3jOIi0+aqS
 rPfv0znX4bxWCw6ENgpIU8qTBpVd/crZbzJBwyTJzQ/8DcJfPhwA5uhgEj6UGlO1G4FblACwJFu
 hxShTuGc3CKTsXNTAFQ==
X-Proofpoint-GUID: svwMJgHo9Mc2arHtotHESGs-ua6IfpMq
X-Proofpoint-ORIG-GUID: OvVXdHMqcUNCvbmhEuucfO_JjWW_ot1H
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fb9628 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IODWg27a4XDs8XJ6STcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060187


On 5/5/26 11:04 PM, Harsh Prateek Bora wrote:
>
>
> On 06/05/26 2:31 am, Gaurav Batra wrote:
>>
>> On 5/5/26 1:49 PM, Harsh Prateek Bora wrote:
>>>
>>>
>>> On 05/05/26 2:24 am, Gaurav Batra wrote:
>>>> @@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct 
>>>> notifier_block *nb, unsigned long action,
>>>>           spin_lock(&dma_win_list_lock);
>>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>>> -                ddw_memory_hotplug_max()) {
>>>> +                pseries_ddw_max_ram) {
>>>>                   ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>>>>                           arg->nr_pages, window->prop);
>>>
>>> I think not only start_pfn, but end_pfn also needs to be within allowed
>>> range, which may require clamping arg->nr_pages if crossing the limits.
>> The reason to only check for start_pfn is because the range given 
>> will either be in the RAM or pmemory. It can never cross the boundary
>
> Usually as an API, we do not trust the caller, hence the check for
> start_pfn. However, if at all we need to go ahead with that assumption,
> may be document that as a code comment and/or in the commit log also?

I will document it. I am wondering, if instead of capping it to 
start+nrpages,

maybe, return an error. If in the future, we get an error, this needs to be

investigated.

>
>>>
>>>>               }
>>>> @@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct 
>>>> notifier_block *nb, unsigned long action,
>>>>           spin_lock(&dma_win_list_lock);
>>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>>> -                ddw_memory_hotplug_max()) {
>>>> +                pseries_ddw_max_ram) {
>>>>                   ret |= 
>>>> tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>>>>                           arg->nr_pages, window->prop);
>>>>               }
>>>
>

