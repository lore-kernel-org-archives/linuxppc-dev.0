Return-Path: <linuxppc-dev+bounces-25114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435D0C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 13:54:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9rKQ6Qwcz2xnp;
	Thu, 30 Jul 2026 23:54:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785419658;
	cv=none; b=gDEoIZrH8Eu9SAxABKJHWIw9Ocxybeo/wE0y/2Zq33cqVwVtcvaRJrjr59GBT2mueomwISqs/DkfM3La+Vlpc3Zy/vKO6lexoUijrtU2szndE/Yem2x40dO7Zws95ZfVDYFV+fh9TfiX8936ycM4AW74Tads1J0OcELgqeHT7v0vOlfngOGhlUhTKLyF1HDqzihVt9jKZ6bi7/kW3XK/OSgm9Sfx69nm7OYtTOnApZ7rINN11sPNZBCqKjPPMPBVNXhRI3v4evMswwXZAbqZk4NRfLdYFGrQwYqoUWY/d9ubA84f+l3TKdDrNYF8rNtmAF8H4vMa5HAef2SZ/fYz6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785419658; c=relaxed/relaxed;
	bh=LD35bWKowyXqJovbw0p4Kh6rbTzj/40A2dmivUeBOHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nc70YmAbmh/3yK+P68xcvx0Z4KNtrW+TLl3npyJJAwtTPtCa82wbfdf6cS64eAMMqzTfPq6Q+zSDsv7AwdMfKRjuTRS26o7YBZ0c+P/J+S7ogNGE584eRzn63JA26Qv0OqHUKso4ur7H271pkdP3fQBOtxe22HJH2iaiRLzo7k7rLYGvd/Xk997fEqxhnIG+fKk3NAr1ri8mijzui6hw/0NLc4lE4eTgvsgercrQswtD/vakVT7M19JStaAyZWNuGvdBMdIu/gJW69FI3HWtDmMnGdtm7RtM//Z1VUafT16OP2T0ZIwYzflGEwmax/sguJkc1Q39F+WOY8CGQse6bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXiP1lSO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VXiP1lSO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9rKP74xxz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 23:54:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHv403020624;
	Thu, 30 Jul 2026 13:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LD35bW
	KowyXqJovbw0p4Kh6rbTzj/40A2dmivUeBOHU=; b=VXiP1lSOHmQc/Yh2LQpM6c
	oWETac0AiU02qliMSt0sgZO/QetRtbSSwUE5xx8HwKX4Bhmfg2FUcMrD2viUP/ok
	32bSnKXndgT4SlKQLFk8guZqC6i2jp07C9eLATLOreGHZQK9yQ8m9E3yDLkuT5wG
	rx3Awq2ngPKCjqZvF+nnWBqCE5p5BcC2YILZetyE3pJauaWTW3bVd+dO/C5aReFQ
	tTesi3Mr7U61bh15BcuEVqdbXXQSvYtasvGfevK/q8VZ63O1couAX0eSbDQlMUCg
	RynQmnQMguJk76j4ddVkyrTUn2kqNEQA1AgeLvNVgh+eLR+618LTLXk0N3OmcCaQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjf670-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:53:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UDfIwa007822;
	Thu, 30 Jul 2026 13:53:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhkgu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 13:53:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UDrcM951380678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:53:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 113172004B;
	Thu, 30 Jul 2026 13:53:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 704AF20040;
	Thu, 30 Jul 2026 13:53:33 +0000 (GMT)
Received: from [9.123.5.233] (unknown [9.123.5.233])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 13:53:33 +0000 (GMT)
Message-ID: <ff80d246-1bc6-4092-861c-9169d0fc599b@linux.ibm.com>
Date: Thu, 30 Jul 2026 19:23:32 +0530
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
Subject: Re: [PATCH v3 1/5] powerpc/xive: make xive IPI allocation NULL-safe
To: Gou Hao <gouhao@uniontech.com>, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, namcao@linutronix.de,
        peterz@infradead.org, kees@kernel.org, lgs201920130244@gmail.com,
        srikar@linux.ibm.com, ynorov@nvidia.com, nilay@linux.ibm.com,
        clg@kaod.org, benh@kernel.crashing.org, miltonm@bga.com,
        mkchauras@gmail.com, akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        gouhaojake@163.com, kernel@uniontech.com
References: <20260727104215.184786-1-gouhao@uniontech.com>
 <20260727104215.184786-2-gouhao@uniontech.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260727104215.184786-2-gouhao@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfXwSU8A8gjf231
 DFICseDTEOgX2h8brHLB+rE7NplOcCwAzdnEyxwwXlhTDFw7myV5mi9fDPm37rpErdIfp2OWlBe
 M7dBeKHt9iYycxkCHpa4tXH8E2dp49g=
X-Proofpoint-GUID: flO1FR0d7tmPL8KuYTdyMFYh62ueWzDK
X-Proofpoint-ORIG-GUID: WobPOG2nD7MdaLVjL9gN3rfgtDM3SDhg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX97EJ8hikXO0F
 oquGP7N8AgGYW7c3LOZVtQcfPEpmKR+oHD+Hg+m4Duze0LSLDbXJMS5P4015mXWPst/0qonwyIg
 FOYiS3r7GL8C1x9Uhi8tKHPGf9otzAAdsxYasklbEcl5+ThV1262EkWmZqUuAmie3kC/O1f87oe
 6e/E8ASokPpYif+LcXZQ0xHlA4pKBsNDGq8UHC/cjOjZhPPyZZ1AqzH5pVROMEY/SQARn/rGVc4
 dxOjEfD9mWO4plUvmm93qjvZ8VjVLna+BGuVDPzwRZYxenUw5FAbaQGLUiqrYWyIEIMErRobQYo
 viifseAlT4U4saZImxGoo9vMXRLUWHxyTTzXuOw8op8tTDaMzPIejWslAxMCHIR4J5UaIvDtH3T
 2XilMlmQ7IUHZiQ43KdTiX8yACxYgSH/vWa58ZcixxEGV/xfi9ZGug+ZDfLDCyb0w/6nNBoHJvF
 4Y3cWUIFNJztjUR5leA==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b5767 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=Z4Rwk6OoAAAA:8 a=iHwBjlyiAAAA:8 a=aow-egSQAAAA:8 a=pGLkceISAAAA:8
 a=qqRgf87witzEI7Tn1VEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=HkZW87K1Qel5hWWM3VKY:22 a=uNSKXYNwxGiU6LD0JREI:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300105



On 7/27/26 4:12 PM, Gou Hao wrote:
> __GFP_NOFAIL should not be used in new code [1].  xive_init_ipis()
> allocates the xive_ipis array with __GFP_NOFAIL, which makes the
> subsequent NULL check unreachable dead code.
> 
> Remove __GFP_NOFAIL so the allocation can fail, and make all xive_ipis
> access paths NULL-safe:
> 
> - Return XIVE_BAD_IRQ from xive_ipi_cpu_to_irq() when xive_ipis is NULL.
> - Set xive_ipis to NULL after kfree() in the error path to prevent
>    use-after-free.
> - Guard xive_setup_cpu_ipi() and xive_cleanup_cpu_ipi() against
>    xive_ipi_irq == XIVE_BAD_IRQ to avoid dereferencing an uninitialized
>    or already-freed xive_ipis array.

I would rather prefer a BUG_ON if the allocation fails. That keeps the earlier
semantic.

- If xive fails, then who will send the interrupts?. It is better to crash instead
of leaving the system in weird state.

> 
> No functional change when allocation succeeds.

Please don't put a statement like this.
It should be either no functional changes or function changes.

> 
> Link: https://lore.kernel.org/all/20260725202632.dcb325658896a470df91cf57@linux-foundation.org/ [1]
> Fixes: 7dcc37b3eff9 ("powerpc/xive: Map one IPI interrupt per node")
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Reviewed-by: Wentao Guan <guanwentao@uniontech.com>
> Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Suggested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>   arch/powerpc/sysdev/xive/common.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> index dadd1f46ec93..86c78af1f68e 100644
> --- a/arch/powerpc/sysdev/xive/common.c
> +++ b/arch/powerpc/sysdev/xive/common.c
> @@ -74,6 +74,8 @@ static struct xive_ipi_desc {
>    */
>   static unsigned int xive_ipi_cpu_to_irq(unsigned int cpu)
>   {
> +	if (!xive_ipis)
> +		return XIVE_BAD_IRQ;
>   	return xive_ipis[early_cpu_to_node(cpu)].irq;
>   }
>   #endif
> @@ -1132,8 +1134,7 @@ static int __init xive_init_ipis(void)
>   	if (!ipi_domain)
>   		goto out_free_fwnode;
>   
> -	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids,
> -				 GFP_KERNEL | __GFP_NOFAIL);
> +	xive_ipis = kzalloc_objs(*xive_ipis, nr_node_ids, GFP_KERNEL);
>   	if (!xive_ipis)
>   		goto out_free_domain;
>   
> @@ -1158,6 +1159,7 @@ static int __init xive_init_ipis(void)
>   
>   out_free_xive_ipis:
>   	kfree(xive_ipis);
> +	xive_ipis = NULL;
>   out_free_domain:
>   	irq_domain_remove(ipi_domain);
>   out_free_fwnode:
> @@ -1190,6 +1192,9 @@ static int xive_setup_cpu_ipi(unsigned int cpu)
>   
>   	pr_debug("Setting up IPI for CPU %d\n", cpu);
>   
> +	if (xive_ipi_irq == XIVE_BAD_IRQ)
> +		return -EIO;
> +
>   	xc = per_cpu(xive_cpu, cpu);
>   
>   	/* Check if we are already setup */
> @@ -1234,6 +1239,9 @@ noinstr static void xive_cleanup_cpu_ipi(unsigned int cpu, struct xive_cpu *xc)
>   
>   	/* Disable the IPI and free the IRQ data */
>   
> +	if (xive_ipi_irq == XIVE_BAD_IRQ)
> +		return;
> +
>   	/* Already cleaned up ? */
>   	if (xc->hw_ipi == XIVE_BAD_IRQ)
>   		return;


