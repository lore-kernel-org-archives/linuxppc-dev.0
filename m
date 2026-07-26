Return-Path: <linuxppc-dev+bounces-24838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DFCC531F9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Jul 2026 10:55:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7JXl0Xnbz2xyk;
	Sun, 26 Jul 2026 20:55:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785063318;
	cv=none; b=dBgCy5QvBB3mEjHlXq0ru5QcPEyGMZKIEGZI7X/f7uT26doCm3TAtg9BVPSd+sJHAwPYjkXcpNXzcqknZyhMqTTe6iwo52iRdmw8/tmtQhgAC/GPbjBhi2f/cQJc9x/DL36DH7qnDvjFbMxWXuFhHqFRE19VKik8w/c8gYFIh5vRo5XbRzdkBndoQWDLAVgBqhh9btb8ldMOAaD+ho0khTFrKlZZj2a0CaSpIwVv2uyT76RpLD7t9914LI2qbTGx8iw8xoKQWooHjkBPKWqCD10xj2VmT1Ievfb3oGQdnNnj58iqvYKN0ouNUM8HIlp0JkHLXbPvPCd23uGovxcZCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785063318; c=relaxed/relaxed;
	bh=TVQiQ6GJzlMIZwPFREBVoOZjG80dXj2ZyjsEnnlKM94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9BTZxG9fxDlZoUH8L57HW4hk+WH8Z+XwOFxsVo4ssVozS42B/dl6wAf1BcOPVSyjGgW4McaMeM5v3AEUeLk2jjBpSGNWI0iO/o+t8ZM3gKtakECdTjWWsHFuL3riDl38f0x5zESmtB0xULM7D+f/FCjuY+EiJ8h/9FQ4/qi9znx221F49acSDwtOfcujjjW7t/ySzXrd/u1jO+v9/KlOGMnfJtS+91Jq18REewrmQ9s0NqMSN6h7d9W0UYAgjpj6pr+8a0afz3TnkQ7CbO/74O8fA31icaXvNC4xOvE/4juzz0IT/OrovbnAScVRyZRI5iBz++6jgBtFJQTma9y4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BN4RwIbj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BN4RwIbj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hbathini@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7JXj5nJTz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2026 20:55:16 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66Q8HoVP1106228;
	Sun, 26 Jul 2026 10:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TVQiQ6
	GJzlMIZwPFREBVoOZjG80dXj2ZyjsEnnlKM94=; b=BN4RwIbjI24Pn+3ikBwlmb
	/9nVMcTHKLwf+NSoR2iHM40D1l8kjxTuzJDUhOeRibNeP5QiAS3O2LRnlVgkBQt6
	ztKdfa9jX3WK6sNZs+jnlx0YWJ3f7ioSR/R92r4pv1o52yKqQOLY59b36Il9BQJA
	E+9vPMm36mMK4s9IMDo2RCpjF8eafM8dukSxjPNhGLy0tH3YqyZe5NmzUOhS9YpW
	8i9ClU6OBfsU/+DFBqn5+wpIIQtJm+fwgJ3TxHJZtoKLi0YVcE6Y3gq9ozzbTti2
	O0NyDW9nfZgeVyl3J95ZUv9izw6ufxlW5TdE+A7IVfaFVbsTMwl4h3jWMjRPMulg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc3b0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 10:54:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66QAfW4L031319;
	Sun, 26 Jul 2026 10:54:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xs1fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Jul 2026 10:54:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66QAssnA51970420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Jul 2026 10:54:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3479E20093;
	Sun, 26 Jul 2026 10:54:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF1A720092;
	Sun, 26 Jul 2026 10:54:40 +0000 (GMT)
Received: from [9.124.223.5] (unknown [9.124.223.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Jul 2026 10:54:40 +0000 (GMT)
Message-ID: <ad7e2f73-d3c6-4696-b596-9c1c1da05a9f@linux.ibm.com>
Date: Sun, 26 Jul 2026 16:24:39 +0530
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com,
        shivangu@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com
References: <20260708143357.673251-1-sourabhjain@linux.ibm.com>
 <20260708143357.673251-2-sourabhjain@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260708143357.673251-2-sourabhjain@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ioFTjGHh6dpN31l5t0EsRPMi3inWEqLT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI2MDEwNyBTYWx0ZWRfX4XbJGokym4wV
 TL1jO3Dkg+5qfFMpGelhWaZK/uNRKG6nLpidzsxMdO3YO72rvVUGz9nyeJvit2HoXWEJ0IX3BR+
 IJBtQhz/b3zxt7jz0PbifxGHnVCO5DPPcw6YHRvrBQg3wAHr3ZlXERG+l4OjzLQhe6Bcv7iw32x
 XXlT+Cnjo//ui9+9YG/e8Jvt2us16nfcPTXJNNdFE0RCElVNqXFjx0p8/30gO9CBhSCLSmjcXNe
 WeheDo3fVTF13YG8zIjJsdj59rTQ3UCLq/a37oP7QBCeVtTO2FjYnhsg1CjRXwePuUKgVFARqpK
 1y8LX3x7OzDkhpoBQTdh8/tQZc8U8iMicJJ/eqT+SRIw4R2ycwTqjjRHe6EtgZj8W3+L1Il9AAn
 RfDSjE0zk4YXfMMg4GDwLNbNKWV4YWfTmGjW9kos3TSOtNY/sM5a/8QTR4SUbDdV33fcnxW538G
 k44wQm5xbco2d6BKXMA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI2MDEwNyBTYWx0ZWRfXwyhklBb7Hymw
 dnkTjWzEKL/TtSupXNrf01/XePnG2zovytnZU668VsxuM6N37KfiLh39k0COeDsTECIXRkT8yYR
 gUL5vg98UszuQBlB+L+ZvgrfMJMgw5Q=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a65e783 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=DU61bVZrTOL0X21X56gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m5bEhSaEHQdQqE9T6EcwqakK4Se19wWW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-26_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607260107

Couple of minor nits below..

On 08/07/26 8:03 pm, Sourabh Jain wrote:
> Crashkernel reservation on high memory depends on the MMU type, so
> finalize the MMU type before calling arch_reserve_crashkernel().
> 
> With the changes introduced here, early_radix_enabled() becomes usable
> and will be used in arch_reserve_crashkernel() in the upcoming patch.
> 
> early_radix_enabled() depends on cur_cpu_spec->mmu_features to find
> out if the radix MMU is enabled. The radix MMU bit in mmu_features is
> discovered from the FDT and kernel configs. To make sure the MMU type is
> finalized before arch_reserve_crashkernel() is called, the function that
> scans the FDT and sets mmu_features, along with some bits from
> mmu_early_type_finalize(), has been moved above
> arch_reserve_crashkernel().
> 
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/mmu.h |  1 +
>   arch/powerpc/include/asm/mmu.h           |  1 +
>   arch/powerpc/kernel/prom.c               | 28 +++++++++++++-----------
>   arch/powerpc/mm/init_64.c                | 27 ++++++++++++++---------
>   4 files changed, 34 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 48631365b48c..7a3b2ff02041 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -208,6 +208,7 @@ extern int mmu_vmemmap_psize;
>   
>   /* MMU initialization */
>   void mmu_early_init_devtree(void);
> +void mmu_early_type_finalize(void);
>   void hash__early_init_devtree(void);
>   void radix__early_init_devtree(void);
>   #ifdef CONFIG_PPC_PKEY
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 5f9c5d436e17..c40dc6349e55 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -384,6 +384,7 @@ extern void early_init_mmu_secondary(void);
>   extern void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>   				       phys_addr_t first_memblock_size);
>   static inline void mmu_early_init_devtree(void) { }
> +static inline void mmu_early_type_finalize(void) { }
>   
>   static inline void pkey_early_init_devtree(void) {}
>   
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 9ed9dde7d231..db1615f26075 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -853,6 +853,21 @@ void __init early_init_devtree(void *params)
>   	if (PHYSICAL_START > MEMORY_START)
>   		memblock_reserve(MEMORY_START, int_vector_size);
>   	reserve_kdump_trampoline();
> +
> +	DBG("Scanning CPUs ...\n");
> +
> +	dt_cpu_ftrs_scan();
> +
> +	/* Retrieve CPU related informations from the flat tree
> +	 * (altivec support, boot CPU ID, ...)
> +	 */
> +	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
> +	if (boot_cpuid < 0) {
> +		printk("Failed to identify boot CPU !\n");
> +		BUG();
> +	}
> +

> +	mmu_early_type_finalize();
>   #if defined(CONFIG_FA_DUMP) || defined(CONFIG_PRESERVE_FA_DUMP)

Please add a blank line here

>   	/*
>   	 * If we fail to reserve memory for firmware-assisted dump then
> @@ -884,19 +899,6 @@ void __init early_init_devtree(void *params)
>   	 * FIXME .. and the initrd too? */
>   	move_device_tree();
>   
> -	DBG("Scanning CPUs ...\n");
> -
> -	dt_cpu_ftrs_scan();
> -
> -	/* Retrieve CPU related informations from the flat tree
> -	 * (altivec support, boot CPU ID, ...)
> -	 */
> -	of_scan_flat_dt(early_init_dt_scan_cpus, NULL);
> -	if (boot_cpuid < 0) {
> -		printk("Failed to identify boot CPU !\n");
> -		BUG();
> -	}
> -
>   	save_fscr_to_task();
>   
>   #if defined(CONFIG_SMP) && defined(CONFIG_PPC64)
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index 64f0df5bb5cd..2fd533bc17cc 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -614,8 +614,10 @@ static void __init early_init_memory_block_size(void)
>   	of_scan_flat_dt(probe_memory_block_size, &memory_block_size);
>   }
>   
> -void __init mmu_early_init_devtree(void)
> +

> +void __init mmu_early_type_finalize(void)
>   {
> +

Please remove this extra blank line

>   	bool hvmode = !!(mfmsr() & MSR_HV);
>   
>   	/* Disable radix mode based on kernel command line. */
> @@ -626,6 +628,20 @@ void __init mmu_early_init_devtree(void)
>   			pr_warn("WARNING: Ignoring cmdline option disable_radix\n");
>   	}
>   
> +	/*
> +	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
> +	 * When running bare-metal, we can use radix if we like
> +	 * even though the ibm,architecture-vec-5 property created by
> +	 * skiboot doesn't have the necessary bits set.
> +	 */
> +	if (!hvmode)
> +		early_check_vec5();
> +}
> +
> +void __init mmu_early_init_devtree(void)
> +{
> +	bool hvmode = !!(mfmsr() & MSR_HV);
> +
>   	of_scan_flat_dt(dt_scan_mmu_pid_width, NULL);
>   	if (hvmode && !mmu_lpid_bits) {
>   		if (early_cpu_has_feature(CPU_FTR_ARCH_207S))
> @@ -638,15 +654,6 @@ void __init mmu_early_init_devtree(void)
>   			mmu_pid_bits = 20; /* POWER9-10 */
>   	}
>   
> -	/*
> -	 * Check /chosen/ibm,architecture-vec-5 if running as a guest.
> -	 * When running bare-metal, we can use radix if we like
> -	 * even though the ibm,architecture-vec-5 property created by
> -	 * skiboot doesn't have the necessary bits set.
> -	 */
> -	if (!hvmode)
> -		early_check_vec5();
> -
>   	early_init_memory_block_size();
>   
>   	if (early_radix_enabled()) {

- Hari

