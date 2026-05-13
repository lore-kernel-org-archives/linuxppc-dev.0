Return-Path: <linuxppc-dev+bounces-20830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44DB8CD4851
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 06:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFkbp6MnVz2xpp;
	Wed, 13 May 2026 16:49:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778654998;
	cv=none; b=k+i1xmx0MpRrtFYYEKsQ99blKv8Id+teGxzG4sqct58ISCGsUxHg8OisfN2qbsiPRTL37Fv73/QFz3Y/g1jvhW5tN5b3ZCaloiWDWr8IvbodOzFmI9INQMbQBe97cm4aKvngz4kVZkqX12EqXbNYFOR6pSFTWqNXNuBMXlpNi3qdBn/lGKlqQnKfYzrTyPJ7CWoQ08SNVKHQ7K05zbUVed8+zukteX4rVXBn3q6EADN88WDkgcv/35cCdU+WrCz3IqEleyNKpQV/Ae6wvDWjWKyiFBDep6bKr0RaA8CVAkUQ3JujZPfuFmHk8lOuiOIvVvshMh6xIpQn9aJLVnTMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778654998; c=relaxed/relaxed;
	bh=zb9AnSZJ8g0WPOC/nqP5MzEBiIJ7WLyueMPR929x84k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkDxQmTp+OmNPY5HD0xhNtjXm1k1CJ78/KHKD0YVxRxEAmtsWXgur00cQMH14h65xx3AWTnlQFwnPjRLSq6GAQuG0S3kuX3YR6V0343q/GfLRB1ZAR75KTqAnWjFQYDq9uCXFPnCj6/WZu6kQXMthvOJKa06pWg0q/9h+8sbW0xRx08sY8FibnXHvwIMAObNaqB9iBZNG8Vle+huO1WTHl6lAAt2zMnxBoFxD8/cFFEZ/KmMsozzX/wIy8SCUPtfj/gLnkEuwYuwXHVhRXG+EKE/5pMkweT6VbsXOAItvmG86zEM3n2wXSg4XqckFLNbBmHJlJ/lkNxg0iz13bPNPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PJZKY9il; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PJZKY9il;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=harshpb@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFkbn5kqqz2xlV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 16:49:57 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D2YqgU3179852;
	Wed, 13 May 2026 06:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zb9AnS
	ZJ8g0WPOC/nqP5MzEBiIJ7WLyueMPR929x84k=; b=PJZKY9ilwXIhUZeOaNHP4j
	qBSKKlIoj/jXROM2HyAj71i85DIH+tmB9yCC+LT2cdedfoqqzciAuo5qO5DuWApa
	Rgw9OBKa0cviYd3s+5+y0nG8zW7rE+a1T/2aqe4pZnktuGXisMjnR/39clEH4LDu
	Cb8ss0Hv8ewnA3rcU5d/+IUfDhHD+WPXb52Wot4oDZ3EW02ZzApGSNQc8aEHjCmZ
	JsuqUkErwpLnTn0zOc22V5cXsi2cen69NnDq2nZk0U9Z6kl8K1PaRT+8Z4j2S17h
	GKY8ZGnfB2qbjYMPirbrZPZ8cHvdtJ/dfau5kY1WWrhTOA2cuvlwufkSm/KXI+Xg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6p5px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 06:49:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D6deWS031508;
	Wed, 13 May 2026 06:49:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpm01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 06:49:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D6nUAi62390736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 06:49:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC3358054;
	Wed, 13 May 2026 06:49:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ABC85805A;
	Wed, 13 May 2026 06:49:26 +0000 (GMT)
Received: from [9.39.26.26] (unknown [9.39.26.26])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 06:49:26 +0000 (GMT)
Message-ID: <a994957d-ab93-47d9-9fd3-16b0ce701c6e@linux.ibm.com>
Date: Wed, 13 May 2026 12:19:24 +0530
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
Subject: Re: [PATCH 1/1] powerpc/pseries/pci: quirks: Add pseries TG3 D3hot
 delay quirk for EEH stability
Content-Language: en-GB
To: Narayana Murty N <nnmlinux@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Cc: christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        mahesh@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com
References: <20260428093529.7618-1-nnmlinux@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260428093529.7618-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a041efd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=v8Yr_C-N-M78gxKgxPMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: pBi12oTuJGY0WC4PBSUcPBTI0sR4oViz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2NSBTYWx0ZWRfX6WDri40QNy0h
 SREeKKmxqGnQaZ6X9iu6p4UX2KlKVaUKfGFPkYJqTRtjXZAYw5A5wN61tjHRF/+xHiAxSI1MvNp
 +tuWVlceiFbyFffjfEW6UaDLN9coN8heYzSxsnSETrYDOkJMv7R2MQv6nMOBN3zsQPWdhLHJeOF
 QFDGzpvf1K5IYXHNgJgzEuBWAUtweEEpbPpX/3divpY0HfuD0nDSgRR6vcUqkszoV9GFtHVhxiF
 L+GS8DRICF0y5z+TwdYy0keIcVwW6c2FWVOx11Pv/Yg92r1SMbI8PCJPX/35WZ1WVNftGt1t/XZ
 vCtElbKzD02G8gG9kbsTq9ac2nWAorcHQxd/cVkVC8lO2WOncwql4MGjuL2ITd2Pw7eIk2/j6Fa
 hSbh7gN9lIxeruyVcUxa8GmAYORajx42lbRuhp0Z/DUPjyaHMHxDNozZijEtaf0bewGR/hjofB3
 uSCP22HEYxWaUOoztdQ==
X-Proofpoint-ORIG-GUID: 5VYVtYpq5e5j_EbuxFbwByCW9mSiaIbs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130065

Hi Narayana,

Few comments inline below ..

On 28/04/26 3:05 pm, Narayana Murty N wrote:
> On pseries platforms, binding Broadcom PCIe NIC devices to the vfio-pci
> driver frequently triggers an unintended EEH (Extended Error Handling)
> isolation event.
> 

Commit log title can be rephrased to say "Broadcom TG3" instead of 
"pseries TG3". Also, need to mention TG3 in commit log as well.

> This occurs because the device firmware violates PCIe specification
> recovery timings when transitioning from the D3hot to D0 power state
> during the binding process. The strict pseries PHB catches the
> resulting Unsupported Request during the subsequent configuration
> space read, assuming a device failure.
> 
> Add a pseries-specific PCI fixup quirk for Broadcom devices to

Not all broadcom devices, only TG3 specific, right ?

> explicitly extend the `d3hot_delay` to 200ms. This forces the PCI
> core to sleep long enough for the firmware to safely complete the
> D0 transition before attempting config reads, ensuring a clean VFIO
> passthrough initialization.

Do we need a "Fixes:" tag here to mention specific TG3 device support 
being tested/fixed ?

> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/pseries/pci.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
> index 84e4ffe957a8..5f3cf9a7bdd3 100644
> --- a/arch/powerpc/platforms/pseries/pci.c
> +++ b/arch/powerpc/platforms/pseries/pci.c
> @@ -291,3 +291,24 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
>   	bus->cur_bus_speed = prop_to_pci_speed(pcie_link_speed_stats[1]);
>   	return 0;
>   }
> +
> +/*
> + * Workaround for sluggish PCIe device firmware.

Mention Broadcom TG3 (specific device details) here as well, until the 
routine broadens its scope.

Also, which specific Broadcom device IDs exhibit this issue?
Are all TG3 devices affected, or only specific models? Please document.

> + *
> + * The device violates the PCIe spec recovery timing when transitioning
> + * from D3hot to D0. On standard architectures this is often ignored, but
> + * the strict PowerPC pseries PHB catches the Unsupported Request during
> + * the subsequent config read and triggers an EEH.
> + *
> + * We inject a longer delay to ensure the device is ready before the PCI
> + * core attempts to access configuration space.
> + */
> +static void quirk_pseries_d0_wake_delay(struct pci_dev *dev)
> +{
> +	dev->d3hot_delay = 200;

No justification provided for using this value. Is this minimum or
maximum from test observations? Please share test details in comments
and/or commit log. Also, I see Marvel sky2 driver using 300ms, not sure
if we may need to increase. Preferably, use a macro to define this
constant? Should it be a tg3 driver level fix during probe or be placed
in drivers/pci/quirks.c ? Also, is there an impact on system boot time?

> +	pci_info(dev, "pseries  Quirk:D3hot->D0 delay %d ms to prevent EEH\n",

Double space after "pseries", missing space after "Quirk:"
Also pci_dbg() may be more appropriate?

> +		 dev->d3hot_delay);
> +}
> +/* Blanket application to ALL Broadcom PCI devices */
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM,
> +			PCI_ANY_ID, quirk_pseries_d0_wake_delay);

Replace PCI_ANY_ID with specific device IDs that are known to have this 
issue, or provide strong justification for the broad scope as it may 
impact system boot time.


