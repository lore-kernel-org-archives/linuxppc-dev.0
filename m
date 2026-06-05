Return-Path: <linuxppc-dev+bounces-22111-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F47CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 07:42:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWthG5PGsz2yNn;
	Fri, 05 Jun 2026 17:42:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780645374;
	cv=none; b=NQpCreti5FPg7Ji/icoX99poNqnyn/TemcIe3BYN7QmThGLGO5iRXROG92u5QYuzdwHkhV95tLKlaffmHCmqwjpoSDxHQk63mfBdP8E/GREYPgSEFnncNFJvN2q8J6exdjm9vI7g78t7ZOAjw8uMBMbc1g1Te7u0jcVbMhouRmaqxQz5id6r30jjMtsDteWzxyxZNFSnFy/lFSLimaTc/aAa9kMFOwuooSV424kbk4mJzJxu0n635EOpvHkIvvglg2Hi2jRVqsGZSEnNL9W75cSPMEOVwnVoFZTSFi7VMgRtjGqJPFxi46DOnGbgyGMS89otemDjTcxdQ3H3JIc6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780645374; c=relaxed/relaxed;
	bh=unrab/aeFG+Z7JblzX7ywViamNHLQvvi09aies/+o04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaEzpAJnlangBWYbIhWUTaJwo0LDjRC7poyzN9t8RUnxw5wS70TAmTB8toIMGZCLxAJP09H1ufMZzbk9iwYvC24CFGD1IHaqhfYUjiF9S8DpMS1pprft6almaHT3CcFsAfAnNaVT17tPkvvcIKBpqw3GJGNXLdg9d8SM1sERcpl+CmsDDE5Ua5v40q6AKgAQYCACt+ATw444ddddRTM/sITdsyLMhP1NzJBULlsm1LAiGRaNXYstje2o/I0a4FoA/kOBfqP/kAmb8cB9y7LcnLmqXDgaBAeZbd12/Smxlq2BhCvv3U688ZMPxtg2R2su4Ur71YrzKOEJiUvD+Uw72w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvGc/N5a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DvGc/N5a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWthF4rWNz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 17:42:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654NVrI81640981;
	Fri, 5 Jun 2026 07:42:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=unrab/
	aeFG+Z7JblzX7ywViamNHLQvvi09aies/+o04=; b=DvGc/N5afL6wE6iBfBqynJ
	7ycKKhIdwj1wsn5lBQmgsqdjZYVHlGXH86XHeYMtUunHiWFvD3bJJfEtqHcWa6kW
	I+q97JmP/mLfP8VzQgOr1jma4+E38eTv+ucoqciT6KLvMclHbk1Ur+RTk49Avc/l
	1x/EACJrFTD/UTl4dVwDDM72/LPFM3QSwkNerO7C7vuzuXEOV5Imbv49Ybjshjd2
	dS0z3DjyjuFzzi5bt/tXPWG1DTdKaEpae5Y7x/0X0DBrbkcQgk5ZxEwaFZighcYs
	PmjIw1buGwc+nbaBx7L/CU31/GoNoh1erBGpd1N/iktsJZqiYFSNOuwZNRYt4e+A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj2x7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:42:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6557dBF9009959;
	Fri, 5 Jun 2026 07:42:39 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egceh0ewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:42:39 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6557gc6x29229626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 07:42:38 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36EE158054;
	Fri,  5 Jun 2026 07:42:38 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6153C5805A;
	Fri,  5 Jun 2026 07:42:35 +0000 (GMT)
Received: from [9.61.250.106] (unknown [9.61.250.106])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 07:42:35 +0000 (GMT)
Message-ID: <415837d1-7c3f-44c5-affb-deffea064a17@linux.ibm.com>
Date: Fri, 5 Jun 2026 13:12:33 +0530
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
Subject: Re: [PATCH v2] powerpc/entry: Disable interrupts before irqentry_exit
Content-Language: en-GB
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: peterz@infradead.org, tglx@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, mkchauras@gmail.com
References: <20260603131054.216235-1-sshegde@linux.ibm.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260603131054.216235-1-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA3MiBTYWx0ZWRfX62EU7DmGxYSU
 5f8jHcDeTV8e2dI6wvKjZ7mwhWAbT86cucZ378KfHEQJx/zSY0WwvBecfvw2meJTd3e4YoXxTnx
 EWdGyM6RDijNNFSa6TmzgFz4S4tJQPkOdNmLhS2x95nL2KIiJBf48RQybKahvd6j5vNpVfjwZGz
 xzc8qztDoVsWQlCmchMbxisZl73SD8MAavy8/9kYhIqWT1aDyXdVAF3xp2grWoZhxbjiVTSvHbo
 OA1sDxrFZLVJh3jph7PV8gnNyqapL/KtCJq8bCAVrj0WtVGriHX4eDDMGLQ809AJTb/1hGHiwFv
 fGjvBS4xNzSilaM5AxTcEz9DK01oXMBZa+pGNyhUXDAcK7h+QE7BXk54dY3s4tW7j9h1/jtHMps
 Om95mMbfZMBuIKedrwP+auw3Ch2SThVgGNrnjgU6x773YVyzKJcpwDoCjjyO4TVoK7ZRMT+5/zd
 OWVS8PaXT00QUe8TstA==
X-Proofpoint-ORIG-GUID: 9MLj7nofYnQDZb04oZAtgN8T6c5huflY
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a227df0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=0qK8jKqZVsqS02L8AVAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BOqhvT3Sj08icEbYmZPK5wtejKadAHPe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050072


On 03/06/26 6:40 pm, Shrikanth Hegde wrote:
> Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
> been enabled.
>
> kernel BUG at kernel/sched/core.c:7512!
> NIP  preempt_schedule_irq+0x44/0x118
> LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> Call Trace:
>   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>   do_page_fault+0xc0/0x104
>   data_access_common_virt+0x210/0x220
>
> This happens since __do_page_fault ends up enabling the interrupts and
> it could take significant time such that need_resched could be set. This
> leads to schedule call in irqentry_exit leading to the bug.
>
> There are many such irq handlers which enables the interrupts.
> Fix it by disabling the irq before calling irqentry_exit. The same
> pattern exists today in interrupt_exit_kernel_prepare.
>
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---

I was able to reproduce this issue consistently, and confirm with this 
patch, reproted issue is fixed. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


> This applies on top on powerpc/next tree.
> base: 6ed60999d33d '("powerpc: Remove unused functions")'
>
> v1->v2:
> Leave those BUG_ON alone since they are tracking the register
> state of userspace (Peter Zijlstra)
> v1: https://lore.kernel.org/all/20260603095521.198267-1-sshegde@linux.ibm.com/
>
>   arch/powerpc/include/asm/entry-common.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index de5601282755..fc636c42e89a 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -260,9 +260,10 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
>   		 * AMR can only have been unlocked if we interrupted the kernel.
>   		 */
>   		kuap_assert_locked();
> -
> -		local_irq_disable();
>   	}
> +
> +	/* irqentry_exit expects to be called with interrupts disabled */
> +	local_irq_disable();
>   }
>   
>   static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)

