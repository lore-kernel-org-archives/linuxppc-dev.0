Return-Path: <linuxppc-dev+bounces-20339-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E45CD13D3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 06:19:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5kXM1KQWz2xjk;
	Thu, 30 Apr 2026 16:19:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777529955;
	cv=none; b=AP2oKFkAOXRVjgrfOX/gHOeEHMgNgQlcFQBN4aW7ZDnAU7tIsOmGjLRPwoilPv5kPepI9Zt+3I43HZzIgAaGXgz749LkYh6cZfEhdzgEeUUSSu8R3wJMNs2fDesEYLVkYMTELUDSfqoYdZCWzaJxOfcTFLifedpG8bIRm5IAQd7U/yPnJqfvuBs4FCiY39RqKkeW52NzjfuXFNYVMvDFL3Y+lvplzrDQPPrEv4WkGIKtCImFxl+XMxxLErtN16flHaD61wuZDER3GtS5C8ZrctKDUDHZvvlVMlOEZSpk5x/wvXyc7WjV7TmfijAPK9qPf4EHkqYAVtavjms3BmEI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777529955; c=relaxed/relaxed;
	bh=qE9jKUDAkBGLSmSl/P6KnKUnAIeAM1blx2/rPLBkFl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGK1cq/Lqb+reeBoSyXtdhiHP0JDabBkuic0jXKghblP/YhhLZppY5ZE7JYwC58ENxf2HO90Hdh6tWCh49FNTDdgawHvnct6j9rYXmyhV7Wd6EjJYoT7hkct1uk9gRxvAL2eTHlGQe4VvfnI0it9Vk8in9pXGNz6AqsNFEGjagYsVYtH2o8R+oMSPMC5L1u8wqgMEVveZ3xS1mZZKN7BP+o2Vju2qFZlYVEPELluwblrDq+ASacf4o64b3MMl7exGPj17mZWpp6u6auW/OUlhuOTGmUj7sIMXDi12AKtFF8ZLHTiHq7cxLIlzS8D/4Pgui/VCl4YOdtHafob8DCM4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rWiZ1VHf; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rWiZ1VHf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5kXL1F0gz2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 16:19:13 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TLVth92845814;
	Thu, 30 Apr 2026 06:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qE9jKU
	DAkBGLSmSl/P6KnKUnAIeAM1blx2/rPLBkFl4=; b=rWiZ1VHfa6CgyeKZhc3kxe
	Il31lC3pVLrF2YGesib7QWNfWrtrQZW65oVUuRbYpmpOIgUqsmDHoTJjqwnJapBI
	31jmU/vqvAeZWvN1VmQWW1oQdDJ7McPsjpucdBorrb/IaX9SQgifMsVdekbYerWe
	OYOtrJl1p2/+0Ppx3bGEiE077Re4Oxuy8rog8gPWh9Tf6c6rGx3MpptBU5KPKir7
	7n25Muup++FyGYTGC0fVqlPoZWT780de+dNFmB5HI/KxoiGNYv9r4rLwm3/+bya3
	soW7EcX9rRxR9i/kjAlhCxkFL8VXdARNqY8nWuyI/xcR/CAF2tLNGcipG4hwnhPQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9re6cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:19:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U6CevX014710;
	Thu, 30 Apr 2026 06:19:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9ehhkxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:19:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U6J8Mn14680766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 06:19:08 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63B595803F;
	Thu, 30 Apr 2026 06:19:08 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCA035804E;
	Thu, 30 Apr 2026 06:19:04 +0000 (GMT)
Received: from [9.124.223.17] (unknown [9.124.223.17])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 06:19:04 +0000 (GMT)
Message-ID: <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>
Date: Thu, 30 Apr 2026 11:49:02 +0530
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
Subject: Re: [mainline][BUG] Observed Workqueue lockups on offline CPUs.
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Boqun Feng <boqun@kernel.org>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
 <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DO7-BjzqUEunGdmkEcoDQXg_RvS7cBmk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA2MCBTYWx0ZWRfX3swG14qacGKg
 fsHYoHu5teEk7SIbW5f2Yj096f5mKnYXTHZ6pUUPVkS3Cv2kd11XiojFLKNG4Y5A113J04prn3o
 0tx4oTQ1J3V1oMsQyqC+2Eg3R248IB7YCFX0kOsVo37hdK9oOeaSwOSVczusNIXLAwGNhyxK6Cy
 4koDhknBYO4Y45I8hTxm/CyWv4wj4XEamD0up9mVg64Zz/cRVkcY5A6SG0ce0VdWWtPTCtVdA5s
 cl5r92xG2njS3zX6Nag3xSBsE/F1RjMI33Y9pFDVM3EnE02z1ZNOwxCx/LxmUFyeewCd1en7EKL
 4BlrZObMVy2JPj/1RvaAVIqY/aENMJ+i7qRwmSs0RMAeWWyR6dw+tTlA26zAkm7VBg7X+6bvPBu
 n+kxmSXXTbIghH4HrJIt9QCP8NCh+EH8SHPW1o0AO+jcZ9TfBowVbln0LasdKMFE5kgg1aZq2jy
 +ZTppyQ52cPM9h7l4Cw==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f2f45e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=Z_pkc8uJlxWzUkK9FVYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-ORIG-GUID: wnEPhCK_syXVt4zTPa6NRYioY_jvigSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300060


On 29/04/26 11:21 pm, Shrikanth Hegde wrote:
> Hi Samir.
>
> On 4/29/26 3:46 PM, Samir M wrote:
>>
>> Hi Boqun,
>>
>> Thank you for pointing me to the existing patches. I have tested both 
>> Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC system 
>> (80 CPUs), and can confirm that the workqueue lockup issue is not 
>> observed.
>>
>
> Can you try only paul's patch and confirm if the issue is fixed?
>

Hi Shrikanth,

I have verified Paul’s “alone” patch, and it resolves the issue no 
workqueue lockups are observed.

Regards,
Samir.


>> Test Environment:
>> - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online 
>> and 384 possible CPUs)
>> - Kernel version: Latest upstream (7.1-rc1)
>>
>> Regression Testing Results:
>> All tests completed successfully with no issues observed:
>> - Hackbench
>> - Kernel selftests
>> - LTP scheduler tests
>>
>> The workqueue lockup that was previously occurring is no longer 
>> present with the patches applied.
>>
>> References:
>> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d- 
>> d699ca496f83@paulmck-laptop/
>> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
>>
>> Best regards,
>> Samir
>

