Return-Path: <linuxppc-dev+bounces-25383-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE76C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:06:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF1gd3lVJz2yH5;
	Wed, 05 Aug 2026 04:06:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785866765;
	cv=none; b=WFml5rL6yOkQAPqb50nLFEQA/KEsea7I1o6pTNx/wqz/WAuJxPrD2YHdqG6CtcctjWbsgHIXr4QmusiHg53Hzcp5RobG818nwjovcqKWjZLC2uykZ2AtX5PEGVQyUZOoY/pUKQN8naUnZ5zJP1swO1o/2RIO7FpfhINnPfhLyL7kdWp//rthnEM2UNEu6zf7doxu7uk64Qay/P70V+gGbwQA2axChP8VyBvByhTDzltUiDJ/IvFcTxugJ4gESH+Um91q75U7qerEOIEm+jTelJM6H5j1jD6rDyEC54rfsncOInSeY8p6o2J09mbFN7dKwB0vC4v6kNy2+jbccArN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785866765; c=relaxed/relaxed;
	bh=j3sUgv3LD9Ix/94g2h8nuCKDeAXjVEjGYOse+rMuj9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bFiOPdgJ/rJ+XfONZBGwFYlhKYmnp6FLGo5KbXObUKuiI8f9XTRrYD29dQ0H/Eq0UFGeN+fb6mEFZR73UBFF4NPdfMOa/zgjmw926BJBMCoZ5KmMnj1XjzcLiWzHM1GLPYMzMWsuDP9zBH+CI5f4Uyr6ZgjtgV8S5jeikU7a/XKFDffwTZVeo2jwK1l/0Exqqb7lwpQveYwzoAVw7uFUAKO+8Wsy75amVLf4XK1ic/+CxfhyYC0seHRew2YTAf1ICzvVYJljNBhuQkYJaVC1WwydxBQWhN9xhfostD0YumGLMT+pM9i1cxx58/D/eAA9yZJzmSwIgYOaLUeC5ycG9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fjLJMtG9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fjLJMtG9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF1gc1YGtz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:06:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674FledV1192114;
	Tue, 4 Aug 2026 18:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j3sUgv
	3LD9Ix/94g2h8nuCKDeAXjVEjGYOse+rMuj9g=; b=fjLJMtG9b+s6CUPqRocjyn
	SiEtAP0xTyQL+ICOfHQohcjBPGdyF7MMciZFoyXsEPMauO2ihOyiQWY+dLP0ope2
	3SP7C1afVe6t5H4UE28GP4T8mcWbrNW2jwTRvrJU/H70mxYcbB8miiuxeUeAyS7Z
	ZbnCajZfoTpPgJMiK9zMRhdATvOHwOKjd4I/yZnmVmCfmIxeGvqiSIG8yWKCKgRl
	DsfLik5za9CA2QUOIy6gJazu6IhoWXH1mSGYGs9KooPwiGx9thrGlJY6TkxLnakx
	jePb5+Kt+P1jr5VcbfFluwvl8B4p60QHrHmNVwie97KURS/1c+kIJmKevdyePVCg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hq3xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:05:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674HuMmY010888;
	Tue, 4 Aug 2026 18:05:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k3514-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:05:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674I5g8a7012714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:05:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78672004B;
	Tue,  4 Aug 2026 18:05:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBC2C20040;
	Tue,  4 Aug 2026 18:05:37 +0000 (GMT)
Received: from [9.39.27.173] (unknown [9.39.27.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:05:37 +0000 (GMT)
Message-ID: <4a026176-969c-4aa7-8f59-6b46daa9166e@linux.ibm.com>
Date: Tue, 4 Aug 2026 23:35:35 +0530
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
Subject: Re: [PATCH v3 3/5] powerpc/pseries/eeh: Add RTAS error validation
 helpers
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-4-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260721033815.5300-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfX+TQvM9rCgV2c
 iwQqSkkRj4wI9+qKVdX0F6deOg1qRCHGzWzS7jZVDXN+fuinUxKb9f7iWBg7HHYY8KP6Rp+UcUM
 TtavUfhL21v9LDYcGVwSV7hlGyFM3GA=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a7229fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=oco2q1pTq4vujUvGTukA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0NCBTYWx0ZWRfXxfAWhp2cnJxP
 lXN38CRkUeFkS0eqx1IrhgOpoaRTY5XXAgRnMeTabaewGB5r5trU3BddautyYpA2zVOXVL7nSYu
 ln4NBn5o4Az4Ap+9DfpwzlyFuZYcTD3lyH3lythbxtk3sUwd0RHu2S04L4OqOboNTaWZ3CNB/zT
 FZPUtchRqmj/xyd+w5UjFm9AnC1WVTdmsw4CsOS+lC6Ns5nnfBJQwDEqDTnDygHMqtTckSWhaBR
 wMmRpCcbvwGp75jtL1IZKxQQxng1hJHuKLXTijdfUR0dU9tiVjCL42XAy7yQ8nY1VELKajNdQuU
 /B7CUgsW+Buf9VPf5l3lK/qJ7k/kGIluB/7z4ng3hfBhECNNeWZOoJitxrbC6Gg8T/Oxg6lhaQn
 LHJBXJ+FY2uVdDX42VsAmVjMM3bcsvYvdQLCy7yRXU5NrZm5bn+T572Rhq8SGYoEJLVDn6yRacf
 lV5iuB+JK32SbL8d5MA==
X-Proofpoint-ORIG-GUID: fMJJB28HP_IzxrNGFeG4ECq8zpV2C7EM
X-Proofpoint-GUID: Vllixcim3xjPMeEJiOW6ehMoXJzT8aRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040144



On 21/07/26 09:08, Narayana Murty N wrote:
> Add validation helpers

Can you provide more details about what these validation helpers are for?

> and buffer-preparation infrastructure used by
> the RTAS-based EEH error injection implementation.

Can you explain what this buffer is and what it is used for?


>
> Changes relative to the original submission:
>   - pr_fmt unconditionally defined at the top of the file, not wrapped
>     in an #ifndef guard.
>   - RTAS error-type constants (RTAS_ERR_TYPE_*) are defined as file-local
>     macros in eeh_pseries.c, not in the UAPI header.  They are internal
>     PAPR firmware type codes, not generic EEH ABI values.
>   - validate_corrupted_page() drops the unused 'pe' parameter entirely
>     (no __maybe_unused).  The mask value is silently accepted since it
>     is not meaningful for this error type.
>   - validate_ioa_bus_error() is removed; callers invoke
>     validate_addr_mask_in_pe() directly.
>   - validate_err_type() and validate_special_event() and
>     validate_corrupted_page() are marked static inline.
>   - prepare_errinjct_buffer() takes an explicit 'void *buf' pointer
>     (kernel virtual address) instead of accessing rtas_errinjct_buf
>     directly, making it easier to test and keeping the global out of
>     the helper.
>   - kernel-doc added for prepare_errinjct_buffer() including a Locking:
>     line stating the caller must hold rtas_errinjct_mutex.

Changelog shouldn't be part of commit message.

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/include/uapi/asm/eeh.h          |  24 +-
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 250 +++++++++++++++++++
>   2 files changed, 271 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
> index 3b5c47ff3fc4..2680b22f8917 100644
> --- a/arch/powerpc/include/uapi/asm/eeh.h
> +++ b/arch/powerpc/include/uapi/asm/eeh.h
> @@ -15,9 +15,27 @@
>   #define EEH_PE_STATE_STOPPED_DMA	4	/* Stopped DMA only	*/
>   #define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
>   
> -/* EEH error types and functions */
> -#define EEH_ERR_TYPE_32			0       /* 32-bits error	*/
> -#define EEH_ERR_TYPE_64			1       /* 64-bits error	*/
> +/*
> + * EEH error types.
> + *
> + * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the original ABI values and must
> + * not be renumbered.  The additional types below are generic identifiers for
> + * error-injection types supported by pSeries RTAS.  Platform backends may
> + * return -EOPNOTSUPP for valid generic types that are not supported by their
> + * firmware.
> + */
> +#define EEH_ERR_TYPE_32				0       /* 32-bits error	*/
> +#define EEH_ERR_TYPE_64				1       /* 64-bits error	*/
> +#define EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT	0x03
> +#define EEH_ERR_TYPE_CORRUPTED_PAGE		0x04
> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_START	0x09
> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_END	0x0a
> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_START	0x0b
> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_END	0x0c
> +#define EEH_ERR_TYPE_CORRUPTED_TLB_START	0x0d
> +#define EEH_ERR_TYPE_CORRUPTED_TLB_END		0x0e
> +
> +/* EEH error functions */
>   #define EEH_ERR_FUNC_MIN		0
>   #define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
>   #define EEH_ERR_FUNC_LD_MEM_DATA	1
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index b12ef382fec7..25aad86c696d 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -1,4 +1,5 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
> +#define pr_fmt(fmt) "EEH: " fmt
>   /*
>    * The file intends to implement the platform dependent EEH operations on pseries.
>    * Actually, the pseries platform is built based on RTAS heavily. That means the
> @@ -31,8 +32,27 @@
>   #include <asm/io.h>
>   #include <asm/machdep.h>
>   #include <asm/ppc-pci.h>
> +#include <linux/mutex.h>
>   #include <asm/rtas.h>
>   
> +/*
> + * PAPR RTAS firmware error-injection type codes.
> + *
> + * These are internal firmware encodings used by ibm,errinjct.  They are
> + * NOT generic EEH ABI values.  Only the types actually handled by
> + * prepare_errinjct_buffer() are defined here.
> + */
> +#define RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT	0x03
> +#define RTAS_ERR_TYPE_CORRUPTED_PAGE		0x04
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR		0x07
> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_START	0x09
> +#define RTAS_ERR_TYPE_CORRUPTED_DCACHE_END	0x0a
> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_START	0x0b
> +#define RTAS_ERR_TYPE_CORRUPTED_ICACHE_END	0x0c
> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_START	0x0d
> +#define RTAS_ERR_TYPE_CORRUPTED_TLB_END		0x0e
> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64		0x0f
> +
>   /* RTAS tokens */
>   static int ibm_set_eeh_option;
>   static int ibm_set_slot_reset;
> @@ -786,6 +806,236 @@ static int pseries_notify_resume(struct eeh_dev *edev)
>   }
>   #endif
>   
> +/**
> + * validate_addr_mask_in_pe() - Validate that addr+mask fall within PE BARs
> + * @pe:   EEH PE containing one or more PCI devices
> + * @addr: Address to validate
> + * @mask: Address mask to validate
> + *
> + * Checks that @addr is mapped into a BAR/MMIO region of any device
> + * belonging to the PE.  If @mask is non-zero, ensures it is consistent
> + * with @addr.
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER on failure.

Using RTAS error codes for kernel function may not be good idea.
How about using -EINVAL?

> + */
> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long addr,
> +				    unsigned long mask)
> +{
> +	struct eeh_dev *edev, *tmp;
> +	struct pci_dev *pdev;
> +	int bar;
> +	resource_size_t bar_start, bar_len;
> +	bool valid = false;
> +
> +	/* nothing to validate */
> +	if (addr == 0 && mask == 0)
> +		return 0;
> +
> +	eeh_pe_for_each_dev(pe, edev, tmp) {
> +		pdev = eeh_dev_to_pci_dev(edev);
> +		if (!pdev)
> +			continue;
> +
> +		for (bar = 0; bar < PCI_NUM_RESOURCES; bar++) {
> +			bar_start = pci_resource_start(pdev, bar);
> +			bar_len   = pci_resource_len(pdev, bar);
> +
> +			if (!bar_len)
> +				continue;
> +
> +			if (addr >= bar_start && addr < (bar_start + bar_len)) {
> +				if ((addr & mask) != addr) {

The check has nothing to do with device or the BAR.
Then why this check is inside the loop?

For my understanding can you please explain what this check is all about?

> +					pr_err("Mask 0x%lx invalid for addr 0x%lx in BAR[%d] range 0x%llx-0x%llx\n",
> +					       mask, addr, bar,
> +					       (unsigned long long)bar_start,
> +					       (unsigned long long)(bar_start + bar_len));
> +					return RTAS_INVALID_PARAMETER;
> +				}
> +				pr_debug("addr=0x%lx mask=0x%lx validated in BAR[%d] of %s\n",
> +					 addr, mask, bar, pci_name(pdev));
> +				valid = true;

Once valid is set, the loop keeps scanning all remaining BARs/devices
instead of breaking. Is it intentional?

> +			}
> +		}
> +	}
> +
> +	if (!valid) {
> +		pr_err("addr=0x%lx not within any BAR of any device in PE\n",
> +		       addr);
> +		return RTAS_INVALID_PARAMETER;

-EINVAL would be a better options for these helpers.

> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * validate_special_event() - Validate parameters for special-event injection
> + * @addr: Address parameter (must be zero for this type)
> + * @mask: Mask parameter (must be zero for this type)
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
> + */
> +static inline int validate_special_event(unsigned long addr, unsigned long mask)
> +{
> +	if (addr || mask) {
> +		pr_err("special-event injection must not specify addr/mask\n");
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * validate_corrupted_page() - Validate parameters for corrupted-page injection
> + * @addr: Physical page address (required, must be non-zero)
> + *
> + * The mask value is not meaningful for this error type and is ignored.
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
> + */
> +static inline int validate_corrupted_page(unsigned long addr)
> +{
> +	if (!addr) {
> +		pr_err("corrupted-page injection requires non-zero addr\n");
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * pseries_eeh_type_to_rtas() - Map a generic EEH error type to its RTAS encoding.
> + * @type: Generic EEH error type (EEH_ERR_TYPE_*)
> + *
> + * Translates a userspace-visible generic EEH error type to the corresponding
> + * PAPR RTAS firmware type code.  Every supported value appears as an explicit
> + * case; coincidental equality between generic EEH and RTAS values is not relied
> + * upon.
> + *
> + * Return: RTAS_ERR_TYPE_* value on success, -EINVAL for unsupported types.
> + */
> +static int pseries_eeh_type_to_rtas(int type)
> +{
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR;
> +	case EEH_ERR_TYPE_64:
> +		return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
> +	case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
> +		return RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT;
> +	case EEH_ERR_TYPE_CORRUPTED_PAGE:
> +		return RTAS_ERR_TYPE_CORRUPTED_PAGE;
> +	case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
> +		return RTAS_ERR_TYPE_CORRUPTED_DCACHE_START;
> +	case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
> +		return RTAS_ERR_TYPE_CORRUPTED_DCACHE_END;
> +	case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
> +		return RTAS_ERR_TYPE_CORRUPTED_ICACHE_START;
> +	case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
> +		return RTAS_ERR_TYPE_CORRUPTED_ICACHE_END;
> +	case EEH_ERR_TYPE_CORRUPTED_TLB_START:
> +		return RTAS_ERR_TYPE_CORRUPTED_TLB_START;
> +	case EEH_ERR_TYPE_CORRUPTED_TLB_END:
> +		return RTAS_ERR_TYPE_CORRUPTED_TLB_END;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
> + * @buf: RTAS error-injection work buffer (kernel virtual address)
> + * @pe: EEH PE associated with the injection target
> + * @rtas_type: PAPR firmware error-injection type after generic EEH-to-RTAS
> + *             translation (RTAS_ERR_TYPE_*)
> + * @func: Error function selector
> + * @addr: Target address, if applicable
> + * @mask: Address mask, if applicable
> + *
> + * Zeroes @buf and populates it according to the PAPR layout for @rtas_type.
> + * Performs inline parameter validation for each error type.
> + *
> + * Locking: Caller must hold rtas_errinjct_mutex.
> + *
> + * Return: 0 on success, RTAS_INVALID_PARAMETER on invalid input.
> + */
> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
> +				   int rtas_type, int func,
> +				   unsigned long addr, unsigned long mask)
> +{
> +	__be64 *buf64 = (__be64 *)buf;
> +	__be32 *buf32 = (__be32 *)buf;
> +
> +	memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
> +
> +	switch (rtas_type) {
> +	case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
> +		/* func: 1 = non-persistent, 2 = persistent */
> +		if (func < 1 || func > 2)
> +			return RTAS_INVALID_PARAMETER;
> +		if (validate_special_event(addr, mask))
> +			return RTAS_INVALID_PARAMETER;
> +		buf32[0] = cpu_to_be32(func);
> +		break;
> +
> +	case RTAS_ERR_TYPE_CORRUPTED_PAGE:
> +		if (validate_corrupted_page(addr))
> +			return RTAS_INVALID_PARAMETER;
> +		buf32[0] = cpu_to_be32(upper_32_bits(addr));
> +		buf32[1] = cpu_to_be32(lower_32_bits(addr));
> +		break;
> +
> +	case RTAS_ERR_TYPE_IOA_BUS_ERROR:
> +		if (func < EEH_ERR_FUNC_LD_MEM_ADDR || func > EEH_ERR_FUNC_MAX)
> +			return RTAS_INVALID_PARAMETER;
> +		if (upper_32_bits(addr) || upper_32_bits(mask)) {
> +			pr_err("32-bit IOA injection cannot encode addr=%#lx mask=%#lx\n",
> +			       addr, mask);
> +			return RTAS_INVALID_PARAMETER;
> +		}
> +		if (validate_addr_mask_in_pe(pe, addr, mask))
> +			return RTAS_INVALID_PARAMETER;
> +		buf32[0] = cpu_to_be32((u32)addr);
> +		buf32[1] = cpu_to_be32((u32)mask);
> +		buf32[2] = cpu_to_be32(pe->addr);
> +		buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
> +		buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
> +		buf32[5] = cpu_to_be32(func);
> +		break;
> +
> +	case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
> +		if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
> +			return RTAS_INVALID_PARAMETER;
> +		if (validate_addr_mask_in_pe(pe, addr, mask))
> +			return RTAS_INVALID_PARAMETER;
> +		buf64[0] = cpu_to_be64(addr);
> +		buf64[1] = cpu_to_be64(mask);
> +		buf32[4] = cpu_to_be32(pe->addr);
> +		buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
> +		buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
> +		buf32[7] = cpu_to_be32(func);
> +		break;
> +
> +	case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
> +	case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
> +	case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
> +	case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
> +		buf32[0] = cpu_to_be32(lower_32_bits(addr));
> +		buf32[1] = cpu_to_be32(lower_32_bits(mask));
> +		break;
> +
> +	case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
> +	case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
> +		buf32[0] = cpu_to_be32(lower_32_bits(addr));
> +		break;
> +
> +	default:
> +		pr_err("unsupported RTAS error injection type 0x%x\n", rtas_type);
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +
> +	pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d addr=0x%lx mask=0x%lx\n",
> +		 rtas_type, func, addr, mask);
> +	return 0;
> +}
> +
>   /**
>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>    * @pe: the indicated PE


