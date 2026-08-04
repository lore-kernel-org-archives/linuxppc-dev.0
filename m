Return-Path: <linuxppc-dev+bounces-25324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F2C55172
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:07:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDjkv0Dxcz2yYs;
	Tue, 04 Aug 2026 16:07:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785823671;
	cv=none; b=Ap/ZW8Qqiw4/daY3YxWZ+HdtfyMUeExVJyeVuQ2Nt3b7KLbyxAjtyfAft1xZKdneN8E95VN3jyn85Ez3ZtnkfRHeJb62j+IAzAZJ/7AQmamrAmef5HyWI0Lv60WrA3rbD9qY70x8D1242HPo6TUrFmzeV3E0Senrx4OMStiHIsAQnxIv3n/RM8XgXQIEriBY4D1W4r9nbF7EF5QLRI8lvtX96b+yKe/zCA7nQUuh2EqniglHyE0eKg4Mq0YZI8q0XeAsUjpZ4TRlDDIVf6EAwIE1w0jtckdcnu08udxKICkxbIDiJjedcnzrPSE8+jEC+cmywAhQLhBVmArdivKEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785823671; c=relaxed/relaxed;
	bh=VHZ2M4HU+LSFbe6IM+b/98L26wwVQP4M2rsivd0YJOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owPit65o2eRY0mIliSesqT/36n8npMM4Hmug4pVL3h6Le2bDRd4fMN6VP51EQYb92613M8rKSOERgwxMMzp6765JGrUgiSe7fknWJylLEtSmHdDhZIVWRsE8RG550ptg2/ebLLzhSYAHG+VNz6akcFExnyhwZip6K/MpCJKRHVjDl1qyI+Y17DCEBPsMZsthydKGEXSJsGFwvRybDclMoseCovIEXKGmYLL1pnU1bttxv/oYJtE3LxSH8QNN88gJz2Ohx6iAyjnd0Gqwe3h5pgObWifOEs/Jp5vZXBrJYPc8Sq7QMzWlzgJOkgBB5HWkAwZaU3I5Zb3+BoUye8Unmw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=An77X1eT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=An77X1eT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDjkt1vfjz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:07:49 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741J2id3658654;
	Tue, 4 Aug 2026 06:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VHZ2M4
	HU+LSFbe6IM+b/98L26wwVQP4M2rsivd0YJOE=; b=An77X1eT0DpngN6FFTWJhc
	XvuyIpOCcRKtgZu0h72Pr4ABcYUMe2vBpPvor68DwsR51p5IhnUjP6B7jB+p6//s
	jX1MarprVEhg0c+fODh0vMUb3MGKJV+Rj8pfIS8ty9flS5l5jcjNf1zajrIvBnY5
	GfQfao4QHwnbziT3BjrkcJ2iQfkbcKHdZVlyFCroiOEyjBtEiHB/HCRmhv3aVwvw
	kdOCVpFSxEGVTHJttkshwDKqayvKsw+/6Jx0tqLp+cRRQfWxksw+nequlR140+oh
	d97fwna7WJmay24gNBY6tJLy9PQf3x+XHj9KHnvDdwhOOvzZwRhWdvsU+Hs0qxOg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4vd6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:07:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6745uP4m025926;
	Tue, 4 Aug 2026 06:07:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtygf5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 06:07:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67467VW333292552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:07:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F2A52004B;
	Tue,  4 Aug 2026 06:07:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9EB2004D;
	Tue,  4 Aug 2026 06:07:28 +0000 (GMT)
Received: from [9.123.6.250] (unknown [9.123.6.250])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 06:07:28 +0000 (GMT)
Message-ID: <8ce23d07-0ee9-492b-aeb4-0910d4d75f9a@linux.ibm.com>
Date: Tue, 4 Aug 2026 11:37:27 +0530
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
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-4-nnmlinux@linux.ibm.com>
 <8f15387e-02f3-47e6-b51d-f02adfd47c86@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <8f15387e-02f3-47e6-b51d-f02adfd47c86@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX3M7IEzydNBg/
 OTUtf8fqCwuzA7w/G50kp+PsxKQUxva1gYA8ERrLt0UoAgOqut5oSMXsmbP/KSwXNuMBJTrC1gn
 zi/2n57X3eBn80s0ZG1IFFS/T9CwEtI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0MyBTYWx0ZWRfX3uBPSqwNZgMB
 vnjYxrU2NMmC21CNcGiLHTlXxXUnnRog5xLhrHkN4jPO96BB/ahsBoBvzSSv9rOPacp3Ofb0LW0
 f5rejMba98IwoAUxG2qW+eGV1bUUJKKFwix6NRRkHIE+ydXN/WnSMO7Lzoe/2aUk2LsAGcM7FJy
 ejr1S5jh6mii/DH0wi03MuGbYKcEnD+p7p4YKtbHlY05bea9565DiBZusmdYmZleuoilC2EEAdO
 ABHaaPr94DW/obzCNDnfbIxlYph2MLM7zu+5Oo4a16jC90manrwxXIHhhj0yNb+onuRqOJ801Sx
 3l1frYQ8MTpE9xhZscM7hdfWyMSxieVveXCxcsAV/LPp6KCqZiHl5sVWWUk4DI5NbHvX7UrNRkP
 kGYxnTC6FTVHt9y4l3yOYoDAdG2SDt00CrIRTrQmCTAoFZ1KJA+4wsel+Tco/65KrOJYx4nFumm
 VqYc//Jg9ZNyNo0GCsQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7181aa cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=vk0q_quzd34ArktdqRYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mVmsWiF2YaOizp2xwm33qbeBG4KG0veL
X-Proofpoint-GUID: p9UReum3l48vBtwEep-exNGyT7wwqa1N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040043

Hi Sourabh,
Thanks for the review.
On 07/06/26 5:47 PM, Sourabh Jain wrote:
>
>
> On 27/05/26 12:54, Narayana Murty N wrote:
>> Add comprehensive validation helpers for RTAS error injection 
>> parameters:
>> - validate_addr_mask_in_pe(): BAR range validation
>> - validate_err_type(): Token range check
>> - Type-specific validators (special-event, corrupted-page, 
>> ioa-bus-error)
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: 
>> https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx-lkp@intel.com/
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 261 +++++++++++++++++++
>>   1 file changed, 261 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c 
>> b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> index b12ef382fec7..d6f2e0d43b89 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -33,6 +33,10 @@
>>   #include <asm/ppc-pci.h>
>>   #include <asm/rtas.h>
>>   +#ifndef pr_fmt
>> +#define pr_fmt(fmt) "EEH: " fmt
>
> Why this is under ifndef?
There is no need for the |#ifndef|guard here. I will define 
|pr_fmt|unconditionally
and move it to the beginning of the file, before the header includes.
>
>> +#endif
>> +
>>   /* RTAS tokens */
>>   static int ibm_set_eeh_option;
>>   static int ibm_set_slot_reset;
>> @@ -786,6 +790,263 @@ static int pseries_notify_resume(struct eeh_dev 
>> *edev)
>>   }
>>   #endif
>>   +/**
>> + * validate_addr_mask_in_pe - Validate that an addr+mask fall within 
>> PE's BARs
>> + * @pe:  EEH PE containing one or more PCI devices
>> + * @addr: Address to validate
>> + * @mask: Address mask to validate
>> + *
>> + * Checks that @addr is mapped into a BAR/MMIO region of any device 
>> belonging
>> + * to the PE. If @mask is non-zero, ensures it is consistent with 
>> @addr.
>> + *
>> + * Return: 0 if valid, RTAS_INVALID_PARAMETER on failure.
>> + */
>> +
>> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long 
>> addr,
>> +                    unsigned long mask)
>> +{
>> +    struct eeh_dev *edev, *tmp;
>> +    struct pci_dev *pdev;
>> +    int bar;
>> +    resource_size_t bar_start, bar_len;
>> +    bool valid = false;
>> +
>> +    /* nothing to validate */
>> +    if (addr == 0 && mask == 0)
>> +        return 0;
>> +
>> +    eeh_pe_for_each_dev(pe, edev, tmp) {
>> +        pdev = eeh_dev_to_pci_dev(edev);
>> +        if (!pdev)
>> +            continue;
>> +
>> +        for (bar = 0; bar < PCI_NUM_RESOURCES; bar++) {
>> +            bar_start = pci_resource_start(pdev, bar);
>> +            bar_len = pci_resource_len(pdev, bar);
>> +
>> +            if (!bar_len)
>> +                continue;
>> +
>> +            if (addr >= bar_start && addr < (bar_start + bar_len)) {
>> +                /* ensure mask makes sense for the addr value */
>> +                if ((addr & mask) != addr) {
>> +                    pr_err("Mask 0x%lx invalid for addr 0x%lx in 
>> BAR[%d] range 0x%llx-0x%llx\n",
>> +                           mask, addr, bar,
>> +                           (unsigned long long)bar_start,
>> +                           (unsigned long long)(bar_start + bar_len));
>> +                    return RTAS_INVALID_PARAMETER;
>> +                }
>> +
>> +                pr_debug("addr=0x%lx with mask=0x%lx validated in 
>> BAR[%d] of %s\n",
>> +                     addr, mask, bar, pci_name(pdev));
>> +                valid = true;
>> +            }
>> +        }
>> +    }
>> +
>> +    if (!valid) {
>> +        pr_err("addr=0x%lx not valid within any BAR of any device in 
>> PE\n",
>> +               addr);
>> +        return RTAS_INVALID_PARAMETER;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * validate_err_type - Basic sanity check for RTAS error type
>> + * @type: RTAS error type
>> + *
>> + * Ensures that the error type is within the valid RTAS error type 
>> range.
>> + *
>> + * Return: true if valid, false otherwise.
>> + */
>> +
>> +static bool validate_err_type(int type)
>> +{
>> +    if (type < RTAS_ERR_TYPE_FATAL ||
>> +        type > RTAS_ERR_TYPE_UPSTREAM_IO_ERROR)
>> +        return false;
>> +
>> +    return true;
>> +}
>
> How about defining this and the function below as inline?
To make all functions look alike.
>
>> +
>> +/**
>> + * validate_special_event - Validate parameters for special-event 
>> injection
>> + * @addr: Address parameter (should be zero)
>> + * @mask: Mask parameter (should be zero)
>> + *
>> + * Special-event error injection should not take addr/mask. Rejects 
>> if either
>> + * is set.
>> + *
>> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
>> + */
>> +
>> +static int validate_special_event(unsigned long addr, unsigned long 
>> mask)
>> +{
>> +    if (addr || mask) {
>> +        pr_err("Special-event should not specify addr/mask\n");
>> +        return RTAS_INVALID_PARAMETER;
>> +    }
>> +    return 0;
>> +}
>> +
>> +/**
>> + * validate_corrupted_page - Validate parameters for corrupted-page 
>> injection
>> + * @pe:   EEH PE (__maybe_unused)
>> + * @addr: Physical page address (required)
>> + * @mask: Address mask (ignored if non-zero)
>> + *
>> + * Ensures a valid non-zero page address is provided. Warns if mask 
>> is set.
>> + *
>> + * Return: 0 if valid, RTAS_INVALID_PARAMETER otherwise.
>> + */
>> +
>> +static int validate_corrupted_page(struct eeh_pe *pe __maybe_unused,
>> +                   unsigned long addr, unsigned long mask)
>
> pe is not used in this function and it is removed in the next patch. 
> Why don't
> we define this function properly in this patch itself.
agree.
>
>> +{
>> +    if (!addr) {
>> +        pr_err("corrupted-page requires non-zero addr\n");
>> +        return RTAS_INVALID_PARAMETER;
>> +    }
>> +    /* Mask not meaningful for corrupted-page */
>
> If it is not meaningful why can't we ignore it?
Agreed. The mask has no meaning for corrupted-page injection, so
  I will remove it from the validator and silently ignore the 
caller-provided
mask instead of printing a warning.
>
>> +    if (mask)
>> +        pr_warn("corrupted-page ignoring mask=0x%lx\n", mask);
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * validate_ioa_bus_error - Validate parameters for IOA bus error 
>> injection
>> + * @pe:   EEH PE whose BARs are validated against
>> + * @addr: Address parameter (optional)
>> + * @mask: Mask parameter (optional)
>> + *
>> + * For IOA bus error injections, @addr and @mask are optional. If 
>> present,
>> + * they must map into the PE's MMIO/CFG space.
>> + *
>> + * Return: 0 if valid or addr/mask absent, RTAS_INVALID_PARAMETER 
>> otherwise.
>> + */
>> +
>> +static int validate_ioa_bus_error(struct eeh_pe *pe,
>> +                  unsigned long addr, unsigned long mask)
>> +{
>> +    /* Must map into BAR/MMIO/CFG space of PE */
>> +    return validate_addr_mask_in_pe(pe, addr, mask);
>
> What is the benefit of adding a static helper function that just calls 
> another
> static helper function in the same file?
>
>
>> +}
>> +
>> +
>> +/**
>> + * prepare_errinjct_buffer - Prepare RTAS error injection work buffer
>> + * @pe:   EEH PE for the target device(s)
>> + * @type: RTAS error type
>> + * @func: Error function selector (semantics vary by type)
>> + * @addr: Address argument (type-dependent)
>> + * @mask: Mask argument (type-dependent)
>
> Isn't the caller of this helper expected to hold 
> rtas_errinjct_buf_lock? If that is
> the case, let's document it.
Yes, the caller is expected to hold |rtas_errinjct_buf_lock|. I will 
document that
requirement in the kernel-doc comment for |prepare_errinjct_buffer()|.
>
>> + *
>> + * Clears the global error injection work buffer and populates it 
>> based on
>> + * the error type and parameters provided. Performs inline 
>> validation of the
>> + * arguments for each supported error type.
>> + *
>> + * Return: 0 on success, or RTAS_INVALID_PARAMETER / -EINVAL on 
>> failure.
>> + */
>> +
>> +static int prepare_errinjct_buffer(struct eeh_pe *pe, int type, int 
>> func,
>> +                   unsigned long addr, unsigned long mask)
>> +{
>> +    __be64 *buf64;
>> +    __be32 *buf32;
>> +
>> +    memset(rtas_errinjct_buf, 0, RTAS_ERRINJCT_BUF_SIZE);
>> +    buf64 = (__be64 *)rtas_errinjct_buf;
>> +    buf32 = (__be32 *)rtas_errinjct_buf;
>> +
>> +    switch (type) {
>> +    case RTAS_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
>> +        /* func must be 1 = non-persistent or 2 = persistent */
>> +        if (func < 1 || func > 2)
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        if (validate_special_event(addr, mask))
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        buf32[0] = cpu_to_be32(func);
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_CORRUPTED_PAGE:
>> +        /* addr required: physical page address */
>> +        if (addr == 0)
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        if (validate_corrupted_page(pe, addr, mask))
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        buf32[0] = cpu_to_be32(upper_32_bits(addr));
>> +        buf32[1] = cpu_to_be32(lower_32_bits(addr));
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>> +        /* 32-bit IOA bus error: addr/mask optional */
>> +        if (func < EEH_ERR_FUNC_LD_MEM_ADDR || func > EEH_ERR_FUNC_MAX)
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        if (addr || mask) {
>> +            if (validate_ioa_bus_error(pe, addr, mask))
>> +                return RTAS_INVALID_PARAMETER;
>> +        }
>> +
>> +        buf32[0] = cpu_to_be32((u32)addr);
>> +        buf32[1] = cpu_to_be32((u32)mask);
>> +        buf32[2] = cpu_to_be32(pe->addr);
>> +        buf32[3] = cpu_to_be32(BUID_HI(pe->phb->buid));
>> +        buf32[4] = cpu_to_be32(BUID_LO(pe->phb->buid));
>> +        buf32[5] = cpu_to_be32(func);
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
>> +        /* 64-bit IOA bus error: addr/mask optional */
>> +        if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>> +            return RTAS_INVALID_PARAMETER;
>> +
>> +        if (addr || mask) {
>> +            if (validate_ioa_bus_error(pe, addr, mask))
>> +                return RTAS_INVALID_PARAMETER;
>> +        }
>> +
>> +        buf64[0] = cpu_to_be64(addr);
>> +        buf64[1] = cpu_to_be64(mask);
>> +        buf32[4] = cpu_to_be32(pe->addr);
>> +        buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
>> +        buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
>> +        buf32[7] = cpu_to_be32(func);
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_DCACHE_END:
>> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_ICACHE_END:
>> +        /* addr/mask optional, no strict validation */
>> +        buf32[0] = cpu_to_be32(addr);
>> +        buf32[1] = cpu_to_be32(mask);
>> +        break;
>> +
>> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_START:
>> +    case RTAS_ERR_TYPE_CORRUPTED_TLB_END:
>> +        /* only addr field relevant */
>> +        buf32[0] = cpu_to_be32(addr);
>> +        break;
>> +
>> +    default:
>> +        pr_err("Unsupported error type 0x%x\n", type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    pr_debug("RTAS: errinjct buffer prepared: type=%d func=%d 
>> addr=0x%lx mask=0x%lx\n",
>> +         type, func, addr, mask);
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>    * @pe: the indicated PE
>
Thanks,
Narayana


