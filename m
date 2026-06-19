Return-Path: <linuxppc-dev+bounces-22822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBCCCD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 13:02:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghd602KkTz3bpm;
	Fri, 19 Jun 2026 23:02:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781874120;
	cv=none; b=BMehlSSGnHArlblPVx/Ip+BfILaK/xfe7hdv1T8NZ1cgI/qFsiRud70x4Qf+rOwGa3UGOzZuKItd1c8+oXzsXhVRzkfkN4NEQEtIZXakeilL3IJW27F91l4Y8wqQk9Tnn0ziDEijPAcVM9oYdmZoARzlz4wayKZQ68YqbaJbCYo9ohGdgSjlFkrGywKF+/0u7SIzwtfmXQVSAchlWRkEqt9zwY41IWf6FzI2J4VYnYnKpbxF/VRGjxQ4FwoIhRODosImGJhzDdJSkMTHZKpZRTz3u8YUyhH1n8wdBa65GFk6MjCJve4wCmF4GYGXEn/GGmNnAZBD8ldA7G0lGxQZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781874120; c=relaxed/relaxed;
	bh=hHSzvt4wtlQEz7yySxRM5feG47vdHJ8Vno8ZGD6/No4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZwDDnTRyt7qR74xKPi6ln0OeBkzPd5/lNkYAnp9RYfBxEoGa07VqJhjZAU/qZ6Sm9IPG9LOf2iEzRJYojl2BmPO5AU80ACqoy5ImxHWThT+voIZVIdy8o7ubXpks62VeZmaRxBuyQFTPYfxhhJWJ/L8mTiU4j3O33riw4wbyryk5B8hrRdue+P3/r0rYGICBvAWzIfeyEXUqEhXL8nSO8c3fALAJ0F5lzQPsTQWLklnb9cg/P47DShQDFUWVU2nqSXzlcCtmw+9u94sYyxR+7DZeeC5C+EGbKgx91Dzb/NcM9x69jnKsMHx0uKUymU7NZ4n25y5rUa3Szu/AvBOew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LyEvpk7u; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LyEvpk7u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghd5z24z8z2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2026 23:01:58 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mNKK1840466;
	Fri, 19 Jun 2026 13:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hHSzvt
	4wtlQEz7yySxRM5feG47vdHJ8Vno8ZGD6/No4=; b=LyEvpk7uolH3x5Ixct0zhH
	vtRrqKFI2l3jqokIMWX+OVRoDQzvFdP3i64YnGj1j0IfVMLsfNCJa/eZFxrQy7H3
	mijXwKSQHaJn/0rdCeo5u/gfdehdIY9PAC5yRQd/+cj89/EkkY4HVgfxkMmUW0jl
	Ah+ESpTcsWtS180UihqO3Weg8fNwOaE5Pew5lWRdsydMSG3XEALEfKcVSBYVoqEh
	vcHu1idJiDt/T9EMd0OSXU1mWUEBjXeqrXRth0GNEvszDwYiCZ2roBVPONPrCY94
	rqV9wM4OJ0a+crm0hCEm9R80MGzKWbNQ1eHJECfeqOZjjbOU0ZFQNLZ1F/PR7b3Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequdppy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 13:01:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JCncOr028990;
	Fri, 19 Jun 2026 13:01:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172gx62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 13:01:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JD1fMh40042786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 13:01:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB4F20063;
	Fri, 19 Jun 2026 13:01:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6485C20043;
	Fri, 19 Jun 2026 13:01:39 +0000 (GMT)
Received: from [9.124.218.121] (unknown [9.124.218.121])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 13:01:39 +0000 (GMT)
Message-ID: <00f9f432-7a09-402d-80d8-3537829af07a@linux.ibm.com>
Date: Fri, 19 Jun 2026 18:31:38 +0530
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
Subject: Re: [PATCH] powerpc: Remove dead non-preemption code
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
References: <2bf10a0afffefb6aca44bf2f864cc17471a80e31.1781870889.git.chleroy@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <2bf10a0afffefb6aca44bf2f864cc17471a80e31.1781870889.git.chleroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEyMCBTYWx0ZWRfXwV34vuTGa02S
 KkvRclUV0185AFNlswp1kFw43WPgTQ21KiXgtLjJnSmaBeMaDll3L59hLUfAy17uALzKBN/BfI3
 6rhuj1y22qaXZ/AR2vTL8iFEYqWxL8U=
X-Proofpoint-ORIG-GUID: qMQlcscXxV--WsnajPHOAARRZM7PDQ9H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEyMCBTYWx0ZWRfX9CfXGgBgn8WJ
 LUP1k9nigbcdilPy71zf/Alh2iDGnhSzOniUguBDn3D3185pvRtzC3qlJbUnUCyDdinm6vCdLDz
 wylU5cFYtV+dVKo7VWdYTTtINz8Yp2d9wk1A3VDg4Qx24FooQ+yU+FZYVKNIXrrU4HR//5ZgY5u
 NVgReJ4gkyDzxZDRZod2+mXDnUe/Tmo17vp1KpkNHgq8o1ntxQJE/rW7C+zS40KTmMr9rlIQ/F+
 3K7zFIWbQd8jnD0X9nVR5r3n/c5UCx0wPZU8lOGT0+Y/PAWwR1VdH6hWeD6YOtMNQM2cWZfYO1Z
 g5nbvBntm2Ha8WrObSDMigQGPIczlg+svFiGTwN31zr1w+nDNon0aj2/imFG3KPxldkbwckc4xJ
 55KnGgtJGUcGP+TZt2mge86nYQ5ltt6MuKL6sokqkUMv3+MidYf70IaEPk7Df6up316/qG+N/S7
 vw8Nq9Ugkx4eZNnBCww==
X-Proofpoint-GUID: E8hOsBSqpuIrA3InYaojkHaqoD3dMrRX
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a353db9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zaO9D7ICNSSlUu4npJ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190120

Hi Christophe.

On 6/19/26 5:38 PM, Christophe Leroy (CS GROUP) wrote:
> Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
> modes"), powerpc always has CONFIG_PREEMPTION because only
> CONFIG_PREEMPT and CONFIG_PREEMPT_LAZY are possible, even in
> dynamic preemption mode (see sched_dynamic_mode).
> 
> As a consequence, need_irq_preemption() is always true and can be
> removed.

right. this can be removed now.
Thanks for the cleanup.

> 
> And because commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY
> feature") includes linux/irq-entry-common.h which already declares
> sk_dynamic_irqentry_exit_cond_resched static key, asm/preempt.h
> becauses useless and can be removed.

s/becauses/becomes

> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> ---
>   arch/powerpc/include/asm/preempt.h | 16 ----------------
>   arch/powerpc/lib/vmx-helper.c      |  2 +-
>   2 files changed, 1 insertion(+), 17 deletions(-)
>   delete mode 100644 arch/powerpc/include/asm/preempt.h
> 
> diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
> deleted file mode 100644
> index 000e2b9681f3..000000000000
> --- a/arch/powerpc/include/asm/preempt.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __ASM_POWERPC_PREEMPT_H
> -#define __ASM_POWERPC_PREEMPT_H
> -
> -#include <asm-generic/preempt.h>
> -
> -#if defined(CONFIG_PREEMPT_DYNAMIC)
> -#include <linux/jump_label.h>
> -DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
> -#define need_irq_preemption() \
> -	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
> -#else
> -#define need_irq_preemption()   (IS_ENABLED(CONFIG_PREEMPTION))
> -#endif
> -
> -#endif /* __ASM_POWERPC_PREEMPT_H */
> diff --git a/arch/powerpc/lib/vmx-helper.c b/arch/powerpc/lib/vmx-helper.c
> index 57e897b60db8..cc9fb72cb4eb 100644
> --- a/arch/powerpc/lib/vmx-helper.c
> +++ b/arch/powerpc/lib/vmx-helper.c
> @@ -46,7 +46,7 @@ int exit_vmx_usercopy(void)
>   	 * set and we are preemptible. The hack here is to schedule a
>   	 * decrementer to fire here and reschedule for us if necessary.
>   	 */
> -	if (need_irq_preemption() && need_resched())
> +	if (need_resched())
>   		set_dec(1);
>   	return 0;
>   }

I booted with the patch, still can change between lazy/full.
So,

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

