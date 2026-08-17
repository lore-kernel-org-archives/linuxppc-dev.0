Return-Path: <linuxppc-dev+bounces-25898-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D2CC5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2026 04:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hNfLq1yfNz2xrC;
	Mon, 17 Aug 2026 14:02:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786939379;
	cv=none; b=RP8NPgH1pXnth05Cel3MLTstPcai8RtaaozI0eh18z5edG8t3rPV8dmlv2DWpRgdUDjBGfuurGx0xiGt3Ahs+eMq0qi1WRU8ih7TaAM5CXET7ZtSfFkWtAhK0yiFHQSt+E0IlwjIgqtF0HND3HDORU+zvBWDUMRIEGts9rbmP4Uw6Qt9WmI9A4RrhfTP+BhOOpmLoA0y7N09OfdeUdNM9V/n3If7f5TB55Zxc/AXEWT0x9YMkcagk+x/KOPqRJhkTEMmcVK/mnEmz6rc1Dgj8GIapIB8xNY4kTPIafOeLKtj55CqbPtZLF83n1qXZPGNl61yjAMxOfXC/Tr//Vp5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786939379; c=relaxed/relaxed;
	bh=m7rjdXvxmQVC11hGSLVWeG7Ao0hxbGsMr2H+5qF0uQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xs0P9H1OWOz7eiSrCH1l1GxT8CGXYzJ22TnIp7r3ymHV8jiclNaD3DuX8vtYic3xKP/kpfe5HEgw27999Mdh/bxXGQrbWBq3Zq7fjwvn1gUYIQyrmkY9VZ+nJCM5EHfL4a9YbsDc2QYO0dq8kYM6ZFp6jk31KuIS8MDvKjxkJTlYx4H1mwv/lMKDO8LdlZWrIbrK/Q9iZDd8tFTwCTQm07IxMT4cJEBzjorrfh/IJH43YJOiIbIi8jaRspyPfd8fSSe3aXeEL7KK4wpx/KHWqknbymytFbMbPPOZjYRhZH1qIzm4YlAdsMQYm4SnYnD25MWbQydFkLMq0GV00uiNwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JphkqLm8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JphkqLm8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hNfLp1hlWz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2026 14:02:57 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVtGj3636306;
	Mon, 17 Aug 2026 04:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m7rjdX
	vxmQVC11hGSLVWeG7Ao0hxbGsMr2H+5qF0uQA=; b=JphkqLm8kIRAkbhLkVJxnI
	q/AYOS1AKsmUtvA8demXZlGXCsiNiH6eKVGf426K9EBt4Yjfmc4WrbcRQWIHuzvh
	dUgR26gSGuGTvf4nXunsO1ChqdEYTR0oTOwfI7fYVYVcP/1MkD/dqtZOyV0kMEOt
	ofH+tPhie/Vdahik/0E0Y6G0Vogx+7g1icIBKRKUYWjYz3148XbHPPxzAVq5BzHX
	BvmQoivqtSGejJFhDAYnb140JE4uLn+3/+zB/ZQdPRNXf1iBZEtRBmroczr8vtUY
	WTgTJl2/HwqMEZlh8Q54AxmoWTh31I862agguKWYWIn0LbalA+S+M64jKFkbdeBA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkr61c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 04:02:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H3uaoq018398;
	Mon, 17 Aug 2026 04:02:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng40td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 04:02:54 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H42rnX17629780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 04:02:53 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF9058059;
	Mon, 17 Aug 2026 04:02:53 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C2B058043;
	Mon, 17 Aug 2026 04:02:52 +0000 (GMT)
Received: from [9.123.14.9] (unknown [9.123.14.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 04:02:52 +0000 (GMT)
Message-ID: <931bb729-a991-49a8-ba42-5bf45eea21ec@linux.ibm.com>
Date: Mon, 17 Aug 2026 09:32:51 +0530
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
Subject: Re: [BUG] Continuously increasing spurious interrupts inside pSeries
 guest on PowerNV host
To: Timothy Pearson <tpearson@raptorengineering.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
References: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyOCBTYWx0ZWRfX9kbMi7QaO6iE
 HE1EPFCamX9r997V6dvVyi0gBWffCsDs8Ujcbkd0icWwVJEJJHj69NMeHcKrFC3Q9f+0jEZk4EZ
 iLbuuTBTnduAzUXbwh7caB59SAJyfHSH7mx3N7zO1DYUBcjNlv2kMPyOAIFxn2pum7zto/Vr4R4
 OXL8bpiEAtAlMI6Mj0FwsiRTBGWlQNrdt95kNdgBz1prADI4IzXRrwkH/Nm6LFor1M2b+8LHZ6w
 Ee7zGl/tPV3I344Muu/PiiARJlFj4yZWmSZitJjHi22W0ZH22pQMKVbjiHiCbkuqy8bvKxves/U
 rApDxUCsA0xClLmXaQ75OPBGKxIBsmcUu/OZRB/jCUqj7KUZ6SbvQ5S4P7ojRSkl1WQLJTzL67z
 i8C5k2y2lppX53VTlCDqVXFWZzEfeRfVmeJou3Vdl1OQnmkyIrjhNqpuHE9httdDuTukCzJQrDw
 QfBr4OWVHh41XwR9a3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyOCBTYWx0ZWRfX5TGyHwyo1tJS
 SKOx3bHGdFe7TVXRX2wkG7/pF8RMeotYnz89GHIF588v4GuLIcO27i4FADcrkr6s4edgkqbiIMr
 89xP9DsjQHIL5loJt063BHNPtZMZLYM=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a8287ef cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=nJLlUGOcei1BVvQT3c8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _olPxzV9vWDBQtSJ3cKBssHNf8kLFAOw
X-Proofpoint-GUID: I8QSrJ0aQJKY5yGDTBEeTyfdN8oiSVRW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170028


On 8/14/26 8:26 PM, Timothy Pearson wrote:
> With kernel 6.12 (Debian stable) we see a continuously increasing spurious interrupt count inside a pSeries guest running on a PowerNV host:
>
> cat /proc/interrupts
>             CPU0
>   16:          0  XIVE-IPI   0 Edge      IPI-0
>   17:          0  XIVE-IRQ 4096 Edge      RAS_EPOW
>   21:          2  XIVE-IRQ 4353 Edge      hvc_console
>   23:          0  XIVE-IRQ 4097 Edge      RAS_HOTPLUG
>   24:          0  pSeries-PCI-MSI   0 Edge      virtio0-config
>   25:      50995  pSeries-PCI-MSI   1 Edge      virtio0-input.0
>   26:      45569  pSeries-PCI-MSI   2 Edge      virtio0-output.0
>   27:          0  pSeries-PCI-MSI 16384 Edge      virtio1-config
>   28:          6  pSeries-PCI-MSI 16385 Edge      virtio1-input
> LOC:       5781   Local timer interrupts for timer event device
> BCT:          0   Broadcast timer interrupts for timer event device
> LOC:          2   Local timer interrupts for others
> SPU:     449927   Spurious interrupts
> PMI:          0   Performance monitoring interrupts
> MCE:          0   Machine check exceptions
> NMI:          0   System Reset interrupts
> WDG:          0   Watchdog soft-NMI interrupts
> DBL:          0   Doorbell interrupts
>
> The spurious interrupts are apparently from the virtio0-[input|output] devices.

Thanks for the report Timothy, we will have a look at it.

Maddy


