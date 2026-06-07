Return-Path: <linuxppc-dev+bounces-22156-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E9CCD8C8C
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 12:18:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYDjL3J1Wz2ySD;
	Sun, 07 Jun 2026 22:18:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780834710;
	cv=none; b=Kaz6bNCFXKq0SCwNZWocy4PUZCwqfrquelxHkGj+WqLiyXct3O4YYL1aA26jE0K5EpO6kdn6itlSsabE1Me463s+WUAWYS7Zw2jYLp9j3PN7YsC8nJDSRKt7GFEokF3oxfkSo8KMJRRXm6/CLo9TE8f9jsU4OtBPYO/kSb6083cHSntntDByqc1c0ipfJT3fbCtQkK9Hg0e9AytXTMPU/pK9vEfGX5eqwHNx5VDGDkBhS3kT6xMBDi8sB9m0loqm3krzsASazANmvMU5O4K40cFCBRDtIt08udlYOBo0a7LqUvxw4wYCQuDoeYf3VgUwnRgKUUkvtcYlkzdAcQDQDg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780834710; c=relaxed/relaxed;
	bh=cXyrvokwkz4X1uoIpCa+gf8uOr+C3tuBcRf4mW38/Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/r23HNATwc30rkzV/JEpC6ymZDVZWhp1jNcLO/be1oqszcPGDQXC/tODf2StcG85U58DgEY1vzqfRRB2BlmAGuZCLnWl8C906UaBrjDIRdWWXvNaKuOfsgcDIUlzsYCtYgxrzDejEICchOYpne3qX+kyoq2SrINwo6taH303gFOrivApLmqMPQ8OOzdeI/WcDGUL4b6tgjztWTwpuBSfmoy8DbY51wDF7h8hxbYMTUhkIDfWJR8raodcmrBJ0sR+Op67jcTPicLca/bVPfdXLbxJWfaNfV7s1rxjc8xIzONciM9JASOHdJETTgKdTl0Iptkl9iQW3eW/r/KBNpQxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ovo6RLif; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ovo6RLif;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYDjK1Hqrz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 22:18:27 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6573oqRA2300781;
	Sun, 7 Jun 2026 12:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cXyrvo
	kwkz4X1uoIpCa+gf8uOr+C3tuBcRf4mW38/Yk=; b=ovo6RLifdigmW10S/PoPHZ
	Wkdt0A0wueLQ36HSdPpEwTWsAVkFDT1G/W8sMMR/Ui8bqibz5yBt2ed46wMHYev1
	tkyHQpa5GHO318UCXIlDzWQEIkm33/s5mUIzTe2VjwJE0dZA6OFHUeKKQcdkf4A/
	HRyvTeiSy5v7cF0xOAbh5CdsyT1NppjK4kJMeQLmy1pBl9i+UINF5nwAGFSLFzLQ
	IVsaxS07n2uxYfTFPnkyM498PJqULRWB8rJlIkI8dmlctnDligPc1YkThjBFIoDX
	auDexyc09MQpawiV4vCMHcHkhNnMqlTEgonR9VBt9y6cTqslYeDf0fCu/83NW2SQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhkvfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 12:18:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657BnfSH023771;
	Sun, 7 Jun 2026 12:18:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjhee3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 12:18:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657CI4HX50266386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 12:18:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67C3820043;
	Sun,  7 Jun 2026 12:18:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 407E520040;
	Sun,  7 Jun 2026 12:17:59 +0000 (GMT)
Received: from [9.39.26.1] (unknown [9.39.26.1])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 12:17:58 +0000 (GMT)
Message-ID: <8f15387e-02f3-47e6-b51d-f02adfd47c86@linux.ibm.com>
Date: Sun, 7 Jun 2026 17:47:57 +0530
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
Subject: Re: [PATCH v2 3/5] powerpc/pseries: Add RTAS error injection
 validation helpers
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-4-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260527072433.94510-4-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDExOSBTYWx0ZWRfX/Del7RVq2tMg
 f870+nr36FvmR+od70TslCdfiI8RK30bqVwW8uzRNs5f3api4SY2MOAIfGEWcuJCO2VMR4TlSak
 DqaOsBJfrhLdc9++vmB24JqOFTJh+rsr4/FExg09Wj7oMPOCSMWTV/MV1CzdtePnT1Lnl63Iao/
 lLHyt/3lhqRPpMD2dH365TFgMiwFrwlawKF+an+JUlaTjjMRrS3pD7d5SDOZEBy9sO4of7dalBB
 xm0vZlrUyWp7ktUH++khOnccxzZMCJ+CMzjSRy0Grg1/H61l5Q/iJwS4segmqy9vwcpVbcVaBjF
 ike5MPgFKz+MOvWUTVqgns8jdO8WM5fGzepIIhpkRejXZVYfth4JRGWZO1dG5xRPt6o7he/Yvr0
 tFIRcPM+G9MQinyS9LvyKEkDNBoqUpwZe/ZLuLxtELIzKyQfFBOUqb/7vWHYkgJLxBUzMiXqCld
 QvqBNb899TsclgkDbXA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a256181 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=KsSUM4bdZCb9M9nwCyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 53wp7MaJ35Fkk9__otau4mI1Hgqs5E4_
X-Proofpoint-GUID: a_IlqHZjG7Ck6QtusBJE1oFAZuKIalVn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070119



On 27/05/26 12:54, Narayana Murty N wrote:
> Add comprehensive validation helpers for RTAS error injection parameters:
> - validate_addr_mask_in_pe(): BAR range validation
> - validate_err_type(): Token range check
> - Type-specific validators (special-event, corrupted-page, ioa-bus-error)
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 261 +++++++++++++++++++
>   1 file changed, 261 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index b12ef382fec7..d6f2e0d43b89 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -33,6 +33,10 @@
>   #include <asm/ppc-pci.h>
>   #include <asm/rtas.h>
>   
> +#ifndef pr_fmt
> +#define pr_fmt(fmt) "EEH: " fmt

Why this is under ifndef?

> +#endif
> +
>   /* RTAS tokens */
>   static int ibm_set_eeh_option;
>   static int ibm_set_slot_reset;
> @@ -786,6 +790,263 @@ static int pseries_notify_resume(struct eeh_dev *edev)
>   }
>   #endif
>   
> +/**
> + * validate_addr_mask_in_pe - Validate that an addr+mask fall within PE's BARs
> + * @pe:  EEH PE containing one or more PCI devices
> + * @addr: Address to validate
> + * @mask: Address mask to validate
> + *
> + * Checks that @addr is mapped into a BAR/MMIO region of any device belonging
> + * to the PE. If @mask is non-zero, ensures it is consistent with @addr.
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER on failure.
> + */
> +
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
> +			bar_len = pci_resource_len(pdev, bar);
> +
> +			if (!bar_len)
> +				continue;
> +
> +			if (addr >= bar_start && addr < (bar_start + bar_len)) {
> +				/* ensure mask makes sense for the addr value */
> +				if ((addr & mask) != addr) {
> +					pr_err("Mask 0x%lx invalid for addr 0x%lx in BAR[%d] range 0x%llx-0x%llx\n",
> +					       mask, addr, bar,
> +					       (unsigned long long)bar_start,
> +					       (unsigned long long)(bar_start + bar_len));
> +					return RTAS_INVALID_PARAMETER;
> +				}
> +
> +				pr_debug("addr=0x%lx with mask=0x%lx validated in BAR[%d] of %s\n",
> +					 addr, mask, bar, pci_name(pdev));
> +				valid = true;
> +			}
> +		}
> +	}
> +
> +	if (!valid) {
> +		pr_err("addr=0x%lx not valid within any BAR of any device in PE\n",
> +		       addr);
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * validate_err_type - Basic sanity check for RTAS error type
> + * @type: RTAS error type
> + *
> + * Ensures that the error type is within the valid RTAS error type range.
> + *
> + * Return: true if valid, false otherwise.
> + */
> +
> +static bool validate_err_type(int type)
> +{
> +	if (type < RTAS_ERR_TYPE_FATAL ||
> +	    type > RTAS_ERR_TYPE_UPSTREAM_IO_ERROR)
> +		return false;
> +
> +	return true;
> +}

How about defining this and the function below as inline?

> +
> +/**
> + * validate_special_event - Validate parameters for special-event injection
> + * @addr: Address parameter (should be zero)
> + * @mask: Mask parameter (should be zero)
> + *
> + * Special-event error injection should not take addr/mask.  Rejects if either
> + * is set.
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
> + */
> +
> +static int validate_special_event(unsigned long addr, unsigned long mask)
> +{
> +	if (addr || mask) {
> +		pr_err("Special-event should not specify addr/mask\n");
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * validate_corrupted_page - Validate parameters for corrupted-page injection
> + * @pe:   EEH PE (__maybe_unused)
> + * @addr: Physical page address (required)
> + * @mask: Address mask (ignored if non-zero)
> + *
> + * Ensures a valid non-zero page address is provided. Warns if mask is set.
> + *
> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
> + */
> +
> +static int validate_corrupted_page(struct eeh_pe *pe __maybe_unused,
> +				   unsigned long addr, unsigned long mask)

pe is not used in this function and it is removed in the next patch. Why 
don't
we define this function properly in this patch itself.

> +{
> +	if (!addr) {
> +		pr_err("corrupted-page requires non-zero addr\n");
> +		return RTAS_INVALID_PARAMETER;
> +	}
> +	/* Mask not meaningful for corrupted-page */

If it is not meaningful why can't we ignore it?

> +	if (mask)
> +		pr_warn("corrupted-page ignoring mask=0x%lx\n", mask);
> +
> +	return 0;
> +}
> +
> +/**
> + * validate_ioa_bus_error - Validate parameters for IOA bus error injection
> + * @pe:   EEH PE whose BARs are validated against
> + * @addr: Address parameter (optional)
> + * @mask: Mask parameter (optional)
> + *
> + * For IOA bus error injections, @addr and @mask are optional. If present,
> + * they must map into the PE's MMIO/CFG space.
> + *
> + * Return: 0 if valid or addr/mask absent, RTAS_INVALID_PARAMETER otherwise.
> + */
> +
> +static int validate_ioa_bus_error(struct eeh_pe *pe,
> +				  unsigned long addr, unsigned long mask)
> +{
> +	/* Must map into BAR/MMIO/CFG space of PE */
> +	return validate_addr_mask_in_pe(pe, addr, mask);

What is the benefit of adding a static helper function that just calls 
another
static helper function in the same file?


> +}
> +
> +
> +/**
> + * prepare_errinjct_buffer - Prepare RTAS error injection work buffer
> + * @pe:   EEH PE for the target device(s)
> + * @type: RTAS error type
> + * @func: Error function selector (semantics vary by type)
> + * @addr: Address argument (type-dependent)
> + * @mask: Mask argument (type-dependent)

Isn't the caller of this helper expected to hold rtas_errinjct_buf_lock? 
If that is
the case, let's document it.

> + *
> + * Clears the global error injection work buffer and populates it based on
> + * the error type and parameters provided. Performs inline validation of the
> + * arguments for each supported error type.
> + *
> + * Return: 0 on success, or RTAS_INVALID_PARAMETER / -EINVAL on failure.
> + */
> +
> +static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int func,
> +				   unsigned long addr, unsigned long mask)
> +{
> +	__be64 *buf64;
> +	__be32 *buf32;
> +
> +	memset(rtas_errinjct_buf, 0, RTAS_ERRINJCT_BUF_SIZE);
> +	buf64 = (__be64 *)rtas_errinjct_buf;
> +	buf32 = (__be32 *)rtas_errinjct_buf;
> +
> +	switch (type) {
> +	case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
> +		/* func must be 1 = non-persistent or 2 = persistent */
> +		if (func < 1 || func > 2)
> +			return RTAS_INVALID_PARAMETER;
> +
> +		if (validate_special_event(addr, mask))
> +			return RTAS_INVALID_PARAMETER;
> +
> +		buf32[0] = cpu_to_be32(func);
> +		break;
> +
> +	case RTAS_ERR_TYPE_CORRUPTED_PAGE:
> +		/* addr required: physical page address */
> +		if (addr == 0)
> +			return RTAS_INVALID_PARAMETER;
> +
> +		if (validate_corrupted_page(pe, addr, mask))
> +			return RTAS_INVALID_PARAMETER;
> +
> +		buf32[0] = cpu_to_be32(upper_32_bits(addr));
> +		buf32[1] = cpu_to_be32(lower_32_bits(addr));
> +		break;
> +
> +	case RTAS_ERR_TYPE_IOA_BUS_ERROR:
> +		/* 32-bit IOA bus error: addr/mask optional */
> +		if (func < EEH_ERR_FUNC_LD_MEM_ADDR || func > EEH_ERR_FUNC_MAX)
> +			return RTAS_INVALID_PARAMETER;
> +
> +		if (addr || mask) {
> +			if (validate_ioa_bus_error(pe, addr, mask))
> +				return RTAS_INVALID_PARAMETER;
> +		}
> +
> +		buf32[0] = cpu_to_be32((u32)addr);
> +		buf32[1] = cpu_to_be32((u32)mask);
> +		buf32[2] = cpu_to_be32(pe->addr);
> +		buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
> +		buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
> +		buf32[5] = cpu_to_be32(func);
> +		break;
> +
> +	case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
> +		/* 64-bit IOA bus error: addr/mask optional */
> +		if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
> +			return RTAS_INVALID_PARAMETER;
> +
> +		if (addr || mask) {
> +			if (validate_ioa_bus_error(pe, addr, mask))
> +				return RTAS_INVALID_PARAMETER;
> +		}
> +
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
> +		/* addr/mask optional, no strict validation */
> +		buf32[0] = cpu_to_be32(addr);
> +		buf32[1] = cpu_to_be32(mask);
> +		break;
> +
> +	case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
> +	case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
> +		/* only addr field relevant */
> +		buf32[0] = cpu_to_be32(addr);
> +		break;
> +
> +	default:
> +		pr_err("Unsupported error type 0x%x\n", type);
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("RTAS: errinjct buffer prepared: type=%d func=%d addr=0x%lx mask=0x%lx\n",
> +		 type, func, addr, mask);
> +
> +	return 0;
> +}
> +
>   /**
>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>    * @pe: the indicated PE


