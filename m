Return-Path: <linuxppc-dev+bounces-26114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F6CC5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 11:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVMWD17p4z2y32;
	Wed, 26 Aug 2026 21:15:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787742904;
	cv=none; b=Vy3RBNF4IznGiK9NxxAVt6Mhd6h77RxER220PADzCE+XGHKZfC3kpE0HCiI1oTbE8063JeUMAvThSKe6RsPZaYwrN/363DvHMXwgSjO5BF1GbbQ/rU0K79NpK7aIjx/sG5lJH9sqYOj1Frf2UK7U2oCJeBv6PpupGzhQabL7gIaozowiuHXW5SgckxlfRweSz/0g6MS0MZs4ZpHqXerYvIrL7dRuDIwbbKfE/+4DW+9uEwK54jAXpeH0HXCMW7KabTC909DoEiXkVlLZiJlUfZDor6oXx2ZVLMV7nImx7e+NPMTffWd5eFJ7obHHQWL/6Ipe2VMB0rs89zWtBjriRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787742904; c=relaxed/relaxed;
	bh=GDF/cABelGaTPBjlS5aio3rOiDGXWwZ8r2MVOStXkyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=am0oO5M2Sj/SmLnGolDK1/dyNLRfSQD/x54wqwz65CNC7Bb+4U58biK5g+lrPxZtzHDN37Q7TZDFGmFtQchZhXRg5QF1w05e+kET4r/3UYL/WCrcx85Z4RzSSw8U3M1sj8HPJnqmYLHfYCqN1pv7/CVhmo2E5cON6JslLAujzB+S1M47JWk2/qY6j01bYZVKrzKyr7hSH+ZmvgQtAJCjOJdPetqxTqBWCJ4gNtWYdoTwui5Nkwgij4S+dvxZFBy/QSluU0A9EVo0gPrgFBdBeCKo/KsrRh1jGZRs1ZGWu09tp9GMM3423YSBQysf+NlhHr1RP3ECO2t8F8JBVmH7eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XuCjLecP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XuCjLecP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVMWB5B6Kz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 21:15:02 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAVw4T3630225;
	Wed, 26 Aug 2026 11:14:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GDF/cA
	BelGaTPBjlS5aio3rOiDGXWwZ8r2MVOStXkyg=; b=XuCjLecPugM/juLB+Q/ukb
	o8WdUu98KmetnJXqUJ2nZxjBqTU28CHKsUX9GpdYvAi2ojHuOkeEvM18C9vCsQej
	xfuzfqegYUkA2gGtEIAtIvpQfVobzPLp0zbBnL9q968tzHfiKRWGzTscduhbTVNC
	EPfnlWHftLk5DsdYps9exlQM7nZAk4U1odxTEzFaEgv8yKzPZyEpfhnc110DAJ/y
	eyBxec4/05eFtffLGtbGwcNoSW3C/IaHa6qH2ittCnQQ2vEqtrUeQA/Fti+TGQlH
	i+c6mxjrXIgsOFwb7quxYNkzPvo1K/e04GZfIHBh7Ya2+UgOCtL7JpkQvHE0Hckg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716hxb56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 11:14:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QBBLvf005665;
	Wed, 26 Aug 2026 11:14:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsy9bed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 11:14:49 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QBEk4h47120676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 11:14:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B1652004B;
	Wed, 26 Aug 2026 11:14:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70E2820040;
	Wed, 26 Aug 2026 11:14:42 +0000 (GMT)
Received: from [9.61.245.81] (unknown [9.61.245.81])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 11:14:42 +0000 (GMT)
Message-ID: <ffb397b5-9998-4293-8113-ab7fef2b34cd@linux.ibm.com>
Date: Wed, 26 Aug 2026 16:44:40 +0530
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
Subject: Re: [PATCH v2] powerpc/rtas_pci: No hotplug on permanently removed
 device on pSeries
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: harshpb@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linux-kernel@vger.kernel.org
References: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfX8fTSV2Lko6x+
 gis3iD/UKcERiFEmCmOOOL1rnfU9Z4MhvGFpD1QbwXPVueXqUH/qZPWJpPdOiviJHafU6mcGJIF
 UYSqrWEci0CyMorYUKWfWh+09ST6AhQ=
X-Proofpoint-GUID: 187BulcNq7VT7rTO1l3oH6R6baEmUaHT
X-Proofpoint-ORIG-GUID: 1DE4JljkgCeYhSv1H9XybzTBOAixtWwH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfX/DvXNmaXLcAE
 StrPH4aQkE7MEQOnoW3y/dd+LKz3iloFejVoGUvy0IfhRgAnRg4wry/wBrPeXQouE5BlhfkVM5c
 MZNHG28YLThSOAc696HS7NuK/FOjfWgq5jeGpT6IGXJRLsGtHZu8YWaIs9gXoRa7tii7irCbxKh
 M5v0GrPqauNBxnNJGMx/63KhuDC11u/udJmAp4HZy3tPRnuNYpYJEDdhgPKF05Yc8440P/UEYxt
 MR7KeE3IXF8k8K12XewJTCZyzmKGBlF210c2L45w1qCfcaCQbtspJG+P3zxFFHElLlxLRKhwBFE
 AXXMSQsGL23cxupkJ5gSxLTA9Sjhr4bQ/gJClBnWlDVrXoJxH9aQdESYcskMmcYD74ZXTZNW9Ho
 hL3dZK+Z8k5/2Boe3BS+/hGGQpr4ZnppVH8ZoVJvPD39mJ3UeadSOHlUqzsO6BB1v7fO10X6cvs
 9WrrLIgv3C6PmJEK66Q==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8ecaab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=2bSin88CYBwzzSIUHhIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260092

Greetings,

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>


I have Tested this patch in my KVM guest environment with device 
passthrough via vfio, It works fine and fixes the issue.
Triggered EEH freeze beyond eeh_max_freezes to permanently remove the 
device, then hotplugged a new PCI device. Without the patch, the rescan 
attempted to bring back the permanently removed device. With the patch 
applied, the removed device is correctly skipped during rescan and only 
newly hotplugged device is seen in the guest.


Thank you,

Tasmiya


On 26/06/26 2:43 pm, Shivaprasad G Bhat wrote:
> The eeh_driver disables and offlines the PE permanently when it
> exceeds the freeze count beyond eeh_max_freeze within the last hour.
> The PE is only offline, so the device tree entries, eeh device
> references are all intact till the real unplug of the device from
> the guest/host takes place.
>
> On pSeries, with a new hotplug of any PCI device, the drmgr initiates
> a system-wide PCI rescan, which finds devices offlined by the eeh_driver
> and there will be attempts to bring them online. This leads to
> recurring EEHs either at the config read time itself or a bit
> later depending on the type of the problem.
>
> For PowerNV, the commit d2b0f6f77ee5 ("powerpc/eeh: No hotplug on
> permanently removed dev") introduced the EEH_DEV_REMOVED flag to
> prevent such inadvertent rescans on hierarchical toplogies relavent in
> Baremetal setups. For pSeries, such topologies don't really make sense
> as the devices are either part of the same PE OR exposed as independent
> devices on multiple virtual PHBs. However, the inadvertent rescans are
> still a possibility with either hotplug of a new device or otherwise
> with manual system-wide pci bus rescan attempts.
>
> So the patch checks for EEH_DEV_REMOVED before allowing config space
> access just like PowerNV, making the PCI core omit the PE, and thus
> preventing subsequent EEH recurances. The patch is tested on PowerVM
> and KVM machines with single and multi-function devices, and on the
> devices behind a switch. The unplug of the affected devices post EEH
> removal is also working fine as expected.
>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> References: d2b0f6f77ee5 ("powerpc/eeh: No hotplug on permanently removed dev")
> ---
>   arch/powerpc/kernel/rtas_pci.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
> index fccf96e897f6..206c825225c2 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -54,6 +54,10 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
>   	if (!config_access_valid(pdn, where))
>   		return PCIBIOS_BAD_REGISTER_NUMBER;
>   #ifdef CONFIG_EEH
> +	if (pdn->edev &&
> +	    (pdn->edev->mode & EEH_DEV_REMOVED))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
>   	if (pdn->edev && pdn->edev->pe &&
>   	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>   		return PCIBIOS_SET_FAILED;
> @@ -105,6 +109,10 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>   	if (!config_access_valid(pdn, where))
>   		return PCIBIOS_BAD_REGISTER_NUMBER;
>   #ifdef CONFIG_EEH
> +	if (pdn->edev &&
> +	    (pdn->edev->mode & EEH_DEV_REMOVED))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
>   	if (pdn->edev && pdn->edev->pe &&
>   	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>   		return PCIBIOS_SET_FAILED;
>
>

