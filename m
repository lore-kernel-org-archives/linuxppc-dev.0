Return-Path: <linuxppc-dev+bounces-26084-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B537C61DBE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:01:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTnw04q6Gz2xVq;
	Tue, 25 Aug 2026 23:01:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787653353;
	cv=none; b=IkUjwx/iSLWOg+b4vSLeMuyHztoq2R5D0q7R7IopL8QQ62bfSJ2K8DXYgA9HfCDNGYBHdrxthOwgDfljpwRCI2tT8Aafn6BCLiUkNCf1w6Rb5yHNkwDHZHFHH1q1lptP6uwQLgwOuGfHuyZIY1P9GDZWUbYOYxdcPkNC/CdqMwIeX4wxHfVOIiNw/nobrQFgfA65kDpkc4c5CZlH/YFlDhiB+694FtTx5+laldJvB4VteslHqc4v8837sApKZ66oY6WV/M10HY3WyL0KZ28LLohUEjly7pP568DqbCj4YLEIc0jxB4rzHIta7W4T5dSFmcRQgXg1xgMcacbZ4Rxsxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787653353; c=relaxed/relaxed;
	bh=oFvNJcbP64tjTMQvQAPxvauvBL5kTdyPeqPkHabVOyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+unAKJJSeLc9IQHrWgqlzs98rfGqDpA4FWGI/qokY/9KVpzgYXfXhp8QWTpoLdGXm4LF0pUpBCirVjkLwAllbzMzSQuZb/f1u3JOtdNwjVsEcbOkJHWesgMuQYktcJCXVSJ8tuj2K+mNumqu9+dWSGiSMY3q526MZCrDXqP8D5IgKipVw57x0mTfTXabaeE8bk5reesxr7hShJ8L4kp4L0KnR8dCHxmgbnfF9v68GxH0OVLjgVmOulz3ew5jV6z2ungHTi6g2VC9PBt4lGSsKkMSNexbemvWptnOen+3OWH3yxoROSW56gEmElG16YTZJ9EbIiXCQq9rjygfx6iFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NTQg+IbM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NTQg+IbM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tasmiya@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTkP41kNmz2x9g
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 20:22:31 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P8VcWA2649244;
	Tue, 25 Aug 2026 10:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oFvNJc
	bP64tjTMQvQAPxvauvBL5kTdyPeqPkHabVOyk=; b=NTQg+IbMk2sSoGrOEFtDsM
	JwJufUP+SuQLMVD7kVJiPEisTAjwuAVqBcqxeW8cQlL6K6khLFUnyvTl61iU+YCM
	e01MlMO5eQpsV8BUOHNung9ObodHhutNCS9fNc3OGcEtxQT6HZ7PYrn/yCm3R7uB
	Kkc9UKgOY14OVKjVTxAfZquQ13ssRuN9DcrKBiS2PuTF203eAtYLIhW5GJO1rNte
	CgDTfqkGk4a+ATaiYHc+BlNR0QzJS8KHZ6diHbOOuxXmeW+9lvoJcc5113EhJox4
	dM1yYReRrdiwjHA3+7r0HQ1cBAEdTISzfTlbcpiWQ+FK2HzTE4NlTjT4cXGgqlXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqqfbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:22:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P9uHXN000600;
	Tue, 25 Aug 2026 10:22:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3q3vdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Aug 2026 10:22:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67PAMFcm46531028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Aug 2026 10:22:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBDB20040;
	Tue, 25 Aug 2026 10:22:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2A82004E;
	Tue, 25 Aug 2026 10:22:12 +0000 (GMT)
Received: from [9.61.254.232] (unknown [9.61.254.232])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Aug 2026 10:22:12 +0000 (GMT)
Message-ID: <80aded32-3975-49f4-a91a-b58b236c832a@linux.ibm.com>
Date: Tue, 25 Aug 2026 15:52:10 +0530
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
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
Content-Language: en-US
From: tasmiya <tasmiya@linux.ibm.com>
In-Reply-To: <177725851139.12391.5948009745181492600.stgit@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: QY_hyjgkWm1NJ1xOB7Wx8V_sARFA7KeA
X-Proofpoint-ORIG-GUID: N6dgpzf8rmJD-9OT2DkoLgCFIPWrKSGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX0Z2ot7ADwItm
 Pgy1KSDTw1mYicPMsutB9EdzuE1MUXxSYh/0wKhNYauWYu998VYXFOmm//fBwkYiqVlqspEoUfv
 NijKi9YEaKKy3T+PTfRAtcuuhmYDYufQ7V0ziaF7dQgkmk468Rh4d5oejNisU99EK5e16MqvUT8
 VJCgwmzR3LJd7csOh/76dwQqp3qKN4Lotv0IQuayQAV+jIjxQyox1/V3A9NZoK0BKmEWXbN4z96
 09urvNEMMQ0eFdrXEFxqmkrBA99pk+rkkOqFQR5h/Gq1pMphk30w4pHK3Bjy03NgVLT5zTMlDHB
 jy0udjCsLFeH2eI7X3BQOHvqadF/jIS05eD/lSVnGuqLJUjsQ6s6D/I/F23FI8gj5BVezuChp6B
 PZvoLwc2D3gG0ogla6/we61JNNLENGYf9qds/4gIMIKrPLFqKGac2T5f6oIICmHXMKXLABGD08s
 yjQAPvD1lmMcjf1ndSQ==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8d6cdc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=x8_tG_8x05Wmyg-anQgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfXwam7c06kaDH8
 nGQKd5D++bGSH1Slde3FlvdBuHT/YMZxORKFhy3WZHOiG953y0kNmkZV27cJRlK/vXp6tSVDfei
 HHIWRc8euj/c1+7njJ+tQIkaycgNT1Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250085

Greetings,

Tested-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>
Reported-by: Tasmiya Nalatwad <tasmiya@linux.ibm.com>


I have Tested the patch in my KVM guest environment with device 
passthrough via vfio, It works fine and fixes the issue.
Triggered EEH freeze beyond eeh_max_freezes to permanently remove the 
device, then hotplugged a new PCI device. Without the patch, the rescan 
attempted to bring back the permanently removed device. With the patch 
applied, the removed device is correctly skipped during rescan and only 
newly hotplugged device is seen in the guest.


Thank you,

Tasmiya


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
> +		return PCIBIOS_SET_FAILED;
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

