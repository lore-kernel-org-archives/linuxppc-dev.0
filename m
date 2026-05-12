Return-Path: <linuxppc-dev+bounces-20793-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10481CD4F24
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 17:18:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFNb12Vtwz2xb3;
	Wed, 13 May 2026 03:18:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778606285;
	cv=none; b=f9LzYmaEF8mYg64wAw5XT/KzkssqG2qxcs6nlJ/kd5K++x7bm1ExptXyJhYVXMCNLdpPIoO8m2x0j/7hQFdvqk7b7JEBZoU/YDNTUspYpHiCL04XTkVGjKqHN1kpjyeuQSoY3tzqsdiWDkq3SqxNwAe+GYF8gZiraR2HMJFi3jyu5iJMOW9i0EjIYMQgQByti9fQdpCDcCh5L3gH8lcQmsX/D1QlFul77cgBgT7YX/owXWCoNQ9mM+MbN6COdc1bYbNdLgK7mfiHkATMUXgYZf0VOc1QFw7otoOpzBFlVc43wm2WwMAy/7J5p3B8YBPD2OTVuVuGgdHYWrSy3aGR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778606285; c=relaxed/relaxed;
	bh=fTpDlWO4wjDcJ2o3f17FVyRu8e/ZA1t2XGuF2DRbWD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mx8C/niLUpBH7PcVOMNFiNUw9yZZyHEST+vuyWpzZjeSl2xycnYk11aD4BmXznhqwKR+0vWZrBT0FhGQQid7cQFH5vqxg7H8kPQXOIdylrgNjAcalMjlMxCX2tRkHJA5xh2wYvHxrZI9WJfeR0IkwWhp6mhAUJTWV5nyWxZKz3qhfGuf0nsX2uwKiZUkgNxloFWWd0zEeGOc5EDy35vuEi57xgqHC/z2SUuO+DuVZOFvIAK+0JzFItv9LFYklf+vwpRSR2CXU95p3HkLufmvQN5siL/yXtg1Hk99wh4HVLYLONAJOVoFisAEp0bgf/whF2OaYONYFCc7I8r8iHQH5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r+xYlNUe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r+xYlNUe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFNb00gRnz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 03:18:03 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64CCcmd52608405;
	Tue, 12 May 2026 17:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fTpDlW
	O4wjDcJ2o3f17FVyRu8e/ZA1t2XGuF2DRbWD0=; b=r+xYlNUeP+O4GqiTLrs9qB
	ewJWp+aWnXw08CScxBKTeGT2mc94zA4nFlDun+sxTTfYidX6WxlhOSU/F7ZuledT
	t6LWlmNsu1xj2NDmeXqVyteBvvonegrHiMI5V3lOlhRE6p91LD/RKiDp9jgLHsJA
	Yb974ItFE203Mnvua4vdewnvSfokz9BahJzlOsgTLNLAvzz+h5mU7HXhWVnzktOc
	rblmee+UCRQEA3RQjIwWv+Rf0W2kMgT4wpOb0deyOEOTwz5y88BG/Msuz0FSm9K4
	XSZjr7b1Is4MdWI9XSMcOMJKsieN6SBnLPx3159QWDHrRMau7Or5KD5R60EnAhfw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv547d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:17:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64CH9SoR029777;
	Tue, 12 May 2026 17:17:51 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgc4rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 17:17:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64CHHppM24642066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 17:17:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F11E858055;
	Tue, 12 May 2026 17:17:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4255658043;
	Tue, 12 May 2026 17:17:48 +0000 (GMT)
Received: from [9.39.27.160] (unknown [9.39.27.160])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 May 2026 17:17:47 +0000 (GMT)
Message-ID: <b7b05e38-675a-4304-a266-91b10ab74e50@linux.ibm.com>
Date: Tue, 12 May 2026 22:47:46 +0530
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
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3OCBTYWx0ZWRfX/YzKyTfwBwQY
 GDBcG+zn3lj8QHZeXCbSoC1bQdUkCB3qsa5Sc/2bTsrEjvFX8mFM1Xtifwjw6XA+6/d807JngHy
 SwTlBL2qsKaxF57C0uooK3S8WAp31r4rU+NEM28UIJJW6QzZKnX1W4HTwsVxwLsUiC3Tyri8Ke4
 VXUeOa4mwypk6fOqwcNyZmba3JzO5EBYe1vAn0BctNTwacoFhW3phLuhs9Qd8GReX0cPDV9k0Qt
 nvUG3WFpJ3fCmK3dBUPsqZ4sPmd/trDXemuXvQ7KnYm5wHHZ5FvYQq/+i7qhW9qnc68juJYoS7o
 hTCsvWOvk4b8A3qnrjSVE+4NA1HT8rCRK4Z5nmJFuaM4iecFkP82zUVsFSSctgGzSUqyXtY+BGv
 9R0aL4HIvRNMCQES2aTgrawgbb3m6HCxl/7WcXuXekUgBWunf3jobs2cFE6Z89GI7MnerRZGUVq
 LHPEy75I/f0f0qjGOzg==
X-Proofpoint-ORIG-GUID: lCWR-71AWLPWhJ2HXqmNzjaLJ5ud4Rr4
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a0360c1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=Ay4m-i_2IE4umDc45DwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZZMvLkw2mwt5lRADhkgaKyl9G78u9ROu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120178



On 27/04/26 8:25 am, Shivaprasad G Bhat wrote:
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
>   arch/powerpc/kernel/rtas_pci.c |    6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
> index fccf96e897f6..ce24b18712ca 100644
> --- a/arch/powerpc/kernel/rtas_pci.c
> +++ b/arch/powerpc/kernel/rtas_pci.c
> @@ -57,6 +57,9 @@ int rtas_pci_dn_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
>   	if (pdn->edev && pdn->edev->pe &&
>   	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>   		return PCIBIOS_SET_FAILED;
> +
> +	if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)

Consider using paranthesis for (pdn->edev->mode & EEH_DEV_REMOVED) and 
moving to next line for readability (similar to prev one).

> +		return PCIBIOS_SET_FAILED;

Why not return PCIBIOS_DEVICE_NOT_FOUND ? Returning SET_FAILED for a 
removed device could be misleading.

Above comments applies to below changes also.

>   #endif
>   
>   	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
> @@ -108,6 +111,9 @@ int rtas_pci_dn_write_config(struct pci_dn *pdn, int where, int size, u32 val)
>   	if (pdn->edev && pdn->edev->pe &&
>   	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>   		return PCIBIOS_SET_FAILED;
> +
> +	if (pdn->edev && pdn->edev->mode & EEH_DEV_REMOVED)
> +		return PCIBIOS_SET_FAILED;
>   #endif
>   
>   	addr = rtas_config_addr(pdn->busno, pdn->devfn, where);
> 
> 
> 


