Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98E606A31D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c7gYDkSV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9RT04rQrz2xwL;
	Fri, 23 Oct 2026 00:14:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792674884;
	cv=none; b=mpy8N8hFIGuwgiRyRgjT3htdODKzdRVPLFtr7OcFXOtFYBaHmnf1yFQLPrggtlVb3sbIDmo1yYZHW5JYrhp6mucazJrXHPzBQ8OrEk72ApUM+Yw3VZ2VPZocxUYPTwwLFY4l+pWOQnwsEbZJsqJZZ44sS4MLWnW53kRFbO0N2SUCqGerc3jXvjTsYob+rdLyemaoCJMUuAErLXsVJ3EJTh0a3bFq3v6aIGPKN4f+DWqdh0GEALRcPUkzgH7D9KMyb4sadE8SKiZF3U3eMO27IxSQmdn+XsOG5zwEwkqLKGm6EpOt/UoVEFmug/ENh1tKwHyydRcdG4wT4sqySqK01g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792674884; c=relaxed/relaxed;
	bh=OsUk0flsYcD+qNd05ZYTAkmrzmHYWzvjASs2678dOU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hvm4uu3cbnlgNxo0Ce9+LSIWYfLWEMIr+ElHWtVNI6RaaoszPsZkN+jEAorolz+sCFnTIe71FdpHVzMdYZdDImwdz9OcZKdiFWNhaRHKzmdGTDFMRRBLKC4AmayBubldzNExt4oYyn1tA07VwnOqrT94+J7Lwddjlk4fCYUe4scUqqB+l/InOE0uAwKY36nfBWXb+cRbSPV49dpv167GxnWf/vHfTe5+P2JRleTdLwLfFAbKkKORqCfdR/eVRDUwifkq0fr4f/MQPRgUwb62N7UJZWTyaWt5ZfJJDVO7pmRezxwttRrI8nNXcpPl47Fd090qOizOy5PvZ0UUEl8/Kw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c7gYDkSV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c7gYDkSV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9RSz1MHRz2xjh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Oct 2026 00:14:42 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MAE4kT2131556;
	Thu, 22 Oct 2026 13:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OsUk0f
	lsYcD+qNd05ZYTAkmrzmHYWzvjASs2678dOU0=; b=c7gYDkSVyXsEQgbbVcueyi
	AZpPvq/QtT7mfxvE51Opc2UDILlWORNKSYkmSvyFQzOckVGyJXQyefAJrCiIDlll
	Zl1iig3xhKo8yeUGAIw1wO8aTpXikOp893oWDt+eVrf1cLfx1M1TaURfV/NvC8bC
	r5lXonruh+SCVuqYkFW1duRvcQdFBpz62dcGLUfNm/WprfQBgJqtyhUzTMaB5wgM
	bV4evacAdY8ZWX4/iAikrm4xqbg5A7L4KbW0te+LwSGMN0hEGEadJpFGl3aRAnuu
	EFOcYC3l//CeWb/4EDQswKusxaIF0jpfjxFDfQT89WH1hkodY5kkSIihdiCyLFFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5bq84f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 13:13:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA4r7M285462;
	Thu, 22 Oct 2026 13:13:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bsa3gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 13:13:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69MDDl8r33424044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Oct 2026 13:13:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1765805F;
	Thu, 22 Oct 2026 13:13:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B312A58043;
	Thu, 22 Oct 2026 13:13:37 +0000 (GMT)
Received: from [9.67.119.174] (unknown [9.67.119.174])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Oct 2026 13:13:37 +0000 (GMT)
Message-ID: <95deeda1-9ccd-4423-9041-18731a8209de@linux.ibm.com>
Date: Thu, 22 Oct 2026 18:43:36 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kexec: Select ima_get/free_kexec_buffer() with
 CONFIG_HAVE_IMA_KEXEC(_OF)
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org,
        kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
        saravanak@kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, zohar@linux.ibm.com, noodles@fb.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20261020083727.1906495-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _3Ib_GBruwcesQrtvIa8ZW5ntGhzMhy5
X-Proofpoint-ORIG-GUID: oxvRYIABcnG-nxVQjlWue4M7DI2aYYDj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfXzcOM8UL9gueO
 CY+UcxINUHYr0hjxrJs/KBXesiY3Sz7o0jwVkVShLTxJJ5ixuvqpKWLsOxZC6ezU5meyRXABaxs
 58Dqwt83Q6uEuKIim2SS8kG/oY2bK90=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1MCBTYWx0ZWRfX+ms0pcRX9GQP
 tyaKnyTEc0ZDwcxQzvXzVdV5LQiyFMW5tMimQlSw2Is6088V7QEMcM93QtZHn5luNMX82YxSpKs
 Edik2brqJ//NwRdtVHjgL4F67JQBY4HtGsaDSotd/aGE5zsZ1HwC10JqC7ReR11ZscBVzdOIYyZ
 8oKnGc6XYN+PR8kO8tjLnVMThufi2rlqivW/jh2X9tksdla+NwyzM8Nmud1YeRtPFng52PIfgWg
 D3Cu3GaHICsND3g8ToduGq7KEfFZlM6LloAFVfZel1VLYC80oadSRWegxg0iFusTRBxT6stDc0i
 FU2eTYyldeZR1D/oMTe30/ZWAK9dOMgpuzc1DLvBUNO6NkaEzduD+suOp4iycusUc4VZxIGfOqb
 U53ApYpaMZGkYi06Li3kpK771jp1pe/pVW1DiUQ28cvrkni8uiHgyWjf8pEZ8CghOMTaMneJAzU
 cKqCrWmr8kMmOmK72yA==
X-Authority-Analysis: v=2.4 cv=Gb2CDgXL c=1 sm=1 tr=0 ts=6ada0c0f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=xUTifld_T7Igq-SLGagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 clxscore=1011 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220050
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/20/26 2:07 PM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> On x86, if CONFIG_OF_FLATTREE is enabled, the kernel uses the device tree
> implementation of ima_get/free_kexec_buffer(). However, x86 passes the IMA
> buffer location through setup_data, not through the device tree, so the
> buffer is never found and the IMA measurement list is not carried over
> across kexec.
>
> Introduce CONFIG_HAVE_IMA_KEXEC_OF (which selects CONFIG_HAVE_IMA_KEXEC)
> and select it for the architectures that pass the IMA buffer location
> through the device tree, via of_kexec_alloc_and_setup_fdt() (arm64,
> powerpc and riscv). Build the device tree implementation of
> ima_get/free_kexec_buffer() only if the new option is enabled.
>
> Select the new option also on LoongArch, to preserve the current behavior
> and avoid a link failure. LoongArch does not pass the buffer location to
> the next kernel yet; this will be addressed separately.
>
> Finally, don't select it for x86, and use x86's own setup_data-based
> implementation regardless of CONFIG_OF_FLATTREE.
>
> Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>


Tested-by: Srish Srinivasan <ssrish@linux.ibm.com> # PowerVM


> ---
>
> v2:
> - Reworded the commit message (no code changes), suggested by Mimi
>
>   arch/arm64/Kconfig      | 2 +-
>   arch/loongarch/Kconfig  | 2 +-
>   arch/powerpc/Kconfig    | 2 +-
>   arch/riscv/Kconfig      | 2 +-
>   arch/x86/kernel/setup.c | 2 +-
>   drivers/of/kexec.c      | 4 ++--
>   kernel/Kconfig.kexec    | 4 ++++
>   7 files changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef944..4b7e248b6c91 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1697,7 +1697,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>   config ARCH_SELECTS_KEXEC_FILE
>   	def_bool y
>   	depends on KEXEC_FILE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>   
>   config ARCH_SUPPORTS_KEXEC_SIG
>   	def_bool y
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 2067d1f2ad7a..b5420d482da4 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -690,7 +690,7 @@ config ARCH_SELECTS_KEXEC_FILE
>   	depends on KEXEC_FILE
>   	select KEXEC_ELF
>   	select RELOCATABLE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>   
>   config ARCH_SUPPORTS_CRASH_DUMP
>   	def_bool 64BIT
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 2580e27e4328..096c6061893b 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -643,7 +643,7 @@ config ARCH_SELECTS_KEXEC_FILE
>   	def_bool y
>   	depends on KEXEC_FILE
>   	select KEXEC_ELF
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>   
>   config PPC64_BIG_ENDIAN_ELF_ABI_V2
>   	# Option is available to BFD, but LLD does not support ELFv1 so this is
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f8e26c4bed2b..161bf8a65beb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -1118,7 +1118,7 @@ config ARCH_SUPPORTS_KEXEC_FILE
>   config ARCH_SELECTS_KEXEC_FILE
>   	def_bool y
>   	depends on KEXEC_FILE
> -	select HAVE_IMA_KEXEC if IMA
> +	select HAVE_IMA_KEXEC_OF if IMA
>   	select KEXEC_ELF
>   
>   config ARCH_SUPPORTS_KEXEC_PURGATORY
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index cda6adb9f69c..bc17e353c099 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -421,7 +421,7 @@ static void __init add_early_ima_buffer(u64 phys_addr)
>   #endif
>   }
>   
> -#if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
> +#ifdef CONFIG_HAVE_IMA_KEXEC
>   int __init ima_free_kexec_buffer(void)
>   {
>   	if (!ima_kexec_buffer_size)
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 029903b986cb..724f29fef0c0 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -116,7 +116,7 @@ static int do_get_kexec_buffer(const void *prop, int len, unsigned long *addr,
>   	return 0;
>   }
>   
> -#ifdef CONFIG_HAVE_IMA_KEXEC
> +#ifdef CONFIG_HAVE_IMA_KEXEC_OF
>   /**
>    * ima_get_kexec_buffer - get IMA buffer from the previous kernel
>    * @addr:	On successful return, set to point to the buffer contents.
> @@ -196,7 +196,7 @@ static void remove_ima_buffer(void *fdt, int chosen_node)
>   	size_t size;
>   	const void *prop;
>   
> -	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC_OF))
>   		return;
>   
>   	prop = fdt_getprop(fdt, chosen_node, "linux,ima-kexec-buffer", &len);
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index 15632358bcf7..c6ed60f04ea4 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -17,6 +17,10 @@ config KEXEC_ELF
>   config HAVE_IMA_KEXEC
>   	bool
>   
> +config HAVE_IMA_KEXEC_OF
> +	bool
> +	select HAVE_IMA_KEXEC
> +
>   config KEXEC
>   	bool "Enable kexec system call"
>   	depends on ARCH_SUPPORTS_KEXEC

