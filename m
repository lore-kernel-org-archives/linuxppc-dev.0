Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D633606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 06:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WYYcvG20
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNxcc0plXz2yCr;
	Tue, 10 Nov 2026 17:31:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794292272;
	cv=none; b=QoFsB0PuwJpOzEtLXeRe+cRz7bHgDzPvHu8Sm3pasFLiduPNZL4oLo9EPp167xm/oW4jMrEsrZXeZml0fIa5+6E9zsSodLp+fYYcEzIpHvuKLCTHTiLPz+kxok9UwWxTDqo0frBNrYKf3PhAuYvMT47i5F7ZYAt99uCYZkACijmFu6wXe08OESPoFK8elJYxN+C9CuHHf8ve9A2MhjGaDxPaVtfmZPKx7TUjPZuyuHy6ABBx/ZKzjEALQxdnRcwsW8sIZoDwZjiYr8BVq/CQQwrwiK70wB/7IGeqxgZhtJSZsJ4xAimX5ukQktvjgIWzU6YJcRI4GOe14C6jaBpDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794292272; c=relaxed/relaxed;
	bh=brTub9yswbs14Dup/AWHeKj8h33iX36qRGdcXTFiC8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzL0Uj3tur2KIio4EUlz5ev0oDm2pjb28UrouIOQ9wDIHCJHT9Ew3Hgp5BIOtSzfqALrh3Td2kb/mFQKjmmYrqy2hi9hxZBZmKnXMk2FcbIDK0gPF89H23cQTv6SWGU/ciq4jdnozRcwDLI9y7bo98sFOIDwToFsyglH7xxQjLWd0FZr2xoVvQFXwJJ7Av0yxpvX4pIUUEPLRfX4UUdJy2KXTNtZiN8Zo/CRIHNdY+pLtYIkZVrscxVB1Ht0rbo0YwQutNnHwWEInKaaCdT44azrTLEUskkRpKaHScv7J9COwF593NoplusY/KfgfILcgXhsCkt1r51eE5rdqCaweQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WYYcvG20; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WYYcvG20;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNxcZ6DHTz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 17:31:10 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA527bk3985578;
	Tue, 10 Nov 2026 06:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=brTub9
	yswbs14Dup/AWHeKj8h33iX36qRGdcXTFiC8Y=; b=WYYcvG20XQnPtp5GK7lyyb
	LF7G2pRPOXytOi9RQJ/SWUcNtCqFimUz680AD/7PZdIfXzTn2E2LQJpAgSJdKXwu
	+eKzKzxCTjUCeCk1kja11a+GsB+pUjBmI2AXkQCYMdm4A28xVM1Ib1RDoYp+3MD+
	HUn0bjvVnzA3UfYo2TAVFTIZpUzjYH4nuS8X6i1v0xXE8OczwbwrUhyn+F9OOjMW
	JIMi2r+Gww87S4Tg5tmjpSdYngvC83w/z5+pO6h/+ORkUgK1nSfLUvzruLkDUvvu
	/Cv4BSWBYawWCb6AyU5tKdnS3Eypi+6TS85f2vFt4rTGSRR98zBFNNCdN5EFsyQQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt3hqe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:31:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4Jwh51176809;
	Tue, 10 Nov 2026 06:31:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak5e8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 06:31:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA6V1uT31064670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 06:31:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 251B158055;
	Tue, 10 Nov 2026 06:31:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5498B58054;
	Tue, 10 Nov 2026 06:30:57 +0000 (GMT)
Received: from [9.43.53.138] (unknown [9.43.53.138])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 06:30:56 +0000 (GMT)
Message-ID: <1bd2597a-4873-4f99-b29e-d5e74ed45b22@linux.ibm.com>
Date: Tue, 10 Nov 2026 12:00:55 +0530
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, npiggin@gmail.com,
        linuxppc-dev@lists.ozlabs.org, info@xenosoft.de,
        Darren Stevens <darren@stevens-zone.net>,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Damien Stewart <hypexed@yahoo.com.au>
References: <zevr6h46.ritesh.list@gmail.com>
 <E1BAC41D-33BA-4A27-8549-6A885489A59E@xenosoft.de>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <E1BAC41D-33BA-4A27-8549-6A885489A59E@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyNCBTYWx0ZWRfX3M078CFe5V1d
 qb3/bk0/0q9YcNTp9EK6vjhpKK+dCRrl0i219PFsnpbxXwHmJ8nHRzihVy3zJ+K80RixJsSsKzk
 JTnweBs+yh4TbyYzKYCkMq6/j07eCJLnsHYGJRDxJXTIxRATvkOWBVfbpzMBp5yBrDf4q+Hm+P4
 1xhKzF/+rFml/VPMyLlDBRdWa4FZqLRkDTeHgcKbOKnQ3S8m4Kz+GL6iOCuhm58rY0eTFxzv9U+
 C3MWcT9ox5IHj7oFp30v53JWoZbBeDzEkyvSJvZnMnbvPdjNwYBXa6f7SRYuLGi06GxzJd5chbW
 HlxOWrvIRDFAKD5c+Kv1KH0tk8pJN/6v+TeLWJVR+4m2BPhcO/oTJqKAygiBmInQ/kPgPIz3Hyw
 EomzifS87g+1TDCWpkrWK6jNMZ9w3hialK+KOy9FtfLwZ1idDAWLMP/G1PlglGe7EC47gzjAiyL
 TzEl159NkRU628CKNyg==
X-Proofpoint-ORIG-GUID: dK3_LM67Bi0BHrIfY2g_Oo10HwNjyVvf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyNCBTYWx0ZWRfX8ognxOgN7mXX
 GJnvuqv0KxyukD2RdisMe92PAzR1H0ssluwtljJQSbjdMJbMhVSyM8gW3PJKIc7gyRFdgcjhq6R
 5j7oV9POzgEyUpAAmpkxo4Bs3X1mU44=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2ba27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=EV07jdzEAAAA:8 a=WpgYjbwqG9q_6oIgj48A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=31fNt1jvsjPrYqhKI4eU:22
X-Proofpoint-GUID: hUN3bLK0UasfBzXro-p50lpBfsCZUWMx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100024
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/10/26 11:09 AM, Christian Zigotzky wrote:
>
>> On 02 November 2026 at 04:39 am, Ritesh Harjani <ritesh.list@gmail.com> wrote:
>>
>> ﻿chzigotzky@xenosoft.de writes:
>>
>>> From: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>>>
>>> Since pas_pci_init() is now called later during boot, the i8259
>>> initialization in pas_init_IRQ() happens too early and accesses
>>> registers that are not yet mapped, preventing the board from booting.
>>>
>>> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
>>> after the ISA bridge has been discovered.
>>
>> That make sense to me. The patch looks good. However, shouldn't we also
>> add Fixes tag and Cc: stable tag - so that this gets backported to older
>> stable kernels.
>>
>>
>> Fixes: c144bc719234 ("powerpc/pasemi: Move PHB discovery")
>> Cc: stable@vger.kernel.org
>>
>> I think the fixes tag should be above - but feel free to correct that.
>>
>> Otherwise looks good to me. Feel free to add:
>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>
>>
>>> Suggested-by: Darren Stevens <darren@stevens-zone.net>
>>> Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>>> Signed-off-by: Christian Zigotzky A-EON Open Source <info@xenosoft.de>
>>> ---
>>> arch/powerpc/platforms/pasemi/pasemi.h |  6 ++++++
>>> arch/powerpc/platforms/pasemi/pci.c    |  5 +++++
>>> arch/powerpc/platforms/pasemi/setup.c  | 12 ++++--------
>>> 3 files changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/pasemi/pasemi.h b/arch/powerpc/platforms/pasemi/pasemi.h
>>> index 6f6743b8e48d..01bcfa258625 100644
>>> --- a/arch/powerpc/platforms/pasemi/pasemi.h
>>> +++ b/arch/powerpc/platforms/pasemi/pasemi.h
>>> @@ -7,6 +7,12 @@ extern void pas_pci_init(void);
>>> struct pci_dev;
>>> extern void pas_pci_dma_dev_setup(struct pci_dev *dev);
>>>
>>> +#ifdef CONFIG_PPC_PASEMI_NEMO
>>> +void __init nemo_init_IRQ(void);
>>> +#else
>>> +static inline void __init nemo_init_IRQ(void) { }
>>> +#endif
>>> +
>>> void __iomem *__init pasemi_pci_getcfgaddr(struct pci_dev *dev, int offset);
>>>
>>> extern void __init pasemi_map_registers(void);
>>> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
>>> index 2df955274652..fb53782da7ec 100644
>>> --- a/arch/powerpc/platforms/pasemi/pci.c
>>> +++ b/arch/powerpc/platforms/pasemi/pci.c
>>> @@ -265,6 +265,11 @@ static int __init pas_add_bridge(struct device_node *dev)
>>>      */
>>>     isa_bridge_find_early(hose);
>>>
>>> +    /*
>>> +     * ISA bridge is now active, add the i8259 cascade (if needed)
>>> +     */
>>> +    nemo_init_IRQ();
>>> +
>>>     return 0;
>>> }
>>>
>>> diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
>>> index 45792ecd5dfd..7a961f2a228f 100644
>>> --- a/arch/powerpc/platforms/pasemi/setup.c
>>> +++ b/arch/powerpc/platforms/pasemi/setup.c
>>> @@ -216,10 +216,12 @@ static void sb600_8259_cascade(struct irq_desc *desc)
>>>     chip->irq_eoi(&desc->irq_data);
>>> }
>>>
>>> -static void __init nemo_init_IRQ(struct mpic *mpic)
>>> +void __init nemo_init_IRQ(void)
>>> {
>>>     struct device_node *np;
>>>     int gpio_virq;
>>> +    struct mpic *mpic;
>>> +
>>>     /* Connect the SB600's legacy i8259 controller */
>>>     np = of_find_node_by_path("/pxp@0,e0000000");
>>>     i8259_init(np, 0);
>>> @@ -230,14 +232,10 @@ static void __init nemo_init_IRQ(struct mpic *mpic)
>>>     irq_set_chained_handler(gpio_virq, sb600_8259_cascade);
>>>     mpic_unmask_irq(irq_get_irq_data(gpio_virq));
>>>
>>> +    mpic = irq_get_chip_data(gpio_virq);
>>>     irq_set_default_domain(mpic->irqhost);
>>> }
>>>
>>> -#else
>>> -
>>> -static inline void nemo_init_IRQ(struct mpic *mpic)
>>> -{
>>> -}
>>> #endif
>>>
>>> static __init void pas_init_IRQ(void)
>>> @@ -300,8 +298,6 @@ static __init void pas_init_IRQ(void)
>>>         mpic_unmask_irq(irq_get_irq_data(nmi_virq));
>>>     }
>>>
>>> -    nemo_init_IRQ(mpic);
>>> -
>>>     of_node_put(mpic_node);
>>>     of_node_put(root);
>>> }
>>> --
>>> 2.43.0
> Hi Michael,
>
> I would like to ask about the status of my patch.
Yes, this is parked for the fixes tree.
Maddy


> The patch received a positive review from Ritesh Harjani.
> This fix is important for our Nemo boards, otherwise fails to boot with recent kernels.
>
> Thanks,
> Christian

