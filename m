Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AAA606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cWwTfVAA
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXxV72TC3z2xqv;
	Mon, 23 Nov 2026 17:53:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795416799;
	cv=none; b=hwT9jhzGDNzQQWz47y072AYOW4h1KyJB1ybsSZLY5adSCd0JIXtU0urUDLmlNBswq1zUHUlFClgPQotbgb3ksDYft4q0wWG0dZREg8RywbPQ+hWSBpFYudXPt5vjd6W+A0bqhko7CjWjrTCzkVNnj9YflYRpFvTrbYyR4JwM2pLyBHP0lnuAChxKjBraRjX0u3pz49NMM7FRYYWwd6SjVWWAfpWlDQzfAk8zJjeng7GVohs/OjymiYrKxfn4JbdWKiOqM5UMwZvY9dAkKKBQDG33ZIg32n0l1rbetb56mTCL3TAyhgCGAHDKq4mo/5lxI5SXjjjzYZ5qlPf4xWpFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795416799; c=relaxed/relaxed;
	bh=LYFLUK4X0v4eb/H71FRu0YrCnuzDn+tDFLUu8DbmnA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JXLVP9JkykpXmieYiVR0b4DMmtYaE0cbNj9s/on/8z8KdM0tZaEEw+9uib5bZBCe601n/6ntx8A65CxhUsli8iHStHixTfzHN6Rqqbpi9SzGLKbM4Qw/61YdkjfEPV1wv9arnMJTHpwWbj70XcXv3/I7wG8sDAKckd+/Q6zEZ9jpZgnboZwVgNxyurZxPLKdxnUr7MSSVhzWhaCPCTPlaDSQxweecRLtXYAIIkAIfeCwRsRymVKen5/RL5dS7fDdcoPIjYbnFmR0vqJjOY8r7uGUHTftBjTFzf83JQTEwccZRIriIqgGBCCDVVxhdNpOEa7Hh9FIp5EulSywlD9Egg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cWwTfVAA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cWwTfVAA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXxV63Dzlz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 17:53:17 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54eG62633014;
	Mon, 23 Nov 2026 06:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LYFLUK
	4X0v4eb/H71FRu0YrCnuzDn+tDFLUu8DbmnA0=; b=cWwTfVAAWnl1nytN9GhvQ3
	BzWMjNOnY5i5dvwNM63/AASQTZaMC0oza8uDjYT7pREkqmmJ7lKFXeTUgG71AlpM
	AR45SqA2Dm9W9x9Vzw5lHZVGMm5AKBiLK0zOrzl1Fm9kTNGHrEuLrDdeNjA196Do
	YoecBMwjh7Gvca4MBxrD46vGtFui+/Z81n003tCBTzGJ20GRCWmofqtx9AMAZlbW
	hSaSes8frXoKJh/PLc02LrqXRtT8UEK2Vr1tqU9D7DBLikRSHb4cLAOB6zS+e9HK
	yPl5XwLXL/LC+vFYMGDqoPiLA5rKvLjeXJnDYNhZYNn2dqu4R0WP27EWvYNjE3vg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11kyf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:53:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN54F2P2817213;
	Mon, 23 Nov 2026 06:53:02 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjwnjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 06:53:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AN6qvu128770570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 06:52:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8C6A2004B;
	Mon, 23 Nov 2026 06:52:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2038020049;
	Mon, 23 Nov 2026 06:52:52 +0000 (GMT)
Received: from [9.124.208.184] (unknown [9.124.208.184])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 06:52:51 +0000 (GMT)
Message-ID: <b5383e66-c777-4e96-9ee8-5548d84f6e89@linux.ibm.com>
Date: Mon, 23 Nov 2026 12:22:49 +0530
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
To: Narayana Murty N <nnmlinux@linux.ibm.com>,
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
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <9efa20ba-d79b-47b8-9677-474c19aa9168@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: POTtVaHnrtjaDJOwoyhxmcXptX7oATw5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfX7zji1cl3E3Hu
 W7rGuHoEeK2vuHLCJY1l6nbaXcH4oHV+L2QxHVnUxWosFYjfIpZZTPWI1HVpIBkwflh5+hhjCqP
 Wt6AJ3wWw18GMcE4/sMBRaFGZM7SIP4=
X-Proofpoint-GUID: 0ODn4djClxTQZDVoDpOsbuaXnGG_WbY7
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03e2ce cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=p_t55juraV-f5WWF2IAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAyNiBTYWx0ZWRfXy7eA93pfZPq/
 El0yeVZG4uYdcedVjb80xp6cQVQMI8kXzrIF0XLQ0Z3DXQ4h0Amb8mXIeHvmZEuYPNihguwpUnt
 Pzp1dkiJm5zLzrX5XCjsKMeryy913cE3exeq9SHvL6ekBfusSEWsriXcxYo9NueiOMauQwW96R1
 Bjp6CT+ppRqTWm8VCOFVKR9UekN+FHbzUtSHSKe7+MikQIpcUaOtoiPGfgH9DXYcUB7ZzMZEHug
 +ln7JdKOGBemWOmsgpUOiRXapWuDLDNLfc5o9jLfjIdCFkRpXfP+Zu9DkEm1a+4pHBqUIRT15a/
 7xuXyRof9rVWTPSg9p4/QLrikn4/q7SdHnSamhvvu9QiAMgJvIa7H4rUYnFOhp1RYT56TPj7PW+
 3B3I/hurA4MK7jKHe7vD22V3ZubBXCMchluezw46Juw3zfyCCo+WkmM9TRJr1E2NvMebeFakTCp
 8VR5KqUSbzi81rh/Wow==
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



On 20/11/26 13:09, Narayana Murty N wrote:
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
> I'll drop this patch from the next revision and will post it as 
> seperate patch.

I don't mind keeping this patch as part of the series. The only thing 
missing is an
explanation in the commit message of why and how this patch is needed 
for the
RTAS-based error injection support for pSeries introduced by the 
previous patches.

It would be helpful to include a scenario explaining why these changes 
are needed
for RTAS-based error injection support on pSeries.

- Sourabh Jain

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
>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 22 
>>> +++++++++++++++-----
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


