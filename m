Return-Path: <linuxppc-dev+bounces-29690-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A52ACCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 09:44:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7VxZ0MYgz2yYd;
	Mon, 19 Oct 2026 20:44:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792403057;
	cv=none; b=EYO9smU2NkgIoPP+Jq+vV7MjYJV/2WdGy/wUWi09+7ILvMSz8Qik51qJZCmxalSt0fxRN5GTJlC/ufGG94twwPNsXA9w4UuEXSl/QtKtL0og27zq8RH8W8v8hH41Jw2IgHnok7MQLsmIyY9mswC6PeNAYYqiGg1YPRVTWgr8PmR+s2D9pOhy3NLSOg3B/SuqL3XwPSe9/J2OHG5q2qV2Run3eGh3ftyoJNAbmOldJ4S9Jopl2Xk1z9/3Ohtay2u/p6bG0vXUF9Q4YH7daBJFvNXKyKwjpPIDIT/jeakjpWr5FJVPILPzn90fc4Q6d9+AiFginS0ZH0Pd/yQnm6Y4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792403057; c=relaxed/relaxed;
	bh=KSCnezMh9nIfs2xl0GvdW2jplK0N2idLbOKLVpOneqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3lotZz1ETZQJvDWi+O3b8Si7jYUFpel6Q8CNfX00xQSXWUKruqeEcSevIWB7R0ske7VkFzwrBNFAsAJuC1bltDN9Kp477rXK3341n4aIK/9bnKsxLsLiYq8/PJZnO0OWmQ5V0Kv29bSDE2Q7pnANQORXwunhRcHgFbKXYgF1k3LFgqsV/83c1LAW27KZyVICb7vxTN9pYgXRlmCQEHJZA+dDGPL58pKBEaLgZhcKD/ODhvPeCLq0QY8hrHO0Sd6pB86gE//8N8Eyf6FsTiyeHpMp9tYTaT4/lhNxHM9ByYtLUn/+4hNSGTpYDJvwo5/wiFh0Pth7p4YUzCBNFTBKw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rtfy+flq; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rtfy+flq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7VxX4t30z2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 20:44:16 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iLPA3251041;
	Mon, 19 Oct 2026 09:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KSCnez
	Mh9nIfs2xl0GvdW2jplK0N2idLbOKLVpOneqQ=; b=Rtfy+flqWLcPy5PZOR0N+A
	HaXz6JqlNHQSCara5TglpiB96W99DWh9XYGCAYmVn9VX0R37l0VPli81Dq5ZubPz
	L77zEehx2APmLeLN9MLZsJmx5G4FwSS+2RpwG2jf0Ncv/cIZu+1+1+ES2u2dKnB8
	GbwAar5R+lOZnv+MYInAduGtiKTsKCPEO81ZpUqPtlG+bN724G5lBTJa7ICZpVBd
	VDEmyG/0lCoJPuZLuxFfzMtnnN9dPn0L+bEsS7tjHI2nMv+ryExZmYnDDSHvfC5p
	lBOnSbk4UcLanbsFhMmVe7hZdHqQavDTeAWtU84snDEr4+xMrhZIRc5VRdNe2gDg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehsymd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:44:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8noNR3845750;
	Mon, 19 Oct 2026 09:44:03 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvd722-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 09:44:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69J9hwS146399824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 09:43:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B75CD2004B;
	Mon, 19 Oct 2026 09:43:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1F9020043;
	Mon, 19 Oct 2026 09:43:55 +0000 (GMT)
Received: from [9.124.217.62] (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 09:43:55 +0000 (GMT)
Message-ID: <1516101a-20e1-43fc-a351-05432c44ddda@linux.ibm.com>
Date: Mon, 19 Oct 2026 15:13:54 +0530
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
Subject: Re: [PATCH v4 2/5] vfio/spapr_tce: Normalize EEH IOA error injection
 addresses
To: Sourabh Jain <sourabhjain@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-3-nnmlinux@linux.ibm.com>
 <2d3a50a9-42c3-4f00-887e-56cf4a0bbe30@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <2d3a50a9-42c3-4f00-887e-56cf4a0bbe30@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX87g+yjhCE8s9
 E8XwShGM1aJAW4fFoF7UZdIBmTzMNTQIv2uT5m0YmaeYtjC7LIdQGYJT5bvehhzuUl0p8QlY/ct
 mS9EVEAPG3ybVorzTT3gvU48/5hu9KTeZD+/Xyi7jjdKszRrGL3eP8YiZ95Xk0GdpucH8qVWMHB
 PHt70bF7e+CTvcCOZXWg6r3Lgl3q3BrcrhrH69Xwc9Y6XRZhT2PCIdlXS5kk2fyaR40GDKVpVCb
 8hJEWIfXuNFjShcoKzZlRpz8N054Ts4VcgO66BVb482NCa07tnyE8D1hJGy6tz9D1TkDqpqyssk
 Fs8AkxLemyHwgWuoDMpgyoPh4gG8296bww5bb6UANXUBsRL1SXkTMqkwXe8i0CUXukzpGU256yU
 SP2KzDchfIS2EvWlDpImtW0pf6zdjMekmJu++LzeJdzmRh3/KearYMi0Xvch8LfbKPIMRwDolzd
 DqyBoe05iZPGliNVnUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzOCBTYWx0ZWRfX2Tg+4ic4rR1E
 VW0WFv/tgsrIZYENKnkLwRwwfxwXJNDdjnPLzeP7K2YSvrIfIvmI2Ar2rCpt8zDUZNpWcS1TjCd
 zF9q2XFzoxhD38tkWQ1WrKObJg2fVXc=
X-Proofpoint-GUID: Gu08-8YGZZ0AvnOY7Ez3AKWS640v7SxJ
X-Proofpoint-ORIG-GUID: 4wkrvi3yp2_5bhLP077kfo68ixmc1WCv
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad5e664 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=RDcXtoapwv7zoTdPU-EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190038

Hi Sourabh,

On 23/09/26 5:10 PM, Sourabh Jain wrote:
> 
> 
> On 31/08/26 12:24, Narayana Murty N wrote:
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
>> Keep the helper local to VFIO so the address semantics of other
>> in-kernel EEH callers are unchanged.  This provides common handling for
>> both pseries and PowerNV backends.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   drivers/vfio/vfio_iommu_spapr_tce.c | 90 +++++++++++++++++++++++++++++
>>   1 file changed, 90 insertions(+)
>>
>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/ 
>> vfio_iommu_spapr_tce.c
>> index 1c0eec228cc6..8a6cc856d7da 100644
>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
>> @@ -774,6 +774,85 @@ static long 
>> tce_iommu_create_default_window(struct tce_container *container)
>>       return ret;
>>   }
>> +static bool vfio_spapr_eeh_err_needs_addr_normalize(unsigned int type)
>> +{
>> +    if (type != EEH_ERR_TYPE_32 && type != EEH_ERR_TYPE_64)
>> +        return false;
>> +
>> +    return true;
>> +}
> 
> Do we really need this function? It is only used once.
> 
>> +
>> +static int vfio_spapr_eeh_normalize_addr(struct eeh_pe *pe,
>> +                     unsigned long addr,
>> +                     unsigned long *normalized)
>> +{
>> +    struct pci_bus_region region;
>> +    struct eeh_dev *edev, *tmp;
>> +    struct pci_dev *pdev;
>> +    struct resource *res;
>> +    resource_size_t pci_start, pci_len;
>> +    resource_size_t res_start, res_len;
>> +    resource_size_t offset;
>> +    int bar;
>> +
>> +    if (!pe || !normalized)
>> +        return -EINVAL;
>> +
>> +    if (!addr) {
>> +        *normalized = addr;
>> +        return 0;
>> +    }
> 
> This silently bypasses normalization for addr == 0. A comment on
> why zero is exempted would be helpful.
Good point.

In v5 I made the no-address case explicit as addr == 0 && mask == 0, 
rather than bypassing normalization based on the address alone.

I also added a comment explaining that this represents an injection with 
no specific IOA target and therefore does not require BAR translation.
> 
>> +
>> +    eeh_pe_for_each_dev(pe, edev, tmp) {
>> +        pdev = eeh_dev_to_pci_dev(edev);
>> +        if (!pdev)
>> +            continue;
>> +
>> +        for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
>> +            res = &pdev->resource[bar];
> 
> I'm not very familiar with this PCI resource regions, so quick question.
> is pdev->resource[] limited to PCI_STD_NUM_BARS?
> 
> Also doesn't this need locking around the traversal? This dereferences
> pdev->resource with no lock held, what stops hot-removal or BAR
> reassignment racing this?
pdev->resource[] is not limited to the standard BARs. The lookup 
intentionally searches only BAR0..BAR5 using PCI_STD_NUM_BARS; ROM and 
bridge resources are not considered IOA bus-error targets.

For the lifetime issue, agreed. In v5 I hold pci_rescan_remove_lock 
while walking the PE devices and accessing their BAR resources so device 
removal cannot race the traversal.
> 
>> +
>> +            if (!resource_size(res))
>> +                continue;
>> +
>> +            if (!(res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
>> +                continue;
>> +
>> +            pcibios_resource_to_bus(pdev->bus, &region, res);
>> +
>> +            pci_start = region.start;
>> +            pci_len = resource_size(res);
>> +
>> +            /*
>> +             * Case 1: userspace already supplied PCI/IOA
>> +             * bus address.
>> +             */
>> +            if ((resource_size_t)addr >= pci_start &&
>> +                ((resource_size_t)addr - pci_start) < pci_len) {
>> +                *normalized = addr;
>> +                return 0;
>> +            }
>> +
>> +            /*
>> +             * Case 2: userspace supplied Linux resource/CPU
>> +             * address Convert it back to PCI/IOA bus address
>> +             * before calling the platform EEH backend.
>> +             */
>> +            res_start = res->start;
>> +            res_len = resource_size(res);
>> +
>> +            if ((resource_size_t)addr >= res_start &&
>> +                ((resource_size_t)addr - res_start) < res_len) {
>> +                offset = (resource_size_t)addr - res_start;
>> +                *normalized = region.start + offset;
>> +
>> +                return 0;
>> +            }
>> +        }
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>>   static long vfio_spapr_ioctl_eeh_pe_op(struct iommu_group *group,
>>                          unsigned long arg)
>>   {
>> @@ -818,6 +897,17 @@ static long vfio_spapr_ioctl_eeh_pe_op(struct 
>> iommu_group *group,
>>           if (copy_from_user(&op, (void __user *)arg, minsz))
>>               return -EFAULT;
>> +        if (vfio_spapr_eeh_err_needs_addr_normalize(op.err.type)) {
> 
> At this point eeh_pe_inject_err is still using eeh_pe_inject_mmio_error, 
> so why to normalize the address in this patch itself? Isn't this is a 
> good candidate for 4/5 patch?
Agreed.

I reordered the series in v5 so that the pSeries RTAS error-injection 
implementation is added before the VFIO address-normalization patch.

The normalization patch is now 4/5, after the pSeries backend has 
switched from the legacy MMIO injection path to RTAS.

>> +            unsigned long normalized;
>> +            long ret;
>> +
>> +            ret = vfio_spapr_eeh_normalize_addr(pe, op.err.addr, 
>> &normalized);
>> +            if (ret)
>> +                return ret;
> 
> We should have error/debug log to tell eeh is not going through.
> 
Agreed. I added a pr_debug() in v5 when the supplied address cannot be 
matched against any PCI bus BAR of the PE.

Thanks,
Narayana
>> +
>> +            op.err.addr = normalized;
>> +        }
>> +
>>           return eeh_pe_inject_err(pe, op.err.type, op.err.func,
>>                        op.err.addr, op.err.mask);
>>       default:
> 


