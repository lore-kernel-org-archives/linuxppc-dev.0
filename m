Return-Path: <linuxppc-dev+bounces-29691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F220ECCF2DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:46:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7W0Z2r76z2yYd;
	Mon, 19 Oct 2026 20:46:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792403214;
	cv=none; b=Frr+S3vCZ/ryLXVNQw6+3djDTCmCYONrOoKGLxOweuhC7iq6NWFwkOWARNW+v3zTZGyy3mPhQcrzB41rvlg/99lOocX/Nyn8bTPZf3cfrJB+6DFp0r5k9bI+y90Jim0tjLAKwc7Tnm00LA+HvS2mPn1OAejTDAXJK1Nlw+DQV1bEB10xCvev/D89q/Mjtz5tlRakQoEL0kdtEhf4JJlKHhJThUGMDPTnMPCwhk+FwL7T58XwsDbmZ3kgxg3tIhY9vXgIt+6IxZPRLJllNhQfbHpnxyTzjZhZTjhdLQzBi6IIGfI8wqhVHyOGS+XTuwkKXcduwTvMIZEIMGUlLJsnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792403214; c=relaxed/relaxed;
	bh=wnf1Rf7FRKXzjsj/SvI8Euz6pjCJ+tLErOXZgzPSuhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdSp4keCotxKnOmO5MVF6fjsUmLpT6z8aHAXTmPsqtu0CyUoWXFK+893MWGqTRV7nxcG04IqdyLlobthSeBaU4Xr/+wcFVfehZpFztL/fYMN26wOHy+0Ce3wSRpsO6vPj7e2MtpywkFANdwFJGD/nnQpk7A2tK6UiTW1XVequcVyvgok8XVoNBeuIR0Hl3JZn7GloI8Qfp9AvFJ2F/vj+ordK3kd0ocjqh4qrkiy25xJ1Rf9SUx4JMQX++rzSGbwqa1Epz1HjLw9xLvQ3mnK817W9XtVj/+DSe9JbHJa/mCh8KNLMd38voP1z9gIpwn4DzTSY+MypmlKmm2XwPf6uA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sb4eOw9h; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sb4eOw9h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7W0Y3WKQz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:46:53 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iMWm3451052;
	Mon, 19 Oct 2026 09:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wnf1Rf
	7FRKXzjsj/SvI8Euz6pjCJ+tLErOXZgzPSuhE=; b=sb4eOw9hxidjXN8N/FKG5W
	MS0xQoQOHNJdleyp/LAzF+mhYC05cV5PxS1lSaE6vPnbVgjIUWHM/ZowQdL7eJ5O
	10Qwwbr4ET1sQsYBJI1hZOLfkoHl4pZ0FG44g33CnQVKfplRmKAboDPVmn4o6x2R
	jvoVBc2J/B6Nao/1512wNxPCTINC4LMgbUMWnjy6350QDEuMW0qiMoBkJ1aaNps5
	27MkVbHZfqxi/fnulRrrvLvDMZoNKL7304mY4r1PQPZAAOBOHgvgv3eOnqEJ/54v
	TJUm72O1xmJrwF+q0rT+K8ufITcBJMSFZ90UmJcBZ25XFgSoQ9BEelL+CK1iFCwA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h5aea5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:46:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YuYe2651399;
	Mon, 19 Oct 2026 09:46:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgvxbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:46:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69J9kSuj50856284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 09:46:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75E6D20040;
	Mon, 19 Oct 2026 09:46:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 307C82004B;
	Mon, 19 Oct 2026 09:46:25 +0000 (GMT)
Received: from [9.124.217.62] (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 09:46:24 +0000 (GMT)
Message-ID: <c2a7f29b-1357-454a-bc8c-8d19657472d9@linux.ibm.com>
Date: Mon, 19 Oct 2026 15:16:24 +0530
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
Subject: Re: [PATCH v4 3/5] powerpc/pseries/eeh: Add RTAS error validation
 helpers
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-4-nnmlinux@linux.ibm.com>
 <89e3286d-4995-4180-976c-285ba8a99785@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <89e3286d-4995-4180-976c-285ba8a99785@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfXzerLSGUrgrOi
 yo7tw2sZf2qQCvHgbKb7k6IejAMZaJ89MA2leE5QlFEH7Uv4OleIJHofdGS7ImVANj4ChVX9DDI
 f0Oubh+gX3dgrQoyqnPqD6yqVPxg6cg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX9t2z1IGp+GZZ
 irEpetyUKpfawJbjrWFE9dBiHjGoP7eIZtzqH6btFAHm6N43dj7vO8gTz7/OFkWRiIYminhOuhr
 gV+u4Ekeotk9qh3g/f67O8DuhVPjAfHz4cEL2lPIgwxXL8rLpH2FioV0fjkVQBLrJQCcD9sSJ63
 rdukIbBFk7LBVzyABJOzMthHaH/XiEG+z2/WJg+J0hx29nV89wkx/X5hkK3erYMAQQitcavaPhu
 wCAiEADtDybfTQOvM5xO7iL9oqUhks6st919YFiaOszS6fKfRpawW4XpM/KzLKa6rg1hpOQfUVG
 Gg8bppzPRpGwzJ3Xo4CCD4rGY1eTmlDVb37RchV6E14mBB+N8nqnZg+twbK/BWW0yQ/brnUr8mh
 uAYoKwHmmsdjozp9JhoKs8WaCcuyHJy3O/hP4IpLBHl+MHDzQhkwvYDhCSEtP60Vb4ctTs1bBez
 KCB5qjKAFr+y34m+4WA==
X-Proofpoint-ORIG-GUID: dFzEFcn44jn4uK-zmrsIN0R6OWyvLC79
X-Proofpoint-GUID: qR6eJNbjW--4Z6CiGFZbAQbhhXwDa-e9
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad5e6fa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8 a=HyaG-9bC87c7v6hrdZUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

Hi Sourabh,

On 23/09/26 5:46 PM, Sourabh Jain wrote:
> 
> On 31/08/26 12:24, Narayana Murty N wrote:
>> Add pseries-specific infrastructure for RTAS-based EEH error injection.
>>
>> Define pr_fmt unconditionally at the top of eeh_pseries.c so all
>> pr_*() calls carry the "EEH: " prefix:
>>
>>    #define pr_fmt(fmt) "EEH: " fmt
> 
> Could you please describe the overall goal of the helpers introduced by
> this patch first, before discussing pr_fmt and the other macros?
> 
Agreed. I reworked the commit message in v5 to start with the purpose of 
the helpers: mapping the generic EEH types, validating the injection 
arguments and target address, and constructing the PAPR ibm,errinjct 
parameter buffer.

The implementation details such as pr_fmt and the RTAS constants follow 
that description.

>>
>> Define RTAS firmware error-type encodings as file-local constants.
>> Only the two IOA bus-error types are supported; other PAPR encodings
>> are not reachable through the generic EEH_ERR_TYPE_* UAPI:
>>
>>    RTAS_ERR_TYPE_IOA_BUS_ERROR     0x07
>>    RTAS_ERR_TYPE_IOA_BUS_ERROR_64  0x0f
>>
>> Add RTAS_ERRINJCT_BUF_SIZE for the ibm,errinjct work buffer size.
>>
>> Add pseries_eeh_type_to_rtas() to translate the two generic EEH error
>> types (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64) into the corresponding RTAS
>> ibm,errinjct encodings.
>>
>> Add validate_addr_mask_in_pe() to verify that a caller-provided address
>> falls within a BAR of some device in the PE.  RTAS IOA bus-error
>> injection requires a PCI/IOA bus address; validate_addr_mask_in_pe()
>> accepts only PCI bus addresses.  VFIO userspace resource addresses are
>> normalized to PCI bus addresses in vfio_iommu_spapr_tce.c before
>> reaching this backend; no resource-address fallback is added here.
>> Use pcibios_resource_to_bus() to convert each BAR resource to PCI bus
>> address space before validating the address.  Returns -EINVAL (Linux
>> errno) rather than a raw RTAS status.
>>
>> Add validate_errinjct_args() as a top-level validation wrapper that
>> checks the PE pointer, maps the generic type, and validates the function
>> range.  Address/mask validation against BARs is done in the buffer
>> preparation step.
>>
>> Add prepare_errinjct_buffer() which:
>>    - guards against NULL buf/pe/pe->phb
>>    - zeroes the buffer unconditionally with memset()
>>    - checks 32-bit truncation for the IOA_BUS_ERROR case
>>    - calls validate_addr_mask_in_pe() for address validation
>>    - supports only the IOA bus-error types (unreachable non-IOA
>>      RTAS cases removed)
>> The caller provides an exclusive per-call RTAS work-area buffer.
>> Firmware session serialization is left to the caller.
>>
>> pseries_eeh_err_inject() retains the existing MMIO injection body
>> unchanged in this patch.  It is replaced by the full RTAS session
>> implementation in the next patch.  This keeps the patch bisectable:
>> each commit builds and functions correctly independently.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202512101130.EYUo0oZx- 
>> lkp@intel.com/
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 215 +++++++++++++++++++
>>   1 file changed, 215 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/ 
>> powerpc/platforms/pseries/eeh_pseries.c
>> index b12ef382fec7..fafe0004e738 100644
>> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
>> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
>> @@ -12,6 +12,8 @@
>>    * Copyright Linas Vepstas 2005, 2006
>>    */
>> +#define pr_fmt(fmt) "EEH: " fmt
>> +
>>   #include <linux/atomic.h>
>>   #include <linux/delay.h>
>>   #include <linux/export.h>
>> @@ -786,6 +788,219 @@ static int pseries_notify_resume(struct eeh_dev 
>> *edev)
>>   }
>>   #endif
>> +/*
>> + * RTAS firmware error-type encodings (PAPR).  These are pseries- 
>> private;
>> + * user-space sees only the generic EEH_ERR_TYPE_* values from eeh.h.
>> + * Only IOA bus-error types are supported; other PAPR encodings are not
>> + * reachable through the generic EEH_ERR_TYPE_* UAPI.
>> + */
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR        0x07
>> +#define RTAS_ERR_TYPE_IOA_BUS_ERROR_64        0x0f
>> +
>> +/* Size of the ibm,errinjct work buffer as defined by PAPR */
>> +#define RTAS_ERRINJCT_BUF_SIZE            SZ_1K
>> +
>> +/**
>> + * pseries_eeh_type_to_rtas - Map generic EEH error type to RTAS 
>> encoding
>> + * @type: generic EEH error type (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64)
>> + *
>> + * Translates the generic VFIO/EEH error type passed from userspace into
>> + * the RTAS-specific ibm,errinjct error type encoding defined by PAPR.
>> + *
>> + * Return: RTAS error type on success, -EINVAL for unknown types.
>> + */
>> +static int pseries_eeh_type_to_rtas(int type)
>> +{
>> +    switch (type) {
>> +    case EEH_ERR_TYPE_32:
>> +        return RTAS_ERR_TYPE_IOA_BUS_ERROR;
>> +    case EEH_ERR_TYPE_64:
>> +        return RTAS_ERR_TYPE_IOA_BUS_ERROR_64;
>> +    default:
>> +        return -EINVAL;
>> +    }
>> +}
>> +
>> +/**
>> + * validate_addr_mask_in_pe - Validate addr against PCI bus BAR 
>> addresses in PE
>> + * @pe:   EEH PE containing one or more PCI devices
>> + * @addr: PCI bus address to validate
>> + * @mask: address mask (passed to firmware unchanged)
>> + *
>> + * RTAS IOA bus-error injection uses PCI bus addresses.  Linux PCI 
>> resources
>> + * are CPU/resource addresses and may differ on pseries due to PHB 
>> window
>> + * translation.  Convert each BAR resource to PCI bus address space 
>> before
>> + * validating @addr.
>> + *
>> + * Zero addr and mask are accepted without BAR lookup (no-address 
>> injection).
>> + *
>> + * Return: 0 if valid, -EINVAL on invalid input.
>> + */
>> +static int validate_addr_mask_in_pe(struct eeh_pe *pe, unsigned long 
>> addr,
>> +                    unsigned long mask)
>> +{
>> +    struct pci_bus_region region;
>> +    struct eeh_dev *edev, *tmp;
>> +    struct pci_dev *pdev;
>> +    struct resource *res;
>> +    resource_size_t bus_start;
>> +    resource_size_t bus_len;
>> +    int bar;
>> +
>> +    if (!addr && !mask)
>> +        return 0;
>> +
>> +    if (!pe)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * RTAS IOA bus-error injection uses PCI bus addresses. Linux PCI
>> +     * resources are CPU/resource addresses and may differ on pseries 
>> due
>> +     * to PHB window translation. Convert each BAR resource to PCI bus
>> +     * address space before validating @addr.
>> +     */
>> +    eeh_pe_for_each_dev(pe, edev, tmp) {
>> +        pdev = eeh_dev_to_pci_dev(edev);
>> +        if (!pdev)
>> +            continue;
>> +
>> +        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>> +            res = &pdev->resource[bar];
>> +
>> +            if (!resource_size(res))
>> +                continue;
>> +
>> +            if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> +                continue;
>> +
>> +            pcibios_resource_to_bus(pdev->bus, &region, res);
>> +
>> +            bus_start = region.start;
>> +            bus_len = resource_size(res);
>> +
>> +            if ((resource_size_t)addr >= bus_start &&
>> +                ((resource_size_t)addr - bus_start) < bus_len) {
>> +                pr_debug("addr=0x%lx mask=0x%lx validated in PCI bus 
>> BAR[%d] of %s: bus range 0x%llx-0x%llx\n",
>> +                     addr, mask, bar, pci_name(pdev),
>> +                     (unsigned long long)region.start,
>> +                     (unsigned long long)region.end);
>> +                return 0;
>> +            }
>> +        }
>> +    }
>> +
>> +    pr_err("addr=0x%lx mask=0x%lx not within any PCI bus BAR of any 
>> device in PE\n",
>> +           addr, mask);
>> +    return -EINVAL;
>> +}
>> +
>> +/**
>> + * validate_errinjct_args - Top-level validation for RTAS error 
>> injection arguments
>> + * @pe:   EEH PE for the target device
>> + * @type: generic EEH error type
>> + * @func: error function selector
>> + * @addr: address argument (type-dependent, may be zero)
>> + * @mask: mask argument (type-dependent, may be zero)
>> + *
>> + * Validates all parameters before opening an RTAS injection session.
>> + * Returns Linux errno values; does not return raw RTAS status codes.
>> + *
>> + * Return: 0 if all parameters are valid, negative errno otherwise.
>> + */
>> +static int validate_errinjct_args(struct eeh_pe *pe, int type, int func,
>> +                  unsigned long addr, unsigned long mask)
>> +{
>> +    if (!pe || !pe->phb)
>> +        return -EINVAL;
>> +
>> +    if (pseries_eeh_type_to_rtas(type) < 0)
>> +        return -EINVAL;
>> +
>> +    if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>> +        return -EINVAL;
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * prepare_errinjct_buffer() - Build ibm,errinjct work buffer
>> + * @buf: RTAS error-injection work buffer
>> + * @pe: EEH PE associated with the injection target
>> + * @rtas_type: RTAS firmware error-injection type
> 
> rtas_type is confusing to me. How about err_type?
Agreed on making the distinction clearer. In v5 I renamed it to 
rtas_err_type, since this value is specifically the RTAS/PAPR 
error-injection type after mapping from the generic EEH type.
> 
>> + * @func: Error function selector
>> + * @addr: Target PCI bus address
>> + * @mask: Address mask passed to firmware
>> + *
>> + * Zeroes @buf and populates it according to the PAPR layout for the
>> + * selected IOA bus-error injection type.
>> + *
>> + * The caller provides an exclusive per-call RTAS work-area buffer.
>> + * Firmware session serialization is handled by 
>> pseries_eeh_err_inject().
>> + *
>> + * Return: 0 on success or a negative errno on invalid input.
>> + */
>> +static int prepare_errinjct_buffer(void *buf, struct eeh_pe *pe,
>> +                   int rtas_type, int func,
>> +                   unsigned long addr, unsigned long mask)
>> +{
>> +    __be64 *buf64 = (__be64 *)buf;
>> +    __be32 *buf32 = (__be32 *)buf;
>> +    int rc;
>> +
>> +    if (!buf || !pe || !pe->phb)
>> +        return -EINVAL;
>> +
>> +    memset(buf, 0, RTAS_ERRINJCT_BUF_SIZE);
>> +
>> +    switch (rtas_type) {
>> +    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
>> +        if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>> +            return -EINVAL;
> 
> This condition is common for both cases, so let take it out of switch.
> And lets move the func check before memset.
Agreed.

In v5 the function-range check is moved out of the type-specific switch 
and is owned by validate_errinjct_args(), which runs before 
prepare_errinjct_buffer().

prepare_errinjct_buffer() therefore no longer duplicates the function 
validation and can zero/build the buffer after the common arguments have 
already been validated.

Thanks,
Narayana
> 
>> +
>> +        if (upper_32_bits(addr) || upper_32_bits(mask)) {
>> +            pr_err("32-bit IOA injection cannot encode addr=%#lx 
>> mask=%#lx\n",
>> +                   addr, mask);
>> +            return -EINVAL;
>> +        }
>> +
>> +        rc = validate_addr_mask_in_pe(pe, addr, mask);
>> +        if (rc)
>> +            return rc;
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
>> +        if (func < EEH_ERR_FUNC_MIN || func > EEH_ERR_FUNC_MAX)
>> +            return -EINVAL;
>> +
>> +        rc = validate_addr_mask_in_pe(pe, addr, mask);
>> +        if (rc)
>> +            return rc;
>> +
>> +        buf64[0] = cpu_to_be64(addr);
>> +        buf64[1] = cpu_to_be64(mask);
>> +        buf32[4] = cpu_to_be32(pe->addr);
>> +        buf32[5] = cpu_to_be32(BUID_HI(pe->phb->buid));
>> +        buf32[6] = cpu_to_be32(BUID_LO(pe->phb->buid));
>> +        buf32[7] = cpu_to_be32(func);
>> +        break;
>> +
>> +    default:
>> +        pr_err("unsupported RTAS error injection type 0x%x\n", 
>> rtas_type);
>> +        return -EINVAL;
>> +    }
>> +
>> +    pr_debug("errinjct buffer ready: rtas_type=0x%x func=%d 
>> addr=0x%lx mask=0x%lx\n",
>> +         rtas_type, func, addr, mask);
>> +    return 0;
>> +}
>> +
>>   /**
>>    * pseries_eeh_err_inject - Inject specified error to the indicated PE
>>    * @pe: the indicated PE
> 


