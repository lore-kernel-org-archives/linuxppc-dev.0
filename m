Return-Path: <linuxppc-dev+bounces-20436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0670FFF885A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 03:53:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8l3l3yvZz2xSF;
	Tue, 05 May 2026 13:53:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777953203;
	cv=none; b=LnwsusPA4DLf5DAA/Q63BxFPVBO9dpyBuafy22m344Yu+lXAf6ZH0Sf4GWpTXq8UR4Sj8/FuUOGfF1uDLKjPblBYEqdCIr8AtbCHFqWU3kf1xDdKRlTIdfJFgc7RaszmLjtnbQ+Zku9KMl+huRrvtnE7wqlIZ2wxSMzqdcqNZuUT5Sxv5KBXTZa4uH6CIBkNM4fsRN4E2T4hbKYOdLmla38+PKGOhksgYXWpnMyspMJquoHuKOR14INAB6BRE95/pcd68acL6u8qaIWKtKSxTo+Z+C2DtZrxjTc5uUrdVODoKGmiZ5F4T+W46GCNlt7HzrFWktxSOEJ+GsuSnoIVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777953203; c=relaxed/relaxed;
	bh=AOJeb8lgDgFb35AqyMJaZNyKLOJQn08GV7x7rxUc4Wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iBRwhG6997D0em9ml97vaz4Y3vyyr5Db1l4UvBKoMy+7W/gphZtWKwHNQXM6p2ilg9dX6gUxl9j3C6oaTl5ZTvv3an7g+pMd5LZ1soxywoIy5m7xmXnt/9jo35zzi+O+a+XO8dODWBBwaZCbgIKtjnG1NDP3Nj1houShk83zE93pdWuoiF/J5E96Xr0rmWN4fCDJUE30DDRpKo8Y+w4idrjbPfw9Q/xw8jxDECrIuwEj0lTu2+Ay8uNDJMbHCgEQkElk5WyRJBSm2CT/SRkhPZvDEj79gdZ3Hr50IvHTmG1b8is3mD++LtBjUM6jK+G9wYCnREkudA7+PmXfJkL5Vw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kox+M4Ch; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kox+M4Ch;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8l3k0XJFz2xMV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 13:53:21 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644EKxd73390293
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2026 03:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AOJeb8
	lgDgFb35AqyMJaZNyKLOJQn08GV7x7rxUc4Wk=; b=kox+M4CheAKiOZDV54u2kt
	RmUwe/PyEgNccX0PEeHYBbRuaoQX1iu9eBEvOP+YRxr82EtvSzsVE+Y89DbreQXI
	YPJkgR3eS5P3cPHAQnumdcEzyR6DLywRuVnjt7vzSdV9fRh27dw5DyELiPYE0H7Z
	MJvOd6MPjhU3oxQYMPZJAUgSwa/cYN7/7hkCk0Czpp8SpmRAfH4bBkiiJxjkYhYL
	cbSbOnnpQ460yTFQlIikrXDTxqOMTzWUd9gO5Njc8rc8Lm19YipvR8hE8o8reEoD
	BhKv468my6TzZp10qAXpkCl14SQB6MNNqczBKQ1/eQB5Ujfc+DyITTlqnOaTV1SA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxhhd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 03:53:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6453dkEx012563
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2026 03:53:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw011s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 03:53:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6453rGvL26018454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 May 2026 03:53:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782E55805C
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2026 03:53:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3DC658054
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2026 03:53:15 +0000 (GMT)
Received: from [9.43.56.4] (unknown [9.43.56.4])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2026 03:53:15 +0000 (GMT)
Message-ID: <6a79a329-2950-476a-a5ef-b0022e247581@linux.ibm.com>
Date: Tue, 5 May 2026 09:23:13 +0530
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
Subject: Re: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
To: linuxppc-dev@lists.ozlabs.org
References: <20260316174747.3871924-1-bvanassche@acm.org>
 <5ee49a18-e6cd-4ab8-8430-e1ef64ec353f@acm.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <5ee49a18-e6cd-4ab8-8430-e1ef64ec353f@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAzMCBTYWx0ZWRfX+BcQ2dVMqioW
 kiS/itfxtNMG4MGvbS3gu+iywPFxK0zQ3dkPDHYNWdMtfJI4aStxn8OKM1roDjXykaYosaR38c4
 /aUcIhU59zjD6g+DdiFbT1CXyD7MBPXeOImvllmqcOx9H6AEwxdxCxFprORZCgHcuVwcz7L7KTq
 88Mr42qKUbXBom7aG2zB60k2hxkQr7W36NQ5MH/ofAS1MJL+qh6mGIUfoDRM49aZQx0NXatjmo9
 MKp+sKR7F4EQB8l+3XAGRAtCCrEsSRAIGb0KwR8J3IUfCodzjO6ROBbYD0t1xxUBUBuhjTKBmK6
 M7NJ4fOZRuYvrIiHyynpd3cfcnrbfh7tJN/kNj3i2PLJdmUEPw+bKW+xWTaOowEGVX5OKs+xEYF
 FI79QCBWp3bE328Vd/Z5EDNzO2tqNAf0HE6YSfwRoG79o88z+YTjBaWQDs/1KXXh6m8fKU0950o
 3XnbKRsBMUs4yJyfsnQ==
X-Proofpoint-ORIG-GUID: rfe2EnyJRKfm68T_iLxot1uYF5H8GYPr
X-Proofpoint-GUID: rfe2EnyJRKfm68T_iLxot1uYF5H8GYPr
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f969ad cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=fOfinEUf4hX9KF6QKBEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050030


On 4/27/26 10:40 PM, Bart Van Assche wrote:
> On 3/16/26 10:47 AM, Bart Van Assche wrote:
>> Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
>> removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
>> Hence, remove these two functions.
>
> It seems like this patch hasn't made it into Linux kernel v7.1-rc1. Has
> it been sent to the right maintainer?
>
my bad, missed it. Will pull it in.
Maddy


> Thanks,
>
> Bart.
>

