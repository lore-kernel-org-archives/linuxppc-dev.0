Return-Path: <linuxppc-dev+bounces-25220-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC2AC5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 03:45:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD2cz5hmyz308Y;
	Mon, 03 Aug 2026 13:45:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785728723;
	cv=none; b=YHR+xg/DZH/hgUL3AShYuMO+1xSwvWwkZ9dwPRxHZguuXiqb2T+MGuRfN/8d19ZnifIDDlQe3asuMeHofypprgTUNE1kJIO8YSlKwyoyGuYNBH9uOIdj6RdDmrhG3CnIQxOlRgVrtdQd7j4lKGXSst6YiIv65K5Th1kqJkCoNREL9/oA0Uhskc0cjNjXzEFdvi0j3eQc70PXE+afEGPdJvq/lUy2+OGFeClxpGrhPB1TVT9GTSLUDJ1HQny7g/Wv4N1WMyFJ0lgoILNeyxq88ttETtkQ0A0ZZeU62fvOqwpBJ0u/jaEposWIfgh1+JyfRSRq/vbPxpS4ydcoMIVDig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785728723; c=relaxed/relaxed;
	bh=SxUg8kroSPRsbNzaGy2KMwTrNv8AwH9EDDpaw4WjsyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfgk01kBFFoHJMSbT8mwfONaM6o02xv9D7I5yvBC72l5DJd3ki7EgkK4D3NmeQkK2jfD5ea7FIV0W+Q6lMjRF7+plYRacG5F6hG6HBWjaItl6lbvbZc42WgX+tGQg7mVEKxHLSc79QDcwjpxNuk131rzY05krpGAWnGl69tmxup63MoOxBmqRsIUSEflkJoekkDMEjo/ZEEzqb+MtP/sfsABaSwC/67hg0TG66yRz9o9AvmECdaLz3B7Ax0zYWvr/Dj6dY0VQBnqkUwyZTwMjOJcpOdBJR/wG/bzp+SBz+zJwmbRtymxPtM+vumIDap8UwiG/SfpS/SnN9Z5mCC8fA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lf+UJGbJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Lf+UJGbJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD2cy6yVDz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 13:45:22 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm2e4160544;
	Mon, 3 Aug 2026 03:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SxUg8k
	roSPRsbNzaGy2KMwTrNv8AwH9EDDpaw4WjsyI=; b=Lf+UJGbJmhGv89gzcm0R7I
	tfho2ep9CEcg2lVRiskJn22JkM3NR7vpisrcLlGDZn9V9MH8I9zZsnUTjeX2OoOs
	/IETcIzZbi4G+uQ7kQcT1jfpJa8vRcogorMqGuvCNVYa+vyNlraCB7PxOgc5jA+H
	/A0cKSR1kmZlJvkrmvApLt4lA6umCpxNq5tD7cVF+COQl7dFbYPj1d3qoWvVxT0Z
	oD77E30gYZadlOSzOYysr3xGkagHpF16RUPEBbYs9c2YGKvmGHPCv0R3762R2eIA
	b3vn2ZBrcWL++LQ1VVJhAou6GMng3eiRsFiY3UZhw9r+zW08FHpw6R/aP55NPc6w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hepcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 03:45:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6733fOId005272;
	Mon, 3 Aug 2026 03:45:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh3hjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 03:45:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6733j6Tt26083728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 03:45:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDCF72004B;
	Mon,  3 Aug 2026 03:45:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8123E20040;
	Mon,  3 Aug 2026 03:45:04 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 03:45:04 +0000 (GMT)
Message-ID: <da03ca94-d602-42d3-a0ae-7c7ee63a6b38@linux.ibm.com>
Date: Mon, 3 Aug 2026 09:15:03 +0530
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
Subject: Re: [PATCH v2 1/4] powerpc/mmu: do MMU type discovery before
 crashkernel reservation
To: Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
 <20260708143357.673251-2-sourabhjain@linux.ibm.com>
 <ad7e2f73-d3c6-4696-b596-9c1c1da05a9f@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ad7e2f73-d3c6-4696-b596-9c1c1da05a9f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX4ZNDXozTtUXF
 zW/aBCTDn84Ayl5nPnFB38rTrLJsRkyrQWR24kZGBUxZAWoa7UNCtc2cBjz7Zyna9Z6Bnv+YRDt
 dtv0Do31bWupAYThRjwsUhrkbaeAd6c=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a700ec8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=jrqVSdEm-Vtbd_SVNe8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAyNSBTYWx0ZWRfX0l8TIpSASMaQ
 JQiQb1J3APzjD6Ew+ycuQrj6j0pXxjQ18Ula5zl4X2q3TInAD0PGFsbRlLYyWgSSWARGVKDYPEQ
 qgc/WIh5JuBBIR1F8+XLJZXN9ttmZHfK63JdVnGko6nJ9OClczkMspNj0MD/S+JWLe5xPiMy/mB
 rwwfI4e/NLZ32S6p2qoDdbEPNDtHaV2g1FxYxxjuEP1ZF2LdZqdFSv0K52EvINPb5H0Wjke71eh
 Y8yrcctEv0os5Ew36+YoIIQr9E+BKkm2IT3CE7cWSdIi+mhEYHOySMtc3cOQvyEqVHg45sBEEWq
 l02vJleC84yMka3liUVcw1v1zO1TkoS7l0mtv7V0dDE0lcwydvzG7/S1IENujAXhZrysLHqAPdc
 2VRg6L5J89VGA3TBHtbSPA4WX9pPS145+hDMWigmB5ldcoJOaTGitQhUHffuxRH6+5nZqBm07SZ
 Xaa6RZsT3lt/zxm7jUw==
X-Proofpoint-ORIG-GUID: M2upJzdIs9Aqz9o6RuYTSpJtmXqEqvo3
X-Proofpoint-GUID: Kz1DTIiekQnFUx58BwFbzKMmWmBT16kV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030025



On 26/07/26 16:24, Hari Bathini wrote:
> Couple of minor nits below..
>
> On 08/07/26 8:03 pm, Sourabh Jain wrote:
>> Crashkernel reservation on high memory depends on the MMU type, so
>> finalize the MMU type before calling arch_reserve_crashkernel().
>>
>> With the changes introduced here, early_radix_enabled() becomes usable
>> and will be used in arch_reserve_crashkernel() in the upcoming patch.
>>
>> early_radix_enabled() depends on cur_cpu_spec->mmu_features to find
>> out if the radix MMU is enabled. The radix MMU bit in mmu_features is
>> discovered from the FDT and kernel configs. To make sure the MMU type is
>> finalized before arch_reserve_crashkernel() is called, the function that
>> scans the FDT and sets mmu_features, along with some bits from
>> mmu_early_type_finalize(), has been moved above
>> arch_reserve_crashkernel().
>>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
>>   arch/powerpc/include/asm/mmu.h           |  1 +
>>   arch/powerpc/kernel/prom.c               | 28 +++++++++++++-----------
>>   arch/powerpc/mm/init_64.c                | 27 ++++++++++++++---------
>>   4 files changed, 34 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h 
>> b/arch/powerpc/include/asm/book3s/64/mmu.h
>> index 48631365b48c..7a3b2ff02041 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
>> @@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
>>     /* MMU initialization */
>>   void mmu_early_init_devtree(void);
>> +void mmu_early_type_finalize(void);
>>   void hash__early_init_devtree(void);
>>   void radix__early_init_devtree(void);
>>   #ifdef CONFIG_PPC_PKEY
>> diff --git a/arch/powerpc/include/asm/mmu.h 
>> b/arch/powerpc/include/asm/mmu.h
>> index 5f9c5d436e17..c40dc6349e55 100644
>> --- a/arch/powerpc/include/asm/mmu.h
>> +++ b/arch/powerpc/include/asm/mmu.h
>> @@ -384,6 +384,7 @@ extern void early_init_mmu_secondary(void);
>>   extern void setup_initial_memory_limit(phys_addr_t 
>> first_memblock_base,
>>                          phys_addr_t first_memblock_size);
>>   static inline void mmu_early_init_devtree(void) { }
>> +static inline void mmu_early_type_finalize(void) { }
>>     static inline void pkey_early_init_devtree(void) {}
>>   diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 9ed9dde7d231..db1615f26075 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -853,6 +853,21 @@ void __init early_init_devtree(void *params)
>>       if (PHYSICAL_START > MEMORY_START)
>>           memblock_reserve(MEMORY_START, int_vector_size);
>>       reserve_kdump_trampoline();
>> +
>> +    DBG("Scanning CPUs ...\n");
>> +
>> +    dt_cpu_ftrs_scan();
>> +
>> +    /* Retrieve CPU related informations from the flat tree
>> +     * (altivec support, boot CPU ID, ...)
>> +     */
>> +    of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
>> +    if (boot_cpuid < 0) {
>> +        printk("Failed to identify boot CPU !\n");
>> +        BUG();
>> +    }
>> +
>
>> +    mmu_early_type_finalize();
>>   #if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)
>
> Please add a blank line here
>
>>       /*
>>        * If we fail to reserve memory for firmware-assisted dump then
>> @@ -884,19 +899,6 @@ void __init early_init_devtree(void *params)
>>        * FIXME .. and the initrd too? */
>>       move_device_tree();
>>   -    DBG("Scanning CPUs ...\n");
>> -
>> -    dt_cpu_ftrs_scan();
>> -
>> -    /* Retrieve CPU related informations from the flat tree
>> -     * (altivec support, boot CPU ID, ...)
>> -     */
>> -    of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
>> -    if (boot_cpuid < 0) {
>> -        printk("Failed to identify boot CPU !\n");
>> -        BUG();
>> -    }
>> -
>>       save_fscr_to_task();
>>     #if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
>> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
>> index 64f0df5bb5cd..2fd533bc17cc 100644
>> --- a/arch/powerpc/mm/init_64.c
>> +++ b/arch/powerpc/mm/init_64.c
>> @@ -614,8 +614,10 @@ static void __init 
>> early_init_memory_block_size(void)
>>       of_scan_flat_dt(probe_memory_block_size, &memory_block_size);
>>   }
>>   -void __init mmu_early_init_devtree(void)
>> +
>
>> +void __init mmu_early_type_finalize(void)
>>   {
>> +
>
> Please remove this extra blank line
>
>>       bool hvmode = !!(mfmsr() & MSR_HV);
>>         /* Disable radix mode based on kernel command line. */
>> @@ -626,6 +628,20 @@ void __init mmu_early_init_devtree(void)
>>               pr_warn("WARNING: Ignoring cmdline option 
>> disable_radix\n");
>>       }
>>   +    /*
>> +     * Check /chosen/ibm,architecture-vec-5 if running as a guest.
>> +     * When running bare-metal, we can use radix if we like
>> +     * even though the ibm,architecture-vec-5 property created by
>> +     * skiboot doesn't have the necessary bits set.
>> +     */
>> +    if (!hvmode)
>> +        early_check_vec5();
>> +}
>> +
>> +void __init mmu_early_init_devtree(void)
>> +{
>> +    bool hvmode = !!(mfmsr() & MSR_HV);
>> +
>>       of_scan_flat_dt(dt_scan_mmu_pid_width, NULL);
>>       if (hvmode && !mmu_lpid_bits) {
>>           if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
>> @@ -638,15 +654,6 @@ void __init mmu_early_init_devtree(void)
>>               mmu_pid_bits = 20; /* POWER9-10 */
>>       }
>>   -    /*
>> -     * Check /chosen/ibm,architecture-vec-5 if running as a guest.
>> -     * When running bare-metal, we can use radix if we like
>> -     * even though the ibm,architecture-vec-5 property created by
>> -     * skiboot doesn't have the necessary bits set.
>> -     */
>> -    if (!hvmode)
>> -        early_check_vec5();
>> -
>>       early_init_memory_block_size();
>>         if (early_radix_enabled()) {

I will address the above comments in the next version.

Thanks for the review Hari.

- Sourabh Jain


