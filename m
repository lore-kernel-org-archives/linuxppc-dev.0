Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137F9606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oECQqBng
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXxF35P5mz2xwP;
	Mon, 23 Nov 2026 17:41:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795416119;
	cv=none; b=PteXBJgo0EqE1JcvPu8j8HC2MvLDUceb76KYU+9F7ZGwyEtEmBj3GiHJG2ldjyC7PV2LkoMseS2FcIHnnVOgS0sd5Tj2RvJxf1ydJF6fe2f6f55IS9WnCWTxp5zpM3jE76QiG37JWGTzUcCBek7DD3/OJa3kNbzYBV1XDHdTwMbrJEcDV2UxpW7s4SI03aew9kCxMA4mTImbxWno0sJ8m9A3nO7H922vaEH9vrEPgjpyL+rLq9snN0lbBXxnuSLgivPIAlsuTmeuVpt66lV56CFRPOYHL7OcipPyEVUYpPX8HSGmkKjYS7g1AYcjGY8a+sjqDcQKLPhpAEpLlXvMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795416119; c=relaxed/relaxed;
	bh=qBreP/Oo/PnPhpv8ZmYNUNcsA5D6iFCiC+x/766XWo0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A2LT5sbZbtuWvzi53mC8TlpiFU7PJDS3Dsrfzh5IMy/2cKOPgHYoDBgA9SrIzkhoZl0pnmVwarfRJ5krCnj8gAZE26vL511DZyOywk6ptXXZ6kyoXxPX8CPoyItREJbQvYSVjtZU2fnA6ORTrONxZ7Tc5SkcTSQ71VYq11fBjoSiv+aHTWhfh7GJcmAepySvaLTHwcSZDzaEC7I3Z0xH7r3GCcw65hIVQL0Tw0yDK9bqgVty0M+pxoSf/rAyn6G5XHwLrvbksF8Dunt6p9qTuBHBxusTTQpBis7njoBN8fKsi54Ix5cwfucWQ9caNisIFE+ieHPvvHLsG8n5BswT6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oECQqBng; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oECQqBng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXxF245L6z2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 17:41:58 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54gFq2633067;
	Mon, 23 Nov 2026 06:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qBreP/
	Oo/PnPhpv8ZmYNUNcsA5D6iFCiC+x/766XWo0=; b=oECQqBngTqmtlK4WTi68N9
	PhTwWYo0yx9envYjzx+ygfIT03cMUhU30Z48RmI2g1BVZAXRwjiLTQ+lxRuBKYR4
	IMEuEBjBUIGRj81k6/6EJd4L9dev3+GHGzjpBNedrhghWSY9Zq77yDWsxZvoJ2qa
	QyFRekOCp+L9hWUnNcZMCf0g9nxUNW6ik/XVdeA2k+BJHH2hdUPmJQM12xPi/VA4
	VDH7PHrjV6+mzuT+VwSANBIfQ69+i/5XbLehctysawShhOJyP0/G68rZQNQYkTg0
	8GR267pnCkx0Y2E6HYbTTo6hOwzVoEnTgGTbah4MPPHiO7eVb0f7ANpHFsU3PaWw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11k1r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:41:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54SlZ1346513;
	Mon, 23 Nov 2026 06:41:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3nmqdtts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:41:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN6fa1C47317442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 06:41:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 826362004E;
	Mon, 23 Nov 2026 06:41:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E91D820040;
	Mon, 23 Nov 2026 06:41:33 +0000 (GMT)
Received: from [9.123.4.64] (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 06:41:33 +0000 (GMT)
Message-ID: <c34ffcfe-f432-415b-af0d-c574ec416e50@linux.ibm.com>
Date: Mon, 23 Nov 2026 12:11:33 +0530
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
Subject: Re: [PATCH v6 5/5] powerpc/powernv/eeh: Map generic EEH error types
 to OPAL
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
 <20261023073642.59657-6-nnmlinux@linux.ibm.com>
 <2ed69cf8-eca2-41ed-a100-844f9d84c2ad@linux.ibm.com>
 <9efa20ba-d79b-47b8-9677-474c19aa9168@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9efa20ba-d79b-47b8-9677-474c19aa9168@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E_boxzguLIIDgS85SKfN-JRZDq-Ftfz-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfX+FX5Z7TOFmwu
 Cj6KN1UyOamK/8EB1BIheVqHHF6+jIrNYpsE3cTZOpYRkPIgcLPJmVsH2TK7JeShu98lJJSP8Yq
 i//fHxw+czHKznEHvxA4tUb8QBjM+Zw=
X-Proofpoint-GUID: f9KpyKt35FTz4Y_A3hX-VETTE8EbGfra
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03e025 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=8MjjNtLoB4kJMNi7y5gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfXxWwrCrOw6kQ6
 3YCt+TI/ZvGB/SSGR+3pPfjteMotugYWFQj/aYRK2LqkIx3DtpQD2z3AlaxiHBJMg7FRhjYlTWQ
 fQ0oFjAP5KN0nowI6tCK2Ly01nIDhv5bXuSDMZIWdmOo0gLbQFsHfbbFwVdF+47LlPIQY2K2xyB
 rLmkkCHp8w2EECvZsnLzTBBaeeKjJJv6uxAG+wueMkmMqst9V6wTpUmwPJ2AyOlcRLGeI211ff3
 Cd3rr6UnVTNN7iBkXAfho0ECE+yUAKHLgyyhMZhO6zI+ytvrQXJwZk6/WajpRYh3jlngy1Vcrvy
 q/fkf5AyeFHYtf/ucvLmmpLY/uXxkJiqAxJNsGv9Cz8r/lDyUzGHUo70tevVyCF/uLGQ/U0hTYy
 pO5eRcgfo3w50+pNHxy6lz6BW21WYLPS6KFvNNSsGYIHQCM5lIaPgMUrpTX0OFOK6OrEDRvBzGp
 TvbOAIJtBxJkxjnECrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230026
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/11/26 1:09 PM, Narayana Murty N wrote:
> Hi Sourabh,
> 
> On 19/11/26 1:11 AM, Sourabh Jain wrote:
>> Hello Narayana,
>>
>> For my understanding, could you clarify why this change is needed as 
>> part of this series?
>> The series is about enabling RTAS-based error injection, and PowerNV 
>> doesn't support RTAS.
>> How does this change fit with the earlier patches in the series?
>>
> The intention was to decouple the generic EEH error types from the
> platform-specific OPAL encodings, similar to the explicit mapping
> introduced for pSeries.
> 
> However, the generic EEH error-type values remain unchanged, and
> the PowerNV mapping is not a prerequisite for RTAS-based error
> injection.
> 
> I'll drop this patch from the next revision and will post it as seperate 
> patch.

Thanks for the feedback, I misinterpreted your comment.

Patch 5/5 is included to keep the generic EEH error-injection interface 
consistent across pSeries and PowerNV.

This patch series introduce RTAS-based error injection on pSeries, where 
the generic EEH error types (EEH_ERR_TYPE_32/64) are mapped to the 
corresponding PAPR error-injection classes.

PowerNV uses the same generic EEH interface through eeh_pe_inject_err(), 
but its backend currently relies on the generic type values matching the 
OPAL error-injection constants.

Patch 5 makes this translation explicit in the PowerNV backend, similar 
to the pSeries RTAS implementation. It does not introduce RTAS support 
on PowerNV or change the userspace ABI or existing behavior.

I'll update the commit message to clarify this relationship.

Thanks,
Narayana
> 
> Thanks,
> Narayana Murty.
>> On 23/10/26 13:06, Narayana Murty N wrote:
>>> eeh_pe_inject_err() is called with generic EEH error types defined in
>>> the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
>>> PowerNV backend previously compared these generic values directly 
>>> against
>>> OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>>> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).
>>>
>>> This is fragile: it relies on the generic EEH ABI values being
>>> numerically identical to OPAL-specific values, and would silently
>>> misbehave if they ever diverged.
>>>
>>> Add an explicit mapping in pnv_eeh_err_inject() that translates:
>>>    EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
>>>    EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64
>>>
>>> Return -ERANGE for unsupported error types, preserving the behavior
>>> of the original code.  Decouples the VFIO/EEH interface from OPAL
>>> implementation details.
>>>
>>> No change to existing userspace ABI or PowerNV behavior.
>>>
>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>> ---
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 22 +++++++++++++++-----
>>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/ 
>>> powerpc/platforms/powernv/eeh-powernv.c
>>> index db3370d1673c..01dae760cecb 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>>> *pe, int type, int func,
>>>   {
>>>       struct pci_controller *hose = pe->phb;
>>>       struct pnv_phb *phb = hose->private_data;
>>> +    int opal_err_type;
>>>       s64 rc;
>>> -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>>> -        pr_warn("%s: Invalid error type %d\n",
>>> -            __func__, type);
>>> +    /*
>>> +     * eeh_pe_inject_err() receives generic EEH error types from the
>>> +     * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
>>> +     * these generic values being numerically identical to OPAL 
>>> firmware
>>> +     * values.  Translate to OPAL-specific types before calling 
>>> firmware.
>>> +     */
>>> +    switch (type) {
>>> +    case EEH_ERR_TYPE_32:
>>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>>> +        break;
>>> +    case EEH_ERR_TYPE_64:
>>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>>> +        break;
>>> +    default:
>>> +        pr_warn("%s: Invalid error type %d\n", __func__, type);
>>>           return -ERANGE;
>>>       }
>>> @@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>>> *pe, int type, int func,
>>>       /* Do error injection */
>>>       rc = opal_pci_err_inject(phb->opal_id, pe->addr,
>>> -                 type, func, addr, mask);
>>> +                 opal_err_type, func, addr, mask);
>>>       if (rc != OPAL_SUCCESS) {
>>>           pr_warn("%s: Failure %lld injecting error "
>>>               "%d-%d to PHB#%x-PE#%x\n",
>>
> 


