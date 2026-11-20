Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58A606A325
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i9BFe3Nu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jW6bY54DWz2xdR;
	Fri, 20 Nov 2026 18:36:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795160201;
	cv=none; b=k0/uWeWCoE2Tlsk5UIhaUmheSeeGfGd4oDyvyma9bP14q6s7IgqRH4EuR4YGc3070F96PXdmCvIjLJBPQeU4q0spmEhE41NaZdvNvYiBVdLac7ePnNX0XoaTKqTRSxGk4HTbFnFtjWwZAdzWzahNJQeLmdu8eZ3aBNGESdGoHiUHn+OoS+mFBmILyC8e6WBm7FlV2GnUDcyKBpgwMrnh2kX2ONHHP8cKzsw1WtoFzYZGT4UK0lViklNaX61l7tZjhtUblYvIxt21Ufy1H2du3VfWHZlybDyniekoMgf0aaWldTtvAJyNiSdhQwOKsEh3rMgr4ioxU2bT5Fz/jtoRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795160201; c=relaxed/relaxed;
	bh=Gf79QGlo4p/BT892f1cWSXKitqVR068o7afdf18RiRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLbwseXg9xa+zI422oa4nhS9rE6JNB2eGzOpS0YQBkGABLU2NlOzGMC2QXVrSIewvy8eMSwC+95HYm7CapFsRkrkWOMtZPjxFM5TkJkYZ7GYPDmRqQmPt/Fb+oWRBkTh2sj60Q9A6BTQ48f1fjV3l7/3GuoPi5MaR4UygAePC/BUYjgi+af4k2HxziBSR6aMu4PQ3rKxjop52mRJ9sMOqeh9xRWmkMz1J+aGLt25Y/r7w3kwVjvBRoDjIdVuP//yEk0vGEAk05GI2V9gsftszaIf7VWXrT9E0axSpAC+Dos3DaBedRUWsgw9hQRLz4wyww7mZhSnE1iiXYkTkGtWSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i9BFe3Nu; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i9BFe3Nu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jW6bX2P0pz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 18:36:40 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK3uL80775758;
	Fri, 20 Nov 2026 07:36:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Gf79QG
	lo4p/BT892f1cWSXKitqVR068o7afdf18RiRw=; b=i9BFe3Nu3epmndzVYOz/nQ
	XROa2C/vCm5xt0rUK8fDuICLmSPYwXwF9Y9Pe/7TB9+H0iqN7Id541gnCYUHYSLO
	XOj7u5udwdbwfYURs+W3KafRME71fkx83uByl0WFwgthq8TwCoGVLtscvReJA5Hg
	6HbEmS06Dgno5jnB90sAjgQHa+GqAzpQHnMKNM4mtKUZ3QcQ2juo8VDaOyI6zSg2
	8BHjVBvsvrsEKRile6345gq4R6+OPzgR5vZUC19EmegDEJ52N9LPzPEb/aP1kdkI
	oDQLY02Q1w9tdYbOX8jZXxc0epsUyz0OqDd42CBLMnl69GaPKdSjsnKlr3jqdCiQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w6g3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:36:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7FTGN1655863;
	Fri, 20 Nov 2026 07:36:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j0ur1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 07:36:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK7aNHc51970426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 07:36:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 051132004E;
	Fri, 20 Nov 2026 07:36:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7331920040;
	Fri, 20 Nov 2026 07:36:19 +0000 (GMT)
Received: from [9.124.218.70] (unknown [9.124.218.70])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 07:36:19 +0000 (GMT)
Message-ID: <1b52c142-116c-4a9e-af19-578a9a71e3f3@linux.ibm.com>
Date: Fri, 20 Nov 2026 13:06:18 +0530
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
Subject: Re: [PATCH v6 4/5] vfio/spapr_tce: Normalize EEH IOA error injection
 addresses
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-5-nnmlinux@linux.ibm.com>
 <518b5813-ab4e-413e-9820-556888216090@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <518b5813-ab4e-413e-9820-556888216090@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1wb5r0GhykOK8MUtHIbS02RWLI06OP1g
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afff87b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ndujvMo2dnuvSWxAOzYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: R-JrSAq6i-WJxETjsmm3DTGCViBCCz3_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfX8Udd4yTQanuo
 5pnjkbTLXBZmK6gXnC+N2/a2nuS6egSl+S0EPQz2LzY8Nk3K1E0ffcwUk4NdikbIENDyh6P7rMZ
 bLFqNNkx0TXEKDXE4qEk/fvyQcKt/cA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyOSBTYWx0ZWRfXxFWqblhip4bs
 gPw3iWEf3DDgY/sHrBuy6Esjx0yYb1XSIhK73i5+Cq1Iq2dBuiFBkIWL8s05wND2T2ZRGp5GARP
 FKpJp0mr4lv7ys5TYzxBXSRjwsEhcWOFU5Y33czQGtyKr4EOpA9NFnJ/z61AUcSL2qBnOV1UgcA
 jGQZ5CkFakt8PUBp0Kzv6p79t9JSN6IM+g+E4joN7wFm99xaBq2lqv5ih8+u/N2GtdAIl05f8VC
 qabHH7cmcpbTB5Cn1ZwcoV47O6aogoMKPv8+rhjbKib0D/BPaXJ2lAi1CISFKI93mIz/uFE2wrb
 CLwNOHyO6j+xKjG8JTmGwRKLvfU0nHijYpReKDTZz/6tWBlYLawgwPrez07PLjEmS0YsxrPp2KA
 +EAQLh2KeAY4/t5fixuHzAJVwlwVFTCSXDNHE6zWV7lyvmxJmCwcWKPHLHoPOmATIXMSv33vaWh
 MOoUt95pA55J8x4g16g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200029
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 19/11/26 1:05 AM, Sourabh Jain wrote:
>   I'm finding this commit message a bit difficult to follow.
> Could you please rework it to make the changes and their purpose clearer?
> 
Agreed. I'll rework the commit message to focus on why address
translation is needed in the VFIO EEH path.
> On 23/10/26 13:06, Narayana Murty N wrote:
>> VFIO_EEH_PE_INJECT_ERR receives a target address from userspace.  For
>> userspace such as QEMU, this address may be derived from the host Linux
>> BAR resource.  The platform EEH backends, however, expect the PCI/IOA
>> bus address used by firmware error-injection interfaces.
>>
>> Normalize IOA/MMIO error-injection addresses in the sPAPR VFIO EEH
>> ioctl path before dispatching to eeh_pe_inject_err().  If the supplied
>> address is already a PCI bus BAR address it is left unchanged.  If it is
>> a Linux resource address, translate it to the corresponding PCI bus
>> address using the BAR-relative offset.
>>
>> Normalization applies only to EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 error
>> types whose error function targets a memory or IO BAR (load/store memory
>> and load/store IO functions, func 0-3 and 6-9).  Config-space functions
>> carry PCI config register offsets and DMA functions carry IOVA/TCE
>> addresses; these address domains are not PCI BAR addresses and must not
>> be translated.  Applying BAR normalization to them would incorrectly
>> return -EINVAL, blocking injection entirely for those function codes.
>>
>> An address and mask pair of zero represents a no-address injection
>> (e.g. a function-level error with no specific IOA target) and is passed
>> through without BAR translation.
>>
>> Only standard BARs (BAR0..BAR5) are searched; ROM and bridge resources
>> are not IOA bus-error targets.  Unassigned or disabled BARs are skipped:
>> pci_resource_len() returns 0 for zero-initialized BARs, and the
>> IORESOURCE_UNSET and IORESOURCE_DISABLED flags are checked explicitly to
>> avoid false matches against unassigned resources.  Hold
>> pci_rescan_remove_lock while traversing PE devices and their BAR
>> resources to prevent PCI device removal from racing the lookup.
>>
>> A pr_debug() is emitted if the address cannot be matched to any BAR, to
>> aid debugging without producing noise in the normal path.
> Which address are you referring to?
> 
The target address supplied by userspace through
VFIO_EEH_PE_INJECT_ERR, which may be a Linux resource address or
a PCI bus address.

I'll make this explicit in the commit message.
> 
>>
>> Keep the helper local to VFIO so the address semantics of other
>> in-kernel EEH callers remain unchanged.
> 
> Which helper are you referring to?
> 
I was referring to vfio_spapr_eeh_normalize_addr().

The intention is to keep the resource-to-bus address translation
local to the VFIO path without changing the address semantics of
other EEH callers.
> 
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 140 ++++++++++++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/ 
>> vfio_iommu_spapr_tce.c
>> index 1c0eec228cc6..d831adaa69fb 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -774,6 +774,131 @@ static long 
>> tce_iommu_create_default_window(struct tce_container *container)
>>       return ret;
>>   }
>> +/*
>> + * eeh_func_needs_bar_addr - return true for error functions whose addr
>> + * argument is a PCI MMIO or IO BAR address.
>> + *
>> + * Memory and IO load/store functions target specific BAR addresses.
>> + * Config-space functions carry PCI config register offsets, and DMA
>> + * functions carry IOVA/TCE addresses; neither requires BAR translation.
>> + */
>> +static bool eeh_func_needs_bar_addr(int func)
>> +{
>> +    switch (func) {
>> +    case EEH_ERR_FUNC_LD_MEM_ADDR:
>> +    case EEH_ERR_FUNC_LD_MEM_DATA:
>> +    case EEH_ERR_FUNC_LD_IO_ADDR:
>> +    case EEH_ERR_FUNC_LD_IO_DATA:
>> +    case EEH_ERR_FUNC_ST_MEM_ADDR:
>> +    case EEH_ERR_FUNC_ST_MEM_DATA:
>> +    case EEH_ERR_FUNC_ST_IO_ADDR:
>> +    case EEH_ERR_FUNC_ST_IO_DATA:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
>> +}
>> +
>> +static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
>> +                     unsigned long addr,
>> +                     unsigned long mask,
> Do we really need mask argument?
> 

The mask argument is currently used only to identify the no-address
injection case where both addr and mask are zero.

I'll move that check to the ioctl caller and remove the mask
argument from the normalization helper.

>> +                     unsigned long *normalized)
> 
> Too much in a single function. Can you split this function as suggested
> for validate_addr_mask_in_pe() in 2/5.
> 
Agreed. I'll separate the per-device BAR matching and address.

> - Sourabh Jain
> 
>> +{
>> +    struct pci_bus_region region;
>> +    struct eeh_dev *edev, *tmp;
>> +    struct pci_dev *pdev;
>> +    struct resource *res;
>> +    resource_size_t pci_start, pci_len;
>> +    resource_size_t res_start, res_len;
>> +    resource_size_t offset;
>> +    int bar, rc = -EINVAL;
>> +
>> +    if (!pe || !normalized)
>> +        return -EINVAL;
>> +
>> +    /*
>> +     * addr == 0 and mask == 0 indicates a no-address injection (e.g.
>> +     * function-level error with no specific IOA target).  No BAR
>> +     * translation needed.
>> +     */
>> +    if (!addr && !mask) {
>> +        *normalized = addr;
>> +        return 0;
>> +    }
>> +
>> +    /*
>> +     * Walk standard BARs (BAR0..BAR5) of all devices in the PE.
>> +     * Hold pci_rescan_remove_lock to protect pdev lifetime during the
>> +     * traversal: pci_stop_and_remove_bus_device() requires this lock.
>> +     * ROM and bridge resources are not IOA bus-error targets, so the
>> +     * search is limited to PCI_STD_NUM_BARS.
>> +     */
>> +    pci_lock_rescan_remove();
>> +    eeh_pe_for_each_dev(pe, edev, tmp) {
>> +        pdev = eeh_dev_to_pci_dev(edev);
>> +        if (!pdev)
>> +            continue;
>> +
>> +        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>> +            res = &pdev->resource[bar];
>> +
>> +            /*
>> +             * Skip unassigned or disabled BARs.  On pseries,
>> +             * pcibios_fixup_resources() zero-bases unassigned BARs
>> +             * (start=0, end=size-1) and sets IORESOURCE_UNSET.
>> +             * Use pci_resource_len() which returns 0 when end==0.
>> +             */
>> +            if (!pci_resource_len(pdev, bar))
>> +                continue;
>> +
>> +            if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> +                continue;
>> +
>> +            if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
>> +                continue;
>> +
>> +            pcibios_resource_to_bus(pdev->bus, &region, res);
>> +
>> +            pci_start = region.start;
>> +            pci_len = pci_resource_len(pdev, bar);
>> +
>> +            /*
>> +             * Case 1: userspace already supplied PCI/IOA
>> +             * bus address.
>> +             */
>> +            if ((resource_size_t)addr >= pci_start &&
>> +                ((resource_size_t)addr - pci_start) < pci_len) {
>> +                *normalized = addr;
>> +                rc = 0;
>> +                goto done;
>> +            }
>> +
>> +            /*
>> +             * Case 2: userspace supplied Linux resource/CPU
>> +             * address.  Convert it back to PCI/IOA bus address
>> +             * before calling the platform EEH backend.
>> +             */
>> +            res_start = res->start;
>> +            res_len = pci_resource_len(pdev, bar);
>> +
>> +            if ((resource_size_t)addr >= res_start &&
>> +                ((resource_size_t)addr - res_start) < res_len) {
>> +                offset = (resource_size_t)addr - res_start;
>> +                *normalized = region.start + offset;
>> +                rc = 0;
>> +                goto done;
>> +            }
>> +        }
>> +    }
>> +done:
>> +    pci_unlock_rescan_remove();
>> +
>> +    if (rc)
>> +        pr_debug("vfio EEH: addr=0x%lx not found in any PCI bus BAR 
>> of PE\n",
>> +             addr);
>> +    return rc;
>> +}
>> +
>>   static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
>>                          unsigned long arg)
>>   {
>> @@ -818,6 +943,21 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct 
>> iommu_group *group,
>>           if (copy_from_user(&op, (void __user *)arg, minsz))
>>               return -EFAULT;
>> +        if ((op.err.type == EEH_ERR_TYPE_32 ||
>> +             op.err.type == EEH_ERR_TYPE_64) &&
>> +            eeh_func_needs_bar_addr(op.err.func)) {
>> +            unsigned long normalized;
>> +            int ret;
>> +
>> +            ret = vfio_spapr_eeh_normalize_addr(pe, op.err.addr,
>> +                                op.err.mask,
>> +                                &normalized);
>> +            if (ret)
>> +                return ret;
>> +
>> +            op.err.addr = normalized;
>> +        }
>> +
>>           return eeh_pe_inject_err(pe, op.err.type, op.err.func,
>>                        op.err.addr, op.err.mask);
>>       default:

Thanks,
Narayana Murty.
> 


