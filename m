Return-Path: <linuxppc-dev+bounces-23938-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B0EC43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 14:32:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwy9H1zhbz3c9w;
	Fri, 10 Jul 2026 00:32:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783607555;
	cv=none; b=hvlFv9xLXU5WPmdPKdsjWf1fM0GEO2fpF8t9kJMKfi/G8AcNuYCZsKSuEDhw8ow3DoowNpWEYyCZyNTuWsRS9BX/NfToWXBde86/JR4mlRBUeiNlzm0PdLtMbdrqN2+m0eKmveQ0zfsBKayl8yHWgQGXX8ywHBmdmP7OhecY30SefrEUij7buP49ZA0RQSjNaiRUB6WrsbEDgrIfksZ8g3LaitdjGMWytPWlEeuD1yaDR6zukJbZK1FLV1dDZWe/JYJ/L+Vw5SnjfRWJF2X1tvot896HqrlKOize8p1cfl1oKSFLq68S3rx4cSFL7OSB3hnQ4smDiTfL0KT+P/0tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783607555; c=relaxed/relaxed;
	bh=QaGT4Vsnd4lVWljMebmRG/rgoFMCDf37fAxRxmQOPRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/s2pKwLbwsP+ZtV5gU5SaKWTbc3PwaiZ53KpThdYJA/3m0hdRb4CXEq6oQ/sQfVkjteZwA0hqp+3FF3KhLTVixFIP6qPObHAa9z5S0I//NUaobLsP719GmPnTSoLZLlYWre+HK35CGZl3UU6D8L44vxabvl6BIkxAz+A28J2OtlatvciBurf8P40SmieJjQXGaUMSYP22e5Xg8kT2UR4zzMq4DqjtxIip/PO0LJtgRrzEtffYHbhU4zNkXKixesIDjykO1ys9+Ax5Z9D3/X57ZfE4t4PXda5GHbBLB88fy2PE4ttHP5VRnyVZX0orh1DHsyt6Z7rLjz4Yd/k0mL9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yt0xeD6w; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yt0xeD6w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwy9G0q2dz3c9k
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2026 00:32:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EINkd1769906;
	Thu, 9 Jul 2026 14:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QaGT4V
	snd4lVWljMebmRG/rgoFMCDf37fAxRxmQOPRU=; b=Yt0xeD6w34cgPpnip371LK
	eFwPQ6TYmdSJ6mKDgwxmWHUFyiV5uHlgvBjNkeutqednWptgrbCBqLZDeu565yAN
	NxIiIxBImFQ3qx6dYmnoZGO9h+W7MPRbHZBG5MXcPAdL7Dg5cZuD4VH9AhWY49Rf
	olx8kTRaAWDpDgVKjNxgau0bYqBGTOlZwmDxyFIKjCxhJAA/hfZmQj4HnMRN3pPC
	f7VDq9tpOaI2GbluIqSL64eqGmycbNr2hbnkMM8LUlCRqfuHg3LtofUY5GukpO+3
	+LXqfpkdyQw5bb6a3BoWgQGt6wq2u+OvorJ+X+xL3uxQPlIWhTktTfhhdSBXx93w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2grs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 14:32:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Dnj1F030588;
	Thu, 9 Jul 2026 14:32:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkdh86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 14:32:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669EWQGd4981662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 14:32:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E7625805D;
	Thu,  9 Jul 2026 14:32:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6BB558054;
	Thu,  9 Jul 2026 14:32:20 +0000 (GMT)
Received: from [9.39.26.55] (unknown [9.39.26.55])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 14:32:20 +0000 (GMT)
Message-ID: <8c9b739c-8a9b-4e9a-8e43-7b1a6e1aa330@linux.ibm.com>
Date: Thu, 9 Jul 2026 20:02:18 +0530
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
Subject: Re: [kvm-unit-tests PATCH 4/6] powerpc: gitlab CI update
Content-Language: en-GB
To: Thomas Huth <thuth@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>
Cc: npiggin@gmail.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, andrew.jones@linux.dev, sbhat@linux.ibm.com,
        Misbah Anjum N <misanjum@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260708105122.1177210-1-rathc@linux.ibm.com>
 <20260708105122.1177210-5-rathc@linux.ibm.com>
 <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <bd10e435-de06-4b67-962c-b520a43a8280@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4fb0fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=dajVmKz5DrVhy7NBYq0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfXy3fjAhyJzi9q
 X/QpsgRUlDtJeOtML7DAvlpBbJOGKyjLaaKHqZhnmr+LaIhsHcnjlySArtXh+x8vJLJ0nVdn5zC
 cejXQcLe2uWi7Z9ZuZy4W24GnNeFJw5uEmyQrALakVHMdPOgFuhJ2pYADBPuqsFXljtMEgmBl+A
 xE0GDgtOk7wkDxCmkv2HNdk2+xSuJIyL1tbCWymEWh9wp55L3n5d3dOGvlodUykbqIU+nOXbe7z
 gULes6BVqjXLXEFs5QcO82LzuUtzGbJ62cTgQ/Be3fa88U9R908f72tCsD1kdoR3pR1Sw2b+QEG
 GQd64EjQ15EE1vym/kkz8E1t9ofNuqU+3i/PjStW1UEYBPQpKLjujwugCfLRTKdIWbpJksmskOL
 hE43QXI38rIw8i2ztXR22ep1FBKaVnXjjSzXtmhzYcZPItRyP0bS01fzjBBhx6CtI/yNkzScOl8
 2yjL2WFhatkRN8tWc0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0MSBTYWx0ZWRfX2EKkd4WRUXCv
 HUyNqMNrgX7BJhODGNu2G4lSM2JId1jhbGJkdM3UrhBo4rLGsjW7gU/D5RDwC356GeVm511u7AD
 OqlDY+16Fe+QHrqRMmMXXBh/bCmVdJs=
X-Proofpoint-GUID: l7VhBmTT8Zckq51zWJ9EKlGUpatI2fbA
X-Proofpoint-ORIG-GUID: 23odIHOL39iWxcbrWoa0v4ITVYe9hX00
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090141

+ folks who might be interested.

Hi Thomas,

On 09/07/26 12:16 pm, Thomas Huth wrote:
>> +++ b/powerpc/unittests.cfg
>> @@ -24,6 +24,14 @@ file = selftest-migration.elf
>>   machine = pseries
>>   groups = selftest migration
>> +# make a kvm-only version for CI for now
>> +# TCG accel support with Qemu and distro release used in gitlab CI 
>> needs to checked.
>> +[selftest-migration-ci]
>> +file = selftest-migration.elf
>> +machine = pseries
>> +groups = nodefault selftest migration
>> +accel = kvm
> 
> This does not make sense (or I don't understand it) - gitlab-CI 
> currently only runs with TCG for the ppc64 jobs, so adding a separate 
> test for this with "accel = kvm" just adds a job there that will always 
> be skipped. What should this be good for?

I understand it may get skipped in gitlab CI for kvm-unit-tests,
but it might be helpful to those who can run it on their Power HW.
If the job can safely skip on non-ppc HW, I hope it's fine?
We would like to get it integrated in IBM's internal CI with Power HW.

Chinmay,
Could you please share logs of running these tests with kvm accel on 
Power HW? Thanks!

regards,
Harsh

