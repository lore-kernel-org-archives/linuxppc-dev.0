Return-Path: <linuxppc-dev+bounces-20487-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA36CD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 21:01:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g99tP0c7qz2xqJ;
	Wed, 06 May 2026 07:01:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778014908;
	cv=none; b=AvAnWnLIzlfHl+Wa3vHaW8mz+/mV2VQuilVoQK9/o+ZNIaF6Tmbf8ivNKJLGKSZ1SPrgsOhDx8IOsQ81VDS4CFySbuzJGgl0jkDtYk1vmlNXsvC+K15WjpNRuZfFu1jHltOlG9PAjuCIVzdTY+mV9owiVjGGwTxbghAhxoY0eUBiG355JRLag3ZLb6izFEgK+2A+iTFYkEH9q3PLU3BnzOO/4/y+l+Lv7zlmYepKqRim63OeLBuWt3Sx5M3H6Nr8PwaFo0uwfAf99F/ZcktK8bIn9Q85CzpoaDO3jTRblitbwOmOnb8OSk9dwhjWt47lr9j0D0oqXnHTExae0Jbcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778014908; c=relaxed/relaxed;
	bh=DRvp8arPug1fL8oLmuqmeRJMGxUu9Cb/upMfqV0MGs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iE5+DMASEZgEgtCrLwiH1izUAIIEpgTbGbRb/rTVsFqJwcRJ0ot52KJvVgHBKuBYVnykh950V1HP1luf6gQ2Fb+beO6WfIEbl8xKGh7cHoDuG64l9WRjekxdNtRuCzMdN8zofwFKQpzR6PX7yX46YanOgqEk4EfwOqw0N8KdXAG1SqZ5sfGSRGEZ/YUrfJNMCWEeW8ZXvqUzh/GU5coliX6nUL0aBPL/vvNQGHpRmgRPvRBxxs+TetAzlq4NrD+T4sAORJ1fODM7UqOlqd0aGdTPCpuJpnvCmgLOovIsfffC6uMUpfb2rLj2oq82Q0Lqnlo2oM7jwuWyGVzD2+7WxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j0FCBTUL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j0FCBTUL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g99tM5lGrz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 07:01:46 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645ETBjp1446669
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2026 21:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DRvp8a
	rPug1fL8oLmuqmeRJMGxUu9Cb/upMfqV0MGs4=; b=j0FCBTUL5NdBXN58XWE99h
	TgPULvSqb5BauCfGTyFViOSkxo3093MZRjDMpiNTIfxahwxO0IVnAjqZV8cQVTnn
	1ZZOTqtDQM6Jbi5zWj+wC7wFSXzdidNp8Snp7oskSxcsYMR1joIdH8vMzW3kBXx1
	rWnR6OEAUyfLjvjT08guc7mP9abGudj4u5Gmf36ICDMQXILrfD4EgRUDTzyLukTg
	tNBOuyt0948l0mDxbnetDFwLJFqIAPEsJklkDh3JiKHNbI34Ph47QabyOjouZrBd
	xNJ+UH83H2WervHIPxNTew6gipwBbj5VR8Y34/vZ0MVT4SKfy8Bw0xK8UCryQ6+A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7dsvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 21:01:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645KsVhg011595;
	Tue, 5 May 2026 21:01:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw3hh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 21:01:43 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645L1fNO28574298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 21:01:42 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E12685805E;
	Tue,  5 May 2026 21:01:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F0A5805A;
	Tue,  5 May 2026 21:01:41 +0000 (GMT)
Received: from [9.67.20.151] (unknown [9.67.20.151])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 21:01:41 +0000 (GMT)
Message-ID: <d8448246-f296-44d1-ac95-a80984e78c7e@linux.ibm.com>
Date: Tue, 5 May 2026 16:01:40 -0500
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
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <83e821e1-2a71-4d8e-a40a-59ed7b333e95@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIwMCBTYWx0ZWRfXzncaUbLOkPf4
 pcBcOgM+s1wbmmb42fYLQogk/JpCmyJBCrmP5c1S0R8YvCcE8palsMuMgfOKPxeojQUwx0gp4tb
 d3UGDG5rD3GbP4mYO28S7lG2U63axXPQL/w0auyOy2XvoXU0GL+vbZbx5TW9ijp8drYu+7NHqDw
 3dZFR7g4ZuT94VvKHOvAQBXtIBoi/JDLGrsfgVCh6kvtwy4XP45Ht0xSjb92Ph9y4fa9TaHRqmm
 LnAxRpPeS0hXiOLyeH1ei09/ICg5bkZKVgOxWGw7waITiOEnS1xSk1nubJj3Xmb2v//uiQseFjE
 BLBCjkFVJCDpehl4YNaPsoiDwme7c4Q4YEYo8MHWJ8JHb8sUMfqUnovEqHo0apxLluP4NU5uRxv
 KeB7IjhUxGJR1dKbnMiq8bkUN3saRGOuPYwhgnVzPoUY42lUau+qkdXZ7FBR8bXtT6XmchCCUTw
 fGqrTzMD+S/9rIpVa8g==
X-Proofpoint-GUID: 1V9kjt4gbfHq4Yts5llTVVq9eR2dd8eG
X-Proofpoint-ORIG-GUID: OdAsk8qTu2S0NRVbwqnLQMRONwe0ipXz
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fa5ab8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=XM4mWxJhrdU4haZ0RUUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050200


On 5/5/26 1:49 PM, Harsh Prateek Bora wrote:
>
>
> On 05/05/26 2:24 am, Gaurav Batra wrote:
>> @@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct 
>> notifier_block *nb, unsigned long action,
>>           spin_lock(&dma_win_list_lock);
>>           list_for_each_entry(window, &dma_win_list, list) {
>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -                ddw_memory_hotplug_max()) {
>> +                pseries_ddw_max_ram) {
>>                   ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>>                           arg->nr_pages, window->prop);
>
> I think not only start_pfn, but end_pfn also needs to be within allowed
> range, which may require clamping arg->nr_pages if crossing the limits.
The reason to only check for start_pfn is because the range given will 
either be in the RAM or pmemory. It can never cross the boundary
>
>>               }
>> @@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct 
>> notifier_block *nb, unsigned long action,
>>           spin_lock(&dma_win_list_lock);
>>           list_for_each_entry(window, &dma_win_list, list) {
>>               if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
>> -                ddw_memory_hotplug_max()) {
>> +                pseries_ddw_max_ram) {
>>                   ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>>                           arg->nr_pages, window->prop);
>>               }
>

