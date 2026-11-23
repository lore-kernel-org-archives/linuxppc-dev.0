Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770DD606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CjsIJcKy
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY8621T1xz2y7p;
	Tue, 24 Nov 2026 01:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795445498;
	cv=none; b=c18GdPSRJ/KPKFXhFLdgHY+ne2bKiD2BGd2N934Lfrle46v1p2xRiMCFOz7iy/PFW07Lln6OWLlQ0nqxOXFAJatLSvOBtxvB6rABdTQh1ZZXgDvkiCK01yqJQHIt0lRi3TJF2X2rAox4lwJSvXRP/CDmYe/qczok2iAykcpoxxpPClTHupvT72xo+9RRX/ncWmgcRSdyZcRcQiYHO2bJolhxmu/D1EtniKuDbos/RqTFKrXl1U8f58FjsNkdf+iHUalnMOGeKlVPy5MWpoJh30xlkzW0qyZbFCPf+17MF0fp/sGODbejgvTjZz1wd4AdSeAIWcux7p7mhtJeFSqxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795445498; c=relaxed/relaxed;
	bh=6B2EKbM2HES/6NZzRUgVUrZ2C5WUdfjd3d3Yerz5WfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwCg9s7E4pusSD9rajcMPelvWEitHo9pPWNvnG6MWg2K+aCdSL1XXkU9Q7L6UTnM8n12rl56B9T5oon/KG2IYRid2aTx5q+CzDDcsaaAQeCaHaM7nLo+HRP1T62bCY0+9WhiDwpHD5zxt04zS2e7OJno4sBmfdQcMpHl90gZadlfbTJdJTiX3pb7NVtOWdCN/Txt4VWyt/IE/EB/7PxevpF/7RLCX9xuOBdEUFLriHpWTUSG84pKHUsMQ1IhVa5lRA3T1OG9ZhbL3Wqf6Jy+UdujSopdBuWvpTED5h/sUHKG45jENQap6OLiAduFjse7pxvsNbBFpGTj+K+tXtfqDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CjsIJcKy; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CjsIJcKy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY8612YTcz2xyj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 01:51:37 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDYwRx2482946;
	Mon, 23 Nov 2026 14:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6B2EKb
	M2HES/6NZzRUgVUrZ2C5WUdfjd3d3Yerz5WfE=; b=CjsIJcKyEqqG3lBzX3l0hj
	oznurocL7+U788CSYFspYRYeAsDT5YMcTAyBFkcLzElkxQJe1LKjPW7KWXQG7Pi0
	pF7LqBU12zSnOfHmJmEcz2NtzwsBQyPAQ4hyz8Bsi7wQeCmfAyF8AnaUI/Mw5Bbr
	BOpaFop5wnu6aQ5+hWsZldngt4mBHHr9DPJt2/rmM4In35Uhgil+/sFecWpIOoYX
	59Rrok8GdQrdOUlpkeavNVMNtHo4h6ukkCP31B0zQWYfE42xX/TY2m4QSEyIsAdI
	6eJ8/v6l7ZrlWK3a8x+AWRQGyTR/64+e+Zpuu2uiEGMXsN20UyLVGfoRIJTx3XcQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4b7d7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:51:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDJYBE1222896;
	Mon, 23 Nov 2026 14:51:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0vf9ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 14:51:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANEpEAx43385124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 14:51:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA2920043;
	Mon, 23 Nov 2026 14:51:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAB0820040;
	Mon, 23 Nov 2026 14:51:10 +0000 (GMT)
Received: from [9.124.210.23] (unknown [9.124.210.23])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 14:51:10 +0000 (GMT)
Message-ID: <4e5ade62-dc94-4410-a1f7-65dd44f6cb7f@linux.ibm.com>
Date: Mon, 23 Nov 2026 20:21:09 +0530
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
 <b5383e66-c777-4e96-9ee8-5548d84f6e89@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <b5383e66-c777-4e96-9ee8-5548d84f6e89@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX2+NsgcLlLYou
 kt7jW+LCgl9JUMM7+lWEE3GHZVjIqfdokuzJbVrWlUtvOLO6aHyqUrWnPnZUT1t9eqD6HRO137o
 FeH5qKlTpOkI8Pk2zocj/PyhwmLppAc=
X-Proofpoint-GUID: PeVVcCuW4sMGv4b90fqD9mHxx9pWfbuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1OCBTYWx0ZWRfX7WebfoAvwwGe
 4U22Sucjm6L1swHfFUMlCXzGgt1pQBzEDCHokJ+9iE1ZmW/JkgHeiUhjTda1DnH01DV6rlV8kEe
 3Ar3izbVHWSJ8GUCvB/2xcl8k7+fynj4C9uc0s4T1kWYwupz9Np59Y1muomLy+iD06BGGrRxd6d
 SQf75M66zzyo4vj3KgzWn5GXa+kqULSkoMKkWQGULumxlCAu/+r/vEjXJmXmKPmOy3rpf1Xlv5c
 Jl3T1kASflK8POwiBiqKDXHjEEt4sAbG4PEnSAQlyXP6sVkdg6x6FvthVxQTL2J8H4DNyDLqwkB
 WkBSj0NUEeE9V1JaCDwQ35GYSd9RydFSs8JOmQEiZQ+RVkuKxwS3Qz0pHm9+R6zAKLRNnjYl87h
 k236qy9xq6XquNai8xNkk6GmvnlYHLxN37XDAbIjSRQvfQCHHwJsrprLht6SayTJdw0a+UYRLLr
 OMobGaBYaDPNV7C/B0w==
X-Proofpoint-ORIG-GUID: UokNdsw91_9SACW79Io2_dvZuf2GYhdI
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0452e8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=4fP7XDlWrgE3Nxb3Mn0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230058
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HI,

On 23/11/26 12:22 PM, Sourabh Jain wrote:
> 
> 
> On 20/11/26 13:09, Narayana Murty N wrote:
>> Hi Sourabh,
>>
>> On 19/11/26 1:11 AM, Sourabh Jain wrote:
>>> Hello Narayana,
>>>
>>> For my understanding, could you clarify why this change is needed as 
>>> part of this series?
>>> The series is about enabling RTAS-based error injection, and PowerNV 
>>> doesn't support RTAS.
>>> How does this change fit with the earlier patches in the series?
>>>
>> The intention was to decouple the generic EEH error types from the
>> platform-specific OPAL encodings, similar to the explicit mapping
>> introduced for pSeries.
>>
>> However, the generic EEH error-type values remain unchanged, and
>> the PowerNV mapping is not a prerequisite for RTAS-based error
>> injection.
>>
>> I'll drop this patch from the next revision and will post it as 
>> seperate patch.
> 
> I don't mind keeping this patch as part of the series. The only thing 
> missing is an
> explanation in the commit message of why and how this patch is needed 
> for the
> RTAS-based error injection support for pSeries introduced by the 
> previous patches.
> 
> It would be helpful to include a scenario explaining why these changes 
> are needed
> for RTAS-based error injection support on pSeries.
> 
> - Sourabh Jain
> 
Thanks for your feed back, I will continued this patch in V7.

Regards,
Narayana
>>
>> Thanks,
>> Narayana Murty.
>>> On 23/10/26 13:06, Narayana Murty N wrote:
>>>> eeh_pe_inject_err() is called with generic EEH error types defined in
>>>> the VFIO/EEH userspace ABI (EEH_ERR_TYPE_32, EEH_ERR_TYPE_64).  The
>>>> PowerNV backend previously compared these generic values directly 
>>>> against
>>>> OPAL firmware constants (OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
>>>> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64).
>>>>
>>>> This is fragile: it relies on the generic EEH ABI values being
>>>> numerically identical to OPAL-specific values, and would silently
>>>> misbehave if they ever diverged.
>>>>
>>>> Add an explicit mapping in pnv_eeh_err_inject() that translates:
>>>>    EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
>>>>    EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64
>>>>
>>>> Return -ERANGE for unsupported error types, preserving the behavior
>>>> of the original code.  Decouples the VFIO/EEH interface from OPAL
>>>> implementation details.
>>>>
>>>> No change to existing userspace ABI or PowerNV behavior.
>>>>
>>>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>>> ---
>>>>   arch/powerpc/platforms/powernv/eeh-powernv.c | 22 ++++++++++++++ 
>>>> +-----
>>>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/ 
>>>> powerpc/platforms/powernv/eeh-powernv.c
>>>> index db3370d1673c..01dae760cecb 100644
>>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>> @@ -1167,12 +1167,24 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>>>> *pe, int type, int func,
>>>>   {
>>>>       struct pci_controller *hose = pe->phb;
>>>>       struct pnv_phb *phb = hose->private_data;
>>>> +    int opal_err_type;
>>>>       s64 rc;
>>>> -    if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
>>>> -        type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
>>>> -        pr_warn("%s: Invalid error type %d\n",
>>>> -            __func__, type);
>>>> +    /*
>>>> +     * eeh_pe_inject_err() receives generic EEH error types from the
>>>> +     * VFIO/EEH userspace ABI.  The PowerNV backend must not rely on
>>>> +     * these generic values being numerically identical to OPAL 
>>>> firmware
>>>> +     * values.  Translate to OPAL-specific types before calling 
>>>> firmware.
>>>> +     */
>>>> +    switch (type) {
>>>> +    case EEH_ERR_TYPE_32:
>>>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
>>>> +        break;
>>>> +    case EEH_ERR_TYPE_64:
>>>> +        opal_err_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
>>>> +        break;
>>>> +    default:
>>>> +        pr_warn("%s: Invalid error type %d\n", __func__, type);
>>>>           return -ERANGE;
>>>>       }
>>>> @@ -1192,7 +1204,7 @@ static int pnv_eeh_err_inject(struct eeh_pe 
>>>> *pe, int type, int func,
>>>>       /* Do error injection */
>>>>       rc = opal_pci_err_inject(phb->opal_id, pe->addr,
>>>> -                 type, func, addr, mask);
>>>> +                 opal_err_type, func, addr, mask);
>>>>       if (rc != OPAL_SUCCESS) {
>>>>           pr_warn("%s: Failure %lld injecting error "
>>>>               "%d-%d to PHB#%x-PE#%x\n",
>>>
>>
> 


