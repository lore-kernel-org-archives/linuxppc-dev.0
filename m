Return-Path: <linuxppc-dev+bounces-19047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B62FF60C2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 05:30:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flGt02970z2ybQ;
	Tue, 31 Mar 2026 16:30:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774935032;
	cv=none; b=iVmgc9YtLhgqy+RdX1UqXdEK9u/ZN7nYCGYWhfD94xzVGJNr3fjYdAuGBHgZ2AlhdhS6gB6xpt91JxlxSI972BqglzbYtLOuIQkFvJAbPvAscvFRiRv7PIiUxuWN6iZryc4b+pYJSa0CQ/51dqf20uz+v76a2rYJhi2EamArcXP2EAHpNeX1bm0CjnqKbFcDeZF6T0Ub66K5ppfDEEl51dCRPo4qj7L+c1s8SS9zuOBdsHMMWQQXZP9p5ph/M7Ed2ncqseduwILUBe5xIY7up12M/EwtppUGyLh39EU/Qw8pj/tyAZb0/V89pizPhqj2gEN17MngcWWPRBk6O6eKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774935032; c=relaxed/relaxed;
	bh=wj/tPjfomNpdW9ZMxM77LzjLfDdk7RITO8p5zn5/c2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKqrBOudlYkaNAqCYJrXbmVA54pV4AaOX/4M5afE7X5V02LpS9tR4Lwe8rM24woFQbRSR5OOCS7Rf3L8VaxDmL4uB+3W/baa4bx2jdxFKqge4HwU5FM3qVS9OaH+HbJd4xPYrsCskWvkAG+Q9L4iNO+jQfkr4sQ5vcU9yoQO7FnAfy8jBxjPx7QdhHiLnfCVbK3hYgDkykmWGFRCqWQ9iT/wh1P1+jqG/I6ymOF8/4IDApU8traPzOLUoftzZo6Wqqlpw6v9IFzbcMLWzptOHmu/CtH8w8lWe+DgB223u+mPNEJiXWrrOysgmgV9+6WM9KRYQ1Bq40ahQG+yWUsYAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fVMPJUzU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fVMPJUzU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flGsz3YkLz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 16:30:31 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UETPbk4019302;
	Tue, 31 Mar 2026 05:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wj/tPj
	fomNpdW9ZMxM77LzjLfDdk7RITO8p5zn5/c2o=; b=fVMPJUzULbt+HYZrgD8rLQ
	HmsR/TYyt8Yo59N0NniacEpHSzkkLgkBwfmgMS/+D2dti06XMOwd05j+EPTflyCE
	9mf8EanIZIEthABoQeCCaTdiatXDs5ThsHhoTyzq4Mnhyi6IM7THIApPbTZTl1GJ
	CmTJQYtbR4iEgSkyj2HLrCreUJ47PA3e3l1U4Rvk+byVIKdkeFim0oulEJtCDJ33
	GdD3u7XiCDf0vUHRvEgimqi/kNJT8U1Pzonp/562p9sykRMMgiCpG+OiGuiXM6cr
	sknjS+va4Gp133YWymj+Q4IK4DXAYG/BViqDDsgWg2a23lOkwIp7x9yx3ssrWRIA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc9dhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:30:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V2lTBT008685;
	Tue, 31 Mar 2026 05:30:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6v11ffqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 05:30:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V5ToKd23790160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 05:29:50 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4160158100;
	Tue, 31 Mar 2026 05:30:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9389580FF;
	Tue, 31 Mar 2026 05:30:09 +0000 (GMT)
Received: from [9.43.68.136] (unknown [9.43.68.136])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 05:30:09 +0000 (GMT)
Message-ID: <ebc659de-ebd2-4e4b-a74d-fa490a6b6dc1@linux.ibm.com>
Date: Tue, 31 Mar 2026 11:00:07 +0530
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
Subject: Re: [PATCH 2/2] powerpc/xive: rework xive_find_target_in_mask()
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Nam Cao <namcao@linutronix.de>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Kees Cook <kees@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20260319033647.881246-1-ynorov@nvidia.com>
 <20260319033647.881246-3-ynorov@nvidia.com>
 <275be5b0-9680-4d85-84f7-cf57142f20df@linux.ibm.com> <acqtJ2WUkg0ZtiHE@yury>
 <dc0c5eff-a55a-4673-806c-00da1177dfea@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <dc0c5eff-a55a-4673-806c-00da1177dfea@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cb5be8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=n96CU2sbz_NvWt6qIrAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uKhnR7HKhtW4BR2iV8TvCyh3zkZ42WIe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA0NyBTYWx0ZWRfX4jpc0z/BOMw6
 xiBL66gMKqtoIEK+bbC7Vm5cs3EOjz52dsg2UDnN8yycoM/x6mT5IA22pJRI+Y1pAZ7Q2WiYxV4
 vvhlr/SiUd6LWbgfpS8o6gQZ6qvJzAvVXTOPp7K7eaSonGCGud9lZ80A7Bf9n4vIZkqfgrIccpN
 xDTsT6yblw0qF4m4cwGrY8FCjD/oaT3xSQMAKOrSYgv91q33xYJzxHotnFR+IRmxDGOL0vR9BOt
 3nN/yysLt3ebSthGz+koJ/k1nX0LzKiCNmgIY2tR1dQjtWFgnoJSx9TP9WVOhU/Gw1k9Keif5iB
 MPnvHyCREClQnralRY/lUn5ukctgfWo9aD1lHNmQE4S/KmN+hJz7xGZfj/HTC3I0CJLIt7Yznl4
 jzO10NmhDw2wr5b9BdKJ8gvsVku7angdrdT1Q1WN0N5YbGNZ+4xUeV80Vv4FwSBH95IiHytwiEt
 LaVJEl+sywPLQyBZfhA==
X-Proofpoint-ORIG-GUID: it6kvNC8mpsob5h8zSDjm7-M17wpFcXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1011 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310047


On 3/31/26 8:29 AM, Shrikanth Hegde wrote:
> Hi Yury,
>
> On 3/30/26 10:34 PM, Yury Norov wrote:
>> On Sun, Mar 29, 2026 at 02:43:27PM +0530, Shrikanth Hegde wrote:
>>> Hi Yury.
>>>
>>> On 3/19/26 9:06 AM, Yury Norov wrote:
>>>> Switch the function to using modern cpumask API and drop most of the
>>>> housekeeping code.
>>>>
>>>> Notice, if first >= nr_cpu_ids, for_each_cpu_wrap() iterator 
>>>> behaves just
>>>> like for_each_cpu(), i.e. begins from 0. So even if WARN_ON() is 
>>>> triggered,
>>>> no special handling is needed.
>>>>
>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>> ---
>>>>    arch/powerpc/sysdev/xive/common.c | 31 
>>>> ++++++-------------------------
>>>>    1 file changed, 6 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/sysdev/xive/common.c 
>>>> b/arch/powerpc/sysdev/xive/common.c
>>>> index e91ec9036ad8..4e05f678e171 100644
>>>> --- a/arch/powerpc/sysdev/xive/common.c
>>>> +++ b/arch/powerpc/sysdev/xive/common.c
>>>> @@ -548,40 +548,21 @@ static void xive_dec_target_count(int cpu)
>>>>    static int xive_find_target_in_mask(const struct cpumask *mask,
>>>>                        unsigned int fuzz)
>>>>    {
>>>> -    int cpu, first, num, i;
>>>> +    int cpu, first;
>>>>        /* Pick up a starting point CPU in the mask based on fuzz */
>>>> -    num = cpumask_weight(mask);
>>>> -    first = fuzz % num;
>>>> -
>>>> -    /* Locate it */
>>>> -    cpu = cpumask_first(mask);
>>>> -    for (i = 0; i < first && cpu < nr_cpu_ids; i++)
>>>> -        cpu = cpumask_next(cpu, mask);
>>>> -
>>>> -    /* Sanity check */
>>>> -    if (WARN_ON(cpu >= nr_cpu_ids))
>>>> -        cpu = cpumask_first(cpu_online_mask);
>>>> -
>>>> -    /* Remember first one to handle wrap-around */
>>>> -    first = cpu;
>>>> +    fuzz %= cpumask_weight(mask);
>>>> +    first = cpumask_nth(fuzz, mask);
>>>> +    WARN_ON(first >= nr_cpu_ids);
>>>>        /*
>>>>         * Now go through the entire mask until we find a valid
>>>>         * target.
>>>>         */
>>>> -    do {
>>>> -        /*
>>>> -         * We re-check online as the fallback case passes us
>>>> -         * an untested affinity mask
>>>> -         */
>>>> +    for_each_cpu_wrap(cpu, mask, first) {
>>>>            if (cpu_online(cpu) && xive_try_pick_target(cpu))
>>>>                return cpu;
>>>> -        cpu = cpumask_next(cpu, mask);
>>>> -        /* Wrap around */
>>>> -        if (cpu >= nr_cpu_ids)
>>>> -            cpu = cpumask_first(mask);
>>>> -    } while (cpu != first);
>>>> +    }
>>>>        return -1;
>>>>    }
>>>
>>> Only concern i have, (which could potentially leads to while(1) loop
>>> today if it), is if mask is empty. atleast for_each_cpu_wrap will not
>>> be a while(1) loop.
>>>
>>> So, IMO this is better than what we have today.
>>>
>>> nit: maybe a good to add a WARN_ON(cpu >= nr_cpu_ids) in the end.
>>>
>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>   The iterator of for_each_cpu() is always >= nr_cpu_ids when it 
>> exits the
>> loop because it's the exit condition. If you want to warn user before
>> returning -1, just do __WARN().
>
> Ok.
>
> It might take a while a while to send the next version out since i am
> working on getting the next version of that paravirt series out soon.
OK, I am pulling this patchset as-is for next merge. I will expect
a followup patch  to add a __WARN().

Maddy



