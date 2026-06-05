Return-Path: <linuxppc-dev+bounces-22122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00569CD6E5D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2026 11:03:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWz7j25XDz2yR5;
	Fri, 05 Jun 2026 21:03:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780657409;
	cv=none; b=OBGMuYtrIJG344DZ7auOhJuI2Y1KAESSwuGmwLxLKLpiQzhDZDKyE3baSHAtdKEGSDIcByLwx3U8TdERv7Jydse+Ysmyy9ETe4UiIJUQKw9/crM+jG/626wTZWlFneUoBYXuRR9HvleGltVUF+2djyBqsK3g4mGL3gk6ECpx05X6XIl2PUJ1Dz+qjWVlHa7A0Zuv/Fcf7PbWpjE/NdkjCeeGtP25uVqX04+IvUqGTB9kz6c4P1b70tvt8A656p5l/aPp43hqwDKp/uyzThNkoRkG1XuOR1qx3jQ9UDsjY4oGYdGw2FVvNAmywCJp1qrVpKu/6Wl6TZ3bLgrsT+loOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780657409; c=relaxed/relaxed;
	bh=m/XsNeSw3F0vmZgJ2HjnIFpoWpeN+TgH303IruEhpdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6P74ATqboNobxNP1wbQdnsYOdQA5jpHsu4gkIKv2Ca+YbvUKLXtVUoDfF8rYLeFLcKuCeawD4xYU8sT7WAK+N3hXZt7Q3jBXnEcrovtGHqVJQ+dxThd7ROMYhdl7nBRV+SNQVusgn/4bdXs1smmSr1/O4ZPum3dHPPAswoRgryrEP+ZyxIFfh0fmvX94iGFXWHsYLmSxxUwEUJbv5oJ0EAv6Onh3xsB7S3B4xO4F1Hi24kKfHEs+gXMfcyDEn7kChltD3syGnSaBbcreBr7uIAay7+Gf+c8o1vWZn2Lq/W23ZvVj1+sZWhOEyCKAWnHiStLPUeAcui2aW92LET9eA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDjwkm31; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LDjwkm31;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWz7g5CDJz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 21:03:26 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6551GJof2252299;
	Fri, 5 Jun 2026 11:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m/XsNe
	Sw3F0vmZgJ2HjnIFpoWpeN+TgH303IruEhpdQ=; b=LDjwkm31cEMgWTAeBDKY6x
	CSlXmfGkkjLsiqVc+7CrSmZUKdl7l1JYz6ciGsdXHX457zVU1pvrMiVZoiOIipAw
	rS6Za6ARXJ2L9TagECSsQWah2/XOSo6AOR/t8r6/LNw+00dj/Th7rMA5MdINocN4
	NTmTKD7M6j/oo2kmen7obC8fHj3P54sSONoCGBTt/EzMH+LZvywG/N4hk7itUtCY
	jwU91T3M9cbISzKDfU/kKM5OvWI0eSgoIPPl/A0xGCAP9YxYW3DPhc1IoKqedoN9
	ZBlgrM0F9Qb19ZJk2immXloID5uHjKIotyqyU3wdBt+Oakl4FKMAdC7ttQ3Z+29g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaekduw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 11:03:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655AsCNw022731;
	Fri, 5 Jun 2026 11:03:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw9e80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 11:03:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655B3GEM53936484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 11:03:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A6E20040;
	Fri,  5 Jun 2026 11:03:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D06720043;
	Fri,  5 Jun 2026 11:03:14 +0000 (GMT)
Received: from [9.124.210.124] (unknown [9.124.210.124])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 11:03:14 +0000 (GMT)
Message-ID: <e99487c8-4630-4a44-adca-71d903ec73af@linux.ibm.com>
Date: Fri, 5 Jun 2026 16:33:13 +0530
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
Subject: Re: [PATCH v3 3/3] powerpc/kexec: fix double get_cpu() imbalance in
 kexec_prepare_cpus
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
References: <20260605082912.305100-1-aboorvad@linux.ibm.com>
 <20260605082912.305100-4-aboorvad@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260605082912.305100-4-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a22acfa cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4Mgw-qLUzwkOAoDCUjgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: mwTgiquZfYir4X_KVp-udbWubyUiHGAl
X-Proofpoint-ORIG-GUID: _5-FPPzLGBH_tRLZL_vtcm8UUt5wYuD-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDEwMyBTYWx0ZWRfX/DlKbqScL15A
 tw7pvw4ZXHB39wzmZw5V+FIcufClGechE+GbnJ7vo1DrhvBgkT8f8KaMZVxI/cEQdUrZhaqR/s3
 C9T7yEX8SS/U0rdmwKmYA0pXAJe3V63hAN70sbrCjo0oSrWqF9wJmtn87KvDnErh1OwTzYrfOCn
 z/lfJzLZKSc+9oHu+tqENGI6AD+w8wN4hUmi4tMzw0K0iLqgu/5+VzHqM7tGU9ZyfvyGZq38WN6
 /NtN3Hs9lfYXEu7kd2yXq8kjEm5nd+kEQbpL2degPOfajLROzeQI08Qy7qeHBlJmWQgvX22F19h
 ic1Az1ENacCJlGJ45M91b8BT1iI+vBVZuC+ytMMLkwXAnVHOI0yJ1jcJ01pGzlSeDtpba7gNmvh
 pLKAXx8eJSEUMWQEYMS30d7u4ioAV7FlgcJfBL4fGwnc26pK226JO0ZU2tQDjUR3UpiUUGAOfgh
 Xh2I6G5d5OyuwDTJuGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050103



On 6/5/26 1:59 PM, Aboorva Devarajan wrote:
> kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
> current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
> twice -- once for KEXEC_STATE_IRQS_OFF and once for
> KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
> leaving preempt_count elevated by one extra nesting level.
> 
> In practice the imbalance does not trigger a 'scheduling while atomic'
> splat because the kexec path is a one-way trip: IRQs are already
> disabled, no schedule() occurs after the leak, and
> default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
> before jumping into kexec_sequence() which never returns. However the
> bookkeeping is still wrong.
> 
> kexec_prepare_cpus() calls local_irq_disable()/hard_irq_disable()
> before invoking kexec_prepare_cpus_wait(), so the CPU is already pinned
> and the get_cpu()/put_cpu() preempt_disable() bracketing is unnecessary.
> Only the current CPU id is needed, so replace get_cpu() with
> raw_smp_processor_id() and drop the now-unneeded put_cpu().
> 
> Fixes: 1fc711f7ffb0 ("powerpc/kexec: Fix race in kexec shutdown")
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   arch/powerpc/kexec/core_64.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
> index 825ab8a88f18..58c13a59b93b 100644
> --- a/arch/powerpc/kexec/core_64.c
> +++ b/arch/powerpc/kexec/core_64.c
> @@ -169,7 +169,7 @@ static void kexec_prepare_cpus_wait(int wait_state)
>   	int my_cpu, i, notified=-1;
>   
>   	hw_breakpoint_disable();
> -	my_cpu = get_cpu();
> +	my_cpu = raw_smp_processor_id();
>   	/* Make sure each CPU has at least made it to the state we need.
>   	 *
>   	 * FIXME: There is a (slim) chance of a problem if not all of the CPUs
> @@ -267,8 +267,6 @@ static void kexec_prepare_cpus(void)
>   	/* after we tell the others to go down */
>   	if (ppc_md.kexec_cpu_down)
>   		ppc_md.kexec_cpu_down(0, 0);
> -
> -	put_cpu();
>   }
>   
>   #else /* ! SMP */


Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

