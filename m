Return-Path: <linuxppc-dev+bounces-22688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EFECD98DA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2026 06:18:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfcHW2htgz3bsY;
	Tue, 16 Jun 2026 16:18:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781590695;
	cv=none; b=jLIF4CtdXHRGaxQa5WzRkdUlkSOiUC9DCkJXWSJS74OuHor0WGOh+NVdC+qAcqKTe2DI00dJD0P/vq+F4/l0rep4VBSUKchAaeRNJY4JjgzzO9dNkMQAHinXuqpd52sc9eL9A3cHNTVfMpUQyVuwd9RPQAAGdbzUZRu0+48d/RjIzghcr26k7vep0ddwYKfs+SdFd6AK9brQtHfgWxQDwzl/shSX1YSjVolLlBAnynQOf+Qun1kfuzIIV/NypMAUBJLAh2JWPlmZPcWVv9lNYccQK+uc2JBV9Fdjy71FOKxcy+Lv9lHNwbE3Vf7M3eTgA2BM+eqJDwbaQK8VRzAtgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781590695; c=relaxed/relaxed;
	bh=iXizRHv0FVEs76Ri8foNhDk9Bb6z3KFlkbxAFlcmJyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6+5tAZ8IIzDf1BDYbt62Fu94B/tEcJpGrPVNMGZDhH6zaH1/54HXKv9JF4ZRZtINAZ1Nb6BEJCIWBcbihUzfvhUrDk0Gj9q9LkNM/cuHnsp7mi3TZIco2qYP5KukxrB363MZ5YoAvKsjyyVQIPDCV7GqulIQyWDoR+fbsaTStCy4lYudvavl00agVZKYO3hbhEkomaZe8cTmej5ReqsxtRv0o/gN/e7fqUiLKZ236FzzHRQwxEns+PJW1mNTElur90qIb9SEy2J9Tj3jdGao8jwLt0el5GNx46Fad0TVjrFj5Zev5M30sOjC8eY5SFMSmszVnOBZjdFFdtAWZ1j6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NYWwRZvU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NYWwRZvU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfcHV3t4yz3brH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 16:18:14 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G0mY1p4015946;
	Tue, 16 Jun 2026 06:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iXizRH
	v0FVEs76Ri8foNhDk9Bb6z3KFlkbxAFlcmJyg=; b=NYWwRZvUc1RgIvwZN5/8tw
	/61uMnV7V2XFgYKpqX8Ib6cpIFoXFkbH0nf5iliZSjN0CRTw3tRhSSk91fFG3XyR
	K88w00GprZ3h56aCnkipo3nJejLsbit91yq3tO1dEQODv71BJYNbalmwZc/C0gM6
	813uyEgPqENBl7alumTRW2orzUuiQddvhthzpvXOKZDqLA7Ny3PFJUZMSVeLPSrf
	eb+TmZ0wGSIwM+UhpabWegukCZBZ0buI61oYVtWgx79CTxX7MlN+9qnTplcrNM5j
	5ST1q1X6v6XQwMGphtVrGEg61HJU/qPUirB92avvSjqfSkUJgCAeNAZNAo9gHEVQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg3p38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:18:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G5o4U8005610;
	Tue, 16 Jun 2026 06:18:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h1y38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:18:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G6I7EZ5833560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:18:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF3D658043;
	Tue, 16 Jun 2026 06:18:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 840E858055;
	Tue, 16 Jun 2026 06:18:04 +0000 (GMT)
Received: from [9.124.214.227] (unknown [9.124.214.227])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 06:18:04 +0000 (GMT)
Message-ID: <8d647e52-d5cd-4158-9072-7ea6e4c1728d@linux.ibm.com>
Date: Tue, 16 Jun 2026 11:48:03 +0530
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
Subject: Re: [PATCH v2] powerpc/fadump: define MIN_RMA in bytes value to fix
 overflow
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        Christophe Leroy <chleroy@kernel.org>,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
References: <a9d56fe88218a7034296f1974568543a0ce2d973.1781265400.git.sayalip@linux.ibm.com>
 <eci8du2i.ritesh.list@gmail.com>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <eci8du2i.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfX+rMlAphVWWdN
 LlcOfyrJlOFf4V9r8shN+4jKy3oyoIM8wP0jhUTLOIpJgbOZ6p+BSOQu9U6Qfw2+uRhyI50DsGl
 Ix7PM3ZaX8hhJPP9WPjjbzE9OOFG8gk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA1NSBTYWx0ZWRfXzFYtDVwhzygM
 btzOqwKPDwvN2RlRdPLs6LmD6QLLKjSlnkgSWha9/q97llL7s0bkebO/Fr/d+/lJrfTkse2CNwt
 7CvIv8FnTgwhnoj6DXxL7/5ZhnuGoG9c8GcT5a5s6x3l6jjpSElT8ZYQP7pKjk93npPxFwsSvyU
 ihAIWZcQcr45rIiDn5DAWzhqmx4NmJ56LaWj4I+hSm2ZFncpqx0q1G+i4dmGlUtfMD8Vg7/2wYy
 NOc76bxf7GwcDBqsiDQD1Brq9YiPUJ86gLxprQ3MdR9WGx6mZrwKl0AaMZchPRkn3gSXmlM32h4
 viR3yvDdSNtvLUo2guPvzXbNEXmPdq5OUQ89iamb8FBkgFsUx8V9Ik1qO5c1L0OLwNX5ISDqYwS
 3MnwNJed/UBogHtjdta2CF4jXO5ZEaHjUhtFLLaMMdjFRUjeIEyQp3kCE5qxLazWiffpdUtEbR4
 X9OWXbBtWbRvys8O8AA==
X-Proofpoint-GUID: gnxeqbfAcIODpv3Ya5o7TBlXew6yn2kY
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a30eaa2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=egA-69wl1Ip0yQvshfsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VDpLcEpsr5E0-sLIK0SARNCkBvX-GvaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160055



On 15/06/26 15:06, Ritesh Harjani (IBM) wrote:
> Sayali Patil <sayalip@linux.ibm.com> writes:
> 
>> The MIN_RMA size checks in fadump_setup_param_area() use
>> (MIN_RMA * 1024 * 1024), which is evaluated in int and can
>> overflow when MIN_RMA is increased to values such as SZ_2G.
>> This triggers compiler warnings such as:
>>
>> warning: integer overflow in expression of type 'int'
>> results in '0' [-Woverflow]
>>
>> Define MIN_RMA directly in bytes using SZ_1M and update the
>> callers accordingly. This avoids repeated unit conversions and
>> prevents integer overflow.
>>
>> Also convert MIN_RMA back to MB when populating the firmware
>> architecture vector, since firmware expects the value in MB.
>>
>> Fixes: b7bb46062457 ("powerpc/fadump: fix additional param memory reservation for HASH MMU")
> 
> Since this is not a bug per-se, so we need not add a Fixes tag.
> But while we are at it, we may correct the commit subject to...
> 
>      powerpc/fadump: Define MIN_RMA in bytes rather than MB
> 
> ... since there is no overflow with it's current value.
> 
> With the above changes in place, feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> 
> 
Sent out v3 incorporating the requested changes.
V3: 
https://lore.kernel.org/all/310b040acef712fdc79e3e37d0f4c2213938b556.1781589284.git.sayalip@linux.ibm.com/

Thanks,
Sayali

