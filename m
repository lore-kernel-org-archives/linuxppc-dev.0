Return-Path: <linuxppc-dev+bounces-25231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546B8C5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:13:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD5vc69XVz2yhP;
	Mon, 03 Aug 2026 16:13:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785737596;
	cv=none; b=MNElNbbTuz9pxKR8KxqKcXAUGIfdy+4/vCX1+Bp0twQDDVN0aBZo0Sge75ohoxtTBMMnuDhell4r5HipUkW29renbToVTuZiJEFkQ88Qzm6q9oRfPFgzNCfsgsdtrdwd1aXBiHb2yUCkyPRNA/VhQGJjtbAzPzjX6N1JacCegUGEyTZxV3TnaO4kXx/OzAk1+RkeS+5ca6FVWCGj58ZTkdJlYHqO7ywz+DxW0SeFv7bIO2LMmToz8nVtS3xLBD+eTM02lEbO8WSMnTaUirlB6cSw4AVNHXhhK1tv771377imd51s7oEruaZ//aJxxzS1ODpD1gdmPWfoW9QoJBEmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785737596; c=relaxed/relaxed;
	bh=mZ/XQGv2uH4gRJm6OW+PuhEi16DtV6ecgPKdHt3cY00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8e9PH8Ql+lciLAJ+iDkFelStQX0IY9LD+kJh3rsUszKnR5TBOogK7Dn55SjJ5NT7aIvF05KukpFfiZcmKt2ROJwMlXqOp1vzHSZwdV01YEL9CT67WNNzpnJwzKpx5eEpXIzLD3cZqVMFWTCQd8m7TM9gA2yk8FV+1BQ7KsVXk0G27vLI3xdJoXkErB1nxdxLkcAKSKKwEwjSd1t0GyKVVpiyrROGJHFCoK8/+zaC97S8DFM7OT0/NwfYqHgGWsvrqom4RzfV1rtBAoZA31+5hEYC0MyZCwPVbK8kHm7OTcQHEg0/osftpbvzw8uT5SG+In8XxoYTbhedj5ClqnAfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BuQDXLOw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BuQDXLOw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD5vb459Mz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:13:15 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm1o9167621;
	Mon, 3 Aug 2026 06:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mZ/XQG
	v2uH4gRJm6OW+PuhEi16DtV6ecgPKdHt3cY00=; b=BuQDXLOwH65zJyLPU4IJD/
	P2Aj0I+VKEv87cajfG4sDVow6amAvFmq7f2dnPR5w73zkNvpzbt1sEW7oUFWae7/
	igbqztZ0iLZnd15HUx46SI5S5EB6ZjjoS8o+7VoQBJT6qAfvqX/oMMpNNH9wnIKZ
	lW6NQrnz2mm7HIe9/tdPRQqulMbWmvkQ/8zhRUa29gddovnjpWI0O59hIGoUnCm7
	uXGI7/HbYC4EAdFcIYj3xfYQeuoS7NJDtxXal29ww8kaPMzVs5I7grRyvFoNvn6n
	U8f6rBNyTOMwdoTExCLKN6e9fbyk676dhC3u0H338ozZMayAOjN/peBQqqo13OMg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy15v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:13:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736BEKg000612;
	Mon, 3 Aug 2026 06:13:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybrwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:13:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736D06M62128582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:13:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5316558052;
	Mon,  3 Aug 2026 06:13:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CEEF58056;
	Mon,  3 Aug 2026 06:12:57 +0000 (GMT)
Received: from [9.36.20.170] (unknown [9.36.20.170])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:12:56 +0000 (GMT)
Message-ID: <4774b148-7cee-4273-9c24-1e86d4603dad@linux.ibm.com>
Date: Mon, 3 Aug 2026 11:42:55 +0530
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
Content-Language: en-GB
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linux-kernel@vger.kernel.org
References: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfXyq7UlHKO9Dld
 ynalTavpFQHF73ju1yuuezqjh3xb9/tQhLGXFQICq27UQNvgzgdrUh52+R7ieJ1CHF94Wbhp2Rp
 ZOdyIbJllJBVOnUlJCeJ3fsSonnrfxE4TME1DvCEwJjREbPc1AeGrJ2MDAP17Htnvo54gM7Alr6
 94Sb1Fxq46wdbjE4JkeZ1W3dV/PRUx5d3wvbHNbrpAnld2IjZIjX2Eqf21MBLuFjcQzwoeaEcxq
 8Yhb4WMdgjQWhb2BNt3HVTVPmvVS0tb9hsJIfy+//YzAjGyyi7LrizZGdsZJFVErPa5EpkV+mB0
 T9QGBV3zIDgLydxKehBaS2AOito+6d+Q5suZFxUKXg1GnNwDOYjHDrX3QvZBuTbgzStEr7kNJUW
 5RRDXPiLut1o7lVQNT0darFgAG3Ck5+s6fCV74YT9jPOB7EO0oaEQWie8x1mx43fJ8jq2zHXYTa
 VssR+RpPC9GiElHaCeQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a70316f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VnNF1IyMAAAA:8 a=2bSin88CYBwzzSIUHhIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZXyKo-wyab7XmuTWaRGNM4XHsX5zFNTn
X-Proofpoint-ORIG-GUID: hl07_a1kvpT7ebkpr0dgqzGehJ-0CP0_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA0OSBTYWx0ZWRfX8guDu28CUi20
 jbL4Bfu1RMD6ipI37FrGuAGKD82/gShWKUskGgKeHPqNCTwRxQig4gYpPSKKQqi+CPvAqFezncf
 2wjyfWOR0UOEKeWVj5QUORDd1ZnCaiY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030049

+ Sourabh, Mahesh, Narayana - FYI/R

Hi Shiva,

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

Thanks for addressing review comments. Feel free to add:
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>   	if (pdn->edev && pdn->edev->pe &&
>   	    (pdn->edev->pe->state & EEH_PE_CFG_BLOCKED))
>   		return PCIBIOS_SET_FAILED;
> 
> 


