Return-Path: <linuxppc-dev+bounces-27687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AECCC982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 08:51:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmRFG5BD3z2y2W;
	Fri, 18 Sep 2026 18:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789721506;
	cv=none; b=KjoZqZEdPQfDocxzsvt23CzO9xnURPJnkVurX4CDIpkOYhBUQGSjOZ6Zi37kl/rB0mcr2JbVXXMY5goF0uBa2gX+bqgYXtFIsB+FEsLKX/33kF1r01fmf7OC9B+/CuuvYfviEjNbc3DE4LVL0Gprwv5yCd1FzFAtpdNEtWBSIaY1LPNVPzcADB53D7JLoVGQxxZcBj0mJhhHWZxEbzM5KP6lhGFg1R8pwJ28OpB765v7JmR+mqU9dcRz4MmwqvolSmwQ6LzPQ7O6PkjYJcloge02q04M541H7MeDWO9KExrKk0R4itA/Jbk2VUWWzlDYJYgnEg5j4TzcoZS56tFUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789721506; c=relaxed/relaxed;
	bh=vtfAvcpcF0lj+t8yJDVgJUlc+CYmzK2k/Po6oqnboUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1HDj+TDXKCUvKQJ5k1+TO+rrhnZo4Sob0SGau+uFn8/Q4gHPWJTDLt7zWgy5tOhMexkbiNWa5XhbJNfxm0pO28cfJwFKCSbaMPkBzIX95a9nYwZvLl6lUB7P0f/FNxYR69uhRqVBeOVnDdVbEIxoGdcVWWW2iVNlWdZTyhM6yFWDgNDIWkO3Xq9loMRElBARe91PcbAV83wgWt/II6mbQwzRP1beKqWkW1Bbji5q2Perjxm0U4DrP2Tb2WPpBCpFlhYdS76zhOYaz6JWPd9Qd6MzFIDvfbcmdyO4+46IZltH2Qrj/htnQNND1hpuFwTRndpeC/7m+IwPWva7l/AwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AWbVPXsG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AWbVPXsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmRFF6tYDz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 18:51:45 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61im13490117;
	Fri, 18 Sep 2026 08:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vtfAvc
	pcF0lj+t8yJDVgJUlc+CYmzK2k/Po6oqnboUI=; b=AWbVPXsGPoQNWU7fFfZQUg
	rEXFgFvcbnMeQq38diRllfbfGiQ1GxbS6lSfhgO4+jwGJjCATIfog2RdsmbOsNFx
	kRCuB1uz5e5dGR/CWOKz8pDXRRMHk6XjxKHms2hNGAXtCMYfnxRjiXDGqB3R/FqY
	XaaJA1n94TxguuFBOtVnbqV0K/Lwusn7atj9accwfZFkwtKyUb6c5/ba7aB0iG7v
	US/UYmshdn8yz6BLFZWEIe/SPJPrAIGXPQ0+fNkUzh2gIVQgSicbeD26mpzePJt2
	kp7nZjxkULkC5ZDVAVo6jMtfFGzcvRm0RIjOKiwGxn65FOQtMsXqPpWOIKMW94qw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eenqx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:51:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6540G251887;
	Fri, 18 Sep 2026 08:51:32 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3ywmfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:51:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8pUwf42074436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:51:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4FD420043;
	Fri, 18 Sep 2026 08:51:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBE720040;
	Fri, 18 Sep 2026 08:51:29 +0000 (GMT)
Received: from [9.39.16.52] (unknown [9.39.16.52])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:51:28 +0000 (GMT)
Message-ID: <cf92173d-b9f2-469c-8f1e-3978ef5469b3@linux.ibm.com>
Date: Fri, 18 Sep 2026 14:21:28 +0530
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
Subject: Re: [PATCH] powerpc: remove unused audit_32.h header
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Ethan Nelson-Moore <enelsonmoore@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260918030810.420490-1-enelsonmoore@gmail.com>
 <1f44b5fa-0238-4412-8742-07f17c06cc04@linux.ibm.com>
 <093ca6ba-5585-40ec-9337-8621c6741d33@kernel.org>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <093ca6ba-5585-40ec-9337-8621c6741d33@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXw8+88cfVAKUM
 WYJLqzCU9I1qSZOYSvoeg5zTIwWY27QoJZ6Ex2qc1VR12snytx/ZSvsAJSdcJSfys84R1HuLNIP
 Tdi2nOienvm9M6LGrF70Iw6YT9cGHTUCZ/e44iJpbpFl2ai8fedNdKw72FwxmTJB4Tm/4EqjeHR
 1MFA6fHRuX8xLkfkJP2mUwYl7S9AJ2yuAf0IHDr0FxjZHOaY8prXy4PSuIh1SvbwMNO65QzZcvu
 ecYmHZN8MIqLC9p4RGd70o2KnaGF/DNa/NLn7oWs7jFmRJonSg7y8LvIBX2kEtQhYHy8/NuxRPR
 5zmUlHAnOwaXe/lJXDxcEpE9LdbdSfUvqNiejOgccvFEllvGFqokPvDsnr/IDWqbeCvfCAEPjNQ
 zsVL0hntIFYQSbDgGThPESzkLFJzIwsaMVQv509Y5P1feFaEZ6Uta2GGGdTIWgOHEmw7UkHRhmE
 WnCxOisQSyeVTuzyRIw==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aacfb95 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=XEP0DKeHsSo43TsCxWEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ot1cD40CQS5OgrZUApgck3vJ2OGg7jHn
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXztM4CQCfkJ4q
 jIy5lRpq8DHfEjW4KIaxreIusK6yc2wRS+oSEEAkQFa5+0F3cjCZ1AJYQ8nXpWt57dxjr0u/raU
 n9akTlgupl5sGjDEvNf87FunpFWqQnI=
X-Proofpoint-GUID: Yk_3TnqPe0CoU3AAzYSubSOER_FTPuSl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117



On 9/18/26 1:41 PM, Christophe Leroy (CS GROUP) wrote:
> Hi Shrikanth,
> 
> Le 18/09/2026 à 09:11, Shrikanth Hegde a écrit :
>>
>>
>> On 9/18/26 8:38 AM, Ethan Nelson-Moore wrote:
>>> The last use of arch/powerpc/kernel/audit_32.h was removed in
>>> commit f26ad12356a2 ("powerpc/audit: Convert powerpc to
>>> AUDIT_ARCH_COMPAT_GENERIC"), but it was left behind. Remove it.
>>>
>>
>> Does it need fixes tag, So that it can propagate correctly?
> 
> My understanding is that this patch is not a real bug fix so it doesn't qualify for -stable trees at the first place. Therefore it shouldn't contain a Fixes: tag.
> 
> See https://docs.kernel.org/process/stable-kernel-rules.html :
> 
> Rules on what kind of patches are accepted, and which ones are not, into the “-stable” tree:
> 
>      It or an equivalent fix must already exist in Linux mainline (upstream).
> 
>      It must be obviously correct and tested.
> 
>      It cannot be bigger than 100 lines, with context.
> 
>      It must follow the Documentation/process/submitting-patches.rst rules.
> 
>      It must either fix a real bug that bothers people or just add a device ID. To elaborate on the former:
> 
>          It fixes a problem like an oops, a hang, data corruption, a real security issue, a hardware quirk, a build error (but not for things marked CONFIG_BROKEN), or some “oh, that’s not good” issue.
> 
>          Serious issues as reported by a user of a distribution kernel may also be considered if they fix a notable performance or interactivity issue. As these fixes are not as obvious and have a higher risk of a subtle regression they should only be submitted by a distribution kernel maintainer and include an addendum linking to a bugzilla entry if it exists and additional information on the user-visible impact.
> 
>          No “This could be a problem...” type of things like a “theoretical race condition”, unless an explanation of how the bug can be exploited is also provided.
> 
>          No “trivial” fixes without benefit for users (spelling changes, whitespace cleanups, etc).
> 
> 

Alright. Makes sense.

>>
>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>
>>> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
>>> ---
>>>   arch/powerpc/kernel/audit_32.h | 7 -------
>>>   1 file changed, 7 deletions(-)
>>>   delete mode 100644 arch/powerpc/kernel/audit_32.h
>>>
>>> diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/ audit_32.h
>>> deleted file mode 100644
>>> index c6c79c3041ab..000000000000
>>> --- a/arch/powerpc/kernel/audit_32.h
>>> +++ /dev/null
>>> @@ -1,7 +0,0 @@
>>> -// SPDX-License-Identifier: GPL-2.0
>>> -#ifndef __AUDIT_32_H__
>>> -#define __AUDIT_32_H__
>>> -
>>> -extern int ppc32_classify_syscall(unsigned);
>>> -
>>> -#endif
>>
> 


