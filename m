Return-Path: <linuxppc-dev+bounces-20486-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68ECCD3427
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 18:50:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g96yT1Rdnz2xmV;
	Wed, 06 May 2026 04:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778007009;
	cv=none; b=Keu4y0fsR5UMYEqzuj0H2dLPBtInovwW0iw/vbG5uh7e0Mw7vLOHXQHi5KW3OrFfOuEWnC9yeB6GNX+Kt8KpDgCgVAONrWwybtLbM9F0h4EgLL4gQomaAQqsASXb9IcRaqurlj5/rELFR+TvD4gbOycCEwpaT7fJLNyn5L1WVGgRq3dHSUsT3MUWkLJgSdND5VNpgiHKk/plcncI2pUCzu1OSFdipnhEk+4CzJDLe+rSesMUw8IXMTt7ncLRtbaD1ZphxT8K67Qd/klXHy/uC1zIvMXhG3Z/bk9U+PYtgZ8QozV+4jYGiGbG/0AlVxupGV9ZbCRJSKcYVvLG/WbiTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778007009; c=relaxed/relaxed;
	bh=NlKqGtdRLiyM65fJvQfZDwLNBfnBPUDyKAZhcYcU+b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQqXS7ckAXCPeFK7MCpfeo0xXkpuNEGTlWHsBb/6id8IKjnJUcgsWB7eKgSp8tgF2LeOLOFL18RXgDggVUbGaE/NWimyobZYqz39v9i9HMPJ17pfPAAF+bI3eQ4VdutikeDggvDENoroqaFTHO2kIQuGk9TTCazxeLP3FVpg7oZpXg2nQXV0PCoUm/2fAT+BO58d7Kr86et1fVED3Mi2iTbn8Z0lLHGyIquZ2pvUfNfBWmIXTHYjZhrDY8ag+Ixcy9Tuapg0ft7xRK8vm0QMTeXGs1BhGUlkb0ShD65GeGtFb+zv1naEJiWpqpJnZs1GtP6jOg2CSsmWf2yTd7xuVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KFTd7ylc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KFTd7ylc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g96yS0dxzz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 04:50:07 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645CklAV851433
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2026 18:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NlKqGt
	dRLiyM65fJvQfZDwLNBfnBPUDyKAZhcYcU+b0=; b=KFTd7ylcFNuZm6Gyz3ery5
	0mrfAYhVPQq+Vvll1nRFj4Xf9dxpA7xXxd3Z7Yie2WAX1oTKhJTzEmSzD2qQQrNQ
	h9kG2xKHqDm4a4R6hyaM8qv80aunfvvN6iVfrQgj4BFuzKM0oZblahKeD1LoGVjV
	wGRWbXvF5LxFiJETDB2AJOIkwSx3eIdghTjDDhKoKVZQJ29m+ZwjK+HMIxt5KQpZ
	3i2TUNeBLWLl3zc7MI3LcKgWhwq3kAVfg1RPFr1IBGD833MBBr4Zs+WrTHlmYLzD
	hbxnnFN2rF8sK9GmYvacV/6mqerdzky+E7d2erB3sqw4UvI8VsaXw3vJ3SjNhTZA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y4mwn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 18:50:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645IOSR8011777;
	Tue, 5 May 2026 18:50:02 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3h2xsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 18:50:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645Io1K426739354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 18:50:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE1F5805A;
	Tue,  5 May 2026 18:50:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7A7D58054;
	Tue,  5 May 2026 18:49:57 +0000 (GMT)
Received: from [9.39.22.124] (unknown [9.39.22.124])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 18:49:57 +0000 (GMT)
Message-ID: <83e821e1-2a71-4d8e-a40a-59ed7b333e95@linux.ibm.com>
Date: Wed, 6 May 2026 00:19:55 +0530
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
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260504205459.39185-1-gbatra@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE4MSBTYWx0ZWRfX18/GiBa+z0v5
 ieCqaeY7TPLy0nj38Io8aZJ1zaskealoC95IGTG70IeK1+k6zoHGqsuhqpJcWD+TtwSATuJUtHC
 FOyZlzSvp+tlsyi7uhPeYsOTH95lIv45Q2TDOOAy2tAUfgc/U+tY/kay2GrcGyuAlbRkV8KBqvo
 p5RBAHlG7BOfXvwtEB7j1Y0g4imJZePomvGqYX5Ee4ZpcXZV0rthNeWFdqSEAyxTfh/WvILo2Nt
 0TQ/0KWKgK+/Cr+jap7ten8FInrAYWbvEfpcjNgPJBVJkrzFK3cFEcZo7wVHxpQcTEmQ4wuf4Bz
 l6XT1lhNqbSZ5TtE0ST2fGg7ERvOylnw14fZFeICN25vBxje1CDrlyutUqe4AwcL/1oV8+Q555m
 O9XXm0WgQw3et+IAs8R/X0LnFeBchh310VdTeADoAWWnq1rzjmWQzP+uuiI2YE73d6klbp9nurS
 RSC7mx4e5jVw7uMFp0A==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fa3bdb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=yLHwI1a16IwV3BGXK7oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: XtblNhvBz2hGKD5kdOWogDJyPzhsqYKA
X-Proofpoint-ORIG-GUID: Ptpj7HOSwZAm4rbH3fgoWZ_XQq_v6J2V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050181



On 05/05/26 2:24 am, Gaurav Batra wrote:
> @@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   		spin_lock(&dma_win_list_lock);
>   		list_for_each_entry(window, &dma_win_list, list) {
>   			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +				pseries_ddw_max_ram) {
>   				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
>   						arg->nr_pages, window->prop);

I think not only start_pfn, but end_pfn also needs to be within allowed
range, which may require clamping arg->nr_pages if crossing the limits.

>   			}
> @@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   		spin_lock(&dma_win_list_lock);
>   		list_for_each_entry(window, &dma_win_list, list) {
>   			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
> -				ddw_memory_hotplug_max()) {
> +				pseries_ddw_max_ram) {
>   				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
>   						arg->nr_pages, window->prop);
>   			}


