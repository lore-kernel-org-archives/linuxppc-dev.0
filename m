Return-Path: <linuxppc-dev+bounces-26910-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7710C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 09:46:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfwtg3CDxz2yqd;
	Wed, 09 Sep 2026 19:46:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788947195;
	cv=none; b=U4Y4Evii2niweuy8p5zqfgFJrn70jABktcSs4kuqlN18Kud/x9rQfxrCqURrvQOOU9rfvxzDJuUjIK/QrCACJb8K9mWLo53s6tqCU84LD1n31DvKOFrfNPlOHxS2amY1GAvdZXaXqOVdP/rcr00IovOoou1oh7jr3sfxPG627lzMkyE1rV6mG1N0JUwBQn8H0ku8tS89SWMHR22bMavMGliReNfOyGdwIQtke93VZjVGSPakeFt53D5+P6n3f9RMBOMFJbFLYT6IH+EFmzFpdXjgF+H+5RvtwH1RUq0eLVCSSMIcC6au2nEio4pGNvV9RdJU0xPDWAo60PlihONA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788947195; c=relaxed/relaxed;
	bh=q3I0iZvzNz2prALlgCWydDc+MG0Yp57hBuPUjrFvD6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXrwWy88ZcYnmCu389fUY9G6i/Wo94iTSKVdJ69bT6aQNMEHfr1rRUp1ZZY5PinndqHu2XMtToBvO9RyiM2ajT8brEhri/msCNwQ1OigDJ+6eZ0jWBnHIClo5B6lI/1HTezL1oDMZUwI4xf7i7+0YpeDt0Z7E6JKG1+ZeExRo8bSTnXux8bS190rqsEI1yrJI4UfbUQ/XGHYkKK+NiOIvhs1C5V/MHhy4zFYEnQ+CZJQpC5VW+2IpJmDzqoFBgTMWZ/nu+fhw49tHXTzXa6Iuncocwff7+2rIGTDkFAFhjnZeI6eKwTu26gtkPsfF0sjJIpir0x27yb97PjNXgj1KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CrQfaw5X; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CrQfaw5X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfwtd3hzTz2ypw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 19:46:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6899UTdW1116734;
	Wed, 9 Sep 2026 09:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q3I0iZ
	vzNz2prALlgCWydDc+MG0Yp57hBuPUjrFvD6U=; b=CrQfaw5XZV/y16z3FiwF6u
	0jpb2pRMVJ/7Ma0mbx6a+n6Lx4vWylil1Aw/7MbQbmh2y+fK4umF0uxvrD5G95RK
	91KCh3Nbp+qOpqPNT7kqnavamFlWf98O1W/ED3z9cKB1p3IJFEHFu4U2onetZNI0
	EhP+KDxnt/v/zDqrLwFFcsp+uaN3NcvCEvCHl+ccdGmP/NDQu1rKXREiLpt/hR0S
	s4/CIiJjLhDE40gn/ipnS7AvXRGmSnaCv2a4yGWzAQOvqHOGB/aHhn2pJ7LGdWYo
	X3OZNjS+Q3ctcq/bvOcze3MdchK6sV5zy1aLXVxccHXVJi04/MZR4ZNRIA38XMvA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrvpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:46:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6899fEoq007344;
	Wed, 9 Sep 2026 09:46:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw9mcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:46:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6899kD2M45089048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 09:46:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504D620043;
	Wed,  9 Sep 2026 09:46:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 248A220040;
	Wed,  9 Sep 2026 09:46:10 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 09:46:09 +0000 (GMT)
Message-ID: <d33d0d1b-1532-495e-a299-518bdb905baf@linux.ibm.com>
Date: Wed, 9 Sep 2026 15:16:08 +0530
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
Subject: Re: [PATCH v2] powerpc/interrupt: Use early_radix_enabled() in NMI
 real-mode guard
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, mkchauras@gmail.com,
        ruanjinjie@huawei.com, ritesh.list@gmail.com, riteshh@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20260909091219.55380-1-venkat88@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909091219.55380-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa12aea cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=yEGRqZUKW7_d8LT8WiEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfX8+heKboGEGVC
 rNVaOeTWaH48kU5DOiFGwCHfskFcxBDr2j/al2pKQ8EjlEPhkkKrfxImTxxrRT17q/n75Sp2CAR
 VTqHquUxEym2roRB6D+MvyY8z5hoInI=
X-Proofpoint-ORIG-GUID: cQnWFzLkItH_PGutJZGZLVB9srtQfG39
X-Proofpoint-GUID: PkhBzffNHXQhGVFdYQsAUQF3XU9z4EYF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwNiBTYWx0ZWRfX/DyIGPwelLVB
 1YPbBYHj4Q1x70Z5+GtlMPH3X43ME5TC8bta3lzMuxLFWF3ltxG78HAu1FCt7kYEi00VOHJEqyr
 ynKjiw3CQNgNHtdUwrdAijxKgO2vtLdMeRBRq5O1zoRMnZMaP2RRpt+j/leEsip1Sq7ueehWGzX
 VqNlEASJZDuXBcqIgFNjz/ZBphrrGo3WdfACC9WHl462OT+xg9SsMucupvoSb2DHcL9Gw1PHmXd
 TIqYOyFXMNJA4mMO3Zb8mB6l11rlsBvu/DUB3rbs8YXp2x24gABYnBTKmIp/IIwrmkRwmLqu8XB
 rKpJkuyUZAdhGSQfegpPEWbOFValijddEjj7J6kA4VTjtZK6CZ2+p0jucF9BwaIFlYAj8mQkJER
 fLuY9AmhmA9I2T1gWja/c4V86cXyOTJWWXW5fy0X7UePAdc9K+nBcdtL8A+5xP3Ch6alxz7hrSl
 aKu8+VE77JeCJ8nv59Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090106



On 9/9/26 2:42 PM, Venkat Rao Bagalkote wrote:
> radix_enabled() uses a jump label which is only valid after
> mmu_feature_keys_init() is called. Before that point, on a pSeries
> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
> cur_cpu_spec->mmu_features but the jump label has not yet been patched,
> so radix_enabled() incorrectly returns true.
> 

The usage window where it goes wrong is:

early_setup:
	configure_exceptions();
	<exception can happen now, and could prepare/exit of corresponding exception>
		<those could use radix_enabled() >
	setup_feature_keys();
	<jump labels are setup and post this it is safe to use radix_enabled()>

But since common wrappers don't have the context of early or late,
using early_radix_enabled() is safer option.

Commit message could convey the same.

> Replace radix_enabled() with early_radix_enabled() which does a plain
> bitmask check against cur_cpu_spec->mmu_features and is correct at all
> times, including before jump label initialization.
> 

If you have data, please put the values of both early_radix_enabled and radix_enabled()
in hash/radix guests in the chaneglog to ensure replacing with early variant
is functionally safe.

> Add the missing #include <asm/mmu.h> since early_radix_enabled() is
> declared there.
> 
> Fixes: 8d0e21012743 ("powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash")
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reviewed-by: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
> ---
> v2:
>   - Added Fixes: tag referencing commit 8d0e21012743.
>   - Included <asm/mmu.h> in alphabetical order.
>   - Added Reviewed-by tag from Mukesh.
> 
>   arch/powerpc/include/asm/interrupt.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
> index 1b45a49e9bed..355f6bbf9894 100644
> --- a/arch/powerpc/include/asm/interrupt.h
> +++ b/arch/powerpc/include/asm/interrupt.h
> @@ -70,6 +70,7 @@
>   #include <linux/irq-entry-common.h>
>   
>   #include <asm/kprobes.h>
> +#include <asm/mmu.h>
>   #include <asm/runlatch.h>
>   
>   #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
> @@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>   		state = irqentry_nmi_enter(regs);			\
>   	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>   		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>   		/* no nmi_entry for a pseries hash guest		\
>   		 * taking a real mode exception */			\
>   	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
> @@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
>   		irqentry_nmi_exit(regs, state);				\
>   	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
>   		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
> -		   !radix_enabled()) {					\
> +		   !early_radix_enabled()) {				\
>   		/* no nmi_exit for a pseries hash guest			\
>   		 * taking a real mode exception */			\
>   	} else if (IS_ENABLED(CONFIG_KASAN)) {				\


