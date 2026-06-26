Return-Path: <linuxppc-dev+bounces-23011-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08853CDE008
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 09:14:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmqkg3sCBz2yVv;
	Fri, 26 Jun 2026 19:14:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782465291;
	cv=none; b=es3RArlmE4FbavO7HubOS8ENiEKpqaB5icdwX6QwnLrMRQ9EJCkjJSz520Whc5Yml8hayBE5hp0k7iiQyItKv679DYqpkfeQwctQ+H++6pll/RmZsC35R8bFZIlfmhn9nf4+hbqBj2cAvHjCvezaFf2SyVMQPblQIeOQxs6l/AVpeQzM7lyXdzxroOTXE/fx5oOYGGYvcNaE60Ghq8cqz+Z/9M5X5jaUzRvdmYqECVSuCKlfjRVUhcnneQ82HmtzdRxlhvXQCCFFMkVc4t92q332aq0TrOKMGMnny8GLlpAx31cwz+gWVMLMhw0jaZEWh1oNjtC+wgowHTUyJgFF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782465291; c=relaxed/relaxed;
	bh=dcenRT8Nscy9kWf89F7q6TQaY8Mx8oDLX6eWQeNrUyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4dGRYBZjih9JakBAhxW1X8po3pUVUzgOXoFkf1SflOmncjnvmwPwFJIHKdlu3+dFNMJFmZvxp7hzlynbTA3GFW84d3aHy1GZq2dLUELh3aJHvVaw4JDy+ThBW4DskoRNnJx/BmhUSngbqaipWoBgtdT+09arC+INRDOeMZ4AFYhietWljBFTyGIvYHtID86nqCJ2bDUYPQVmmmuYYOjHSX78LxNYDGWSX41as53Q6pakQ63hskGcOuZRUHa8jOK+Ea3jxfDMuWx4KwC1CGX6IKqLsCzDjCD1xthYO3Qe+h+KapXhXPRhKmcgdPTEAGEaRp7Be9mFKW1q2PPXTqsCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NLh0Lgq1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NLh0Lgq1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sbhat@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmqkf5mMJz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 19:14:50 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q6mE0k2322469;
	Fri, 26 Jun 2026 09:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dcenRT
	8Nscy9kWf89F7q6TQaY8Mx8oDLX6eWQeNrUyM=; b=NLh0Lgq1VjW9VR+TkzAfzb
	Rcj/4uG6VctcXrLQnS9mc6AaIjIavL0RNZisIpk176zu/bEQk/DZMksOEq4q3UA+
	pUSfYIsCrnfAogw5o6GQd2WXeV67/87rDgfS2KUi14OdcWBxDGAiSmufZaROW4el
	+Qusv6U7LEUswV/JmxZyf683KilqQcWLqL+IvzqWRvnJpi/Jdov48aOyBDDNZczQ
	QolflomgZkUQCbP22SkUm9OOG6gLS3DY0jXLeA0L58J0HIM7kmjkCSJxRtT64TMx
	vXFWxFxFuqwq9VUS8ybJ3Zz3bAIy3NB3XHflCpYfg2iOvfyEzUoXnxE56uMjnukg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3xb4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 09:14:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65Q94ifi007116;
	Fri, 26 Jun 2026 09:14:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgj5ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 09:14:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65Q9Eapf42664352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 09:14:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C338F2004E;
	Fri, 26 Jun 2026 09:14:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 354AE2004B;
	Fri, 26 Jun 2026 09:14:35 +0000 (GMT)
Received: from [9.123.12.85] (unknown [9.123.12.85])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 09:14:35 +0000 (GMT)
Message-ID: <96850460-f3a2-447c-bcdb-1ed2aec9d8eb@linux.ibm.com>
Date: Fri, 26 Jun 2026 14:44:33 +0530
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
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
 <b7b05e38-675a-4304-a266-91b10ab74e50@linux.ibm.com>
 <b896e3b9-6e0a-490b-820c-54c1608b5424@linux.ibm.com>
Content-Language: en-US
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
In-Reply-To: <b896e3b9-6e0a-490b-820c-54c1608b5424@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3e4302 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8n4TwCIs6I_wRnbbygwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX8rgQ0veEVSmY
 kqyw6Gcg8hg60Gq/agfqRk4boWJRRAVwwoGXa7kmwS3MopipiTOsH6MYip1fFrKTdtHOjoZgSGp
 7YCsuwmRJT3X5z5ay0c33Ox+TpHR/mA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA3MCBTYWx0ZWRfX85SxvhExmsuI
 XsD/eKQD+R2O60xtR6qXUiJ0SM4Wvrn+YwamLy0ihpHUT/0Rg7xmf5mg4L02ZodwuRTCHmDmMlu
 ZCQ9hDl2vXLuHWWXni13upPScRpk2mmmuRZYO8+N9gzrgLQfZqr9plyuarkK7ZItSdaAoi9M0mm
 ZR7AvUixuEi+fTqsfXKB4M9+Ak1IygGxplwDRJe9vRwbWLhn6KDpcp572A5A4H/rbANqkfzJtSA
 yz1jKI+Z94FMJHIhciq6ltyYHYaM6otXXEtBreL1as/22dqoCM7yllg1Lqv/68WUJIVDTGkD2JX
 yuLexvLPJhE/y5QzAZK04xUhyFXYmMuFP+hLpUEcYqWHKhTCuFGUi+jQgbMqiIBUl05S5HxhPgm
 Ya9JmpdCiUMF2QOS7VyUS/UynfjckG1d//ieofaFgT7V2h1l7bHHzTREJYVImlLWxuTwlSCCWHl
 QwEjx6EzoQojDwp4cNA==
X-Proofpoint-ORIG-GUID: LDT3PBzXunniFoTgtkNDsGxb5vWGZ0IT
X-Proofpoint-GUID: NHl0fZBv3gPziZILMDcZcAVX7CB-p1Zs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260070

Hi Harsh,

On 5/12/26 11:14 PM, Harsh Prateek Bora wrote:
>
>
> On 12/05/26 10:47 pm, Harsh Prateek Bora wrote:
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
>
> Also, not sure if this commit description is correct as the patch only
> changes behaviour of RTAS config-space accesses and not making changes
> for omission semantics.

This is for the pci core rescan attempts to be skipped, when rescan is 
attempted

with write to rescan sysfs file.

  pci_bus_generic_read_dev_vendor_id+0x48/0x220
  pci_scan_single_device+0xa8/0x130
  pci_scan_slot+0x9c/0x2e0
  pci_scan_child_bus_extend+0x70/0x410
  pci_rescan_bus+0x2c/0x70
  rescan_store+0xa4/0xe0
  bus_attr_store+0x3c/0x60
  sysfs_kf_write+0xb0/0xe0

> The existing code in arch/powerpc/kernel/pci_of_scan.c already
> suppresses discovery of removed device:
>
> #ifdef CONFIG_EEH
>         if (edev && (edev->mode & EEH_DEV_REMOVED))
>                 return NULL;
> #endif
>
This is boot time only scan from the pcibios_init() path.


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
>>
>> Consider using paranthesis for (pdn->edev->mode & EEH_DEV_REMOVED) 
>> and moving to next line for readability (similar to prev one).
Sure.
>>
>>> +        return PCIBIOS_SET_FAILED;
>>
>> Why not return PCIBIOS_DEVICE_NOT_FOUND ? Returning SET_FAILED for a 
>> removed device could be misleading.
>>
>

Sure.


> Also we should check for EEH_DEV_REMOVED before checking for
> EEH_PE_CFG_BLOCKED to avoid returning early when the latter is still set
> for a removed device.
>
Sure.


v2 posted here - 
https://lore.kernel.org/all/178246517230.1267.12206176311111155505.stgit@linux.ibm.com/


Thanks,

Shivaprasad

<snip/>


