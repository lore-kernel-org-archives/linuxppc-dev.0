Return-Path: <linuxppc-dev+bounces-26085-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C68FC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 15:16:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTrwW5GTgz2xVq;
	Wed, 26 Aug 2026 01:16:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787671003;
	cv=none; b=W6h2H3gOX+0F41bzdcJSM8XRYNy4FPRkjPxYKUZdpJioYhqDO8JwR2OjdKprJAccdeL2Evn1gS1PixU2JMEbM2CtzbI1w7XgNy+sC+68AnInBQVRIeVnNQWVUdggWHOFoWewo01a+0qTaF/v1pWi6+G5/4VzhkEfKM39+xgYtKMTGRgEYzsl8Vo20ewz0hgPEuTPndlk77HP4JYPvim/0SYzrgvolGg8pNXkQfZ3e75huRZC0kotRxp2DVi1RFtGnV+H7bRYIqyOrnGf0oPo58ddOV/KwOW7KU0tnudUDN8i/IqCVy7+FPzRSCFSux2nwZ/B8ISrLfhA3IguL119lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787671003; c=relaxed/relaxed;
	bh=+rc6e6Zc0mG/DaIfNSDD2hfj1uCVwvLCyWZb8d14LXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J9qoeIgVE2tE5T59t/01JPo2nu4hhdtS5TLEo7sF9bV9Yj0lpLrnH4ChwBR+cNp3su4vD3nHD5CyMIvAh7RVI0wBS39qLumOkzjXKI8T/acgx3UfZD9XboGctiC2qLnjSi7t6AuvEZ9dtU/dI5IVURtR1s1bRtbqLd0xfzsDHQQxK6PnNnZ9uket/rPaTPsmSbkeWx1NeHU/XVqLQ8W532bareKqHUr+mtumGe9HyfekOEO2LotVBrdt2GTMlwuOeRyXX9yz4MAohwx3YgfnMVt1AnHq+o/i7T1gIelAOBgPnSUL1ZwYNAwjNfGJomvCnd9obWYC70kCc4rHZJd8Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UOjoEQeR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UOjoEQeR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTrwV3sJgz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 01:16:41 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PEYwF21024702;
	Tue, 25 Aug 2026 15:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+rc6e6
	Zc0mG/DaIfNSDD2hfj1uCVwvLCyWZb8d14LXk=; b=UOjoEQeRCD1WIh00bwGE+0
	CKKB7xPhm9UED1sYaCV8PAxDkOUHyyqUNuUKVf4q05zpu6sFNWRgcYiD2O8IHxgQ
	jlDxt577f1TcqgotNCd3RE0T6RLRiySo3FwRdRk0fj1mFUYjYO18/DX4s8utFw/7
	brZwurGKBLDTIqKqiHiCXUrIQP+ICpzdoMmq4IfXqn4xx6N47hpKzjdFCecKlAqU
	DRVpS2AQP9tTuOKqyr+7ePei77EKS8UWfSMx7DmII4VosOGYvG5RKBao48nqPzW4
	4I7/jeTU0B6mYl+WDW+qCRqzy1pLxOxy8Rw3GFpbYLoey3lYM7f/jJ/HHBv0fONQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hs3qs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 15:16:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67PEuISt019496;
	Tue, 25 Aug 2026 15:16:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh4skb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 15:16:21 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PFGKKO59048358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 15:16:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 678B658061;
	Tue, 25 Aug 2026 15:16:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A23F5803F;
	Tue, 25 Aug 2026 15:16:17 +0000 (GMT)
Received: from [9.124.213.132] (unknown [9.124.213.132])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 15:16:16 +0000 (GMT)
Message-ID: <c6117753-10a7-4e10-bd8f-526a5dd8a300@linux.ibm.com>
Date: Tue, 25 Aug 2026 20:46:15 +0530
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
Subject: Re: [PATCH] powerpc/rtas_pci: No hotplug on permanently removed
 device on pSeries
To: tasmiya <tasmiya@linux.ibm.com>, Shivaprasad G Bhat
 <sbhat@linux.ibm.com>,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
 <80aded32-3975-49f4-a91a-b58b236c832a@linux.ibm.com>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <80aded32-3975-49f4-a91a-b58b236c832a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfXzplxPLeWcqVf
 91jksxwvXPZD7YgneCqZMOqEjWn9dyunZG1nyIf3HIY4q/J0hKa2sldo4An1uVh+6LX/JS52hJq
 sXvBRzxk1knAfIvf3e/qHQiDM7GNYqU=
X-Proofpoint-GUID: XD1d5de-4feQHCDNdLFYSKzFjzORVEmc
X-Proofpoint-ORIG-GUID: JSyYUBOPqZxABSEd6JDLrd0RxJE1nk-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX5C6vS1ykdovs
 Ez21EuQ3RS7VqSMiixO8Ba0Hh4dGMhIvepqcQtJm+hHoS6GdnFaK7QMcegiT/jBhV3ZT/qXULBs
 MkuHiv1B4fll/ozj8RRFUc4x90NpynTeOq3gI1tiIcuwgi6YgT3cLyq5M54fXLraNEqhOqCD4Ti
 6kCWKnoH5eCGVR/Af87V2yIc+7aFScejmVilCG+1Znu6aOOfal0rzQGdHfmJBVqZWbiXbBiU3cY
 xP5+U0nhkp8Bz5Q4EWjq6pJs+KWEK9pBhd5XxTV/Vk6TJoQu4HscZhEjremzpP8b5wH/Gg+KDmu
 jxLCx0cffP0R3zvRxf92vfKAoTs3lv3aNFNhf8FterXTKlctMgy52aq2azzfD9apdWWTtL1yLtQ
 Hgwr21jaDZsjaVxfgpmC2lEbbliAxjXkWIj1UuE78Nb7ZCrXornyL1QTp5txjHNCyIVq800zTkw
 zfqWRsn1jlLU3va/6Dw==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8db1c6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=koTKpVfbUEzoDsrEVSgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250128

Hi Tasmiya,

There was a v2 posted here:
https://lore.kernel.org/linuxppc-dev/178246517230.1267.12206176311111155505.stgit@linux.ibm.com/

Although a minor change in return value and re-ordering before 
CONFIG_BLOCKED incorporated in v2, it's better to test v2 and provide 
test feedback on the same.

Thanks
Harsh

On 25/08/26 3:52 pm, tasmiya wrote:
> Greetings,
> 
> Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
> 
> 
> I have Tested the patch in my KVM guest environment with device 
> passthrough via vfio, It works fine and fixes the issue.
> Triggered EEH freeze beyond eeh_max_freezes to permanently remove the 
> device, then hotplugged a new PCI device. Without the patch, the rescan 
> attempted to bring back the permanently removed device. With the patch 
> applied, the removed device is correctly skipped during rescan and only 
> newly hotplugged device is seen in the guest.
> 
> 
> Thank you,
> 
> Tasmiya
> 
> 
> On 27/04/26 8:25 am, Shivaprasad G Bhat wrote:
>> The eeh_driver disables and offlines the PE permanently when it
>> exceeds the freeze count beyond eeh_max_freeze within the last hour.
>> The PE is only offline, so the device tree entries, eeh device
>> references are all intact till the real unplug of the device from
>> the guest/host takes place.
>>
>> On pSeries, with a new hotplug of any PCI device, the drmgr initiates
>> a system-wide PCI rescan, which finds devices offlined by the eeh_driver
>> and there will be attempts to bring them online. This leads to
>> recurring EEHs either at the config read time itself or a bit
>> later depending on the type of the problem.
>>
>> For PowerNV, the commit d2b0f6f77ee5 ("powerpc/eeh: No hotplug on
>> permanently removed dev") introduced the EEH_DEV_REMOVED flag to
>> prevent such inadvertent rescans on hierarchical toplogies relavent in
>> Baremetal setups. For pSeries, such topologies don't really make sense
>> as the devices are either part of the same PE OR exposed as independent
>> devices on multiple virtual PHBs. However, the inadvertent rescans are
>> still a possibility with either hotplug of a new device or otherwise
>> with manual system-wide pci bus rescan attempts.
>>
>> So the patch checks for EEH_DEV_REMOVED before allowing config space
>> access just like PowerNV, making the PCI core omit the PE, and thus
>> preventing subsequent EEH recurances. The patch is tested on PowerVM
>> and KVM machines with single and multi-function devices, and on the
>> devices behind a switch. The unplug of the affected devices post EEH
>> removal is also working fine as expected.
>>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> References: d2b0f6f77ee5 ("powerpc/eeh: No hotplug on permanently 
>> removed dev")
>> ---
>>   arch/powerpc/kernel/rtas_pci.c |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/ 
>> rtas_pci.c
>> index fccf96e897f6..ce24b18712ca 100644
>> --- a/arch/powerpc/kernel/rtas_pci.c
>> +++ b/arch/powerpc/kernel/rtas_pci.c
>> @@ -57,6 +57,9 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, int 
>> where, int size, u32 *val)
>>       if (pdn->edev && pdn->edev->pe &&
>>           (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>>           return PCIBIOS_SET_FAILED;
>> +
>> +    if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
>> +        return PCIBIOS_SET_FAILED;
>>   #endif
>>       addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
>> @@ -108,6 +111,9 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, 
>> int where, int size, u32 val)
>>       if (pdn->edev && pdn->edev->pe &&
>>           (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>>           return PCIBIOS_SET_FAILED;
>> +
>> +    if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
>> +        return PCIBIOS_SET_FAILED;
>>   #endif
>>       addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
>>
>>
> 


