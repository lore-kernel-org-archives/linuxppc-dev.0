Return-Path: <linuxppc-dev+bounces-20831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F3ACD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 07:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFl1m43Vtz2xpp;
	Wed, 13 May 2026 17:09:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778656140;
	cv=none; b=YZGBYYjg+5cPebL6pyQYOyk3nR4++RSw+lA7TkZ7vZ/Ya+8iFHvThS7kp+42E36AU9oKMzjh/HB0ZO3na7fkOfFqlBFeWdvKMiPhX8do3YLMhHIN2W3bdgx3g0Z65nGZCIvmOOxSqo5g8VKdEA2v1HsON0EJc2f1yJzPCBwbjeKYPbPwOSpU8+DWKTXDlqrQeSZORXN5y8DH4wq8seEH0LE8yTAh6USOVRr7BBAy+qD5/f0MuNzgnWyJeeGBEbbYfSvEaZCX+HzQj3g8xj5HeumoNoNPs9IiMajeXTngJE/y2wV/dnqjLRhxqd2tmmO0fYzL5kZRKpDMIp8FV79tKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778656140; c=relaxed/relaxed;
	bh=ZFLG1ThLigjpcIXngpflJ7eNwj+nm/3eRnDkncjhTMA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YeDYyQJD/CBIoDjFajqeCi9t4pOClLnewjdTy5NAtI8ikwIfihiexeDoMmna3KvprDofuJBPQK5mX5FjNHd3eUNQKHRGnbCOgUT365xXAqqLsna9B+FDH8K9R5Ry5xi2UBTDKZnxDrna8fgaBOYVsrP2sZVoGIi2hu2HTjDA0+wcG0KRB/ZCOYOqnZn+ubO5a3+/5GNqlZAaKkqM5YKoPstklXxeyO0J8ch671NTxEEj3Sy3CFc5OIAUuLxCxlxntoVpTElyyma1Bh0y7toJIk91bOrU3QnEqfdylrLjjOkjSPwvMFZWqGg8t1Mk6JquMn5bM4FD44wtuHWh1TE6yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UjYbfCH2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UjYbfCH2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFl1l171Jz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 17:08:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D23CUL3179843;
	Wed, 13 May 2026 07:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZFLG1T
	hLigjpcIXngpflJ7eNwj+nm/3eRnDkncjhTMA=; b=UjYbfCH2gW7NaQN14BnAhu
	qG82vNlq9hMJv5sCE20XDO4Y1pZmaPghaIPG9ZRyCC+whNtM3xFLc/HDXQXj9RnB
	eMOVKA2pzLjTv7zV/IACUXMfaNBiAnxdB2dnrl1RDePUmgIDGiYiRHHz9Fc/RgK8
	96g7mL7SbEAzm5OS4HYO6hoUef4UqgavI1jbqac5R3Z5FtlP+d2xNcPkj7RRWFEN
	9j2h61evno0K7oUaEJnSkzdWZl2MK6EKxIgkeecWB5u61ULWXCZs8D+7iI1RcnZf
	3gMssvysbqfltjrxyFbSMIR2lRC3H2z5YSwStOZQNOWWWVC19gqUxvNyPs+KMQIQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6p7te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:08:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D6sXP7004913;
	Wed, 13 May 2026 07:08:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpp2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:08:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D78p7335914420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 07:08:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 712E05805C;
	Wed, 13 May 2026 07:08:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4580A58051;
	Wed, 13 May 2026 07:08:48 +0000 (GMT)
Received: from [9.39.28.204] (unknown [9.39.28.204])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 07:08:47 +0000 (GMT)
Message-ID: <59787cfc-c08f-465b-b66c-1a4537307bf3@linux.ibm.com>
Date: Wed, 13 May 2026 12:38:36 +0530
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
Subject: Re: [PATCH 0/3] MCE robustness fixes and LKDTM powerpc enhancements
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, sshegde@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        chleroy@kernel.org
References: <cover.1778057685.git.sayalip@linux.ibm.com>
Content-Language: en-IN
In-Reply-To: <cover.1778057685.git.sayalip@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a042386 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=FSmv8dLCCGc-WVpy0bEA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: tNgME0BuTSbqN9nByqr2SIgXhjpX6yAf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3MSBTYWx0ZWRfX6XBwRuiPax7v
 bWleYpKGWeKkxhoCm7E61DjUXKoPKpjf7MQiZ+6n9dLInZO5r2lhk5Mxl6qDsQ8I2cv6O9RhnHh
 IubO7eH6KvCyhybWW45wxjTI5Qidz07jVRidDwbZf2D3fFHoyLXgNbIe15Ps8D6ryduK3nwZ/oS
 Mhwl3LT7wIKdYvNtZEiB1+S84UDWeROVuQ8ZG+H6AFg3u9Gi7DSc+psRFFraD3XYQeNZm66mr76
 qvmMpjT+N7Ei2RffV1ZEFV961x3nLyg74I6OP5qnGDDUe5Zd2ktKL8k+vY7rxkwMz9HzZfLLndR
 BaAF9d5PwP8KDw+JLkUJvyE9JYb07GM01+3nx8N8n2pbHhWa2xSNqNe/prkj4dDWRi7Og5/YHWz
 D2GGJyOlfjevOaM9EHU4qhjQL9ssMZ/FNcUx21iJiIWiKzb3AWR2Y4xPt6EroJ7uHENhFCF0aeP
 OrngOpNDZppMKCXalQA==
X-Proofpoint-ORIG-GUID: z_vBTsT7t_k4R8xwTkJMKK7D30Yi8H-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130071



On 06/05/26 14:36, Sayali Patil wrote:
> Hi all,
> 
> This series fixes a panic observed while handling machine check exceptions
> (MCEs) from real mode. It also improves the reliability of the
> PPC_SLB_MULTIHIT test by adding isync instructions after slbmte operations,
> and introduces a new LKDTM trigger (PPC_RADIX_TLBIEL) to validate MCE
> behavior on radix MMU.
> 
> Please review the patches and provide any feedback or suggestions
> for improvement.
> 
> Thanks,
> Sayali
> 
> Sayali Patil (3):
>    powerpc/time: remove preempt_disable/enable from arch_irq_work_raise()
>    lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
>    lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation
> 
>   arch/powerpc/kernel/time.c              |  2 --
>   drivers/misc/lkdtm/Makefile             |  2 +-
>   drivers/misc/lkdtm/powerpc.c            | 44 +++++++++++++++++++++++++
>   tools/testing/selftests/lkdtm/tests.txt |  1 +
>   4 files changed, 46 insertions(+), 3 deletions(-)
> 


Sashiko has provided some comments 
(https://sashiko.dev/#/patchset/cover.1778057685.git.sayalip%40linux.ibm.com), 
so I am planning to split this into two patch series. I will send v2 
part 1 today with the proposed change for "powerpc/time: Remove 
preempt_disable/enable from arch_irq_work_raise()", and v2 part 2 with 
the remaining two patches later.

Thanks for the review, Ritesh and Shrikanth.

Regards,
Sayali

