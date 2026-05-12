Return-Path: <linuxppc-dev+bounces-20794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E612CCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 17:44:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFP9K32c1z2xjQ;
	Wed, 13 May 2026 03:44:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778607861;
	cv=none; b=aRn9HTH84cFrh1OfnOEzdHkjSCBSVlAsVRHB4b63+LDuZ6Ne9R4UjOLwQkug97mZjg6F0HrF60Gq65FhvqOb3dUBiXtELily4v7uLjkTpQAx7MCXaPK86B5pIFzfR4e8toeqF3NKs7Rh484iqZxP28mOK8CtOuxJA/Vwt3F189GVdhXEV6BYVuIc1ePlUat7menDOAWN2VPR2UYc+GfkUFSro2ggI5UIX6dgA9vc3MHXDz2c5xNog1ls7aPX2lAGOOxVuT0GLg7Aa7d5bxAnLauaVr3c17Wyiv951Wij5QCvs3JgmYg2z0LLbAtAfyqO/JhrtRu9ZOWaHMD5WpZENw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778607861; c=relaxed/relaxed;
	bh=DuObsbnZIM+6tsUBFxEcLFpAE0c3lv4RMFIR6Cmgd54=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GcGtzLboicKfxysiKv3Xw/1Z2xvQxpJnzhWLm23FfCc6oOZe9PmvxNjynceFER7TaMnh0pApykAuRls1KT8yBfHJPcI5Q8rL+VDEl5mqtbb47mwnm3HsQAc6nZg28yGYE486ba3+V/rJiPsT1ZOWEW6/uiUQeU6b/vWpuaxnFzOXWPM7ULwNjtgb3rgLAW0kMFK7B10WYvDjzKQtjeC2/BF21AU0VRroT3Oya7hIYnBCbXha9pkT61ZIgvkdScIt7pxxSle3YoZDvWknb5D3T+0KY+CknlbZdncLLHBZUGn0yF2hORFcFkMfWml1RCiBqpJM/bv8U+c8NTaDP3YCSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DpRydOTr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DpRydOTr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFP9J2Scwz2xb3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 03:44:19 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCtANk3177209;
	Tue, 12 May 2026 17:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DuObsb
	nZIM+6tsUBFxEcLFpAE0c3lv4RMFIR6Cmgd54=; b=DpRydOTrFl87zt3c/8lnDz
	e3xYil+39qlVS98BODfoZrVOIDzOSAy8to81nuq/ZYmz40zMIhOtgngoO0eTTJQY
	5biYdkW5gNk9/xRFZEai9ga86Z3TpkI2pRMwKq2GXhTHFhFAag8ylKNw64M08YZA
	RJcfR186KxMkHqRzNHU9Hza9YVdjYQXOfK3QVefeu90IzuI5IyTMlgyQacDeHjW9
	TOf45Ck6J17Q2Tzzxfl5vF1w4NRRJdb/L9jyaj8QPJuyNNlWhd5Efk8HrrcjrBVP
	kUqHzZh1qLScutBJuf0Bt7NnxgTSG9y2c3uIQYFxazsADrY82/ncNFJjSOa4A4fg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6m44e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:44:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CHdUBd005185;
	Tue, 12 May 2026 17:44:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgm7nd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:44:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHi6Wg64553356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:44:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 788EA58055;
	Tue, 12 May 2026 17:44:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEC7458043;
	Tue, 12 May 2026 17:44:03 +0000 (GMT)
Received: from [9.39.27.160] (unknown [9.39.27.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:44:03 +0000 (GMT)
Message-ID: <b896e3b9-6e0a-490b-820c-54c1608b5424@linux.ibm.com>
Date: Tue, 12 May 2026 23:14:02 +0530
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
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
 <b7b05e38-675a-4304-a266-91b10ab74e50@linux.ibm.com>
In-Reply-To: <b7b05e38-675a-4304-a266-91b10ab74e50@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a0366e8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=cRKesxm4ivsSXepMR-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7Evfu2dr7u3HrT0d7VYbU5LB4hX8-m3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4MyBTYWx0ZWRfXy4YzMYh1frm/
 IwW8yp4/MOBqb0XfgJf3L8I9jD9p2/VYMobNx54if2/AdolV3q/WJJ5oL9enlrHXOzBAQQJG063
 Ty565FtzSKeMH+Xya0Tb6RVK+U7iLjNJseqgC+3CM1hllpwT69sBhmtw/MaVsWQntaJhetPWY7Y
 aFjSvWZsSLn6o5LQm//iDs71tY//3A/S1p3ZiNKkKYm5QNZK0/1gz8XjJH7u0oP08W6VlQSiDL3
 dFejEt2DmoXplSpcoqP+paDzmZX0/xjvL1SKwF3ZXU1yVVg/YMd3531vfVG+6yZN02IRLHHGrSw
 wyhyYqJjPnPHjnIqP0sTYPI7gfXtDtjIlJ1U/sQ4gDCCpHBt8pchUO1Qp5q552EMxrr6XkwZA+7
 Q6v69M3Qf2br8n5O8R4M4KBPdn9hdE2JYgm9FjAGk/sKPfm0yWvJSb3LxKtDzzYIliy3F9jmWWU
 DrWnevZNitrxedc/zEw==
X-Proofpoint-ORIG-GUID: YpZ9gMUiO3hFzURLZEb1kG6GQZ4gWhHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120183



On 12/05/26 10:47 pm, Harsh Prateek Bora wrote:
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

Also, not sure if this commit description is correct as the patch only
changes behaviour of RTAS config-space accesses and not making changes
for omission semantics.
The existing code in arch/powerpc/kernel/pci_of_scan.c already
suppresses discovery of removed device:

#ifdef CONFIG_EEH
         if (edev && (edev->mode & EEH_DEV_REMOVED))
                 return NULL;
#endif

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
> 
> Consider using paranthesis for (pdn->edev->mode & EEH_DEV_REMOVED) and 
> moving to next line for readability (similar to prev one).
> 
>> +        return PCIBIOS_SET_FAILED;
> 
> Why not return PCIBIOS_DEVICE_NOT_FOUND ? Returning SET_FAILED for a 
> removed device could be misleading.
> 

Also we should check for EEH_DEV_REMOVED before checking for
EEH_PE_CFG_BLOCKED to avoid returning early when the latter is still set
for a removed device.

> Above comments applies to below changes also.
> 
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
>>
> 
> 


