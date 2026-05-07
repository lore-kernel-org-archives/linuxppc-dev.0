Return-Path: <linuxppc-dev+bounces-20552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA13CD342C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 04:44:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gB05p2qw7z2yrD;
	Thu, 07 May 2026 14:44:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778129070;
	cv=none; b=FwXDKSiOLUgy/V9MSt0CB0XjO44tK5ttkNcBqNjWqiCdhwKB/wt8P+Kxr0SZ16y3YABRExXDQAUX1tVw8hzDP1si0DKGUX2Sra9IE5ar89wkKvlNhnRAkz/V+hItsflmcZEpXEN8AtDaUJlIWosVvZOcctM7cw0U1uAl/eYF6Y4lnzOePPao2NdWjYpDViMkYiaKNtrSC6hZWnRwRW2OeGCenfTl5s582fEcAOkVSh0zV0oPP4/ZjMU77U8aVk5vKHPSUNxmlnykJF2ZQymLoxVOOejY221wwU8FxCtKDPXdZyV7LPZtT+v70WORDcLpILRpUB56euV9sgG0yMJhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778129070; c=relaxed/relaxed;
	bh=nDS03zC8Hz99d510KYu2t0mhkHiUUAPeFrsx7s34BDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKBf4D96dPPWqjA8Oaz3oaK4fj1y5BtgfMDYen4XinA8hv8LkxFVoREkI8rrucTGyOgYISoUajfXgiaxZUTiEJf4lQeHeCZ/CDR83Qs2cfpUmTrWSgfJBe9a8ZmpeTzs52WPatSo9wenRmWnbrvYWmW2A1xxDFTyu3OdqRPOXlnTj34L3N78zgDn3yrO33GsQ7BMTSCSX8xt0ZO5pL1iUiUrps1kfuhzHwqRSczmLYxiCcrmiuuB+C2pudBNvJvBs/MtmQCU3gSbAFxK4E1umflg+hIWpEFzOkO3tsUIjCoC571RLraHY3FENrABCr5M9KRRRRmcFj2pFUqo+OD4yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M8OYNUDI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M8OYNUDI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gB05n2Dhbz2xlm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 May 2026 14:44:28 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6471Cj6u2503246
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 May 2026 04:44:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nDS03z
	C8Hz99d510KYu2t0mhkHiUUAPeFrsx7s34BDU=; b=M8OYNUDIgUeQWf2fl9PC81
	iRGHtKdYzi+MsVhH+mz/wOlaBcLKvMgC2cPRdr8/zFMZeeqZbA6Ln6+itO9DUb0x
	NDDA3NkQdngIzmXRHqz/KYH9iaJ+QovOxzYaIO0v6uoIenAMLi9EmGTm2bAa/YUY
	NNvAmKwlgIq4uQgY/Cpbxt8CAuIqRDyWPA1JvUPHKBgSj4s+bykZ8Y0kmqrPY+VY
	wtTN9u61Wgy8o5OeKkQhozVguQmev1H8wuv4ml9JSeTx3A5pqXojEvqQHXSdDRMK
	4THa2SrqpwEt8HiLBHoytSnpj/3wtrNaoUAvRyRVLWf21NgiEaTtMSAO3am7+P2Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1m5x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:44:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6474dOR1029475;
	Thu, 7 May 2026 04:44:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yh78e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 04:44:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6474iOFl18940544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 04:44:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C2158055;
	Thu,  7 May 2026 04:44:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3512D5803F;
	Thu,  7 May 2026 04:44:22 +0000 (GMT)
Received: from [9.123.0.169] (unknown [9.123.0.169])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 04:44:21 +0000 (GMT)
Message-ID: <23cc6749-2ebd-4143-b9ad-b7d4b3af233e@linux.ibm.com>
Date: Thu, 7 May 2026 10:14:20 +0530
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
 <36506ccd-5448-4ed6-a1be-aa89d80c4d43@linux.ibm.com>
 <b03c0960-ee22-4de1-94bf-c1c9eec757af@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <b03c0960-ee22-4de1-94bf-c1c9eec757af@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: i275kK_QZgiYy-1j5x7lbG5kgV_OVQ4k
X-Proofpoint-GUID: sKTgPEmtBFIkJilz24n2MJCKGoyKQBz4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA0MiBTYWx0ZWRfX2xfsdFXVIm+P
 lYXjAeFKt+s5+d9m7ZqKgephHKaUG1bUT6L0Y8pwNiTxWlpIl+szxYtj2UbDCOceqMCy1wCZY/V
 9nJZd+lk6ilDwl5jBj9ezwI+8rf39knbujvy0OhlhqP0W9/5Ds/GE0dn/4oQET0VnEl7o7Sz3KJ
 eTEG63pqxR3cvhCaG0vdFaJJAVn7ywNCMlsEtl2ETxb9XCMhZ+G8xhjn5jOe4DFy7+iixaqcQqn
 602+w/+L4ZaIU1m/vqKS5WBK1BiZa2Hh+mcS+djBykAqcBWrHO0J03tJB/8Epd401ipHXAvuHgz
 Z8DZCGWI42b3A9e1ZvunwH1UzMmLycoWf0vZ2JQcmyz5VlbBsyNqXP+kP1/igfges50wlfT7zE1
 bbsR7HLrga70ydNHi6e1MtuwcRQEVfhj+7cokgq0ZRAPY7UcSV68GLO5IL1u7xqH0t3JR0JdNF0
 MGm1ytGs4zgJcIvNTEQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fc18ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=F_MelqUyvxu5laXEkE8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070042



On 07/05/26 12:57 am, Gaurav Batra wrote:
> 
> On 5/5/26 11:04 PM, Harsh Prateek Bora wrote:
>>
>>
>> On 06/05/26 2:31 am, Gaurav Batra wrote:
>>>
>>> On 5/5/26 1:49 PM, Harsh Prateek Bora wrote:
>>>>
>>>>
>>>> On 05/05/26 2:24 am, Gaurav Batra wrote:
>>>>> @@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct 
>>>>> notifier_block *nb, unsigned long action,
>>>>>           spin_lock(&dma_win_list_lock);
>>>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>>>> -                ddw_memory_hotplug_max()) {
>>>>> +                pseries_ddw_max_ram) {
>>>>>                   ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>>>>>                           arg->nr_pages, window->prop);
>>>>
>>>> I think not only start_pfn, but end_pfn also needs to be within allowed
>>>> range, which may require clamping arg->nr_pages if crossing the limits.
>>> The reason to only check for start_pfn is because the range given 
>>> will either be in the RAM or pmemory. It can never cross the boundary
>>
>> Usually as an API, we do not trust the caller, hence the check for
>> start_pfn. However, if at all we need to go ahead with that assumption,
>> may be document that as a code comment and/or in the commit log also?
> 
> I will document it. I am wondering, if instead of capping it to 
> start+nrpages,
> 
> maybe, return an error. If in the future, we get an error, this needs to be
> 
> investigated.
> 

I am not sure erroring out for crossing RAM/pmem boundary is a right
thing to do here if it can hinder persistent memory onlining (since
there is an existing code comment which says it can get called when
onlining persistent memory as well). In that case, a WARN may be a
better choice.


>>
>>>>
>>>>>               }
>>>>> @@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct 
>>>>> notifier_block *nb, unsigned long action,
>>>>>           spin_lock(&dma_win_list_lock);
>>>>>           list_for_each_entry(window, &dma_win_list, list) {
>>>>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>>>>> -                ddw_memory_hotplug_max()) {
>>>>> +                pseries_ddw_max_ram) {
>>>>>                   ret |= tce_clearrange_multi_pSeriesLP(arg- 
>>>>> >start_pfn,
>>>>>                           arg->nr_pages, window->prop);
>>>>>               }
>>>>
>>


