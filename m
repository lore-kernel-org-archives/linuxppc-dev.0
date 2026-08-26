Return-Path: <linuxppc-dev+bounces-26113-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C6BBC5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 11:07:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVMLp6Wvkz2y32;
	Wed, 26 Aug 2026 21:07:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787742466;
	cv=none; b=X/p8rB3m/RUzWJ+7c++L0tPdrmxX6MYtXubDNOnDZJINTqrtyi14veitD3awl1HHiymUqgD7Wbioaj1GJp9MB1uZ8+V8cLC/cKocKoOltqwtkqpYnHGYazNP7OXrBl6QDpm/DT68Wc/5b7i9dEEbrNgmsNd1dCRYc0LWL1f2l7nFpbQeVEQ6ySLEtD4ZssS0NMI3kjjogs+kNFJsNeWPRWbXUpy0ikXF/uFfnszY/Q2/UxgpoiOdHVN2q6jNdVPJGYMh6FTuOPvulNUi8Th2aqYbNof6PgQkUwqqxQkaa2Ap4faIQERqS1iI7IQbmlH8NKkrvItR30mhfDGslqc7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787742466; c=relaxed/relaxed;
	bh=SICwhhjGxNhXSsOq7GPFaV9hQygchFki3GkCkSPKHXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh8i1bbzVhSA92upfPVnMcCzAxu2gYncy1qz1+Y05rEjWg5BwjFrGqQyHzc+K4WUHcErktzaplUiUqbuFpLfLlBnSalMT26ztp9DuLsghzjujwU5YoQUXzkJ7oS48pgOqWH1mfLYA94PwGP8wZau2h+LJ1ZYnYkIk5g7xb7NCd805JpNN15YKkVsHa5PEHex8QcqKO5EJ8E9PQBcnGQtLoZLJgdl+dyQtGrhc3KZUmHseamNxeQB+umWlq211fKA4ah11hOXzwOvFd9G1mTvsbJ0uHMyRY65KO1EPWYWa2IX5x+BX1BbGBzPBTKqYqVO8g7EMIKEa+12kmynNd/rXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PoLnJ/Tn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PoLnJ/Tn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVMLn2j2yz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 21:07:44 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAVfIs3793926;
	Wed, 26 Aug 2026 11:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SICwhh
	jGxNhXSsOq7GPFaV9hQygchFki3GkCkSPKHXU=; b=PoLnJ/TnBrkpFewceYCw7/
	FVR5RzZtjgDsqjBjaDWRdPaAQl0UtEa7BlsYR/YBKnjE3VyyS/+/VhC9OZtsbu+P
	weccOkTetSpEkxPoTvcBP7uefJmUEpBkNhnB8ffMyMbzVr7HbXVqPfhADBXFJPqu
	PQtOd4H5jGAkqhfuCQFw+b4Qfoz2KvO/CNyLVNVz4xzktlsEGPcLUB/VpH6RaHo+
	VNdO1KqHjsdG/9LGng1EvsFyA0xpULNEZrcvMIX1kzW9SOTdN/e3O/OmsaUvUH5b
	0hlK2XVInreUKX2u1aZpJseMYfKLO0oZO6LyW2J9J92PsdEGZSn6egxiVTYDIzwQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxdvvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 11:07:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QAuGkJ018391;
	Wed, 26 Aug 2026 11:07:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9akf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 11:07:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QB7MGv36372952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 11:07:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5380520049;
	Wed, 26 Aug 2026 11:07:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EE7F2004D;
	Wed, 26 Aug 2026 11:07:18 +0000 (GMT)
Received: from [9.61.245.81] (unknown [9.61.245.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 11:07:18 +0000 (GMT)
Message-ID: <6a37522d-ac3d-4992-a240-40fcd49557aa@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:37:16 +0530
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
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
 <80aded32-3975-49f4-a91a-b58b236c832a@linux.ibm.com>
 <c6117753-10a7-4e10-bd8f-526a5dd8a300@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <c6117753-10a7-4e10-bd8f-526a5dd8a300@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfXwwbhpsOgHEZa
 95rjgCZsFzs1ioJcp53xCl7FnYlq0OPDxg/MX0vfC93sSJuEgbXR/dRO+sR2oLJYQM//efxGHCe
 Bmf4ogjFEaCmG20QQbysz1YRTlXE7iw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8ec8ef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M3Y7q1RbFEiiUnmc_lAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0fx5DpBPdoEHRzHDDtF4wPRqxyYqcKEr
X-Proofpoint-GUID: oRR8Vl0N0-ZrmMbBwM3BXXhikqdXDhts
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfX5UEH16XRrdbs
 Y48fnlzXt1Z+q/JHz5Cwy/iNVpCYPInYDeKmw9BXeNpplOM+EzHYAjWsnUhAqyyb4kf+kU9mLh3
 oh+Up8IFdsJXnmgdb4T7kMAA6LwYmWNXlEk51TxqCLyuEXhWfBRjOy73IsX+RZwOJsG3i8kjzTd
 b3SBUGgnypz4x4Z6fHR1rcB4B1oOLUBm/LhK+cNUlEVZU1wJ5jgXLiC87mgXqUY9wmAC4JFqiPm
 V9J5BwptMZNCJ2zNlTYw/XgNr95L2V3Wf+f9HeI/UGq2jTmR3rJ4lSg8zHtwMNbXp5t8Q3xSfXG
 KlcMEhUELdX5MKcmafmGx34vc9jgoGAWfjTLW1OZHkmsjaNSwyn/9g8AE+jXyIypm6zHSyyODC6
 ts1/YGxJ+Fg20o+ym4/QMwwy4gfThw0az0/W0wmUOyeJ54EKhJbcZTa/7gYaO050i2YHq+ID5yJ
 0U/h+btnK56SReklskg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260092

Greetings,

Latest Patch tested 
: https://lore.kernel.org/linuxppc-dev/178246517230.1267.12206176311111155505.stgit@linux.ibm.com/ 


I have tested latest patch in my environment. The patch fixes the issue 
reported.


On 25/08/26 8:46 pm, Harsh Prateek Bora wrote:
> Hi Tasmiya,
>
> There was a v2 posted here:
> https://lore.kernel.org/linuxppc-dev/178246517230.1267.12206176311111155505.stgit@linux.ibm.com/ 
>
>
> Although a minor change in return value and re-ordering before 
> CONFIG_BLOCKED incorporated in v2, it's better to test v2 and provide 
> test feedback on the same.
>
> Thanks
> Harsh
>
> On 25/08/26 3:52 pm, tasmiya wrote:
>> Greetings,
>>
>> Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
>> Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
>>
>>
>> I have Tested the patch in my KVM guest environment with device 
>> passthrough via vfio, It works fine and fixes the issue.
>> Triggered EEH freeze beyond eeh_max_freezes to permanently remove the 
>> device, then hotplugged a new PCI device. Without the patch, the 
>> rescan attempted to bring back the permanently removed device. With 
>> the patch applied, the removed device is correctly skipped during 
>> rescan and only newly hotplugged device is seen in the guest.
>>
>>
>> Thank you,
>>
>> Tasmiya
>>
>>
>> On 27/04/26 8:25 am, Shivaprasad G Bhat wrote:
>>> The eeh_driver disables and offlines the PE permanently when it
>>> exceeds the freeze count beyond eeh_max_freeze within the last hour.
>>> The PE is only offline, so the device tree entries, eeh device
>>> references are all intact till the real unplug of the device from
>>> the guest/host takes place.
>>>
>>> On pSeries, with a new hotplug of any PCI device, the drmgr initiates
>>> a system-wide PCI rescan, which finds devices offlined by the 
>>> eeh_driver
>>> and there will be attempts to bring them online. This leads to
>>> recurring EEHs either at the config read time itself or a bit
>>> later depending on the type of the problem.
>>>
>>> For PowerNV, the commit d2b0f6f77ee5 ("powerpc/eeh: No hotplug on
>>> permanently removed dev") introduced the EEH_DEV_REMOVED flag to
>>> prevent such inadvertent rescans on hierarchical toplogies relavent in
>>> Baremetal setups. For pSeries, such topologies don't really make sense
>>> as the devices are either part of the same PE OR exposed as independent
>>> devices on multiple virtual PHBs. However, the inadvertent rescans are
>>> still a possibility with either hotplug of a new device or otherwise
>>> with manual system-wide pci bus rescan attempts.
>>>
>>> So the patch checks for EEH_DEV_REMOVED before allowing config space
>>> access just like PowerNV, making the PCI core omit the PE, and thus
>>> preventing subsequent EEH recurances. The patch is tested on PowerVM
>>> and KVM machines with single and multi-function devices, and on the
>>> devices behind a switch. The unplug of the affected devices post EEH
>>> removal is also working fine as expected.
>>>
>>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>> References: d2b0f6f77ee5 ("powerpc/eeh: No hotplug on permanently 
>>> removed dev")
>>> ---
>>>   arch/powerpc/kernel/rtas_pci.c |    6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/ 
>>> rtas_pci.c
>>> index fccf96e897f6..ce24b18712ca 100644
>>> --- a/arch/powerpc/kernel/rtas_pci.c
>>> +++ b/arch/powerpc/kernel/rtas_pci.c
>>> @@ -57,6 +57,9 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, 
>>> int where, int size, u32 *val)
>>>       if (pdn->edev && pdn->edev->pe &&
>>>           (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>>>           return PCIBIOS_SET_FAILED;
>>> +
>>> +    if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
>>> +        return PCIBIOS_SET_FAILED;
>>>   #endif
>>>       addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
>>> @@ -108,6 +111,9 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, 
>>> int where, int size, u32 val)
>>>       if (pdn->edev && pdn->edev->pe &&
>>>           (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>>>           return PCIBIOS_SET_FAILED;
>>> +
>>> +    if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
>>> +        return PCIBIOS_SET_FAILED;
>>>   #endif
>>>       addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
>>>
>>>
>>
>

