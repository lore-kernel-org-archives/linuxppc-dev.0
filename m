Return-Path: <linuxppc-dev+bounces-24324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C868C44512
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jul 2026 00:18:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1Vqm4rscz3brV;
	Fri, 17 Jul 2026 10:18:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784247492;
	cv=none; b=npvrA/cOtRSMo1mVdgEf/vHIdSD+Yj0BOkf2wxBip6qvookHRlYqsoezuhLUW6MeLsccoIE9qJa5pwEiFM8gT4inkehZhEC2MLQ28AqchspUwlGrdaPHWkn4zUYguuZKnJzQxyfOq531F8uJxExruxkoJabxcyr7SLl9s3DLyEFN5SUhTde+RZLUBR5pf8NY8WMOkzH7kKWFmVfdmEJKx3wdBrsrPEGjdmKsg+plWETaf3K0+Y7emaHTi77PvJYOBocBj1+c0W3KDfEclGt8guJofw8Tt/RMZof1M5vI5eMy9R2bYgTPJ/vCQYgcGU5cKYZrTZPvjRUaAiWjQ9rz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784247492; c=relaxed/relaxed;
	bh=4AdliLziaxe3oWIP0QLOr4ptlmfg4nGfLqRA/ySQzcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILaxIK3DEgFhZWX96KBPjMWadC+5CFlyVAq5/TkTULhg27g9XYy3DdEQu0lR+JFRLhq2k3LWyn7VPoKs/DorNwL9H/RhBwkm1DwQWUBi1kcmBBKrB4no1MIS41Pm2wJWuf8Uwb7ufGQsBPRQj6ahWIODyf12/Td6VoFjuIe76q91qztY4ZLM4M1cVG2p19l7MX1xjZKNpyxR+iMi0tpG6cqPf9W8BL937TfWJu7Nhel3EBB+TvdhBOj12jqVsdn//wYT8IrdLKTEieTORSPLGugaWNHNZ1zorvwqeCbgcBKjBLlG61s1UzJgoSq69guCT5kAXu505amg2IBiJd+VDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XCzvnJYR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XCzvnJYR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1Vqm213cz2yRF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 10:18:11 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GNgF8v2751611;
	Fri, 17 Jul 2026 00:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4AdliL
	ziaxe3oWIP0QLOr4ptlmfg4nGfLqRA/ySQzcg=; b=XCzvnJYRxR/fsyi+EmOyzV
	twYAFkNcFWEk8mBGB3FlCG0xkxfmuIttxYE4xc+PfRsNCmCSjz8DvCcqd5eOjBkS
	LvwTm/TGCMmkvaEu4OLraVN2d3ceBRNavuayhrh91etKEFuIXj3e1vBl//NtDec2
	vd+F38aL74Gayb+jO2vWeR7ythTeGmqfal8MJ3GVFaGJCT0qBsxp/dJtBIg4bWt5
	2W/2+f5sc8p9oLZfL+vlbxK0SvO2XTkP7PhsR2QEuzRb6FgyahrMLTzzHmZH+Yjx
	+9DNfShmeLyY28B4d33mDaXWw/4TMjEkrqQvig/sdcHrDFkcTOxnWvxxMeuaf4AA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33m8hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:18:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66H04ddj012120;
	Fri, 17 Jul 2026 00:17:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uyf49k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 00:17:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66H0HwRN24969760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 00:17:58 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1156B5806D;
	Fri, 17 Jul 2026 00:17:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E00D85806C;
	Fri, 17 Jul 2026 00:17:56 +0000 (GMT)
Received: from [9.61.118.188] (unknown [9.61.118.188])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 00:17:56 +0000 (GMT)
Message-ID: <053ed037-3079-41a7-9340-616d9ae052c5@linux.ibm.com>
Date: Thu, 16 Jul 2026 17:17:56 -0700
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
Subject: Re: [PATCH net-next v3 05/15] ibmveth: Refactor RX interrupt control
 for MQ RX queues
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, Dave Marquardt <davemarq@linux.ibm.com>
References: <20260706193603.8039-1-mmc@linux.ibm.com>
 <20260706193603.8039-6-mmc@linux.ibm.com>
 <20260714124327.GJ1364329@horms.kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260714124327.GJ1364329@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfX7q8wVXLxB1Nd
 8ErqQEU9sXKNhLT9ocdqSwMvk+NNbVVZlfN0wK+jOofRC86OKLMW7JU3/BTORAbq+BrK1B1Pgnj
 8CMAAc9sAyBWzTku7UJIaDQpVOJJIuo=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a5974b8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=F2C2ttmqdAMir2IvWxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TrkS95NrFAmGbjKqQSKH01RFt9_N5rTy
X-Proofpoint-ORIG-GUID: ckgN4CW2bdOQa9-Hbvep9iom1OIk4hFX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDAwMCBTYWx0ZWRfXy291Lp/PU4Ck
 K1db1nR4qZMfpWyFKi5kAIkKaX0tfnLViYjUTWU/a4U93eot697Mp2lE8VWxyAhvie0JPOKvuW/
 61U9a/7wG4oNAMZ03UW4bAzKx85ZG7cordcWkKjyZ2YwI5XuiOMI3/NCm7nEyKBZb8ZkWOk3eng
 nXF/vCqPqeySz6s+mAXo0iM3yxMYM8VuLQQVSGEa+Bc68ZbwmdfufPwNuIizLPMBs83c9tB2DMW
 d+30M6O7DcFKGIZ6d1DUjI+Ov0HUlxfzfTJy33Pxapr3P04o5ZouA+zZ2Lf2rXlrGa1pPPzb4r1
 puM3kGREBXO1GggFgIw7SPfONpQxwl7JHWpx6UP27xDdpuDKeSdfskRBr6/K+6aoIJN73b01Hho
 agnjK915LWHa+pbeSXK8maUc10WXcqPDpbyA5ZV+A7cvKRB3z2Tq3XK13b27YiAKBGsS9hxurwb
 KZlh0eZY9hyai1MFLAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_08,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170000


On 7/14/26 5:43 AM, Simon Horman wrote:
> On Mon, Jul 06, 2026 at 12:35:53PM -0700, Mingming Cao wrote:
>> Queue 0 and subordinate RX queues use different interrupt control
>> interfaces in PHYP:
>>
>>    - queue 0: h_vio_signal() after h_register_logical_lan()
>>    - queue N: H_VIOCTL against the queue handle/hwirq mapping
>>
>> The current code is single-queue oriented and cannot safely scale to
>> multiple RX queues in poll completion and open/close IRQ setup.
>>
>> Introduce queue-indexed interrupt helpers:
>>
>>    ibmveth_enable_irq(adapter, queue_index)
>>    ibmveth_disable_irq(adapter, queue_index)
>>    ibmveth_setup_rx_interrupts()
>>    ibmveth_cleanup_rx_interrupts()
>>
>> These helpers centralize queue0-vs-subordinate dispatch and make IRQ
>> lifecycle symmetric across open/close and future resize paths.
>>
>> request_irq() is wired with &adapter->napi[i] as dev_id per queue, so
>> interrupt ownership follows the NAPI instance that services that RX
>> queue.
>>
>> Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
>> Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>

**

*Hi, Simon*

*

Thanks for the review of this series!

*

> Although it is added later in this patch set, I believe linux/irqdomain.h
> needs to be included in this patch so that irq_dispose_mapping is defined.
*

Thanks, will fix in v4 — move linux/irqdomain.h into this patch

where irq_dispose_mapping() is first used

*
>
> Also, I think it would be best to add these helpers in the same patch(es)
> that they are first used.  As this will avoid temporal compiler warnings
> about declared but otherwise unused functions. Similarly for patch 13/15.
*

Agreed — will fix in v4. Helpers will be introduced in the same

patch that first uses them (rather than ahead of the open/close

wiring), and I will apply the same rule to patches 13/15.

*
>
> Overall, please make sure that when each patch of the series is applied
> no new warnings or errors are introduced for allmodconfig W=1 builds.
>
> FWIIW, I exercised this using gcc 16.1 from
> https://www.kernel.org/pub/tools/crosstool/
>
> ...
*

Will do — v4 will be checked so each patch applies cleanly under

allmodconfig W=1 (no new warnings/errors), including with a

current crosstool gcc.


Thanks,

Mingming

*


