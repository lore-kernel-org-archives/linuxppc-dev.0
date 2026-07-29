Return-Path: <linuxppc-dev+bounces-24975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A08C54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 08:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h94ph1kpYz2xrL;
	Wed, 29 Jul 2026 18:13:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785312812;
	cv=none; b=FqINeeYUsh9owbiflYrmBeg3YgLyCRTwe/FUK9x2uqSx7WHP3gDnFaISvgiSXJUo2hlN66RFcdb5Cc0JwqizNLoXv3tL+iChKcry7NEJ+6Yam+i1ZuZsmrtD8D7DPi4BsKNA3f9vJrSBx77K7BnsfezGqLuTE9xpBPfnvOFEuhIv2Yo7v+Apu4iZc0BRccqYDzzT69ibr0YCTqHdvbStPCq+BUfVCzm9uNYF9xniW2yzTcrll3S1mnnMD7WD5rGE69Zhy2E56EE2I4exfUKpAE14jMZv70j8zmsuKSlXds4ryuBQ/uvm59JDuVLl2FRp60y0WTdCcrVZoOa5OC1bdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785312812; c=relaxed/relaxed;
	bh=Zj8xlQpQT1qlVLnN1tvUBEkv6y325NX8k5Myxf91WTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxxVOzaBosj0I6Qo3RzXWCDo54rUx3d78d/eq/UgmzA/qqm0kyF8kVItIbecnfUMzUph5coENiBlV397jedBz4aBCEL8u8EnBd4Zt5VksgV70+QgpO7HGo317+Sp2bBg0evmpkNyBy7EwX9WGgAC+eTgblLCJRNRSEaB0umTdbcg92XfcaSaqBz6iPMpTBA3wipdKKEUGkxacj1KkZXtEuaAgrlSPvQkqo5fcZWZXhb9k2kUB/NgYQxR/uOSGRGCqBRDQJt+X61w+26yfuztRay6cHh9xF9X0nI0Zul9qcLmn4WFoGW0xMMVMxMLeH01U5c4XTKO/Eh22NFu8Efd0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OqHeWxga; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OqHeWxga;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h94pg24nWz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 18:13:30 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7ljFc1722249;
	Wed, 29 Jul 2026 08:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zj8xlQ
	pQT1qlVLnN1tvUBEkv6y325NX8k5Myxf91WTc=; b=OqHeWxgakNmRMPHlhw4z/W
	hBMjW4nfZLVLGPWSp9+xH91ROm6vHQVSWoq0nRY+pyIPUkl+Wtz5s70jRfh5tg04
	w32IWFCASoI7oqce5EqB2LyjxPncqMEDb4jKVDSJpP9RxpDwBJYhQqtIHMYDyI0E
	3Be44qxynZq3XWAdMTuscC6v3IF7yZ8ACQVXynFsV9uDSx2pU0K82scp0Y88iXNe
	9OmzWTFRrmvYYpxyIBzk+Buea+0oSs7Oa5PC9PTpHgjT9JeuXc12N+oLLpnpyCb6
	BcQjHsYOZbjWNTzOEnvZbdhKgiHjl0tDTZ7AISFbc5WqgSLcPHaq+75ilFgXW3xQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuychk1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:13:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T8BJPI032610;
	Wed, 29 Jul 2026 08:13:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw5xp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 08:13:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T8DESB30278258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 08:13:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B83E620040;
	Wed, 29 Jul 2026 08:13:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1838520043;
	Wed, 29 Jul 2026 08:13:12 +0000 (GMT)
Received: from [9.39.24.31] (unknown [9.39.24.31])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 08:13:11 +0000 (GMT)
Message-ID: <93bd50eb-0205-4ed6-a3cb-a29bda61db3d@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:43:10 +0530
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
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is lesser
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
 <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
 <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
 <4e7bd9342efa0cbdd162445a994f73c9ad473645.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <4e7bd9342efa0cbdd162445a994f73c9ad473645.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mTZGkNDAx-goU1ZEh5ucpLvuSerr5FDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA2MiBTYWx0ZWRfXwBQ/+rIjHgC8
 xN95o8x1WRiFxG7QtgbHqOo5MIVEV3t+wyTK7KudPOZ9Xmp5uAJmL7cY5thyZTjGYbBevMqrLpr
 TOR9VohSRLQH17Vic4m4kTNh+N82oax2XXrk2bZvvf+2JKLZlFMRKC6hu+/Co8LLrSHBzrI4OkG
 Mdb7E6I6YaQOxhaELHelwH9xmVZFGcLgBCrkgTq155rsTMRdT6+Hd7J4hi7qcac/VNVyBc02M0o
 e/v07YSdrZm15eIoMcOeXwk5vGOZ2rnpBu9AesoLHKsXF1cxIcXeN6UK65RVzzxHs8P5PPLQN9w
 gA6BNgqf2YKNXm265cjo0p7wKNlQbXsoFHXuN7OZUmjNzMv01pc7kUecyP+NpxX6+W3/iZLKs+c
 xcuqUYuX2ZqEOeMx4ZiHQVZR53tj4pC/cLsOvc7ApHBwE9BFdbRfwAueh7L2CrdWB1ZaQL3D/1C
 DRpC7GYtmT6eHyShFdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA2MiBTYWx0ZWRfX/i+jWj2Cxuzc
 7LNQiB4V9c0sGMVbIeyTAt2BwV6Er7xvqYjINVrQzp/VI3wfDCunbn9vaa2MTqXIYRAqIKDAfvg
 iQvy0Wi1Clc63lRJ/CFHnd/GDZEAMP4=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a69b620 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=kwF1vnAZszKunuOjKt0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: aXKBVhE0eoDwHzGaPdcNSIgQJIZfZSyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290062



On 29/07/26 12:30, Shivang Upadhyay wrote:
> On Wed, 2026-07-29 at 11:58 +0530, Sourabh Jain wrote:
>>> Yes, I made it this way by reading the dump_bytes and source_len
>>> relation. PAPR only says that dumped_bytes should not exceed the
>>> source_len. My change reflects the same restriction in sw. Also
>>> along
>>> with this lengths check, we have firmware reported error flag also,
>>> which should take care of overflow (Qemu handles it like this [1]).
>> But the firmware not copying the entire Real Mode memory is also a
>> problem for
>> the kernel, isn't it?
>>
> I think it should be fine. Firmware will report it status flags, right?

I don't know. Does PAPR says anything about the error code corresponds
to when memory to not copied completely?

> There are these valid flag values.
>
> Dump Error Flags (set by platform)
>   Bit mask
>   0x8000 = Invalid section data type
>   0x4000 = Invalid source address
>   0x2000 = Requested section length exceeds source
>   0x1000 = Invalid partition destination address
>   0x0800 = Partition memory destination too small


