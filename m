Return-Path: <linuxppc-dev+bounces-24091-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C4DC44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:29:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8bT740mz2xlv;
	Mon, 13 Jul 2026 14:29:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783916965;
	cv=none; b=f9rbsIB6JnIbm/BwKeuxNnl6ZdJnkuuahRiDLPxAKiSoM+dQkirRMsNIKxPBeFrWNiDd9zOORlQzvWuA7IzZxBI9p05XNGPftXxoG4QxQvwQAtlSnNeA40wJX8eM9KqA7lT7Wu4L/8sx4x5VMlK9+RHh/RD6UTiaH6qHnlfEYcfWg0xNn9c6GjWXbhtGbXg3E3OSqSCeejMg1om4HtZ+bi7kwrylraCKgOhD+nt6XDlKC0GEbmw8QflgVt9QwcqeDTMjGoqvuSSZZ1N9kMVXnD6PVPIfW28yv/Y3S/KMM+WaoDGgiijq5bqO+jqsPXfpwxIflUUjIOSA052oJ7JovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783916965; c=relaxed/relaxed;
	bh=gzB7Qq83W0yurf5d0T9ewLmRHCVVnYYeLNCTLvL7itM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CT+fELT3g+raa4eYkwcWLiH5bqW3QUyc/ATOYkmlRB5EU90lZYBaHf1aBS3y3Fs3dK7J/o7xxfZAaXD1CnJiLn7/NiANTH5aHfSrELNcuLsZwf2qO3PfNSWpQAfg71/uwd0n34tzOssuOReSC2nCY+DuqJYq5K9X8DTio6BGwtMXIjXeqZKNM1zvoGob7qRu9QlnwZtKeadNhVB9b8YL5p0mhVYJf1vXtwXXs5f4dTV4ydEYJobczPfETMssdNJA8JC5nSkkaVSHtgloslqw6D4DDsFtQlH5reaTwyxt5b8IaDZVVxrPv2zbUy9XW4La3BYQmz/Mm8cg3uMphv0NBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dxTULM+L; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dxTULM+L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8bT15Kyz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:29:24 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3C4SQ1284114;
	Mon, 13 Jul 2026 04:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gzB7Qq
	83W0yurf5d0T9ewLmRHCVVnYYeLNCTLvL7itM=; b=dxTULM+LIah4Maiz++XkMS
	QaJ6Rd8Mxkmkw0TV0nYChHYvF+6MZf28OhMGYGTlb4BQDbhYFnrAY//cXMwIHLyV
	X9c19WMemFIPi4RESy+o0SByqSLLsrW6eQUcoXHOXbFmvZRHeusoA07mlL3vGr7n
	gbv7pzRTt14gSV72hTFCCWKpKeZmsrwjHwPGJEJ5YMovOudL6gXHAj9yKWpcU8Bp
	5bBoHSaI3M/fCcMnWbACuI9t38slqEH9h0D54QY3HLhlWVSLNMBzXqYSo+zMCbQF
	1JnQyoArr+LmEcQttT9wTq0EowVojW+Pg5XGaDu1aqZat86t6Z06H2BaGCLtRa7A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86kxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:29:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4K0GB001183;
	Mon, 13 Jul 2026 04:29:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvv4w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:29:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4TBqx32899572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:29:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6051F20040;
	Mon, 13 Jul 2026 04:29:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2177820049;
	Mon, 13 Jul 2026 04:29:09 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:29:08 +0000 (GMT)
Message-ID: <adaccc07-7ae6-4733-b29c-ca81547ed504@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:59:08 +0530
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
Subject: Re: [PATCH v2 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a
 common header
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
 <se5nv7wu.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <se5nv7wu.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfXxeYZ3fbzjK3G
 btrQ0XpIt+DrWimtLaQ5bcN9iIv8ShrnefZXDIW66dk4IuE9aJuy63d35H70DU77Hj1K9dI7EMR
 5csSeK9VCvlyy5QummkIojFtcRPxCyZKbUZ4BijwKjcTaTZgXN8A4f8O8bfyR2WK1PWRo1sOtB2
 Y0FWgkbYtL11Y0LWJcXR2gOjciIezgnT8eDYgarGtDH4vfASeLyt+4VJOk3r9aS0PBIKzCbBfze
 lSzaWoo5Txk2nxQ2e9qajSuutEqG6hco+tPTs9r2dJ5RmTDcgGS1POQSihiP+IiWSi5+uQhWyx/
 ZyJ+1rGqzJL0RVgwfmcVcLXJbaWw1dkuSuJtiyVXGcEX79G01+CRexdfL6pODD6LYPHrNKJeptq
 grNWdT/Dvz/FKc+8d6hoUiegNUQhSQUuvYjOQN7k+Q+JjU2h1jEc/BAOHy9mTkreqYP+5vq6Jxg
 zz5ymRZ7wFnEpF1cltw==
X-Proofpoint-ORIG-GUID: KmurF7AQJxTT1siSrSkPNullBKf1MT1t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX/e9nWWRdLST1
 pLf6r3xi0Ij3ILx7ZIzqnyfi210jCS4eGGt3eUrf3XReGhwcRnwFus8AD5uxXPrswjrEtSa/fnB
 YtQc5dt7ZCHjJyCvkLDS6/OC7JoVjdU=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a54699d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=q2OaD_7NxbxaO4DEed8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: niqcrZRxeZdZ4yWFxIGV_wGD9IBOd4RY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130039



On 13/07/26 09:48, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The H_WATCHDOG input and output definitions are currently local to the
>> pseries watchdog driver. The next patch in this series also needs these
>> definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.
>>
>> Move the H_WATCHDOG definitions to a new common header,
>> asm/papr-watchdog.h, so they can be shared without duplicating the
>> PAPR watchdog definitions.
>>
>> No functional changes.
>>
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
>>   drivers/watchdog/pseries-wdt.c           | 53 +---------------------
>>   2 files changed, 59 insertions(+), 52 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/papr-watchdog.h
>>
>> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
>> new file mode 100644
>> index 000000000000..fb3a511aa861
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/papr-watchdog.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H
> should be _ASM_POWERPC_PAPR_WATCHDOG_H

oops my bad. I will fix it in v3.


>
>> +
>> +/*
>> + * H_WATCHDOG Input
>> + *
>> + * R4: "flags":
>> + *
>> + *         Bits 48-55: "operation"
>> + */
>> +#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
>> +#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
>> +#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
>> +
>> +/*
>> + *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
>> + */
>> +#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
>> +#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
>> +#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
>> +
>> +/*
>> + * H_WATCHDOG Output
>> + *
>> + * R3: Return code
>> + *
>> + *     H_SUCCESS    The operation completed.
>> + *
>> + *     H_BUSY	    The hypervisor is too busy; retry the operation.
>> + *
>> + *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
>> + *                  "operation" or "timeoutAction" is invalid, or a
>> + *                  reserved bit is set.
>> + *
>> + *     H_P2         The given "watchdogNumber" is zero or exceeds the
>> + *                  supported maximum value.
>> + *
>> + *     H_P3         The given "timeoutInMs" is below the supported
>> + *                  minimum value.
>> + *
>> + *     H_NOOP       The given "watchdogNumber" is already stopped.
>> + *
>> + *     H_HARDWARE   The operation failed for ineffable reasons.
>> + *
>> + *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
>> + *                  hypervisor.
>> + *
>> + * R4:
>> + *
>> + * - For the "Query Watchdog Capabilities" operation, a 64-bit
>> + *   structure:
>> + */
>> +#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>> +#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>> +
>> +#endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
> ditto

