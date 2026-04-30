Return-Path: <linuxppc-dev+bounces-20345-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0624CFF8873
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 15:36:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5yvr1trFz2xSG;
	Fri, 01 May 2026 01:36:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777563416;
	cv=none; b=EqPnotLtTgQFgB5nl69mWCUs+Lq3bJ/A+55aO35F2coI75adz88/bo2C7egovfD1P8gT/zYtxeNpfni5WByCbLl3TGhlDIgNAfMLtBGBX3EpnR/FrVpMYXNy3I4gYM3EBJ/YEk/ZtP6O1mO7lMHbWNXHtYT3noD3Ee4LUh3HTpeKoFyfjhofgL230j4tog23Vn0wk5YH1AYdJt6yP64q9I9cKnpjnn7v89nsceMMpgDoyRY7Y1/7MG95RlNPydSpjvRE4D9SET1UZcFw+2r+qL5frDBIpEpoTBXGCju/CqIx1k236qZ6jBMVkg7t6f5iFXjAO2NOWu0uLXg9InzcPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777563416; c=relaxed/relaxed;
	bh=h9V1qH+yCoHPi85IK5Lz6IKOZqyxzFPjLfAxORR7lgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBSD0j2BesgJyxIb93PIAE2wpeKDm44d7jafzEqifzxVHBs+wb7rCQVfsVCRTF9845oKau+lIhCVfWvVcD0F2uoBY4x8lTBGVQc4RBZQ5UhoRhCErC4RcfVDp8R0/QZ0vqvRpTn+tI3F7iy8GtQSM+ooVJE/R8HWwvPS9ZHD91F6k2EHkqrfPkXN6PjsrDxVXqeEEU5i87bUgMZvxm+YQ7UwVLGcI07hC5bk7TD6ARnBk3wXRBJVeUWD2+Kjdt197sy3id+JjWObJ2nSokNjQ+fCJ2whUTYUSiBSBfQNqKX9J/lrZaMeBB9NxuIDNmnHgeADv9QT9cgPrTD7Wj40nw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uz/T6rwV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Uz/T6rwV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=samir@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5yvg2c9vz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 01:36:46 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UCP3Re036865;
	Thu, 30 Apr 2026 15:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h9V1qH
	+yCoHPi85IK5Lz6IKOZqyxzFPjLfAxORR7lgk=; b=Uz/T6rwVbRIrMdQGt73sMb
	vwz0JyEk0EoocWwmx+AT21veamu2ieauvGOJADpOCK+fsev/rRYXLKCM60xDs1lj
	zIEk3DFr+dRWSii2wLE3lvqvGvnhQGrS7ngyqr8P/CUpq4i2qXBNnDSXnjBzApdA
	ldXPd/S6rei4moskoW7stD2zxGRqtOQI5KsRYGHPevdBg+bGa/qHcSaf0B2SUkye
	E0B/ixb6L1kxM/qfA0JiwqbQ8wTKP79XbhuzRpGALkYGKBpMDpO4JrxLF4Oxje8B
	V3HOR6ZSHurUrXFICunHctC6ZSKzi6NKRefif52nCUaT3NB7hYnVl9ZRJ7l8QZnw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e6u0k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:36:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFOBqO025204;
	Thu, 30 Apr 2026 15:36:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqkrkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 15:36:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63UFacTG32637596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 15:36:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2875058057;
	Thu, 30 Apr 2026 15:36:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8BBE5805D;
	Thu, 30 Apr 2026 15:36:34 +0000 (GMT)
Received: from [9.39.18.177] (unknown [9.39.18.177])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 15:36:34 +0000 (GMT)
Message-ID: <4597b29c-3548-482f-9a34-8d69a59d77fd@linux.ibm.com>
Date: Thu, 30 Apr 2026 21:06:32 +0530
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
To: paulmck@kernel.org
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        RCU <rcu@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
        Boqun Feng <boqun@kernel.org>
References: <97a7d011-d573-4754-9e5d-68b562c64089@linux.ibm.com>
 <688280dc-78a2-4796-9eaf-e1c058836012@linux.ibm.com>
 <ae-EP1BpXgnEWCt4@tardis.local>
 <1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com>
 <5ab8d72e-1a93-4d50-b097-0dde35d81f25@linux.ibm.com>
 <6c51cebc-3b98-439d-adcd-a0f382b98f40@linux.ibm.com>
 <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Content-Language: en-US
From: Samir M <samir@linux.ibm.com>
In-Reply-To: <16676927-5a4a-4007-9ece-593a4699adb0@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Wmg3tAgrz8b2fQl0dwWKjuCWspfAAcQG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE1OCBTYWx0ZWRfX+FH0OVqWT3um
 qS3uMtQnDCZz+jaMCAbaZgoUEJ14AZuBnF/tEdfLxq5+auzyaIkqcUIi2qZEnxP+qmB1sZb5tcO
 mzTmzRZWMCkKi3d+coeUV1xYJnlaOIg3n73znu1gDtA1DyDm0wt6f4A/vm+267gKTNFWJaQWwOK
 SYyzwkl5O6H3nXasOgzw4FuMrX55a3C2kJHaipgfNUzxZPRxNSggU/r0Q/jn7nAvLswPgs1fRMR
 RNNFqqHG1EdNsQboUijXjRQLWVSf7EX5SXynUeEMPA1PGtW1DGLCI7gZPJNwLByaZSMsfYM2iCn
 fBYqryW/qmAgMeHCXB+j29hGmJEVAAMi1hIdXvM/1faWiXy8thzEdMQ5C1Nw9X6WTvFRKFDQ2Go
 rRGkSUses5GxX18r2qobKjXGPfFTAILrik+kOYyI9f9lm7v5CNK3+p9Yggo7ub3jjyMfRLHmQTh
 UKFRXdVNvGPLzAeCrcg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f37707 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=qCof3rqyAAAA:8 a=VnNF1IyMAAAA:8 a=OO9Z8b08tAtk0z3vkt4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sGiMcuukUhmiu4iKGgn_:22
X-Proofpoint-GUID: yEsCtX3Np_yzCS6ZTvX-RMiNgwpiTZRU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300158


On 30/04/26 8:30 pm, Paul E. McKenney wrote:
> On Thu, Apr 30, 2026 at 11:49:02AM +0530, Samir M wrote:
>> On 29/04/26 11:21 pm, Shrikanth Hegde wrote:
>>> Hi Samir.
>>>
>>> On 4/29/26 3:46 PM, Samir M wrote:
>>>> Hi Boqun,
>>>>
>>>> Thank you for pointing me to the existing patches. I have tested
>>>> both Paul's patch [1] and TJ's workqueue patch [2] on my PowerPC
>>>> system (80 CPUs), and can confirm that the workqueue lockup issue is
>>>> not observed.
>>>>
>>> Can you try only paul's patch and confirm if the issue is fixed?
>>>
>> Hi Shrikanth,
>>
>> I have verified Paul’s “alone” patch, and it resolves the issue no workqueue
>> lockups are observed.
> Thank you, Samir!  May I add your Tested-by?
>
> 							Thanx, Paul

Hi Paul,

Yes, you may add:
Tested-by: Samir <samir@linux.ibm.com>

Thanks,
Samir
>> Regards,
>> Samir.
>>
>>
>>>> Test Environment:
>>>> - System: PowerPC with 80 CPUs ( e.g. PowerPC LPARs with 80 online
>>>> and 384 possible CPUs)
>>>> - Kernel version: Latest upstream (7.1-rc1)
>>>>
>>>> Regression Testing Results:
>>>> All tests completed successfully with no issues observed:
>>>> - Hackbench
>>>> - Kernel selftests
>>>> - LTP scheduler tests
>>>>
>>>> The workqueue lockup that was previously occurring is no longer
>>>> present with the patches applied.
>>>>
>>>> References:
>>>> [1]: https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-
>>>> d699ca496f83@paulmck-laptop/
>>>> [2]: https://lore.kernel.org/rcu/adlHKowvhn8AGXCc@slm.duckdns.org/
>>>>
>>>> Best regards,
>>>> Samir

