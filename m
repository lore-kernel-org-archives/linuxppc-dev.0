Return-Path: <linuxppc-dev+bounces-26990-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4529C88E41
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 17:50:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg7cv2MSmz2yx5;
	Thu, 10 Sep 2026 03:50:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788976223;
	cv=none; b=gP45J4d9u9rVgShxQuONzbhjkeE4Hr2zsBRGuy1xMsrfuJ1n8xFcVsbiOj/czM1e8iXzIzAsHKcgdC4bTuH6uXlyzXHTnFdsO5L3BkfEPWMjRsqiwPT+Kd6L7yHxQLNO1/whgACD+1QQWQLOLlHxBUtorJmIK8/maLXQJ1lXsidiknicjxx5snApqhNMCVu0eU5dnCnza276XjhqVE+DBVvNRZSFXC/TlTtBnEzL3bMnH+vyWIKmy8U54bjAYLVgCEQxery7b3S/0dIZ1u+0qj81Z9wmI40DdrwQ/ru3b72JhCQPI6LjmhmtWD51pCXSmGdxhue31FN/plts+fkyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788976223; c=relaxed/relaxed;
	bh=vllDYnSPyYBC5MLdPMakBLcVa0f30Ab2JQe3/cgnTRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9/ciMvZTdCOsRuno1S/nwVwGHhvUj/FlQ4/ielMgkY/2vpigfN5q0AhD1q7hK5JoZJGFqTh9KFEwf2t1DYUj9WSFRZ7hyQNh5JRqD19wcsJ0JRCELw31sP9Ke9O/46CwIO/k0fsXfEmdylamBhcv/75bpfIu9WDV+2mPN6zLlxZuWHcJbpQ5lzbXSwRGKIl71x5K8EEbpMX436J8Nd3mJcrK4J0PudBkaBPkcV4w2hY0OAeCvPLl372anVWHQ1YT2qvHADQtikLcH4CJLxyQL/iWBbzsMS+XEuimxgwgwVLCVHeeXbZ8O5lst3qLU2opFf+wxmKT21eRaf2/0tDVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKs6NMnB; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKs6NMnB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg7cs4pXmz2ywy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 03:50:21 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689HVS0I458559;
	Wed, 9 Sep 2026 17:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vllDYn
	SPyYBC5MLdPMakBLcVa0f30Ab2JQe3/cgnTRo=; b=qKs6NMnBm7nwWI+VclHU2R
	+zyjK1BsZhieW+9x4EJpBUkx5iXQ7uj1tBxNlW0iuLYIme3OeGAhPyw2YM+iI4PJ
	GoKOnaubF1Aw/6aAiWIEKrK1nhy+kNln6riObTZy3bANCzYkBcG9fqHOf6nmygPX
	BD/w1cZt043lmUh0GGD6iabSsBFzByV/vM2+CFPQfn45aR2tw70LABTKqyvJpqkP
	018qEfVT5hkQ7U5Py8zjhKOpVkG6vsZhuBCJKkXysLyjojWeS0fjMckHkNPgql5L
	DmfxkxYV4i/4eII4K2w1db4on+glFg5b+4MjUNMNdruKpAZYH/tmjPTlDaYSZmTw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf47jj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 17:50:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689HfEb8013573;
	Wed, 9 Sep 2026 17:50:07 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswbt6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 17:50:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Ho1Li50528720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 17:50:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9952004B;
	Wed,  9 Sep 2026 17:50:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB6D20040;
	Wed,  9 Sep 2026 17:49:57 +0000 (GMT)
Received: from [9.124.210.73] (unknown [9.124.210.73])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 17:49:57 +0000 (GMT)
Message-ID: <8d45cfd1-55d0-4e8f-aac1-fae5c9c4d91c@linux.ibm.com>
Date: Wed, 9 Sep 2026 23:19:56 +0530
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
Subject: Re: [PATCH v3] powerpc/interrupt: Use early_radix_enabled() in NMI
 real-mode guard
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, mkchauras@gmail.com,
        ruanjinjie@huawei.com, ritesh.list@gmail.com, riteshh@linux.ibm.com,
        linux-kernel@vger.kernel.org
References: <20260909123240.58786-1-venkat88@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260909123240.58786-1-venkat88@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: le47yeovAKeL2kNIM8LlOwlNt8p9ry_K
X-Proofpoint-GUID: nB3Ltu30_QnBcjIpIuxP_UbWUcAWYPJw
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa19c50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=is8AelrDeVLTFk3XgSAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfX4uGBVpUR7ZgD
 XDqAtOVuNOlwrvA92FfWX3+T8JW09XJwahZY9XJ9JbS/YxiaK8Fd6qUCODA9P7oilZNRG9hfzmn
 u9t9MWSkTmPTytvhPWFH07kCjPKFVCYI7RAiwAaaRHAk4r2MNyNxWaoWIH/BYPFb6isq1vrN1/c
 1eOMOrTeZJ4vbu2DrMkXbBw3SX0v99foQooIgapVaayl0e/wJvtzbzzE7I5BJDP0VVyYbaC7Rf7
 BHKYoT8f49Wg3fF+PIKG/T8wsJRiOzEf0h2ewoGR6fO80PSAlbzYSZx+8h1W+Pu5COe8P5rfX3A
 UPG88t4vtAbadqSBFxpbuJCN7UtTN+Akrpi0ZdJ685ABy+FVcJmxcBNLeYplgR/esXpCVGwy3VJ
 YfAtig3fHwyAsuQN5Sl69t4/9jjfLMIh1b6tFzGVBEffHqYYJhBzcOp2dPSDq0tSsVecU8sgcUU
 HT1cdpfjWdnot0jhcRg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE5NSBTYWx0ZWRfXxFyTze+Ek32y
 8wszwQt368DhFK58AeOV4i02dijsfD5kaVlcPit7vl2gzTRqZf0+umGsbgrbmr3qea/9eB6LAVD
 oDrERc0nrX/Ka1bI+WfNQkbq8UolT6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090195



On 9/9/26 6:02 PM, Venkat Rao Bagalkote wrote:
> radix_enabled() uses a jump label which is only valid after
> setup_feature_keys() is called. Before that point, on a pSeries
> hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
> cur_cpu_spec->mmu_features, but the jump label has not yet been patched,
> so radix_enabled() incorrectly returns true.
> 
> The dangerous usage window where it goes wrong in early_setup():
> 
>      early_setup:
>          configure_exceptions();
>          <exceptions can happen now, and handler enter/exit can be invoked>
>          <those could use radix_enabled(), which returns stale true>
>          setup_feature_keys();
>          <jump labels set up; post this it is safe to use radix_enabled()>
> 
> If an NMI occurs in this window, !radix_enabled() evaluates to false in
> DEFINE_INTERRUPT_HANDLER_NMI. The handler fails to skip NMI entry in real
> mode and attempts to access memory outside the Real Mode Area (RMA),
> hanging the boot.
> 
> Since common interrupt wrappers do not have the context of early or late,
> using early_radix_enabled() is the safer option. It does a plain bitmask
> check against cur_cpu_spec->mmu_features and is correct at all times.
> 
> Console logs from a pSeries HASH guest showing values across boot stages:
> 
> [    0.000000] DEBUG: after early_init_devtree: early_radix_enabled=0 radix_enabled=1 (mismatch means NMI real-mode check is unsafe!)
> [    0.000000] DEBUG: after configure_exceptions (DANGEROUS WINDOW): early_radix_enabled=0 radix_enabled=1
> [    0.000000] DEBUG: after setup_feature_keys (jump labels initialized): early_radix_enabled=0 radix_enabled=0 (should now match!)
> [    0.057124] DEBUG: post secondary CPU bringup: early_radix_enabled=0 radix_enabled=0 (should match!)
> 
> Console logs from a RADIX guest showing values across boot stages:
> 
> [    0.000000] DEBUG: after early_init_devtree: early_radix_enabled=1 radix_enabled=1 (mismatch means NMI real-mode check is unsafe!)
> [    0.000000] DEBUG: after configure_exceptions (DANGEROUS WINDOW): early_radix_enabled=1 radix_enabled=1
> [    0.000000] DEBUG: after setup_feature_keys (jump labels initialized): early_radix_enabled=1 radix_enabled=1 (should now match!)
> [    0.057016] DEBUG: post secondary CPU bringup: early_radix_enabled=1 radix_enabled=1 (should match!)
> 
> Add the missing #include <asm/mmu.h> in alphabetical order since
> early_radix_enabled() is declared there.
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

> Fixes: 8d0e21012743 ("powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash")
> Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Reviewed-by: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>

Nit: I prefer to see Signed-off-by at the end.
But i guess b4 or patchwork tools take care of ordering. So i think
we are fine.

> ---
> v3:
>   - Clarified early_setup execution flow and race window in changelog.
>   - Explained why early_radix_enabled() is required for context-agnostic wrappers.
>   - Added console logs for both HASH and RADIX guests in changelog.
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


