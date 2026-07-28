Return-Path: <linuxppc-dev+bounces-24923-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C04C53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:19:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8Wf92DK6z2xyk;
	Tue, 28 Jul 2026 20:19:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785233953;
	cv=none; b=mNB1WqtBtCifNrsNMSO5Id3q/Z0IxGtX7zObnsF257x4J94vfBXNVpWUqB68+WzuCd5wJVYM8OSPBj7rATgSLjoCea+f3lfssJKr2O8i8qA3QWy2qLYfpV7e/QLTT20ukFkSZAEHyugDbOha2imb0xKg5vzdgowZJbicdnBliPsnGuYdD6nbPZEUMVFPH5tREuNi8CFPrDV5702KfyDoBZ/qf1KBEyctjXUQ0YmLb6XJrnDrSmvnjGB5nc0b85dFmSIedpQlHh3cRIBO2I7siXlXv9qCtEVs4E3nAoPBMMj/Jz0/8lUuS1WI4xb7fF61MdB1rXj/1I1eH0ogwJ+ISw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785233953; c=relaxed/relaxed;
	bh=20clSKjrkY3LR5FI2SK5TXJPPQRLR0i+g+Ob0lXHQlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kc0RXS+F+HKqdgXTSGdr4OgaevgcljzTLoomfKsizMQTVpVv0BERrQ+5YnodJihyD6EKeg5Z8j73PEw55I1DhE1AJ73i5/86hlEM/aSrPczueOyOFCR5bA39RMHlnY/bd/22LJ4Xd4sYYPeOM+sjKb+wldfouyTHb9CCkBzPiYyb3z3S59huq3A/n5aZYQ+cB40RmMgP7KIe4JBut+c0SV/dXsobXCt+aCIudL/BFFLh5dAQUSjeD0ZZOl9inUwnSnk2yU5S5ZCyeoCoYqvHa172U7Q/9V8/yNoIqgA7nZjh9CyLmuEcVeSBeKA4wlKYI5i+Q5+ezFv9ipHAj6s70w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AuI/Qqd4; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AuI/Qqd4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8Wf75F6vz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:19:11 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8I8H7484911;
	Tue, 28 Jul 2026 10:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=20clSK
	jrkY3LR5FI2SK5TXJPPQRLR0i+g+Ob0lXHQlc=; b=AuI/Qqd43xFh+Rf8rMLATG
	Jf0NBzvOE0ZiCcUTsUv0Xm9fbbspK0n2rGcHsYJ3Fs74oM8M9as8tSVkm+cGoyz/
	KKjL1lA7p2v/S93F8HKzo90JWrpuNju02Esfd6fssStUvfMkL+Z+jltIUdfVR2IN
	RZ57+9ln6LZAjCIyOSrSOASs88glcvJrnfScoysD5A+0I2PA9WwPnURTJ8WPGfoP
	Dk5o6fVjKwvtm/lR86t8u03vdKe+LM7SZS7x8MVu1VhGX+O0H3LN9bknUavPm6i0
	U2G2mkOh91D02jWXubz/qGUYcx1OiXctYiZTtMxUlWc5ebh5GT0YH6Y+CSZbXVnA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7cmj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:18:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SABM0V017751;
	Tue, 28 Jul 2026 10:18:53 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh9874-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:18:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SAIq0224707608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 10:18:52 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BE6E58062;
	Tue, 28 Jul 2026 10:18:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 595CA5805D;
	Tue, 28 Jul 2026 10:18:49 +0000 (GMT)
Received: from [9.43.35.153] (unknown [9.43.35.153])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 10:18:48 +0000 (GMT)
Message-ID: <23a3df54-dca0-4c98-89e6-9dd89e746b01@linux.ibm.com>
Date: Tue, 28 Jul 2026 15:48:42 +0530
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
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
 <a7f327e0-072b-41c9-ba95-361c948ddfa9@kernel.org>
 <b671b001-8120-4f50-90c8-3d0abf01300e@linux.ibm.com>
 <20260728151342.229f146b-70-amachhiw@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20260728151342.229f146b-70-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: w-oSVZRBMBGhb2z3e5CkCRo0eftIpBpl
X-Proofpoint-ORIG-GUID: DP1TZG9oc3S2xiamcV1rFB7wZjqGWLFu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MCBTYWx0ZWRfX6rGea9TPzJot
 rvYAFd5ab122mtnUIajPe772rTY5XmEwvsoirzMV9Yn+sRgBED7OjJDw0C3f9AXqf2A/daFmPdE
 JbVG0QwtJZEaxQ5qo4Bys0mg3LlDPwOiWpr05+yY61IjOKrw7fYZIFICvdWNpz+ffRIiQuGVMDV
 eqLsm/WS81p1AcDAPUhosgB64S5AqHg0Fs/NHtPZZNAskJZ+oGMUjLAVNHFqmPDOem2sHSUBnpy
 15MKbihm03HW8eeS3xZKkS4ZfIpoSIYlBLqeEHdSNSTVXJaTdfd4Ag9CINhqEKXJ2i5m666vQ6d
 eDKAcR/vGolfzYFG3ERCpnoI0kngH88o4b4l6d74eG7Sm5odaHxIM564w98VzkRXq8H8VGKDM6t
 Th9ze6C/6wIA25Pl2J3diWKVyg/KCFxBgyqGfDfRvgZj7dJ86zyj8vxJ1guhwCUAi16mqy2sNHK
 3gIHj9t4YtfpLqSda1w==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a68820f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=Qa5cbdg8B8FBaVCEi-cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MCBTYWx0ZWRfXw0TOyvlTb59x
 sKXdabUR6nMOZe6zYfzWs95/REwzJfx1viM2XN5Zcfzny6Hkhr+DlmV92IUi6bkNBlYjt9lesHE
 ZHxygnSrx2DfgO7pCP9OlWyX34XqIVg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280090


On 7/28/26 3:14 PM, Amit Machhiwal wrote:
> On 2026/07/28 11:32 AM, Madhavan Srinivasan wrote:
>> On 7/27/26 6:47 PM, Christophe Leroy (CS GROUP) wrote:
>>>
>>> Le 12/07/2026 à 17:13, Thorsten Blum a écrit :
>>>> The local table structure is not used - remove it.
>>>>
>>>> Remove % in the comment while at it.
>>>>
>>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> Looks like it's never been used since commit de91a5342995 ("[POWERPC]
>>> ps3: add spu support") that introduced it.
>>>
>>>
>>> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
>>>
>>> I have no opinion about the %0 versus 0, is it worth the change ?
>> FYI.. I have added this patch as-is to my fixes-test
>> not waiting for v2
> The v2 was already sent Maddy.
>
>    https://lore.kernel.org/all/20260713091731.97212-3-thorsten.blum@linux.dev/
yes I have picked up the v2. My bad, sorry for the noise
Maddy
> Thanks,
> Amit
>
>> Maddy
>>>
>>>> ---
>>>>    arch/powerpc/platforms/ps3/spu.c | 4 +---
>>>>    1 file changed, 1 insertion(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/ps3/spu.c
>>>> b/arch/powerpc/platforms/ps3/spu.c
>>>> index e817def7f424..c904f9fa1caa 100644
>>>> --- a/arch/powerpc/platforms/ps3/spu.c
>>>> +++ b/arch/powerpc/platforms/ps3/spu.c
>>>> @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
>>>>     * The current HV requires the spu shadow regs to be mapped with the
>>>>     * PTE page protection bits set as read-only.
>>>>     *
>>>> - * Returns: %0 on success or -errno on error.
>>>> + * Returns: 0 on success or -errno on error.
>>>>     */
>>>>      static int __init setup_areas(struct spu *spu)
>>>>    {
>>>> -    struct table {char* name; unsigned long addr; unsigned long size;};
>>>> -
>>>>        spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>>>>                              sizeof(struct spe_shadow),
>>>> pgprot_noncached_wc(PAGE_KERNEL_RO));

